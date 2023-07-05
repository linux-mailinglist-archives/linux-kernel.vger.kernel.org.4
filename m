Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF529747DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGEHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGEHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:04:36 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E601A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:04:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfjzOF_1688540667;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmfjzOF_1688540667)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:04:28 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v2 0/2] erofs: introduce xattr name bloom filter
Date:   Wed,  5 Jul 2023 15:04:25 +0800
Message-Id: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
  Refer to patch 1 for more details.
- fix the value of EROFS_FEATURE_COMPAT_XATTR_BLOOM; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)
- pass all tests in erofs-utils (MKFS_OPTIONS="--xattr-filter" make
  check)

[*] https://lore.kernel.org/all/74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com/
RFC: https://lore.kernel.org/all/20230621083209.116024-1-jefflexu@linux.alibaba.com/


Background
==========
Filesystems with ACL enabled generally need to read
"system.posix_acl_access"/"system.posix_acl_default" xattr to get the
access and default ACL.  When filesystem is mounted with ACL enabled
while files in the system have not set access/default ACL, the getattr()
will run in vain while the round trip can decrease the performance in
workload like "ls -lR".

For example, there's a 12% performance boost if erofs is mounted with
"noacl" when running "ls -lR" workload on dataset [1] (given in [2]).

We'd better offer a fastpath to boost the above workload, as well as
other negative xattr lookup.


Proposal
========
Introduce a per-inode bloom filter for xattrs to boost the negative
xattr queries.

As following shows, a 32-bit bloom filter is introduced for each inode,
describing if a xattr with specific name exists on this inode.

```
 struct erofs_xattr_ibody_header {
-       __le32 h_reserved;
+       __le32 h_map; /* bloom filter */
	...
}
```

Following are some implementation details for bloom filter.

1. Reverse bit value
--------------------
The bloom filter structure describes if a given data is inside the set.
It will map the given data into several bits of the bloom filter map.
The data must not exist inside the set if any mapped bit is 0, while the
data may be not inside the set even if all mapped bits is 1.

While in our use case, as erofs_xattr_ibody_header.h_map is previously a
(all zero) reserved field, the bit value for the bloom filter has a
reverse semantics in consideration for compatibility.  That is, for a
given data, the mapped bits will be cleared to 0.  Thus for a previously
built image without support for bloom filter, the bloom filter is all
zero and when it's mounted by the new kernel with support for bloom
filter, it can not determine if the queried xattr exists on the inode and
thus will fallback to the original routine of iterating all on-disk
xattrs to determine if the queried xattr exists.


2. The number of hash functions
-------------------------------
The optimal value for the number of the hash functions (k) is (ln2 *
m/n), where m stands the number of bits of the bloom filter map, while n
stands the number of all candidates may be inside the set.

In our use case, the number of common used xattr (n) is approximately 8,
including system.[posix_acl_access|posix_acl_default],
security.[capability|selinux] and
security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].

Given the number of bits of the bloom filter (m) is 32, the optimal value
for the number of the hash functions (k) is 2 (ln2 * m/n = 2.7).


3. The hash function
--------------------
xxh32() is chosen as the hash function.

Following are some tested statistics of several candidate hash
functions.  Listed are time (in millionsecond) consumed when these hash
functions process input data in chunks of 24, 32, 64 and 4096 bytes.

	| 24 B 	| 32 B	| 64 B	| 4 KB
--------+-------+-------+-------+------
jhash	| 1325	| 2041 	| 4016	|  2294
jhash2	| 1323	| 2035	| 4011	|  2310
crc16	| 7918	| 1056	| 2110	| 13784
crc32	| 1824	| 2436	| 4873	|  3107
crc32c	| 2120	| 2708	| 5142	|  3109
xxhash	| 1320	| 1967	| 2131	|   429
xxh32	| 1458	| 1358	| 1848	|   836
xxh64	| 1321	| 2081	| 2128	|   429


3.1. multiple hash functions with various seeds
-----------------------------------------------
As previously described, the given data will be mapped into several bits
of the bloom filter map with hash functions.  There could be several
hash functions (k), with each hash function mapping the given data into
one bit of the bloom filter map.  Thus given the number of hash
functions (k), each xattr name will be mapped into k bits of the bloom
filter map.

Here in our use case, k hash functions are all xxh32() but with
different seeds.  As following shows, the seed is (index + i), where i
stands the index of the current hash function among all hash functions.
In this way, each hash function is distinguishable with others.

```
for (i = 0; i < k; i++)
	bit = xxh32(name, strlen(name), index + i);
```

3.2. input of hash function
-------------------------
As previously described, each hash function will map the given data into
one bit of the bloom filter map.  In our use case, xattr name serves as
the key of hash function.

When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
and the remaining name apart from the prefix are handy.  To avoid
constructing the full xattr name, the above index and name are fed into
the hash function directly in the following way:

```
bit = xxh32(name, strlen(name), index + i);
```

where index serves as part of seed, so that it gets involved in the
calculation for the hash.

An alternative way is to calculate the hash from the full xattr name by
feeding the prefix string and the remaining name string separately in
the following way:

```
xxh32_reset()
xxh32_update(prefix string, ...)
xxh32_update(remaining name, ...)
xxh32_digest()
```

But I doubt if it really deserves to call multiple APIs instead of one
single xxh32().


Also be noted that for xattrs with long xattr name prefixes, the
above "name" is the xattr name after stripping the corresponding short
predefined xattr name prefix rather than the long xattr name prefix, as
only the former is handy in the kernel routine.


3.3. discussions
----------------
I think a wider discussion on the implementation details is needed,
including the number of the hash functions, and all other implementation
details mentioned above, as they are also part of the on-disk format.


Performance Improvement
=======================
The performance statistics are tested with 'ls -lR' workload upon the
dataset [1].
			| uncached(ms)  | cached(ms)
------------------------+---------------+----------
erofs.share		| 468		| 264
erofs.share.bloom	| 370		| 254
erofs.share.noacl	| 412		| 216
erofs.share.noacl.bloom	| 318		| 206

The tested erofs image is built in shared xattr layout.  It indicates
~20% performance improvement with bloom filter in uncached scenarios.


[1] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
[2] https://lore.kernel.org/all/071074ad149b189661681aada453995741f75039.camel@redhat.com/


Jingbo Xu (2):
  erofs: update on-disk format for xattr name filter
  erofs: boost negative xattr lookup with bloom filter

 fs/erofs/erofs_fs.h |  8 +++++++-
 fs/erofs/internal.h |  2 ++
 fs/erofs/xattr.c    | 12 ++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.19.1.6.gb485710b


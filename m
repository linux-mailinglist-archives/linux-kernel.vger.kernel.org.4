Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1B669CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjAMPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjAMPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192D7EC85
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673624074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nkTEvwnwKCoz5mwfXkdmxk0qiSk+vj0kq3gpwQ2MC4g=;
        b=KcHVNX+KGc/xDRFDQx5zgP4Llrxu9rSpJwr19XSPqyrX+mI0VCFk5XTGqlAf9Xjqvz/l/Q
        9TsT42fJauK1CdxlGbJLE+IGwfVjqjNqbHtlwNAmyAbBHPQUm7NI1VyAp/Wme3/xiLDjRz
        1WMgVRt8AYPiXcuaM+EQqqW3a6xwvoM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-hv-oBVQ_NiaMX8jymOZB7A-1; Fri, 13 Jan 2023 10:34:33 -0500
X-MC-Unique: hv-oBVQ_NiaMX8jymOZB7A-1
Received: by mail-lj1-f197.google.com with SMTP id e20-20020a2e8ed4000000b0027ffe3be6f8so5656242ljl.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkTEvwnwKCoz5mwfXkdmxk0qiSk+vj0kq3gpwQ2MC4g=;
        b=wKkdZg3Y+v4ce5cU/3+1Scp+cOQpRZ/NR0m3ZcFn2perZN8hlGsS+gJVfCstOb4Av+
         icIcm8nCfAjt0lBl6utTRwT6qbNsXnqtzAcK2G+mFwOEDe/lJtB6Z7rvcTNw8xEPCypQ
         ECZEGw+gbHa8efHhJ1IhWqW5pSuewaKV1vo7miiP8ZQBTfTcu7t4a8NIQnFDcd/SQmtx
         05IUJb8jSjNX7339160dDgeuwk4gjxF63M1GDk5RVVM7TCmQ16HUzVZMxQWCBjLZ2E6m
         IQYME+Aydd+Qd+rjnI1SliKcfkBAAjtdgdYFULLePAFScEwR1/co/0NZ23AoowjJ8+FC
         G/Jg==
X-Gm-Message-State: AFqh2krdqH1cSdMzHAeSpvSXOkPxO4TT3wBYIerglY041KozmiEw3DAl
        e7BjtLowtC76eiDFubwVG8iO0+DSKBpCfSo8laYXmKJHvfTd/B/rtRhbh7KZlkA5AFhRuq2DzGa
        89XiQ4vf4m9MLVHfXS+TTPVfv
X-Received: by 2002:a05:651c:1a0a:b0:282:b95e:bf73 with SMTP id by10-20020a05651c1a0a00b00282b95ebf73mr8791553ljb.4.1673624071040;
        Fri, 13 Jan 2023 07:34:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvvCdv23pjulJqBNHeBYyFzpl1zVckPzLTSjWcj3SvmREsgpND0v97bhuD79EDFO9WZoTWtaA==
X-Received: by 2002:a05:651c:1a0a:b0:282:b95e:bf73 with SMTP id by10-20020a05651c1a0a00b00282b95ebf73mr8791547ljb.4.1673624070831;
        Fri, 13 Jan 2023 07:34:30 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id p20-20020a2e9a94000000b00289bb528b8dsm725473lji.49.2023.01.13.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:34:30 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 0/6] Composefs: an opportunistically sharing verified image filesystem
Date:   Fri, 13 Jan 2023 16:33:53 +0100
Message-Id: <cover.1673623253.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano and I have recently been working on a new project we
call composefs. This is the first time we propose this publically and
we would like some feedback on it.

At its core, composefs is a way to construct and use read only images
that are used similar to how you would use e.g. loop-back mounted
squashfs images. On top of this composefs has two fundamental
features. First it allows sharing of file data (both on disk and in
page cache) between images, and secondly it has dm-verity like
validation on read.

Let me first start with a minimal example of how this can be used,
before going into the details:

Suppose we have this source for an image:

rootfs/
├── dir
│   └── another_a
├── file_a
└── file_b

We can then use this to generate an image file and a set of
content-addressed backing files:

# mkcomposefs --digest-store=objects rootfs/ rootfs.img
# ls -l rootfs.img objects/*/*
-rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
-rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
-rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img

The rootfs.img file contains all information about directory and file
metadata plus references to the backing files by name. We can now
mount this and look at the result:

# mount -t composefs rootfs.img -o basedir=objects /mnt
# ls  /mnt/
dir  file_a  file_b
# cat /mnt/file_a
content_a

When reading this file the kernel is actually reading the backing
file, in a fashion similar to overlayfs. Since the backing file is
content-addressed, the objects directory can be shared for multiple
images, and any files that happen to have the same content are
shared. I refer to this as opportunistic sharing, as it is different
than the more course-grained explicit sharing used by e.g. container
base images.

The next step is the validation. Note how the object files have
fs-verity enabled. In fact, they are named by their fs-verity digest:

# fsverity digest objects/*/*
sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f

The generated filesystm image may contain the expected digest for the
backing files. When the backing file digest is incorrect, the open
will fail, and if the open succeeds, any other on-disk file-changes
will be detected by fs-verity:

# cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
content_a
# rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
# echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
# cat /mnt/file_a
WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
cat: /mnt/file_a: Input/output error

This re-uses the existing fs-verity functionallity to protect against
changes in file contents, while adding on top of it protection against
changes in filesystem metadata and structure. I.e. protecting against
replacing a fs-verity enabled file or modifying file permissions or
xattrs.

To be fully verified we need another step: we use fs-verity on the
image itself. Then we pass the expected digest on the mount command
line (which will be verified at mount time):

# fsverity enable rootfs.img
# fsverity digest rootfs.img
sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 rootfs.img
# mount -t composefs rootfs.img -o basedir=objects,digest=da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt

So, given a trusted set of mount options (say unlocked from TPM), we
have a fully verified filesystem tree mounted, with opportunistic
finegrained sharing of identical files.

So, why do we want this? There are two initial users. First of all we
want to use the opportunistic sharing for the podman container image
baselayer. The idea is to use a composefs mount as the lower directory
in an overlay mount, with the upper directory being the container work
dir. This will allow automatical file-level disk and page-cache
sharning between any two images, independent of details like the
permissions and timestamps of the files.

Secondly we are interested in using the verification aspects of
composefs in the ostree project. Ostree already supports a
content-addressed object store, but it is currently referenced by
hardlink farms. The object store and the trees that reference it are
signed and verified at download time, but there is no runtime
verification. If we replace the hardlink farm with a composefs image
that points into the existing object store we can use the verification
to implement runtime verification.

In fact, the tooling to create composefs images is 100% reproducible,
so all we need is to add the composefs image fs-verity digest into the
ostree commit. Then the image can be reconstructed from the ostree
commit info, generating a file with the same fs-verity digest.

These are the usecases we're currently interested in, but there seems
to be a breadth of other possible uses. For example, many systems use
loopback mounts for images (like lxc or snap), and these could take
advantage of the opportunistic sharing. We've also talked about using
fuse to implement a local cache for the backing files. I.e. you would
have the second basedir be a fuse filesystem. On lookup failure in the
first basedir it downloads the file and saves it in the first basedir
for later lookups. There are many interesting possibilities here.

The patch series contains some documentation on the file format and
how to use the filesystem.

The userspace tools (and a standalone kernel module) is available
here:
  https://github.com/containers/composefs

Initial work on ostree integration is here:
  https://github.com/ostreedev/ostree/pull/2640

Changes since v1:
- Fixed some minor compiler warnings
- Fixed build with !CONFIG_MMU
- Documentation fixes from review by Bagas Sanjaya
- Code style and cleanup from review by Brian Masney
- Use existing kernel helpers for hex digit conversion
- Use kmap_local_page() instead of deprecated kmap()

Alexander Larsson (6):
  fsverity: Export fsverity_get_digest
  composefs: Add on-disk layout
  composefs: Add descriptor parsing code
  composefs: Add filesystem implementation
  composefs: Add documentation
  composefs: Add kconfig and build support

 Documentation/filesystems/composefs.rst | 169 +++++
 Documentation/filesystems/index.rst     |   1 +
 fs/Kconfig                              |   1 +
 fs/Makefile                             |   1 +
 fs/composefs/Kconfig                    |  18 +
 fs/composefs/Makefile                   |   5 +
 fs/composefs/cfs-internals.h            |  63 ++
 fs/composefs/cfs-reader.c               | 927 ++++++++++++++++++++++++
 fs/composefs/cfs.c                      | 903 +++++++++++++++++++++++
 fs/composefs/cfs.h                      | 203 ++++++
 fs/verity/measure.c                     |   1 +
 11 files changed, 2292 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst
 create mode 100644 fs/composefs/Kconfig
 create mode 100644 fs/composefs/Makefile
 create mode 100644 fs/composefs/cfs-internals.h
 create mode 100644 fs/composefs/cfs-reader.c
 create mode 100644 fs/composefs/cfs.c
 create mode 100644 fs/composefs/cfs.h

-- 
2.39.0


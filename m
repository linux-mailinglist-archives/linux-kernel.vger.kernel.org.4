Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6127712AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEZQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjEZQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:43:58 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BED9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:43:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjX7bdM_1685119431;
Received: from 192.168.2.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjX7bdM_1685119431)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 00:43:53 +0800
Message-ID: <ac8519fd-85f4-e778-0c6c-b2e893a37628@linux.alibaba.com>
Date:   Sat, 27 May 2023 00:43:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Du Rui <durui@linux.alibaba.com>, alexl@redhat.com
Cc:     agk@redhat.com, dm-devel@redhat.com, gscrivan@redhat.com,
        linux-kernel@vger.kernel.org, snitzer@kernel.org
References: <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
 <20230526102633.31160-1-durui@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230526102633.31160-1-durui@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 03:26, Du Rui wrote:
> Hi Alexander,
> 
>> all the lvm volume changes and mounts during runtime caused
>> weird behaviour (especially at scale) that was painful to manage (just
>> search the docker issue tracker for devmapper backend). In the end
>> everyone moved to a filesystem based implementation (overlayfs based).
> 
> Yes, we had exactly the same experience. This is another reason why
> this proposal is for dm and lvm, not for container.
> (BTW, we are using TCMU and ublk for overlaybd in production. They are awesome.)
> 
> 
>> This solution doesn't even allow page cache sharing between shared
>> layers (like current containers do), much less between independent
>> layers.
> 
> Page cache sharing can be realized with DAX support of the dm targets
> (and the inner file system), together with virtual pmem device backend.

First, here I'd suggest you could learn some kernel knowledge of what
DAX is and what page cache is before you explain to a kernel mailing
list.  For example, DAX memory cannot be reclaimed at all.

Block drivers has nothing to do on filesystem page cache stuffs, also
currently your approach has nothing to do with pmem stuffs (If you must
mention "DAX" to proposal your "page cache sharing", please _here_
write down your detailed design first and explain how it could work to
ours if you really want to do.)

Apart from unable to share page cache among filesystems, even with
your approach all I/Os are duplicated among your qcow2-like layers.

For example, there are 3 qcow2-like layers: A, B, C:

filesystem 1:  A + B
filesystem 2:  A + B + C

Filesystem 1 and 2 are runtimely independent filesystems and your block
driver can do nothing help: both duplicated I/Os and page cache for any
data and metadata of layer A, B.

If those container layers are even more (dozens or hundreds), your
approach is more inefficient on duplicated I/Os.

You could implement some internal block cache, but block level cache is
not flexible compared with page cache on kernel memory reclaim and page
migration.

> 
>> Erofs already has some block-level support for container images
> 
> It is interesting. Erofs runs insider a block device in the first place,
> like what many file systems do. But do you konw why it implements another
> "some block-level support" by itself?
> 

That is funny honestly.  As for container image use cases, although OCI
image tgz is unseekable but actually ext4 and btrfs images are seekable
and on-demand load could be done with these raw images directly. In
principle, you could dump your container image stuffs from tgz to raw
ext4, btrfs, erofs, whatever.  Or if you like, you could dump to some
"qcow2", "vhdx", "vmdx" wildly-used format, their ecosystem is more
mature but all the above don't help on page cache sharing stuffs.

Please don't say "I like erofs" and at the same time "why it implements
another some block-level support" by itself".  Local filesystems must
do their block-mapping theirselves: ext4 (extents or blockmap), XFS
(extents), etc.

I've explained internally to your team multiple times as a kernel
developer, personally I don't want to repeat here again and again to
your guys.

Thanks,
Gao Xiang

>> And this new approach doesn't help
> No. It is intended for dm and lvm.> 

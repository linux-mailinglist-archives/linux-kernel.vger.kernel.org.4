Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F871327B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 06:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjE0EMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 00:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjE0EMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 00:12:33 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA95DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 21:12:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjYkMWT_1685160745;
Received: from 30.0.159.48(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjYkMWT_1685160745)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 12:12:28 +0800
Message-ID: <11c1e59f-d05e-5479-fa6b-36d9a793c16e@linux.alibaba.com>
Date:   Sat, 27 May 2023 12:12:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Du Rui <durui@linux.alibaba.com>
Cc:     agk@redhat.com, alexl@redhat.com, dm-devel@redhat.com,
        gscrivan@redhat.com, linux-kernel@vger.kernel.org,
        snitzer@kernel.org, Gao Xiang <xiang@kernel.org>
References: <ac8519fd-85f4-e778-0c6c-b2e893a37628@linux.alibaba.com>
 <20230527031319.92200-1-durui@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230527031319.92200-1-durui@linux.alibaba.com>
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



On 2023/5/27 11:13, Du Rui wrote:
>> Block drivers has nothing to do on filesystem page cache stuffs, also
>> currently your approach has nothing to do with pmem stuffs (If you must
>> mention "DAX" to proposal your "page cache sharing", please _here_
>> write down your detailed design first and explain how it could work to
>> ours if you really want to do.)
> 
> We have already done experiments (by virtio pmem), to make virtual PMEM
> device in QEMU, make guest vm sharing only one memory mapping on host,
> with filesystem that supports DAX. In guest vm, fs keeps no page cache,
> maybe "sharing pagecache" is not such accurate description, but sharing
> memory pages on host can do prevent making duplicated pagecache pages in
> VMs.

First, does virtio-pmem have some relationship with this kernel
claim "dm / lvm" proposal" of yours?  Does your virtio-pmem work
on bare matel or cloud server or runC (I mean without some host
adaption)?

Secondly, does your virtio-pmem have any relationship with this
kernel approach? If not, why not directly using your userspace
work on your specific use case? How does this kernel DM approach
have any help to your "sharing pagecache"?

Do you know how kernel FSDAX work and what type of memory of
pmem is?  Could you give me your detailed kernel design to do
in-kernel DM+pmem dax mapping?

> 
> Please make sure that you have already understood that dm-overlaybd are
> for GENERIC purpose. It is NOT a special design for container, and have
> nothing related to filesystem implementations.
Previous dm-qcow2 is more generic (on-disk format friendly for
read-write as well as qcow2 format with two-level l1/l2 indexes
takes less runtime memory persistent footprint than your on-disk
format which needs to load and parse your hardly-seekable on-disk
lsmt+zfile layer indexes to some new in-memory represention which
can be used for random accesses before any real I/Os and these
in-memory indexes _cannot_ be _partially reclaimed_ from memory)
and qcow2 has more wider ecosystem compared to your approach, but
could you see the community tendency of this?

ublk-qcow2: ublk-qcow2 is available:
https://lore.kernel.org/r/Yza1u1KfKa7ycQm0@T590

Second, I have to mention here your previous attempt including
read (maybe later write) your DADI file stuffs in your
in-kernel block driver, which I think that was really
dangerous:

see vfsfile.c of your previous codebase
https://github.com/data-accelerator/dadi-kernel-mod/commit/ff12687f2c567ddf51a28df88b25dd2d0e3737a2

static struct file *file_open(const char *path, int flags, int rights)
{
..
	fp = filp_open(path, O_RDONLY, 0);
..
}

static ssize_t file_read(struct file *file, void *buf, size_t count, loff_t pos)
{
..
	vfs_fadvise(file, pos, count, POSIX_FADV_SEQUENTIAL);
..
		ret = kernel_read(file, buf, count, &lpos);
..
}

In your current proposed patch, you still call it as "struct
vfile" but use raw block device stuffs instead.

But this raw block device use cases are limited (almost useless)
for containers since as Alex said, almost all container users
switch to filesystem-based approach (I don't want to repeat why).
And your kernel approach is almost useless for virtual machine
use cases (see how qcow2 works for VMs).

In the end, Assume that if you *end up with* later upstreaming
reading backing filesystem files directly under the block layer
(for example, as your second step), that is really a not-go.

Anyway, all the above is on behalf myself.

Thanks,
Gao Xiang

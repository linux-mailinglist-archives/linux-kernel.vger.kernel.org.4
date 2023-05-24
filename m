Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE97C70EEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbjEXHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbjEXG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:59:48 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72C1B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:59:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjMytmC_1684911581;
Received: from 30.240.109.115(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjMytmC_1684911581)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 14:59:42 +0800
Message-ID: <ff5a72a3-3977-68f1-c5c6-41c90b7229b2@linux.alibaba.com>
Date:   Wed, 24 May 2023 14:59:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
 <ZGz32yw7ecKhW+lj@redhat.com>
From:   Du Rui <durui@linux.alibaba.com>
In-Reply-To: <ZGz32yw7ecKhW+lj@redhat.com>
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

Hi Mike,

On 5/24/23 1:28 AM, Mike Snitzer wrote:
> On Fri, May 19 2023 at  6:27P -0400,
> Du Rui <durui@linux.alibaba.com> wrote:
> 
>> OverlayBD is a novel layering block-level image format, which is design
>> for container, secure container and applicable to virtual machine,
>> published in USENIX ATC '20
>> https://www.usenix.org/system/files/atc20-li-huiba.pdf
>>
>> OverlayBD already has a ContainerD non-core sub-project implementation
>> in userspace, as an accelerated container image service
>> https://github.com/containerd/accelerated-container-image
>>
>> It could be much more efficient when do decompressing and mapping works
>> in the kernel with the framework of device-mapper, in many circumstances,
>> such as secure container runtime, mobile-devices, etc.
>>
>> This patch contains a module, dm-overlaybd, provides two kinds of targets
>> dm-zfile and dm-lsmt, to expose a group of block-devices contains
>> OverlayBD image as a overlaid read-only block-device.
>>
>> Signed-off-by: Du Rui <durui@linux.alibaba.com>
> 
> <snip, original patch here: [1] >
> 
> I appreciate that this work is being done with an eye toward
> containerd "community" and standardization but based on my limited
> research it appears that this format of OCI image storage/use is only
> used by Alibaba? (but I could be wrong...)
> 
> But you'd do well to explain why the userspace solution isn't
> acceptable. Are there security issues that moving the implementation
> to kernel addresses?
> 
> I also have doubts that this solution is _actually_ more performant
> than a proper filesystem based solution that allows page cache sharing
> of container image data across multiple containers.
> 
> There is an active discussion about, and active development effort
> for, using overlayfs + erofs for container images.  I'm reluctant to
> merge this DM based container image approach without wider consensus
> from other container stakeholders.
> 
> But short of reaching wider consensus on the need for these DM
> targets: there is nothing preventing you from carrying these changes
> in your alibaba kernel.
> 
> Mike
> 
> [1]: https://patchwork.kernel.org/project/dm-devel/patch/9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com/

OverlayBD is a generic solution for overlayable and random accessable 
read-only block device, it is a part of container image solution, but 
not only designed for container images. Actually our team also use it in 
VM and other data images.

Container images in format of OverlayBD is not only used in Alibaba, as 
a open-source solution of containerd, it has already have users in 
community. The project also have contributors from community.

I do like erofs, and also looking forward to widely used container image 
solutions via filesystem. But any filesystem container image soultion 
has no conflict with a generic block device image.

All filesystems that access data via block-devices are possible to 
create OverlayBD image, including those widely used filesystems. With 
dm-snapshot or dm-thin providing writable layer for a read-only block 
device, block images can be mounted as full featured filesystem, with 
100% compatibility to those filesystems on normal block devices.

By my tests, erofs, btrfs, squashfs, and other filesystems on OverlayBD 
performs very well, in some certain circumstances, even better that 
those on raw block devices.

Considering sharing page cache, lots of filesystem supports DAX for PMEM 
devices, that might be a way to work around I think. Currently those 
related implementation is not a part of this module.

Thanks for the replying.

Du Rui

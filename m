Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80470EF26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjEXHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjEXHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:15:19 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5EB3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:13:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjN6v8P_1684912430;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjN6v8P_1684912430)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 15:13:51 +0800
Message-ID: <fd4d0429-4da3-8217-6c13-14fd8a198920@linux.alibaba.com>
Date:   Wed, 24 May 2023 15:13:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Alexander Larsson <alexl@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
 <ZGz32yw7ecKhW+lj@redhat.com>
 <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 23:43, Alexander Larsson wrote:
> On Tue, May 23, 2023 at 7:29 PM Mike Snitzer <snitzer@kernel.org> wrote:
>>
>> On Fri, May 19 2023 at  6:27P -0400,
>> Du Rui <durui@linux.alibaba.com> wrote:
>>
>>> OverlayBD is a novel layering block-level image format, which is design
>>> for container, secure container and applicable to virtual machine,
>>> published in USENIX ATC '20
>>> https://www.usenix.org/system/files/atc20-li-huiba.pdf
>>>
>>> OverlayBD already has a ContainerD non-core sub-project implementation
>>> in userspace, as an accelerated container image service
>>> https://github.com/containerd/accelerated-container-image
>>>
>>> It could be much more efficient when do decompressing and mapping works
>>> in the kernel with the framework of device-mapper, in many circumstances,
>>> such as secure container runtime, mobile-devices, etc.
>>>
>>> This patch contains a module, dm-overlaybd, provides two kinds of targets
>>> dm-zfile and dm-lsmt, to expose a group of block-devices contains
>>> OverlayBD image as a overlaid read-only block-device.
>>>
>>> Signed-off-by: Du Rui <durui@linux.alibaba.com>
>>
>> <snip, original patch here: [1] >
> 
> A long long time ago I wrote a docker container image based on
> dm-snapshot that is vaguely similar to this one. It is still
> available, but nobody really uses it. It has several weaknesses. First
> of all the container image is an actual filesystem, so you need to
> pre-allocate a fixed max size for images at construction time.
> Secondly, all the lvm volume changes and mounts during runtime caused
> weird behaviour (especially at scale) that was painful to manage (just
> search the docker issue tracker for devmapper backend). In the end
> everyone moved to a filesystem based implementation (overlayfs based).

Yeah, and I think reproducibility issue is another problem, which means
it's quite hard to select a random fs without some change to get the
best result.  I do find these guys work on e2fsprogs again and again.

I've already told them internally again and again, but.. They only focus
on some minor points such as how to do I/O and CPU prefetch to get
(somewhat) better performance and beat EROFS.  I don't know, I have no
enough time to even look into that whether this new kernel stuffs is
fine: because of a very simplist idea:

  stacked storage overhead generally takes double runtime/memory
footprints:
    filesystem + block drivers

> 
>> I appreciate that this work is being done with an eye toward
>> containerd "community" and standardization but based on my limited
>> research it appears that this format of OCI image storage/use is only
>> used by Alibaba? (but I could be wrong...)
>>
>> But you'd do well to explain why the userspace solution isn't
>> acceptable. Are there security issues that moving the implementation
>> to kernel addresses?
>>
>> I also have doubts that this solution is _actually_ more performant
>> than a proper filesystem based solution that allows page cache sharing
>> of container image data across multiple containers.
> 
> This solution doesn't even allow page cache sharing between shared
> layers (like current containers do), much less between independent
> layers.
> 
>> There is an active discussion about, and active development effort
>> for, using overlayfs + erofs for container images.  I'm reluctant to
>> merge this DM based container image approach without wider consensus
>> from other container stakeholders.
>>
>> But short of reaching wider consensus on the need for these DM
>> targets: there is nothing preventing you from carrying these changes
>> in your alibaba kernel.
> 
> Erofs already has some block-level support for container images (with
> nydus), and composefs works with current in-kernel EROFS+overlayfs.
> And this new approach doesn't help for the IMHO current weak spot we
> have, which is unprivileged container images.
> 
> Also, while OCI artifacts can be used to store any kind of image
> formats (or any other kind of file) I think for an actual standardized
> new image format it would be better to work with the OCI org to come
> up with a OCI v2 standard image format.

Agreed, I hope you guys could actually sit down and evaluate a proper
solution on the next OCI v2, currently I know there are:

  - Composefs
  - (e)stargz   https://github.com/containerd/stargz-snapshotter
  - Nydus       https://github.com/containerd/nydus-snapshotter
  - OverlayBD   https://github.com/containerd/accelerated-container-image
  - SOCI        https://github.com/awslabs/soci-snapshotter
  - Tarfs
  - (maybe even more..)

Honestly, I do think OSTree/Composefs is the best approach for now for
deduplication and page cache sharing (due to kernel limitation of page
cache sharing and overlayfs copyup limitation).  I'm too tired of
container image stuffs honestly.  Too much unnecessary manpower waste.

Thanks,
Gao Xiang

> 
> But, I don't really speak for the block layer developers, so take my
> opinions with a pinch of salt.
> 

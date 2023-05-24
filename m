Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2770EA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjEXA4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:56:19 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA52C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:56:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjLvOod_1684889773;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjLvOod_1684889773)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 08:56:14 +0800
Message-ID: <17c39e1d-2376-c90f-5e87-ed1982a7cff9@linux.alibaba.com>
Date:   Wed, 24 May 2023 08:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [dm-devel] dm overlaybd: targets mapping OverlayBD image
To:     Mike Snitzer <snitzer@kernel.org>, Du Rui <durui@linux.alibaba.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
 <ZGz32yw7ecKhW+lj@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZGz32yw7ecKhW+lj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2023/5/24 10:28, Mike Snitzer wrote:
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

Not necessarily Alibaba, actually OverlayBD solution is open-source to
containerd, at least I think it's an opensource project and I saw some
Microsoft Azure guys are also working on this.

> 
> But you'd do well to explain why the userspace solution isn't
> acceptable. Are there security issues that moving the implementation
> to kernel addresses?

OverlayBD user-space solution was actually the original Alibaba solution
widely used in Alibaba internally, and Nydus might be the another one
(used but limited, Ant group and Bytedance use Nydus more widely.) Since
Alibaba group is a big company, it's pretty normal to have two similiar
competing solutions together.

After I joined Alibaba, personally, I persuaded OverlayBD guys switching
from their stacked storage solution to a simple fs solution, because:

  - It allows a simple on-disk format rather than a long storage stack
    with a random fs, it increases the overall attack vector: which I
    think this year LSF/MM already discuss about that;

  - Different random fses cannot share page cache across images. IOWs,
    many in-kernel fses actually doesn't suit for container image use
    cases;

Also consider this one:
  - Apart from the detailed on-disk design, this attempt is just a
    read-only solution without  1) on-demand load;  2) write support;

  - Very similar to the exist approaches:
    dm-qcow2  https://lore.kernel.org/r/164846619932.251310.3668540533992131988.stgit@pro/
    dm-vdo   https://lore.kernel.org/r/20230523214539.226387-1-corwin@redhat.com/

I also persuaded Nydus guys from their own format to erofs format, but
I failed to persuaded Overlaybd guys.

> 
> I also have doubts that this solution is _actually_ more performant
> than a proper filesystem based solution that allows page cache sharing
> of container image data across multiple containers.

Agreed.

> 
> There is an active discussion about, and active development effort
> for, using overlayfs + erofs for container images.  I'm reluctant to
> merge this DM based container image approach without wider consensus
> from other container stakeholders.

I'm too tired about these different container image solutions.  I will
go on improve EROFS, and hopefully it will finally useful to everyone.

Thanks,
Gao Xiang

> 
> But short of reaching wider consensus on the need for these DM
> targets: there is nothing preventing you from carrying these changes
> in your alibaba kernel.
> 
> Mike
> 
> [1]: https://patchwork.kernel.org/project/dm-devel/patch/9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com/
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel

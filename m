Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921C74250F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjF2LkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjF2LkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:40:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF0610F0;
        Thu, 29 Jun 2023 04:40:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D592C14;
        Thu, 29 Jun 2023 04:40:56 -0700 (PDT)
Received: from [10.57.33.98] (unknown [10.57.33.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5BB3F64C;
        Thu, 29 Jun 2023 04:40:10 -0700 (PDT)
Message-ID: <11d40d12-bb6c-25b3-ef44-43f4ded0e628@arm.com>
Date:   Thu, 29 Jun 2023 12:40:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
 <CANiDSCsAgD33gMk9-CTGHuUv_b4KfRnO02ETEt6jFtQvw+6cag@mail.gmail.com>
 <ZJystxdl0jVoe5b6@google.com>
 <CANiDSCu3WOqK9wdLDXmW+zbckq15gmxKjtFA4Aghv6uoidO_3Q@mail.gmail.com>
 <2023062942-thumb-giddily-f0e0@gregkh>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2023062942-thumb-giddily-f0e0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-29 09:40, Greg Kroah-Hartman wrote:
> On Thu, Jun 29, 2023 at 09:13:23AM +0200, Ricardo Ribalda wrote:
>> Hi Zubin
>>
>> On Wed, 28 Jun 2023 at 23:57, Zubin Mithra <zsm@chromium.org> wrote:
>>>
>>> On Wed, Jun 28, 2023 at 11:04:20PM +0200, Ricardo Ribalda wrote:
>>>> On Wed, 28 Jun 2023 at 23:00, Ricardo Ribalda <ribalda@chromium.org> wrote:
>>>>>
>>>>> Allow devices to have dma operations beyond 64K, and avoid warnings such
>>>>> as:
>>>>>
>>>>> DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
>>>>>
>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>> Reported-by: Zubin Mithra <zsm@chromium.org>
>>>
>>> Should this be cc'd to stable@ as well?
>>
>> Not sure, in most of the cases this is "just" a warning fix. Let the
>> maintainer decide:
> 
> Warnings can cause reboots as the majority of the linux systems in the
> world run panic-on-warn, so yes, it should be backported.

Although in this particular case, running DMA_API_DEBUG=y on production 
systems is a pretty inadvisable thing to do anyway ;)

However I'm glad I looked, since I think this also points to a bug in 
dma_alloc_noncontiguous() - it's one thing to blame a driver for trying 
to map a malformed scatterlist of its own, but if the DMA API is 
generating one internally without respecting the device's (claimed) 
parameters, then that's on us. I'll have a look into it...

Thanks,
Robin.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2464863EF86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLALdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiLALdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:33:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E132252C;
        Thu,  1 Dec 2022 03:32:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A04DBB81EED;
        Thu,  1 Dec 2022 11:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061CEC433C1;
        Thu,  1 Dec 2022 11:32:54 +0000 (UTC)
Message-ID: <20badb75-65c7-719e-ab93-28e6b5e97f22@xs4all.nl>
Date:   Thu, 1 Dec 2022 12:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, posciak@chromium.org,
        paul.kocialkowski@bootlin.com, mchehab+samsung@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>
References: <TYAPR01MB6201561D2644EE783BA8B196922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <b645f983-447b-7b4b-6dd6-d5f10da08e96@xs4all.nl>
 <TYAPR01MB62019A8DD1215F41F0FE663C92309@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <TYAPR01MB62019A8DD1215F41F0FE663C92309@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

On 26/10/2022 11:16, yuji2.ishikawa@toshiba.co.jp wrote:
> Hi Hans,
> 
>> -----Original Message-----
>> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> Sent: Monday, October 24, 2022 4:49 PM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; posciak@chromium.org;
>> paul.kocialkowski@bootlin.com; mchehab+samsung@kernel.org;
>> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: Question for an accepted patch: use of DMA-BUF based videobuf2
>> capture buffer with no-HW-cache-coherent HW
>>
>> Hi Yuji,
>>
>> On 10/24/22 06:02, yuji2.ishikawa@toshiba.co.jp wrote:
>>> Hi,
>>>
>>> I'm porting a V4L2 capture driver from 4.19.y to 5.10.y [1].
>>>
>>> When I test the ported driver, I sometimes find a corruption on a captured
>> image.
>>>
>>> Because the corruption is exactly aligned with cacheline, I started
>> investigation from map/unmap of DMA-BUF.
>>>
>>>
>>>
>>> The capture driver uses DMA-BUF for videobuf2.
>>>
>>> The capture hardware does not have HW-mantained cache coherency with
>> CPU, that is, explicit map/unmap is essential on QBUF/DQBUF.
>>>
>>> After some hours of struggle, I found a patch removing cache synchronizations
>> on QBUF/DQBUF.
>>>
>>>
>>>
>>> https://patchwork.kernel.org/project/linux-media/patch/20190124095156.
>>> 21898-1-paul.kocialkowski@bootlin.com/
>>> <https://patchwork.kernel.org/project/linux-media/patch/20190124095156
>>> .21898-1-paul.kocialkowski@bootlin.com/>
>>>
>>>
>>>
>>> When I removed this patch from my 5.10.y working-tree, the driver
>>> yielded images without any defects.v
>>>
>>>
>>>
>>> ***************
>>>
>>> Sorry for a mention to a patch released 4 years ago.
>>>
>>> The patch removes map/unmap on QBUF/DQBUF to improve the
>> performance of V4L2 decoder device, by reusing previously decoded frames.
>>>
>>> However, there seems no cares nor compensations for modifying lifecycle of
>> DMA-BUF, especially on video capture devices.
>>
>> I'm not entirely sure what you mean exactly.
>>
> My concern is consistency between ioctls and the state transition of capture buffers.
> Generally, streaming I/O (DMA-BUF importing) buffers are handled following by userland.
> 
> Ioctl(VIDIOC_QBUF) -> /* DMA transfer from HW*/ -> ioctl(VIDIOC_DQBUF) -> /* access from CPU */ -> ioctl(VIDIOC_QBUF) -> ...
> 
> Therefore, expected semantics is that a buffer is owned by HW after QBUF, and owned by CPU after DQBUF.
> In practice, ioctl(QBUF) kicks vb2_dc_map_dma_buf() and ioctl(DQBUF) kicks vb2_dc_unmap_dma_buf() before applying the patch.
> This implementation keeps consistency in terms of cache coherency as cache-clean is done in vb2_dc_map_dma_buf().
> 
> By applying the patch, ioctl(DQBUF) does not kick unmap_dma() anymore. The similar for ioctl(QBUF).
> Therefore, in practice, a buffer is not owned by CPU just after ioctl(DQBUF).
> To keep compatibility of buffer operations, there should be delayed map_dma()/unmap_dma() call just before DMA-transfer/CPU-access.
> However, no one referred to such function in the v4l2 framework in the examination of the patch.
> Also, there is no advice for individual video device drivers; such that adding map_dma()/unmap_dma() explicitly.

The cache syncing is supposed to happen in __vb2_buf_mem_finish() where the
'finish' memop is called.

But for DMABUF it notes that:

        /*
         * DMA exporter should take care of cache syncs, so we can avoid
         * explicit ->prepare()/->finish() syncs. For other ->memory types
         * we always need ->prepare() or/and ->finish() cache sync.
         */

And here https://docs.kernel.org/driver-api/dma-buf.html I read that userspace
must call DMA_BUF_IOCTL_SYNC to ensure the caches are synced before using the
buffer.

Are you calling DMA_BUF_IOCTL_SYNC?

I suspect that vb2_dc_unmap_dma_buf() caused a cache sync, so you never noticed
issues.

Regards,

	Hans

> 
>>>
>>>
>>>
>>> Would you tell me some idea on this patch:
>>>
>>> * Do well-implemented capture drivers work well even if this patch is applied?
>>
>> Yes, dmabuf is used extensively and I have not had any reports of issues.
> 
> Many architectures can avoid this problem.
> A problem statistically occurs, only if a video capture HW does not have HW-maintained cache coherency with CPU.
> Does this patch consider such case?
> 
>>>
>>> * How should a video capture driver call V4L2/videobuf2 APIs, especially
>> when the hardware does not support cache coherency?
>>
>> It should all be handled correctly by the core frameworks.
>>
>> I think you need to debug more inside videobuf2-core.c. Some printk's that show
>> the dmabuf fd when the buffer is mapped and when it is unmapped + the length
>> it is mapping should hopefully help a bit.
> 
> I added printk and dump_stack() to several functions.
> The patched function __prepare_dmabuf() is called every ioctl(QBUF).
> Function vb2_dc_map_dmabuf() is called only for the 1st call of ioctl(QBUF) for a buffer instance.
> After that, vb2_dc_map_dmabuf() was never called, as the patch intended.
> 
> Regards,
> 	Yuji
> 
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>>
>>>
>>> ***************
>>>
>>> [1] FYI: the capture driver is not on mainline yet; the candidate is,
>>>
>>> https://lore.kernel.org/all/20220810132822.32534-1-yuji2.ishikawa@tosh
>>> iba.co.jp/
>>> <https://lore.kernel.org/all/20220810132822.32534-1-yuji2.ishikawa@tos
>>> hiba.co.jp/>
>>>
>>>
>>>
>>>
>>>
>>> Regards,
>>>
>>>               Yuji Ishikawa
>>>


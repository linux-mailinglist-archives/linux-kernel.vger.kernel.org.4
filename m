Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA5609BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJXHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJXHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA54F7C;
        Mon, 24 Oct 2022 00:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0455B80E23;
        Mon, 24 Oct 2022 07:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3673CC433C1;
        Mon, 24 Oct 2022 07:49:13 +0000 (UTC)
Message-ID: <b645f983-447b-7b4b-6dd6-d5f10da08e96@xs4all.nl>
Date:   Mon, 24 Oct 2022 09:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, posciak@chromium.org,
        paul.kocialkowski@bootlin.com, mchehab+samsung@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYAPR01MB6201561D2644EE783BA8B196922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <TYAPR01MB6201561D2644EE783BA8B196922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

On 10/24/22 06:02, yuji2.ishikawa@toshiba.co.jp wrote:
> Hi,
> 
> I'm porting a V4L2 capture driver from 4.19.y to 5.10.y [1].
> 
> When I test the ported driver, I sometimes find a corruption on a captured image.
> 
> Because the corruption is exactly aligned with cacheline, I started investigation from map/unmap of DMA-BUF.
> 
>  
> 
> The capture driver uses DMA-BUF for videobuf2.
> 
> The capture hardware does not have HW-mantained cache coherency with CPU, that is, explicit map/unmap is essential on QBUF/DQBUF.
> 
> After some hours of struggle, I found a patch removing cache synchronizations on QBUF/DQBUF.
> 
>  
> 
> https://patchwork.kernel.org/project/linux-media/patch/20190124095156.21898-1-paul.kocialkowski@bootlin.com/ <https://patchwork.kernel.org/project/linux-media/patch/20190124095156.21898-1-paul.kocialkowski@bootlin.com/>
> 
>  
> 
> When I removed this patch from my 5.10.y working-tree, the driver yielded images without any defects.v
> 
>  
> 
> ***************
> 
> Sorry for a mention to a patch released 4 years ago.
> 
> The patch removes map/unmap on QBUF/DQBUF to improve the performance of V4L2 decoder device, by reusing previously decoded frames.
> 
> However, there seems no cares nor compensations for modifying lifecycle of DMA-BUF, especially on video capture devices.

I'm not entirely sure what you mean exactly.

> 
>  
> 
> Would you tell me some idea on this patch:
> 
> * Do well-implemented capture drivers work well even if this patch is applied?

Yes, dmabuf is used extensively and I have not had any reports of issues.

> 
> * How should a video capture driver call V4L2/videobuf2 APIs, especially when the hardware does not support cache coherency?

It should all be handled correctly by the core frameworks.

I think you need to debug more inside videobuf2-core.c. Some printk's that show the
dmabuf fd when the buffer is mapped and when it is unmapped + the length it is
mapping should hopefully help a bit.

Regards,

	Hans

> 
>  
> 
> ***************
> 
> [1] FYI: the capture driver is not on mainline yet; the candidate is,
> 
> https://lore.kernel.org/all/20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp/ <https://lore.kernel.org/all/20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp/>
> 
>  
> 
>  
> 
> Regards,
> 
>               Yuji Ishikawa
> 

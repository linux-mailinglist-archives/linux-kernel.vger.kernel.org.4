Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06463A0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1FoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1FoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:44:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7B6170
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:44:20 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ozWwB-0008Hk-HK; Mon, 28 Nov 2022 06:44:15 +0100
Message-ID: <6a5b523d-711b-d809-06b9-fdada64c9c65@leemhuis.info>
Date:   Mon, 28 Nov 2022 06:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-US, de-DE
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669614260;845ae785;
X-HE-SMSGID: 1ozWwB-0008Hk-HK
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 12:03, Manivannan Sadhasivam wrote:
> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> 
> As reported by Amit [1], dropping cache invalidation from
> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> (most probably on other Qcom platforms too). The reason is, Qcom
> qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> for validation. The modem has a secure block (XPU) that will trigger a
> whole system crash if the shared memory is accessed by the CPU while modem
> is poking at it.
> [...]
> [1] https://lore.kernel.org/linux-arm-kernel/CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/
>

I have Amit's report on the list of tracked regressions. I also noticed
the proposed change "arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency":
https://lore.kernel.org/all/20221124142501.29314-1-johan+linaro@kernel.org/

I have no expertise in this area, but it looked somewhat related to my
eyes, so please allow me to quickly ask: is that related or even
supposed to fix Amit's regression?

Ciao, Thorsten

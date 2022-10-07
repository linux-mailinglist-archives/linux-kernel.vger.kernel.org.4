Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963A5F8115
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJGXR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJGXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:17:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49399F759
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A8E6CE18D3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 23:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC1BC433C1;
        Fri,  7 Oct 2022 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665184667;
        bh=g4k39+l5WOW6KmldEWGm/pmbP8ZMxghfPuq3gJQX1+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atCzcVdvVlyTQ+aCgrh4pXO4NZes0/NC88Dq8sqDjG27qOxtSg06vPTQsKLfrDFUs
         M1fAVgmxaMEIT8gVgghyOqXW1D82NtjReYgQqpHHXcyNh7op9Jpj4jbo2V+aazStNF
         m5hum0hsbQhfshxfXBIdtXtVwTtLbtVMq1LKzUXZiCrASvkwK8pYVGOHvjG9QbZS/l
         IUtWPudj6le0WzVRlTxcljgbpGj5VMXNNfcCED+y5WiR85fBQSFTOvrlKGzsDROE/w
         qsD8PcqHrIrjZAElY5l5P8k8sOyjpbmmcOpd+TwYEsYIL6Ev26vfFHRZ+gmmuHCzq2
         hTLzTvjtOQApA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ogwbB-00FDKL-4F;
        Sat, 08 Oct 2022 00:17:45 +0100
MIME-Version: 1.0
Date:   Sat, 08 Oct 2022 00:17:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
In-Reply-To: <20221007200022.22844-3-konrad.dybcio@somainline.org>
References: <20221007200022.22844-1-konrad.dybcio@somainline.org>
 <20221007200022.22844-3-konrad.dybcio@somainline.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <37c075fc9aa9624d65b8fdda3cb5ae96@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: konrad.dybcio@somainline.org, ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, martin.botka@somainline.org, angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org, jamipkettunen@somainline.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-07 21:00, Konrad Dybcio wrote:
> Add support for A7-A11 SoCs by if-ing out some features only present
> on A11 & newer (implementation-defined IPI & UNCORE registers).
> 
> Also, annotate IPI regs support in the aic struct so that the driver
> can tell whether the SoC supports these, as they are written to,
> even if fast IPI is disabled. This in turn causes a crash on older
> platforms, as the implemention-defined registers either do
> something else or are not supposed to be touched - definitely not a
> NOP though.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v3:
> - Replace use_fast_ipi with has_uncore_ipi_regs in aic_init_cpu
> (logic error, this was written to regardless of FIPI usage before,
> but touching Sn_... regs on SoCs that don't explicitly use them for
> IPIs makes them sepuku..)
> - Drop A11 compatible
> 
>  drivers/irqchip/irq-apple-aic.c | 47 ++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 15 deletions(-)

Since you cannot be bothered to read the review comments on
the previous versions of this series, I'll do the same with
these patches. Feel free to stop Cc-ing me.

         M.
-- 
Jazz is not dead. It just smells funny...

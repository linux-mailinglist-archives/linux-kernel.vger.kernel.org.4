Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313CF729C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbjFIOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjFIOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA93C06;
        Fri,  9 Jun 2023 07:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B226585A;
        Fri,  9 Jun 2023 14:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E87C433D2;
        Fri,  9 Jun 2023 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686319845;
        bh=pWEvgK5s7smvq54iBHJynBKQ8jT6malI3eJGPkwkTt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfWNj8U0zLfRvld8k8cn1npbE2heCFn3Y2u9pryCgAI04EjV60/1jxNC4GUJMRCgK
         LrABEUbPTvUD+SUrBbVi+MbIf+2UPyi6ScP+BxLMX+7S6sxXS/BM474LPT0FG2zeIk
         6W3wkly4oHISXpiYCCcGZTfUrEeJ42hJpAOBsVg3mfHm2xw61IivYD3CzGzloCy/Ux
         pMbxee1rz/B4mEW+ezPUeQ/IRbflEuGsGAiLqyETry2bSQsmgqk/xEc3obAJ3ab/oO
         2S28HWvjhAI/oibV+GH2jEg9K6wz8wi5gbvEx36HKtgUNKtYiYEPAK8Um4sp6s4Wvf
         e3JfPz1EZBuUQ==
Date:   Fri, 9 Jun 2023 22:10:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8mp: Add coresight trace components
Message-ID: <20230609141025.GW4199@dragon>
References: <20230515150149.2790189-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515150149.2790189-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:01:49AM -0400, Frank Li wrote:
> Add coresight trace components (ETM, ETF, ETB and Funnel).
> 
> ┌───────┐  ┌───────┐  ┌───────┐
> │ CPU0  ├─►│ ETM0  ├─►│       │
> └───────┘  └───────┘  │       │
>                       │       │
> ┌───────┐  ┌───────┐  │  ATP  │
> │ CPU1  ├─►│ ETM1  ├─►│       │
> └───────┘  └───────┘  │       │
>                       │ FUNNEL│
> ┌───────┐  ┌───────┐  │       │
> │ CPU2  ├─►│ ETM2  ├─►│       │
> └───────┘  └───────┘  │       │   ┌─────┐  ┌─────┐
>                       │       │   │     │  │     │
> ┌───────┐  ┌───────┐  │       │   │ M7  │  │ DSP │
> │ CPU3  ├─►│ ETM3  ├─►│       │   │     │  │     │
> └───────┘  └───────┘  └───┬───┘   └──┬──┘  └──┬──┘               AXI
>                           │          │        │                   ▲
>                           ▼          ▼        ▼                   │
>                       ┌───────────────────────────┐   ┌─────┐   ┌─┴──┐
>                       │          ATP FUNNEL       ├──►│ETF  ├─► │ETR │
>                       └───────────────────────────┘   └─────┘   └────┘
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!

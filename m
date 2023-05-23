Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4F70DBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbjEWLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjEWLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:46:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B77119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:46:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso6998778f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684842380; x=1687434380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXiSekeK0+dNYQ7Rl2lu7vRoSGRXoE72FsEwh/pkNec=;
        b=t+w5SJpb+2rMXjGSrr+ycYAAGx3jSe8ZceNk2+WtAc/Sr1DyRn6buZJ1jzbRtn7zho
         xGL4A42tPWO2M2/8+rUPZiO25rWJ8jQHwfM+AOrPG0ADTxM9ph3ThMrRLEKW5XAHpdDi
         A83Joe5XH2/cQVUJoA+HwPS3S/obukDQo0SY2UjxHZEz4mDrU1dCojbSqWQo0nugyFcT
         ZCPDGkkyyouOas7o+JuldkAx407Zo2PuAfqHDCIb1x+NlfQuJzEpSpQ9O53lEvPdVsd5
         TlL0h2hmPIGc7rX69ilptpzz/OEQNnQiXbp5M1rEUbK22g2/Kg0pnsVSp4Dg8VL73JBb
         qpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842380; x=1687434380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXiSekeK0+dNYQ7Rl2lu7vRoSGRXoE72FsEwh/pkNec=;
        b=d2R4x3X/Zz8mt7np3I0EYO4Kp+fCXH+YsfNJe4tHmuHpwLRBvPpIHzOHSmKaKipHdY
         F9QuQ9s0cAjKnIiLL9q69FBMEt0vgDnZqu4jITihPgxNHasr48Nj67nic7UzywNlNMZx
         X2fVadlavyoZ+JLsF+kN+17T+/+l5uALWiRNXwsc7NhEik70YNQoUvtNUI0rce9k8b9N
         yHhBL1V3xX2i3VN/fO6c+V3vYCqJAs8nQBQ1+/Elq0sCt9NLGsLDoxZ3BzgVchBdpIbZ
         5kcks/BZ1gw2ddHqDWiGwrR+1yB8QdNOq1FbNc5dbMQn2b9mfkOpg7inq8DxjLVXBGpM
         BZTw==
X-Gm-Message-State: AC+VfDyX7R/2sE/l4dCY/bm0PFjJT/JosbpDGjZcmTt7Rt/n2HOW3Xom
        jpb9j5lwA0vQOmeE3F1+VlX/FQ==
X-Google-Smtp-Source: ACHHUZ4vJR8IdN6rXRgEnWf9szojVeR1Ubr3de6/rFKhcPiTu8ggdv+zZEpWXWPQvFRZK8+eQJV04A==
X-Received: by 2002:adf:dd09:0:b0:2f6:208d:2234 with SMTP id a9-20020adfdd09000000b002f6208d2234mr10158434wrm.2.1684842379718;
        Tue, 23 May 2023 04:46:19 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:802c:7f03:2fe0:bd27:d746])
        by smtp.gmail.com with ESMTPSA id i18-20020adffc12000000b0030631a599a0sm10805590wrr.24.2023.05.23.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:46:19 -0700 (PDT)
Date:   Tue, 23 May 2023 13:46:18 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
Message-ID: <20230523114618.laajn2et5nbcxszv@blmsp>
References: <20230511133226.913600-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511133226.913600-1-msp@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just wanted to ask if I need to do something specific for it to go into
a rc? Sorry if I missed doing something for that, I haven't had to fix
something in an rc that often before.

Best,
Markus

On Thu, May 11, 2023 at 03:32:26PM +0200, Markus Schneider-Pargmann wrote:
> The given operations are inverted for the wrong registers which makes
> multiple of the mt8365 hardware units unusable. In my setup at least usb
> did not work.
> 
> Fixed by swapping the operations with the inverted ones.
> 
> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
> Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8365.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
> index 6b4e193f648d..6d785ec5754d 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -583,15 +583,15 @@ static const struct mtk_gate_regs top2_cg_regs = {
>  
>  #define GATE_TOP0(_id, _name, _parent, _shift)			\
>  	GATE_MTK(_id, _name, _parent, &top0_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +		 _shift, &mtk_clk_gate_ops_no_setclr)
>  
>  #define GATE_TOP1(_id, _name, _parent, _shift)			\
>  	GATE_MTK(_id, _name, _parent, &top1_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr)
> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>  
>  #define GATE_TOP2(_id, _name, _parent, _shift)			\
>  	GATE_MTK(_id, _name, _parent, &top2_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr)
> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>  
>  static const struct mtk_gate top_clk_gates[] = {
>  	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
> -- 
> 2.40.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7067B638986
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKYMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKYMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:17:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA24A06C;
        Fri, 25 Nov 2022 04:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669378616; x=1700914616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSFOXCUtd8kCT1EOBLk19+HwBikY8iOKRD/WMkWE6uU=;
  b=XRpFUAy4SmzINlLQgse1uU8xSiOqevuxPW2JvptmjuhriawNzat+uqZk
   NTm9hbHi/yhQFhSI4TmPzt3t9sCux5XJkHLsJc5T8tXhnugDiTm4U+4lJ
   7Z8kQDfCUbePlUFta6/U+5I8wu7pX9W1GAX2Dwa0pJQgiyWAxnaRyy+5F
   6oXWAragmJnxCW61L3LJZz8zjTx8LokLcPH1wxX6NnGCXpI2PmZnQchAF
   78AWRLh9dJKN/GYK7Wu+UReSOLN17vYg5HHZlX5DlybRF1Jgv67eD3I+J
   86Uod0pKYMkvdQTw+vP4cbOn2bGEK3YlJ2SETbtYLSaiiO74bMDJ8XFqj
   A==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="188647684"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 05:16:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 05:16:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 05:16:36 -0700
Date:   Fri, 25 Nov 2022 12:16:18 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five
 SoC
Message-ID: <Y4CyEkzn2rqRqx+t@wendy>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/ivrvx4A+OImtW@spud>
 <CA+V-a8uBrx-+S59_zMz6kyLurVs4z0f+WxuUKc8k3VQWuZYWWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8uBrx-+S59_zMz6kyLurVs4z0f+WxuUKc8k3VQWuZYWWA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:50:01AM +0000, Lad, Prabhakar wrote:
> Hi Conor,
> 
> Thank you for the review.
> 
> On Thu, Nov 24, 2022 at 9:31 PM Conor Dooley <conor@kernel.org> wrote:

> > But yeah, this is basically the sort of stuff that'd be nice to have in
> > the previous patch!
> >
> Agreed, I'll include this in the binding patch too.

I said "the previous patch" but I meant "the previous patch that I
commented on the commit message for". I can hardly expect telepathy, so
sorry for the poor wording.


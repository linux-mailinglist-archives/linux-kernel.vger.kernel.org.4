Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2686E287C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDNQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:39:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38EE45;
        Fri, 14 Apr 2023 09:38:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud9so46868329ejc.7;
        Fri, 14 Apr 2023 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681490327; x=1684082327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+23CJXUeXEiMANHb7JQatzqlQ3jciMx/LE2VS/DvXc=;
        b=nsEHtUVib75SqhI5bUhm3AeZZ4/XoLTFt0OY78W+k6m5LxGpa+8YDTgCxKPEKOHXf4
         RB7Fo/3zW+hkE/cYCq0LZFxioXUCm2OEBqO+ArydGXxB5khWsNuIJ4OSzrPxtZIpctF3
         d+wQ9eUxdQ+75zwoK4MZTcijAg0Ve8qp6O5xkGinh/NT4fZaoDUCTPjAnOrkahxilzaR
         np9oBfnWuhhtZZpaRa0RUctMSroWBneqiKwP2k2kRoSWdLTI9MWzv3sAyBxQKus29IyK
         A+8APQ7oglrB1Og+v3E/HCBA/RORVr7n13r3sj/aR85I7WRbrMKRy7buXoCN1Ee3uyyO
         JzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490327; x=1684082327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+23CJXUeXEiMANHb7JQatzqlQ3jciMx/LE2VS/DvXc=;
        b=RcOV7O6hYLLC9ZT2QAZZUliZtqNzx1ZeHdEkIPHeFqPGvvbrNa7iyk5c8rjiVFX5Z/
         ZR7DSE7+ZNJNOXtjEUzvjwWCkio+ZuoLUbCJXbC5fXPvgyCLWYbOcTFqywBzmFN76KzL
         URu4958YVdJ8KpRJS/TLJECNCBb/bggYn101Hgv2UyZwKa4hmcmhOHsqlSG6KgZzteJf
         +hW1ST2i+rGIIFnTW5qoY2FU4IQ3pMacLOEcRNDQca2MSo8xd45SbPt3N0SgdtE1QrRf
         Nb5pQMXAyxg94zAzAn6VZYNeiuOz5YNvD7S4l6dMsjXu0q7oGizaRqyMeRjCfbDjShpQ
         ZorQ==
X-Gm-Message-State: AAQBX9cVrudZJXKFR+3EAqecSbnkrQGkGdw3s7Wornlk+7OpkS6vFDgR
        MTe8S/447pKox66oCtQn5fM=
X-Google-Smtp-Source: AKy350Yz0mvtAPT+D8ybgEYiO7BjA9CMGziNJyFdJ0nitkYwVc36x0MutiDKL5yf271n78i84lVXFw==
X-Received: by 2002:a17:906:3399:b0:94e:fd4d:9543 with SMTP id v25-20020a170906339900b0094efd4d9543mr1263398eja.75.1681490327146;
        Fri, 14 Apr 2023 09:38:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709063a0a00b0094a6cf3b642sm2657977eje.142.2023.04.14.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:38:46 -0700 (PDT)
Date:   Fri, 14 Apr 2023 19:38:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>, Bai Ping <ping.bai@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhou Shide <u201911681@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hao Luo <m202171776@hust.edu.cn>
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
Message-ID: <c37446f6-bfd6-456d-80aa-542fb2139929@kili.mountain>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
 <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 12:06:59PM -0700, Stephen Boyd wrote:
> Quoting Zhou Shide (2023-04-12 20:24:39)
> > The function imx8mm_clocks_probe() has two main issues:
> > - The of_iomap() function may cause a memory leak.
> > - Memory allocated for 'clk_hw_data' may not be freed properly
> > in some paths.
> > 
> > To fix these issues, this commit replaces the use of of_iomap()
> > with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
> > This ensures that all memory is properly managed and automatically
> > freed when the device is removed.
> > 
> > In addition, when devm_of_iomap() allocates memory with an error,
> > it will first jump to label "unregister_hws" and
> > then return PTR_ ERR(base).
> > 
> > Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
> > Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> > Signed-off-by: Zhou Shide <u201911681@hust.edu.cn>
> > ---
> > The issue is discovered by static analysis, and the patch is not tested yet.
> 
> And you're not coordinating with each other?
> 

This is a university program.  The patches are reviewed by his professor
and teaching assistants etc.  I've been reviewing some of these patches
as well because of they're using Smatch.

regards,
dan carpenter


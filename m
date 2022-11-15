Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901A5629936
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKOMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKOMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99AD27DD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668516613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPAUafDhWcFcck903dib/KZcqq9KhAJf3LXaIPMuS/A=;
        b=PDGrZ3c3pB6FdQvHuQply4z0yxurwUqOrSBVN6W8+t3Ld48rW64NAUOXZabxzrLheNfHzQ
        jAzYoVunko/j6uDcu+wcpkzHbMdpoJVpFyaBscQh6ZK+W5S0dUc4GmjnTESGTQWtLTS1ZE
        VRkLTn+VNa/gPfS4h84w/c7LGwxzWAU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-dpc2EIXANBCgUZYGzv5UcQ-1; Tue, 15 Nov 2022 07:50:12 -0500
X-MC-Unique: dpc2EIXANBCgUZYGzv5UcQ-1
Received: by mail-oo1-f69.google.com with SMTP id e10-20020a4a91ca000000b0047f7bf95662so5007310ooh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPAUafDhWcFcck903dib/KZcqq9KhAJf3LXaIPMuS/A=;
        b=x/46dkKO71c8Yj7eXqf49gaFE4fiOX86T/50KJt0XDkLpoVslMcqNmDGEI4Du9Io5/
         sc6uubyRkVqsm7b/IAaY2XDGWQF7/bcCCzC8l6+ELYFF/Z9XzQZncLu6EbTOR3Uo4LNI
         gXuehNLCmqj212a+9F60Ji5yfvb3LVXzp7UgPvXGuDIYTtTRnh/BDVHlA0VxmApjIR9W
         Lhj5f+TRHgEB9lpsmpInITSI9UHGwqhYpfxlHGGM8s3tOpo7IjB3pk3t/3gXIwSClcjf
         iq5y7BvZJekOr5BjmXxUrK+vQRw1CC9ogvYUTmvNtgqSNoclVtRJqqeicX86jTXVtbbV
         pXpg==
X-Gm-Message-State: ANoB5pn74jFGG+JAVeqXIe95u5UP8VMV784YUGijbXQR3EQpOIxCunh2
        80jFVnaM3f/cli1E4mv36a5VjIDTKZnl/acKJkgzGf/7yWpBawngX5r0wqeDzj3nwXvcuKw5St2
        aWUrk5w28bFYm7sYcJOvIvyIm
X-Received: by 2002:a05:6870:a2c4:b0:137:5344:7776 with SMTP id w4-20020a056870a2c400b0013753447776mr891506oak.208.1668516611744;
        Tue, 15 Nov 2022 04:50:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4L/QZHXSlNDjzf5/xVQ71QRGcvzfmxSA1emzSYdbkNT6O2lFXB1f5yFALQ79CD7wBtvrG8uA==
X-Received: by 2002:a05:6870:a2c4:b0:137:5344:7776 with SMTP id w4-20020a056870a2c400b0013753447776mr891492oak.208.1668516611476;
        Tue, 15 Nov 2022 04:50:11 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id n19-20020a9d7413000000b0066cb9069e0bsm5428437otk.42.2022.11.15.04.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:50:10 -0800 (PST)
Date:   Tue, 15 Nov 2022 06:50:08 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        sboyd@kernel.org, bmasney@redhat.com, agross@kernel.org,
        mturquette@baylibre.com, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <20221115125008.tv2x2fa76i24wkx6@halaney-x13s>
References: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
 <Y3OBK0PponwcsQB1@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OBK0PponwcsQB1@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:08:11PM +0100, Johan Hovold wrote:
> On Tue, Nov 15, 2022 at 03:52:17PM +0530, Shazad Hussain wrote:
> > Added parent_data as CXO for three UFS reference clocks named,
> > gcc_ufs_ref_clkref_clk, gcc_ufs_card_clkref_clk and
> > gcc_ufs_1_card_clkref_clk.
> 
> The commit message should explain why this is needed rather than just
> state what is being done. For example, something along the lines of
> 
> 	The three UFS reference clocks gcc_ufs_ref_clkref_clk,
> 	gcc_ufs_card_clkref_clk and gcc_ufs_1_card_clkref_clk are all
> 	sourced from CXO.
> 
> 	Update the clock driver to describe this.
> 
> should do.
> 
> > Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> > Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
> > Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> And with a tweaked commit message you can also add:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for the patch Shazad! Same as Johan, you can add my T-B:

Tested-by: Andrew Halaney <ahalaney@redhat.com>

and with a tweaked commit message my R-B (based on Bjorn's comments
about hw documentation in v1):

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> 
> >---
> > Changes since v1:
> > - Renamed patch subject. Did not include Brian's T-b comment.
> > - Added parent data for two ufs phy ref clocks.
> > 
> > v1 of this patch can be found at
> > https://lore.kernel.org/all/20221030142333.31019-1-quic_shazhuss@quicinc.com/
> > 
> > used below patches for verification on next-20221114
> > https://lore.kernel.org/lkml/20221104092045.17410-2-johan+linaro@kernel.org/
> > https://lore.kernel.org/lkml/20221104092045.17410-3-johan+linaro@kernel.org/
> > https://lore.kernel.org/lkml/20221111113732.461881-1-thierry.reding@gmail.com/
> > 
> >  drivers/clk/qcom/gcc-sc8280xp.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> > index a18ed88f3b82..b3198784e1c3 100644
> > --- a/drivers/clk/qcom/gcc-sc8280xp.c
> > +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> > @@ -5364,6 +5364,8 @@ static struct clk_branch gcc_ufs_1_card_clkref_clk = {
> >  		.enable_mask = BIT(0),
> >  		.hw.init = &(const struct clk_init_data) {
> >  			.name = "gcc_ufs_1_card_clkref_clk",
> > +			.parent_data = &gcc_parent_data_tcxo,
> > +			.num_parents = 1,
> >  			.ops = &clk_branch2_ops,
> >  		},
> >  	},
> > @@ -5432,6 +5434,8 @@ static struct clk_branch gcc_ufs_card_clkref_clk = {
> >  		.enable_mask = BIT(0),
> >  		.hw.init = &(const struct clk_init_data) {
> >  			.name = "gcc_ufs_card_clkref_clk",
> > +			.parent_data = &gcc_parent_data_tcxo,
> > +			.num_parents = 1,
> >  			.ops = &clk_branch2_ops,
> >  		},
> >  	},
> > @@ -5848,6 +5852,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
> >  		.enable_mask = BIT(0),
> >  		.hw.init = &(const struct clk_init_data) {
> >  			.name = "gcc_ufs_ref_clkref_clk",
> > +			.parent_data = &gcc_parent_data_tcxo,
> > +			.num_parents = 1,
> >  			.ops = &clk_branch2_ops,
> >  		},
> >  	},
> 
> Johan
> 


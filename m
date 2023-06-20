Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA373738B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFTSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFTSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E384B186;
        Tue, 20 Jun 2023 11:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C536135B;
        Tue, 20 Jun 2023 18:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B49C433C0;
        Tue, 20 Jun 2023 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687284697;
        bh=VTiFKT6Z64g8zSgonzXFVxQd/dWKaj0YtS/ajTUezpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LS9BK7eLpAP73WcTFv8l0fgFL9o/t1b/Tx9HjzSZL31GlFhrnKdU/79nw0gz19IHR
         F0XMbKzmmWsttEZNv6qCM9wgAdHjc52slCOjO8C8HgBpx/wRq96ksJqN4XFh9pM7l7
         HjGhxBrr0+XMxG6WoIc54qNrHorg6FWBX068XtVeHmWwsg6+ck4IX1sLSJIpfy9gXL
         aQ5D1GWVG074oRFoFM8ACxO1ifsK9XGOIakbQdtAvTiLh5lzMAbJ8K3Yu2wgEpp8jo
         S1r24JvaWPYE7vf3TW64i4W8hQYMgD2gxBAdaO0EeCVHULsm+DJMclS2kltemUOn8X
         5uK9wODajJxBg==
Date:   Tue, 20 Jun 2023 11:14:51 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Don't ignore return values of
 regmap functions
Message-ID: <20230620181451.idesqpkdyb2wa65l@ripper>
References: <20230615-topic-bwmonretval-v1-1-223bd048ebf7@linaro.org>
 <3364339a-908d-7ab6-7d62-a05ab8e67739@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3364339a-908d-7ab6-7d62-a05ab8e67739@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:26:13PM +0200, Krzysztof Kozlowski wrote:
> On 15/06/2023 23:12, Konrad Dybcio wrote:
> > As it turns out, not all regmap accesses succeed. Not knowing this is
> > particularly suboptimal when there's a breaking change to the regmap
> > APIs. Monitor the return values of regmap_ calls and propagate errors,
> > should any occur.
> > 
> > To keep any level of readability in bwmon_enable(), add some comments
> > to separate the logical blocks.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Nice coincidence, I just had some talks with a friend about uselessness
> (IMHO) of regmap MMIO return status checks.
> 
> Sorry, for me most of this makes the code difficult to read for no gain.
> Errors are not real. This is some artificial problem. Solving it makes
> code less maintainable.
> 
> If we used here readl/writel, you would not add any checks, right? Then
> don't add for regmap mmio.
> 

I agree, the mmio regmap interface should only fail because of bugs or
things are misconfigured. Would be nice to capture that in a WARN_ON()
or something...

Regards,
Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F94617491
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKCCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKCCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1904F13F5F;
        Wed,  2 Nov 2022 19:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8BCB61D02;
        Thu,  3 Nov 2022 02:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6C6C433D6;
        Thu,  3 Nov 2022 02:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667444058;
        bh=TJnMJHD6hPbLCE+9UsVHwY4+xmWXlNigWRrcrs/Q/Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tv1Afe7clPt1KI/NDkhOMZ//XZIaeeKAad3qQdfq6a5tnmcdJLnZvQOmQfVlvurrw
         cV5PHU21JWSGeiAeHPDBt1LJkX2wdyz5PfffFpRUwBCwAMbN2ACyIbI7hw8PWtZzGg
         tPO/y2KAvwiPTlRV3Mo5wIo+OEFdFNDXsNo/H8Sp/p90f9tD5/cj2HB1ps+8PG7hTC
         c/SmaEPBZ2FSqfSyYoyMgmmBDDBvR0/jkbdu02Sk797AxnO2n/xBgzF+xDlpUAFn4U
         uYwWBv4yffznIl4a/0lOYIN6piOwosQK4o0JRZOjCj/jWL2DXIAoh/iA+SSC+GNQKA
         ufKBDCyg5xrgQ==
Date:   Wed, 2 Nov 2022 21:54:15 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     bmasney@redhat.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <20221103025415.qchtpnoxssudch6q@builder.lan>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 07:53:33PM +0530, Shazad Hussain wrote:
> Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
> clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
> gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.
> 

Prior to that change we relied on both cxo and gcc_ufs_ref_clkref_clk
being voted for. So I think the reasoning for this patch should simply
be to express the fact that the clkref is fed from CXO.

Regards,
Bjorn

> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-sc8280xp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index a18ed88f3b82..72b545121c57 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -5848,6 +5848,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_ref_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> -- 
> 2.38.0
> 

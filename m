Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7F5EADC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIZRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIZRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:12:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F211D0D3;
        Mon, 26 Sep 2022 09:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F7A60FA8;
        Mon, 26 Sep 2022 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C25C433D6;
        Mon, 26 Sep 2022 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664209407;
        bh=//h3Ki1Q/jkhX/AuuWyJZHCujymp5Zrs2M2JnYSsksg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFQTPdP8B3rTVXjFl4MS+gyFAVE4JTmDg1M+th/wGNvD//9ewF67MybYezkcUcLqd
         ptplidEpnLCJElTPeJj3M+5HDNjoclPh2Ym5eOy4OAh2QR+npPIFqZcqK0hQO6Jvl+
         zgNlGpPP+lVdoZzzgW3AqoU1HjQX3wTL23lNmGLEDjafeGvAiFW9BfyFUerozoL93V
         Vzp8ez5F1fvFijvcESUOwTCRbd29I5NhNhZ1qo7fnbOnHe9pjmep10Cs6YwGdFwZOy
         OjIv7T8kNoKvuLYIAX6xvL2BX1yEGg/iWrZE6u88b/z806QFTd/Y1ydmNmO/Co5Z3L
         Ai5KPJj7WfPMg==
Date:   Mon, 26 Sep 2022 11:23:24 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] clk: qcom: common: Detach the power domain at the end of
 probe
Message-ID: <20220926162324.xsh4niaxdmh3ao3i@builder.lan>
References: <20220804103456.3176943-1-abel.vesa@linaro.org>
 <CAA8EJpoYrXNBeZfDTAmjhsHaMqO+jeUVt4BtQkKy=T7Q0EuH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoYrXNBeZfDTAmjhsHaMqO+jeUVt4BtQkKy=T7Q0EuH8A@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 05:37:48PM +0300, Dmitry Baryshkov wrote:
> On Thu, 4 Aug 2022 at 13:35, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > None of the CCs actually need the PD attached to their device,
> > but rather some GDSCs registered by those CCs need that PD as a parent
> > in order to propagate power gating and the performance state.
> >
> > So lets detach the PD from the CC right at the end of probe, after
> > everything has been successfully set up.
> 
> Would it still be possible to read the clock registers if we detach
> the device from the domain?
> I think it was the original issue behind putting the dispcc/videocc
> into the MMCX domain: to be able to poke into the clock registers,
> which are gated by the MMCX.
> 

I share the understanding, that on several modern platforms e.g. dispcc
was shown to depend on mmcx and the associated gcc abh clock being
enabled.

@Abel, could you please verify this on 8250/8350/8450?

Regards,
Bjorn

> 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> 
> -- 
> With best wishes
> Dmitry

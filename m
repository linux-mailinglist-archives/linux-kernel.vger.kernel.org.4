Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D642664733
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjAJRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjAJRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:17:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13561CB2B;
        Tue, 10 Jan 2023 09:17:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BF2B816AC;
        Tue, 10 Jan 2023 17:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0E7C433A0;
        Tue, 10 Jan 2023 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673371050;
        bh=fI0Jd97+0nJRqxn7ywqClnDN9QYikPAUW+G+b73cGsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAyaNn8R90QBXTYYVWpNj7QZfz7KxlQDXO/m7VE8osVfxQEuj5Zu9fj/dHPiCoeN+
         FVJKyJ3FF6D/q2SjADCbThiid2Ju0T8pPC4gM46ovMk691fZfQ6vnuSooLcriMqNKR
         07q8AS6zdlpKa+ckfSDsTBLYJ62iznLVQxNOpe2YYgqt/shiKz5AwU6+dMP+5pbaLT
         DC892KlUYnalfDVVhVhqzZR6IkWedINctg51nqN8WvfrCO+BxLbu3S27/WVLqiFe9o
         fTC74jyXiLgtwC5ELoyW7+XW/d82VNX7LvmereeShq3GOdTFlXVBrqjgNepTg5dQ3+
         MY1Cu0e3teuGw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
        ulf.hansson@linaro.org, sboyd@kernel.org, quic_akhilpo@quicinc.com,
        robdclark@gmail.com
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, sean@poorly.run,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        khilman@kernel.org, agross@kernel.org, pavel@ucw.cz,
        linux-clk@vger.kernel.org, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, len.brown@intel.com, daniel@ffwll.ch,
        olvaffe@gmail.com, gregkh@linuxfoundation.org, linux@roeck-us.net,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        geert@linux-m68k.org, airlied@gmail.com, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v5 0/5] Improve GPU reset sequence for Adreno GPU
Date:   Tue, 10 Jan 2023 11:17:24 -0600
Message-Id: <167337103777.2139708.8328240666621116621.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 16:18:26 +0530, Akhil P Oommen wrote:
> This is a rework of [1] using genpd instead of 'reset' framework.
> 
> As per the recommended reset sequence of Adreno gpu, we should ensure that
> gpucc-cx-gdsc has collapsed at hardware to reset gpu's internal hardware states.
> Because this gdsc is implemented as 'votable', gdsc driver doesn't poll and
> wait until its hw status says OFF.
> 
> [...]

Applied, thanks!

[1/5] PM: domains: Allow a genpd consumer to require a synced power off
      commit: a9236a0aa7d7f52a974cc7eaa971fae92aa477c5
[2/5] clk: qcom: gdsc: Support 'synced_poweroff' genpd flag
      commit: 8b6af3b58cafc2cbdf6269f655b2d3731eb93c2f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

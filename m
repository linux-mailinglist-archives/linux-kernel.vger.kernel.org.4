Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32234640FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiLBU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiLBU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3231EA5D8;
        Fri,  2 Dec 2022 12:58:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D693623E6;
        Fri,  2 Dec 2022 20:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71E1C43470;
        Fri,  2 Dec 2022 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014738;
        bh=0zpPUVxdK93s0V2+n5U3LTSB8Wkk7jwHuasJoRSPfu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWmRaX1bJ8Vl6FteHwVDsh5fEuMd7ltPWTOrhvk1CBKsro5gMOGZMH6Ahk0L+SW0L
         Dy30eZuVlFJNxv1xr288LnE3RAUIs6KN0wrkgw0YRNSjrAd93ZcYtLFqDCl28ngkbd
         N/liBk2gukHqV6jDEIRavVJto812ghfgtn5X0gECd54RBo1Ajt0FC+WCeOMjNYu9BE
         dy1GdI66tzNzKwHS1Lgmm6zdqkrWfXMZK3Cj+DL93mgWZlM/rOZ97IwpDnnob2sf2s
         wL+E8xfR9Ycm/enr59iYBbgdJHpfD3e4jxDjSNHsd/faiq/QskTYrbJvRBkQnmSnMO
         y9jnyeAFCwnzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     swboyd@chromium.org, dianders@chromium.org
Cc:     dmitry.baryshkov@linaro.org, konrad.dybcio@somainline.org,
        mka@chromium.org, sboyd@kernel.org, quic_tdas@quicinc.com,
        linux-arm-msm@vger.kernel.org, tdas@codeaurora.org,
        judyhsiao@chromium.org, agross@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] clk: qcom: lpass-sc7280: Fix pm_runtime usage
Date:   Fri,  2 Dec 2022 14:58:44 -0600
Message-Id: <167001472419.2721945.15791825531411350207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
References: <20221104064055.1.I00a0e4564a25489e85328ec41636497775627564@changeid>
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

On Fri, 4 Nov 2022 06:56:28 -0700, Douglas Anderson wrote:
> The pm_runtime usage in lpass-sc7280 was broken in quite a few
> ways. Specifically:
> 
> 1. At the end of probe it called "put" twice. This is a no-no and will
>    end us up with a negative usage count. Even worse than calling
>    "put" twice, it never called "get" once. Thus after bootup it could
>    be seen that the runtime usage of the devices managed by this
>    driver was -2.
> 2. In some error cases it manually called pm_runtime_disable() even
>    though it had previously used devm_add_action_or_reset() to set
>    this up to be called automatically. This meant that in these error
>    cases we'd double-call pm_runtime_disable().
> 3. It forgot to call undo pm_runtime_use_autosuspend(), which can
>    sometimes have subtle problems (and the docs specifically mention
>    that you need to undo this function).
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: lpass-sc7280: Fix pm_runtime usage
      commit: d470be3c4f30b4666e43eef6bab80f543563cdb0
[2/3] clk: qcom: lpass-sc7180: Fix pm_runtime usage
      commit: ff1ccf59eaffd192efe21f7de9fb0c130faf1b1b
[3/3] clk: qcom: lpass-sc7180: Avoid an extra "struct dev_pm_ops"
      commit: e3ad6c3f21ddb89e4b71361be8318da57dbe3597

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

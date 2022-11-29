Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8C63C405
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiK2Pp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiK2PpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:45:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859E59FED;
        Tue, 29 Nov 2022 07:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 623FE617AB;
        Tue, 29 Nov 2022 15:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A20C433C1;
        Tue, 29 Nov 2022 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669736723;
        bh=OBajQxyPKWk4eBVakGjlcr0afXEUapA11McgDnqCERY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2Ho0a2RYST8CGg8p8OHCzolQz82thLT7OpRnlwIAlED6f+4ob2GTjF49zM7kQfut
         fHmCMle3msv6TgsC318FXf48vL02wg3f/4+wfledN5W3CT2jakO9ER4TRC+fo/+FYy
         wzUU5epLEqVvkC81KSou9ozbbkv31MrakAysRe6rgb9zQqaCZJhgBLsqn++GIQ12tg
         C96EkZH/sz7f6JbPCmQvWIj0MJMNyCil8oSCETDJjAVMh9GzThPlZ0s0GZ5iQG1QmO
         m8I2X4ZM8yHxxwQMT83W6m9QgIf41vGyiMXU2D4Y3QNJKF0BW+swDFuTP/vr4FTlWl
         J/N5LZR1T5FbQ==
Date:   Tue, 29 Nov 2022 08:45:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4YpELN4/0cesonb@dev-arch.thelio-3990X>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

A better solution would be replacing SET_SYSTEM_SLEEP_PM_OPS() with
SYSTEM_SLEEP_PM_OPS(), which was added to avoid needing to add these
'__maybe_unused' attributes to these functions. See commit 1a3c7bb08826
("PM: core: Add new *_PM_OPS macros, deprecate old ones") for more info.

> ---
>  sound/soc/qcom/lpass-sc7180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
> index b96b85a..41db661 100644
> --- a/sound/soc/qcom/lpass-sc7180.c
> +++ b/sound/soc/qcom/lpass-sc7180.c
> @@ -163,14 +163,14 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int sc7180_lpass_dev_resume(struct device *dev)
> +static int __maybe_unused sc7180_lpass_dev_resume(struct device *dev)
>  {
>  	struct lpass_data *drvdata = dev_get_drvdata(dev);
>  
>  	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
>  }
>  
> -static int sc7180_lpass_dev_suspend(struct device *dev)
> +static int __maybe_unused sc7180_lpass_dev_suspend(struct device *dev)
>  {
>  	struct lpass_data *drvdata = dev_get_drvdata(dev);
>  
> -- 
> 2.7.4
> 
> 

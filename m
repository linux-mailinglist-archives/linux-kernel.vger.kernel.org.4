Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7770A491
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjETCIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjETCIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28201E56;
        Fri, 19 May 2023 19:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B178465BCD;
        Sat, 20 May 2023 02:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7BFC433D2;
        Sat, 20 May 2023 02:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684548495;
        bh=VvXyl4JMyrOrcQ4+N4CUG8o5DnJlsTXB9lsiZ3ivRdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRzO0JqxNmwuwNTW6yAHwkCcnN7ds3roIybgMzQTLvE3PfqR9MA39M9eHsqnUzYAb
         +W4fOU7lgJa0iVaWRs9mekKjGvAnHtCxfI61cWmR9xtZhhphm3xfD7sKazbgM5mANV
         mh8SNBpdr++PuQEKWNQjz8lI/+jDT4saI990IzoQxIXznXF1v3JF+f/x/Ua8/JGZtp
         wz3dTVMyW5ydPUNZzyUSc7gSNj/LatO19pNs9gi3Rj4g9Wx3oR+qo4ObnzDMLG8V/E
         Oh3rlZ7Uu/RL17lEmvhFw8x+g3LJ7Z+fAELtYDNGlLB0o0cyfUKxd3Jn93RqCQZ8ZG
         YuZFYTMKCJGeA==
Date:   Fri, 19 May 2023 19:12:01 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: qcom_scm: Clear download bit during
 reboot"
Message-ID: <20230520021201.t2zeermogm4s5fgq@ripper>
References: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 04:50:23PM +0530, Mukesh Ojha wrote:
> This reverts commit 781d32d1c970 as it causes regression(reboot
> does not work) for target like IPQ4019 that does not support
> download mode scm calls end to end.
> 

What do you mean with "reboot does not work"?

Does qcom_scm_set_download_mode() crash the board? Does the reboot
always end up in download mode? Or some other form of "not work"?

Regards,
Bjorn

> Fixes: 781d32d1c970 ("firmware: qcom_scm: Clear download bit during reboot")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..a4bb9265d9c0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1508,7 +1508,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  static void qcom_scm_shutdown(struct platform_device *pdev)
>  {
>  	/* Clean shutdown, disable download mode to allow normal restart */
> -	qcom_scm_set_download_mode(false);
> +	if (download_mode)
> +		qcom_scm_set_download_mode(false);
>  }
>  
>  static const struct of_device_id qcom_scm_dt_match[] = {
> -- 
> 2.7.4
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAC72844C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjFHPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbjFHPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:54:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEC11A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:53:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565de553de1so11561797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686239623; x=1688831623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtDK807cWu25+ZWD4p2mPiRke5/KbH6pzz8Izn+8M88=;
        b=bKFfe1UzeXsuj7UXSDZ74VbTqvJep4IALpVfyydksV2DoZxST1mj386nEwE89m2GZs
         sllw/G69t6OwY8I2fizivGEKRCq++DKH3XKeKmxqPH5InyTToE+WnqLeURWAoShgOh17
         zWTDzZS/ZbcFwUEDAsY62cUd7HIxZi3dTn2PxrRdr2XFkdHjTaUzSK+/GSOia9ROSdHz
         woze1xRdNscHVeWlxavLYqv2RR6r443oUiiMDD0EQRj2ovIu1o1957gUPYetV4P4Ao8J
         572SvlgwQpx0GyYhxeegetTygUXlbr70hn3PbXWNPcBCm0aBcCWTh7s2SRUY2/yJ00oL
         b1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239623; x=1688831623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtDK807cWu25+ZWD4p2mPiRke5/KbH6pzz8Izn+8M88=;
        b=jatA5BODTs5U4AXqZ1giPLfvvK3w+Zb7/XpJugJuhGAABkKeyz7TWWZyamQr1OVsZn
         3gHEUKr8YaNR948X5lPMI5oZslbtZces/ettl2DQxedUEIDeBgY23v5mvOFY30bWz0P6
         SSCAMuKcCKRlQkMbgr4eTdyRwdjXMQ19zuq2KG9fZLl8fl/F59hHBHd0DVJLswjflcHd
         lhP/Z/vSVyzTyfmBFe0zzjg2cfZcejsIKn6KwyvZ3VSCw/jClNlIhbIjhPoGxsPiAs2t
         KE4VWzRhAV8u8l0T2MtNSUfIcuJ/bF+MK0CJ7uo490MD2Xw9XJE4aPIXDyHKKa+7q2al
         EEFA==
X-Gm-Message-State: AC+VfDy5DKipCppZDvhhOjTrV9PdJf8KebIY2BEwQUnOUy7MpdYmov1N
        iQtZWel3m8ZV1/+emTFEJ0xj/Ae9osm/oo28PD4Ugg==
X-Google-Smtp-Source: ACHHUZ6hDDsS6kObKDwaaHM+E4MXBVpxcbHkEUo/DnPMO0OSAxvknsk1eVHW9vuwG2DLJP5tGPC9AqmbLE5I9hSkwdM=
X-Received: by 2002:a0d:d7c9:0:b0:561:fc3a:30f3 with SMTP id
 z192-20020a0dd7c9000000b00561fc3a30f3mr191024ywd.8.1686239623279; Thu, 08 Jun
 2023 08:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <55920f880c9742f486f64aa44e25508e@hyperstone.com>
In-Reply-To: <55920f880c9742f486f64aa44e25508e@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 17:53:07 +0200
Message-ID: <CAPDyKFpBeAHSk1-XJoBAFPS_hecOpq4Ceeq4qnokeD=zjvParQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] mmc: block: ioctl: do write error check for spi
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 at 11:56, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> SPI doesn't have the usual PROG path we can check for error bits
> after moving back to TRAN. Instead it holds the line LOW until
> completion. We can then check if the card shows any errors or
> is in IDLE state, indicating the line is no longer LOW because
> the card was reset.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for next and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index d920c4178389..e46330815484 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -178,6 +178,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                int recovery_mode,
>                                struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
> +static int mmc_spi_err_check(struct mmc_card *card);
>
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -608,6 +609,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>                 return 0;
>
> +       if (mmc_host_is_spi(card->host)) {
> +               if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
> +                       return mmc_spi_err_check(card);
> +               return err;
> +       }
>         /* Ensure RPMB/R1B command has completed by polling with CMD13. */
>         if (idata->rpmb || r1b_resp)
>                 err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> --
> 2.37.3
>
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>

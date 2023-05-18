Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC8707A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjERGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERGXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:23:21 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0255198
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:23:19 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-436750830efso504027137.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684390998; x=1686982998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=749dNWMKtBMpR9cyBLSBqEA+If7g3taC0uv4e/bxAE8=;
        b=Z1QN6Yo0GQ5urzF72Gls7MS9N02snqrN0bCdSIwwrirAaFNxHoKd4yhGLcJjtp2kPH
         KoCQMwFmKI0Pb4Cg/UaMvKZRA1jTUdfq4pyofigadmUeYvW0pVd4gnYoRgQ64ETsW+6p
         yCwsEBVkK0p20L/8/T/XHSn1KA7JhGREW4I0G1j2Dj+brtmB3a8iuvOz6nHxqxNtVvoT
         zcsCi4uQKLLFVqRVecdmcxYTolwH/pkUY01RiMWMylSHeeV7X0kNatIChZkLHmvsG+lM
         FIIVmLdv8UjOf2d+yB+FJMprihlAGOYf0/5oZcDZmOMmfR+TKXUPWBgK9l2ta0w69elz
         KVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684390998; x=1686982998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=749dNWMKtBMpR9cyBLSBqEA+If7g3taC0uv4e/bxAE8=;
        b=YQCYInESYaREJQFmVRww7qV+rVFasxKJkyLYOL4Wx0DSXo8E8nvD2qYYuukqMAdCel
         xoLmPBWWFpxEUWEkm1v1Pv9cQyxWhhmDOmCm4T+ZEtr3xR8zxEDh7arbNZSJdpK+kfjU
         v00HcvK/u6at6T2/A9bXp8SuFqypG+bi8YDXAjt3I7uUICDCcDUzut4XlFp6dWrgMiDY
         PXFsBmkCle7YJscN18+o9pIqKLEJ+IBqAqkoJp5iV/Q2R/eWK9EbzklTzC1e9kT5KaGe
         R23OpzRYwpprMUTCq4CkxDBwOjBMoGJZWqscNwsFhRpeLZnKd4mCvc7wv0P4Y93TYEtE
         NOAw==
X-Gm-Message-State: AC+VfDwcB9KgZlnjVWAhDn6dILOoqvzNBGhEqNSX6AufR53Y2d2cVLwL
        cnpslGTGKsN1L0bTbu2KACiAdzsn2bpDzsK0BYprWg==
X-Google-Smtp-Source: ACHHUZ6zG5GZLWWLE8HvKQB9FTouw62j2S54wMHGyuRs26XJPyvfN6pyDORkMK6l5oWORGfKZ0Kf2HZ79TdDYXBM2Ps=
X-Received: by 2002:a67:f419:0:b0:434:47ea:b02 with SMTP id
 p25-20020a67f419000000b0043447ea0b02mr178156vsn.10.1684390998542; Wed, 17 May
 2023 23:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230516125111.2690204-1-etienne.carriere@linaro.org> <20230516125111.2690204-5-etienne.carriere@linaro.org>
In-Reply-To: <20230516125111.2690204-5-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 May 2023 11:53:07 +0530
Message-ID: <CAFA6WYMyJrW25sdZRkQHDje72+tLDw4T+bjB6tmVf8XH0De1RQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] firmware: arm_scmi: optee: use optee system invocation
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 18:24, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Changes SCMI optee transport to call tee_client_system_session()
> to request optee driver to provision an entry context in OP-TEE
> for processing OP-TEE messages. This prevents possible deadlock
> in case OP-TEE threads are all consumed while these may be waiting
> for a clock or regulator to be enable which SCMI OP-TEE service which
> requires a free thread context to execute.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v7
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> No change since v6
>
> Changes since v5:
> - Applied Sudeep's review tag
>
> Changes since v4:
> - Updated to new API function tee_client_system_session() introduced
>   in patch v5 2/3.
>
> No change since v3
>
> Changes since v2:
> - Fixed syntax issues (missing ';' chars), reported by kernel test robot.
>
> Changes since v1:
> - Updated to use new tee API functions tee_client_request_system_context()
>   and tee_client_release_system_context().
> ---
>  drivers/firmware/arm_scmi/optee.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index e123de6e8c67..25bfb465484d 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
>         if (ret)
>                 goto err_free_shm;
>
> +       ret = tee_client_system_session(scmi_optee_private->tee_ctx, channel->tee_session);
> +       if (ret)
> +               dev_warn(dev, "Could not switch to system session, do best effort\n");
> +
>         ret = get_channel(channel);
>         if (ret)
>                 goto err_close_sess;
> --
> 2.25.1
>

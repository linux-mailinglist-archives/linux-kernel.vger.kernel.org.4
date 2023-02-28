Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192986A5CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjB1QTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1QTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:19:16 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4170D50A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:19:15 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536cb25982eso286548967b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvwi10BCTbbsbzCDkyaJyelvBf36hI6KbwY7rWAn+yI=;
        b=Rs7XQMKTGdkQouim1SxhyfOHHjAPnJdbNpHg0sJ+MBDNH0F89vy4153+0K4fSwpRzO
         /BgxRQ3nEMNtm4BhcSqTytojoSlcZfJYJNFn46+eC0FGyhdyqV+bQDrFyq4UQB+aWJA5
         G7IyfIA77lACVCE46aHx78a0EeQBe1RJ8KAVfTvqC+pzf27e/y/nKfJtLCoQOU3Xr/4i
         l3sEg+AgWKy31KTOwfnt6wFojKVMobFgdO54cZX2LjQgumufcN7XPMXaeMbKZIQKdq3E
         QJ6ADTFvzA3wegE9OcG0oh3Xw8FWI5CdGEuXqQMi48VkIE3uvuJknvcVdbEZ/4e0qoTp
         sYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvwi10BCTbbsbzCDkyaJyelvBf36hI6KbwY7rWAn+yI=;
        b=sKFsg0ddus0usB9TGk3UZvsFYmjBzf+LE4kVfoVtjvWBYYIR9kZSPP4z1ZugHYbebQ
         7ttmrFW9U8kpCrWUbuht+l5MwKQkxefzIeP3GEjj71jy/LJmkHrGd9jCfPXtyRHDMUZF
         hjenTM+VP1QARMuoEHobpYvk+t1LD9ap0maQsKaeI3ZR+glT/OK8H4GWc/Hgc9dAzskf
         qgwHdExR1Xt6NmQxUE4LebR8ephQw31wqJRv0J6Nn/WWuOEXmwVFp3wk5XglkKmeTLWD
         lhsyMqIziF5oOKtRTGlEkp1sdp8erfnBYW0l73dhS9yERcDgLseMXBB+cSHFZxowOlic
         7xSg==
X-Gm-Message-State: AO0yUKUdCWC85uTvgqXkI/V3jgxZzbG9JNdfSk/KAV3m59pE3TDiLZ84
        CrH6/j3P6bHt8fgR3GPiuPCe8xRxitZsWJ+qd75uxw==
X-Google-Smtp-Source: AK7set/VGlrxe4bCPrXoKKdImpARYrcb4bLo6BZA7c0D74m/IHouJb6Ka7q1yEfXuou60h8FhHfju3fw/QNEiAlPsik=
X-Received: by 2002:a81:3e17:0:b0:52f:69d:cc75 with SMTP id
 l23-20020a813e17000000b0052f069dcc75mr1980711ywa.6.1677601154832; Tue, 28 Feb
 2023 08:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de> <20230228135508.1798428-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230228135508.1798428-3-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 28 Feb 2023 08:19:03 -0800
Message-ID: <CABXOdTfSg8MtNFD8nz8XYsy74K3gMY0xis+aq+VfDnQi7JZsxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pwm: cros-ec: Explicitly set .polarity in .get_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 5:55=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The driver only supports normal polarity. Complete the implementation of
> .get_state() by setting .polarity accordingly.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/pwm/pwm-cros-ec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 86df6702cb83..ad18b0ebe3f1 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -198,6 +198,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>
>         state->enabled =3D (ret > 0);
>         state->period =3D EC_PWM_MAX_DUTY;
> +       state->polarity =3D PWM_POLARITY_NORMAL;
>
>         /*
>          * Note that "disabled" and "duty cycle =3D=3D 0" are treated the=
 same. If
> --
> 2.39.1
>

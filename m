Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA437112B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjEYRob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:44:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C0E76
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:43:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so1593864276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685036626; x=1687628626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvg1LF6ZKIn2vWNEhEDwKSuGqGYImWJiPe1uUBeKlZA=;
        b=efPy5J1ioAVeAgWGlA2+YMxEGITfTO3Sb5LdcEKRz6b+uTM1gH9ymZ3F9KuvjRG3jU
         z8PlFs7H/YSWF9GVfiG51wlspQG5IS7irbU3zNRMEHP1KNGRVpKL9jE4MoovrBo/S6Fw
         d6l6WKoQxoyUGyvFsR5LALj/4NPRIobzt9+0QE2FzBhYJ67AD25BdGlBRADpKxc5nR9o
         hyzTcKQakLuxoCnJyiwNFAbuRp8L3HXKKgnUVQodF7yyeRgvFxV/emlQbeGyDV99+eAg
         ZpcO28j2T+NaOWHYPRQkvJnxlB3/HlHacbq+Zm/dhjr+HWfhaov5k4BrlyBp7S8/Tsrm
         sPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036626; x=1687628626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvg1LF6ZKIn2vWNEhEDwKSuGqGYImWJiPe1uUBeKlZA=;
        b=dRSpUOfUc6CUNJZQS0mIcZt2QI2K3xQYuk1obFihgfYQfif1XRF4Mi+cQRYojZN5e8
         wNEsmwiR18Qs+qQNSF3FZzsU9aUpI5ELevJRAywQDemj+9a/aAYuOrvgSqMG5pWd3Pru
         nVpt7643HngNGqOzkeJQIOfhB4FC0kAVn8icfHlfyb7dC+FU6uDBTS8ciDNW0U6KLBcn
         P18SOvq0JDapcgtowO5NE6E9vCDSogQGZDER9ZEMHL4RWxkk/dJiudGapI9HeppL3mGP
         xkb0lV4hbf5UBVQvWdA+/0iuzETGrXGdKngxqErNxDj/EWLIAr8o6hWNuhTx7moTNbTG
         6OHg==
X-Gm-Message-State: AC+VfDxzgcLCIIWox6s32mOJU61pLpW0oPRYD97qZF0uGr0L1vLbw0eX
        2fKRn+GnDFm5Y/xqBAhQNwLotiaWPOsgoP6/RXBXbg==
X-Google-Smtp-Source: ACHHUZ6NPefUkGUqL5vl6EIMjaZhIvc9rAjwAMQRnSJYg/n1gXXKtfjBGm5wCVdPT4h89FLdrxNLTwdajRoXyM+R9sE=
X-Received: by 2002:a25:73ce:0:b0:ba8:29cf:f772 with SMTP id
 o197-20020a2573ce000000b00ba829cff772mr4654184ybc.46.1685036625596; Thu, 25
 May 2023 10:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230525103428.49712-1-linmiaohe@huawei.com>
In-Reply-To: <20230525103428.49712-1-linmiaohe@huawei.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 25 May 2023 10:43:34 -0700
Message-ID: <CAJuCfpEP0m+4fdTSvY5TuWwvvpiQntG5OBhSmEMJipoX75eNLg@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: make psi_cgroups_enabled static
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 7:43=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> The static key psi_cgroups_enabled is only used inside file psi.c.
> Make it static.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 81fca77397f6..2ccb0b2ebd78 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -140,7 +140,7 @@
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> -DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
> +static DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
>
>  #ifdef CONFIG_PSI_DEFAULT_DISABLED
>  static bool psi_enable;
> --
> 2.27.0
>

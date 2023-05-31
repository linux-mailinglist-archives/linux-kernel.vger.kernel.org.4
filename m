Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902B7185A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjEaPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEaPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:06:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA610D0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:05:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f0e612589so4126364fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685545536; x=1688137536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKym96YAzpIP9uRUNi0zGjtXWFUPd2ygLCpBbo0BoMc=;
        b=rsDm8mSycBA9yjsx3K+zjz6B/A5ovegUVU46esg64idEZcUM2/vcGhkQIejHdpUUqi
         ZiFFtrVJzP1DyFEVjp8ckHlunExlJkN15Yraj7vBA8415T/sWBiGugfEtislSdrcOgIp
         I/4aoyfpmO/nnteg81xWA6cN/hT2v+F9KtMnEgFGk0CvRjTDwh9wnIGgx0CrSOMu2zl3
         pEK/MO4SgzhvQHmXlAHBsbOOOHjjtPhbYbTHJobAUkiiqFWTNL1ZX4kx4WTEJiigKcXC
         rv6XqqfwdXshhLCzNELkHJs6CRBDHTtxTktrj3kZHSf+1wt0etkahP1LRMQiR/3e2Xus
         BR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545536; x=1688137536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKym96YAzpIP9uRUNi0zGjtXWFUPd2ygLCpBbo0BoMc=;
        b=HN7fWIrRnI6jhirbT+/qxFVRZdS+93QE2FEAItHFEOYRoJ89Ju/hfjQI0bPOIdspwT
         2vyI6jWV5PT/tIPIXyNBU6WvDJYvcR657U3IeApELDYluecog3k6FEKHilyyR20jnCHM
         bvynQmKDFDflcjJv2u0b416iDGavik/3mrLRqAmJRTONoqAXokRTn4UJ1TpGQCUc9J68
         l3unBeXfwBxVMkZ0YpbbY8iSunW6MZLCidwHTDKei8CGYSJk72oW0gsczJnQOd/RHWCv
         aR8TY/Bq3HYjVbeg4Ql5puYL4wSxA7aHGjWD0tuZSlwvDnYRiodhBg6eouvIVY8VIhoY
         aT3g==
X-Gm-Message-State: AC+VfDxRtbS+BmoewewyQL1UxpNrVpmUWMrBmv/fnS7/GmxA9GC5HbY2
        Dw1Igx5BbvOX+EnHhrk/eqPkNSkjCQrbgCNxD7Sb9Q==
X-Google-Smtp-Source: ACHHUZ6Axf4tx5LENQVUBnzkqzLQgLlmHXX/SDmmcOAQYfuZVZ9/AY8qp30uzVjHucMHU4QqsUwiTJcV09Soko9AgWA=
X-Received: by 2002:a05:6870:659e:b0:192:63b5:13cc with SMTP id
 fp30-20020a056870659e00b0019263b513ccmr5480033oab.12.1685545536357; Wed, 31
 May 2023 08:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230531141556.1637341-1-lee@kernel.org>
In-Reply-To: <20230531141556.1637341-1-lee@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 31 May 2023 11:05:25 -0400
Message-ID: <CAM0EoMnw_4Z6tGC8=JkGKuCFTkJHt5JOFj56+_Z6GDExAMbugQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Lee Jones <lee@kernel.org>
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:16=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
>
> Cc: stable@kernel.org # v4.14+
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/sched/cls_u32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 4e2e269f121f8..fad61ca5e90bf 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -762,8 +762,11 @@ static int u32_set_parms(struct net *net, struct tcf=
_proto *tp,
>         if (tb[TCA_U32_INDEV]) {
>                 int ret;
>                 ret =3D tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       if (tb[TCA_U32_LINK])
> +                               n->ht_down->refcnt--;
>                         return -EINVAL;
> +               }
>                 n->ifindex =3D ret;
>         }
>         return 0;

The spirit of the patch looks right I dont think this fully solves the
issue you state.
My suggestion: Move the if (tb[TCA_U32_INDEV])  above the if
(tb[TCA_U32_LINK]) {
Did you see this in practice or you found it by eyeballing the code?
Can you also add a tdc test for it? There are simple ways to create
the scenario.

cheers,
jamal
> 2.41.0.rc0.172.g3f132b7071-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAD718587
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjEaPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjEaPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:03:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F16133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so68205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685545429; x=1688137429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9hQYHnZva8RSd0ItZzDKoX0R76IANPL/LygsCiCcfM=;
        b=5eyGCrFRA0SL7FzVYaBQBJ2c8rAMnCHGbZbxofJSdWYn2RGso3EZe9+EkK/66lPwO6
         Iqkjxs1Z/wsp/BJMjYgtx7qNFvjln+N+gOdsgizXyHLaMvugYES3hJhblFygpuNU3dBK
         /rkufjynWgFactLBpWmY1gI2TdNk5gBTjLL1IcIFvlTBqQx1x7UhpM3ZgDbiWyCc+umi
         8mT7thH79odxYbf+z7xCjuY8T+f0NRrw+w4Yf0uEp2Z9YXaRoiq533RL8cCe+FwjH5Gd
         kko7M2E/dnpLMQhNoYP4itS4DOXOBeGc2UE44rlrN49637vqEg+778LGtVyqQds6j7tb
         dCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545429; x=1688137429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9hQYHnZva8RSd0ItZzDKoX0R76IANPL/LygsCiCcfM=;
        b=IRSgetw1hVOaf8zi33WxpoNB4qGeTVTtAieoY4Z+yMC00WZhN1Zyrc0Bvrx8iKTdjw
         aeSLypYxVZadzVSuhJAGD3PC1csZl9qwn912Xp5DgY0IrCks5kFFc7oA7Bc8VfVVN6ck
         Kw4wiGxYdpa//r5xx26nFV4vZ2CHJTlwuXlRp8w7fTQvPipmw1i6+kt06XCaI7iaeN6c
         0XF1BaBnXRabSn++cT1hldQMis35K6N5mhi06PVcjwJB9772yjgqTT8G4JjSTWsw1+dt
         SqDYOkglsPKMSVKxt9s0soTvNEmGNf2/Hj5RXV0UdOhqmv41++eWw+J4eZxfavE3zbpo
         4fxg==
X-Gm-Message-State: AC+VfDzzPsNvZUoQdGA4CJxrtHuxRIaVzt63ZYJU3iTw/EsOsa/zEc1f
        mVWBxvami0przPCMhIJXtI4+nHe16/+Yqcc+vRpMkQ==
X-Google-Smtp-Source: ACHHUZ79rtAYPrPj9pBckviOihnUQ6c6rbV3UKc5JhuaJRnXqnkN385r39yywDbzp8MbSz7+BQtk28q2498nTMd+/Y4=
X-Received: by 2002:a05:600c:4f8d:b0:3f1:9a3d:4f7f with SMTP id
 n13-20020a05600c4f8d00b003f19a3d4f7fmr132466wmq.1.1685545428875; Wed, 31 May
 2023 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230531141556.1637341-1-lee@kernel.org>
In-Reply-To: <20230531141556.1637341-1-lee@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 31 May 2023 17:03:37 +0200
Message-ID: <CANn89iJw2N9EbF+Fm8KCPMvo-25ONwba+3PUr8L2ktZC1Z3uLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Lee Jones <lee@kernel.org>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@kernel.org
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

On Wed, May 31, 2023 at 4:16=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
>
> Cc: stable@kernel.org # v4.14+

Please add a Fixes: tag.

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

This call should probably be done earlier in the function, next to
tcf_exts_validate_ex()

Otherwise we might ask why the tcf_bind_filter() does not need to be undone=
.

Something like:

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 4e2e269f121f8a301368b9783753e055f5af6a4e..ac957ff2216ae18bcabdd3af3b0=
e127447ef8f91
100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -718,13 +718,18 @@ static int u32_set_parms(struct net *net, struct
tcf_proto *tp,
                         struct nlattr *est, u32 flags, u32 fl_flags,
                         struct netlink_ext_ack *extack)
 {
-       int err;
+       int err, ifindex =3D -1;

        err =3D tcf_exts_validate_ex(net, tp, tb, est, &n->exts, flags,
                                   fl_flags, extack);
        if (err < 0)
                return err;

+       if (tb[TCA_U32_INDEV]) {
+               ifindex =3D tcf_change_indev(net, tb[TCA_U32_INDEV], extack=
);
+               if (ifindex < 0)
+                       return -EINVAL;
+       }
        if (tb[TCA_U32_LINK]) {
                u32 handle =3D nla_get_u32(tb[TCA_U32_LINK]);
                struct tc_u_hnode *ht_down =3D NULL, *ht_old;
@@ -759,13 +764,9 @@ static int u32_set_parms(struct net *net, struct
tcf_proto *tp,
                tcf_bind_filter(tp, &n->res, base);
        }

-       if (tb[TCA_U32_INDEV]) {
-               int ret;
-               ret =3D tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-               if (ret < 0)
-                       return -EINVAL;
-               n->ifindex =3D ret;
-       }
+       if (ifindex >=3D 0)
+               n->ifindex =3D ifindex;
+
        return 0;
 }

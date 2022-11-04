Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A55618D99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKDBZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKDBZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:25:08 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4E2339C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:25:07 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3701a0681daso31683317b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lToyp0EgaeZrIwiFmFTuf4gl0OZ3lSV2+wziFDvZU0c=;
        b=BwjfzLpI7W5zZiHbND1rLgzjf82q9tnMyeShyKAkCXXZqs+YmydpwUHoO/WirQt3lf
         yJGCXs8z4IJlm6o5WJIqHbWuRVQJSN9TGyCHAc4ENasZO8Nxj5hAXkBr0nZamE7EeCOw
         xAIOCFupCalx9OZtXnQjUTbT+a1WKlc4ucPabyUTmV+d8tQvdXzyShr9cIBUndxy+EV8
         se3fS6MzkdceUSg3BB83wEcGmZrnWfrcFEU4PEYzTrcrqBFk7S9F03SmmQahxITu7P98
         9owynZWuHcUWju8byAKyV54LDWFyYAwZxW01YtyHOfOmcmgQc5Qm6nNnkh9AMv6t+Kil
         sX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lToyp0EgaeZrIwiFmFTuf4gl0OZ3lSV2+wziFDvZU0c=;
        b=j/PnXbwVWdEudYuG4lzkZexHq9/4dTlOe9su0PJTRPvAExMd4kulI6dQw+f52tUj2O
         GUO6qxdlUj13AIQXdKpwnGOq6+Ja9ptfcCIPdLUQpOEj06B9iVHYVl+Kat6Cy3PSlnbg
         e399fqWPl43MqrHl6fD0MUVGYNc7STtogiw5uFrzUt8OHmA5y7cVs6kqmPRpukb7DGcK
         T9FWhDmmQahpDuM25zsV44eKBHUcPKtXp3noN/EkCdAm0a7LSDFr6x9vzE6rVwKvMruM
         6TTQSDaaxEy2PwU5buoir0U7MhYyHhnPtkzJgeR/+m6IGacFdoTS4Poo25DvYbvec/Yf
         OH9g==
X-Gm-Message-State: ACrzQf2iCyZ6b6TvKCjgCtUb0zwGSY+CHP+DftqLrlhdj2eZ1gzR2EzW
        94lytezIE/xPiBLszAIcbP1wohYNrNHEGIP68Ugap8Z/O9M=
X-Google-Smtp-Source: AMsMyM4l63xPJCnxqq3wUHD84HXv74JHao2lfXPNGvrT3jau3PH7lHQLU8mbdztP3lXdowg41GV/MmDJFi/pXl6U7ro=
X-Received: by 2002:a81:5a86:0:b0:36f:cece:6efd with SMTP id
 o128-20020a815a86000000b0036fcece6efdmr30814116ywb.489.1667525106247; Thu, 03
 Nov 2022 18:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221104022723.1066429-1-luwei32@huawei.com>
In-Reply-To: <20221104022723.1066429-1-luwei32@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Nov 2022 18:24:55 -0700
Message-ID: <CANn89i+Pe+yMnGUTUbg=---VB1RO1KDfRLrZjaUVM7OHktMw2g@mail.gmail.com>
Subject: Re: [patch net v5] tcp: prohibit TCP_REPAIR_OPTIONS if data was
 already sent
To:     Lu Wei <luwei32@huawei.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Nov 3, 2022 at 6:22 PM Lu Wei <luwei32@huawei.com> wrote:
>
> If setsockopt with option name of TCP_REPAIR_OPTIONS and opt_code
> of TCPOPT_SACK_PERM is called to enable sack after data is sent
> and dupacks are received , it will trigger a warning in function
> tcp_verify_left_out() as follows:
>

> In function tcp_timeout_mark_lost(), tp->sacked_out will be cleared if
> Step7 not happen and the warning will not be triggered. As suggested by
> Denis and Eric, TCP_REPAIR_OPTIONS should be prohibited if data was
> already sent.
>
> socket-tcp tests in CRIU has been tested as follows:
> $ sudo ./test/zdtm.py run -t zdtm/static/socket-tcp*  --keep-going \
>        --ignore-taint
>
> socket-tcp* represent all socket-tcp tests in test/zdtm/static/.
>
> Fixes: b139ba4e90dc ("tcp: Repair connection-time negotiated parameters")
> Signed-off-by: Lu Wei <luwei32@huawei.com>
> ---
> v5: modify the commit message
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index ef14efa1fb70..54836a6b81d6 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3647,7 +3647,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>         case TCP_REPAIR_OPTIONS:
>                 if (!tp->repair)
>                         err = -EINVAL;
> -               else if (sk->sk_state == TCP_ESTABLISHED)
> +               else if (sk->sk_state == TCP_ESTABLISHED && !tp->bytes_sent)
>                         err = tcp_repair_options_est(sk, optval, optlen);
>                 else
>                         err = -EPERM;
> --
> 2.31.1
>

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

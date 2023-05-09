Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F056FC90D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjEIObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEIObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:31:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F0C3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:31:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f38824a025so201051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683642699; x=1686234699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVfjjlZkJp0IYfrXhtcCeEFdqQLI9OZif8q75MPv2cU=;
        b=olalahCXesiGetwDI0UJCDouvP+4kEGEnF+/v6CftgPAUla/oSp/Ta+Szf/a5A6wGC
         DFl4OdFka/jmQB/Hi9FG7FMCbpMyWWuBUOGT3olzwl1Uo88DG/d60LfCDYaD/ofRMhgM
         pqMzt0UfxfHLIPSKcwKRGXl3hpFO5CMcSW7Hfw7vji/ON8lLH43XJuNJ34n27qYKtCVw
         HNYeIAKDFK8CxxNOVJh39aw1Kth55rvRcesDX9IUUwMkHjSpxgxjgrOi/radMW+1pBGX
         Yz0+42hs0VjgghezD2Aru09jLJE0C55OKl0aHHI67Ai1aOV1sNQQU6KNavwLJMX5IUg2
         uJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683642699; x=1686234699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVfjjlZkJp0IYfrXhtcCeEFdqQLI9OZif8q75MPv2cU=;
        b=iJ2oi+qN5dSVryoG4lkCfd3ZIph1vclkvGnPnnrjZngutUCR4YXY/YgmY5Q6To3s6g
         QhqcDzMnxk/wX4VWS7dZ66WLSUwIyUSZ9JZwQfyiujDiGn9jkZOgwfAQNmNXheWsnCD0
         12DbwcUK6U2NFAbZQBupMxaTzXMF2Yb2sp7jYjWBPl8ErkMDgNjRa130p0eV/W8LzOWG
         ysSr4EOtMt3shzYhIAQy5TCPrck22niFg9HC1ulcF4sqOZzdwvamCveYsestR3bfgNnv
         w6nHnUBRC8w+pzgDNvfUoyZKauujCgVUTeZM14ta5C8DF4Fb5qE13yQJ034C+0OAJI2B
         xfuw==
X-Gm-Message-State: AC+VfDxZDP32SINfV8gs65jtAGd6hK/lz+keg7hsBWbQlD4Cc/SBeHwk
        IDmFaRkhve4Yaj2/Ve6FRjn/n6liZmVZgYGb9+8ULw==
X-Google-Smtp-Source: ACHHUZ7dN/s0ctIZYprNETPi3u5BlxsS06tHXNKXEuu1OHxZqCi0W2hgAXXsyJZc/Lcj7URgbmO0HNEK4GP2jG0Hj14=
X-Received: by 2002:ac8:5982:0:b0:3db:1c01:9d95 with SMTP id
 e2-20020ac85982000000b003db1c019d95mr470317qte.4.1683642699179; Tue, 09 May
 2023 07:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230509135546.580158-1-dongchenchen2@huawei.com>
In-Reply-To: <20230509135546.580158-1-dongchenchen2@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 May 2023 16:31:26 +0200
Message-ID: <CANn89iJRe1-EXa8soRORCKSkQG+mK1MNYfR8B=VPbCrSJ5NpOA@mail.gmail.com>
Subject: Re: [PATCH net, v3] net: nsh: Use correct mac_offset to unwind gso
 skb in nsh_gso_segment()
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        simon.horman@corigine.com, jbenc@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com, weiyongjun1@huawei.com
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

On Tue, May 9, 2023 at 3:55=E2=80=AFPM Dong Chenchen <dongchenchen2@huawei.=
com> wrote:
>
> As the call trace shows, skb_panic was caused by wrong skb->mac_header
> in nsh_gso_segment():
>
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 3 PID: 2737 Comm: syz Not tainted 6.3.0-next-20230505 #1
> RIP: 0010:skb_panic+0xda/0xe0
> call Trace:
>  skb_push+0x91/0xa0
>  nsh_gso_segment+0x4f3/0x570
>  skb_mac_gso_segment+0x19e/0x270
>  __skb_gso_segment+0x1e8/0x3c0
>  validate_xmit_skb+0x452/0x890
>  validate_xmit_skb_list+0x99/0xd0
>  sch_direct_xmit+0x294/0x7c0
>  __dev_queue_xmit+0x16f0/0x1d70
>  packet_xmit+0x185/0x210
>  packet_snd+0xc15/0x1170
>  packet_sendmsg+0x7b/0xa0
>  sock_sendmsg+0x14f/0x160
>
> The root cause is:
> nsh_gso_segment() use skb->network_header - nhoff to reset mac_header
> in skb_gso_error_unwind() if inner-layer protocol gso fails.
> However, skb->network_header may be reset by inner-layer protocol
> gso function e.g. mpls_gso_segment. skb->mac_header reset by the
> inaccurate network_header will be larger than skb headroom.
>
> nsh_gso_segment
>     nhoff =3D skb->network_header - skb->mac_header;
>     __skb_pull(skb,nsh_len)
>     skb_mac_gso_segment
>         mpls_gso_segment
>             skb_reset_network_header(skb);//skb->network_header+=3Dnsh_le=
n
>             return -EINVAL;
>     skb_gso_error_unwind
>         skb_push(skb, nsh_len);
>         skb->mac_header =3D skb->network_header - nhoff;
>         // skb->mac_header > skb->headroom, cause skb_push panic
>
> Use correct mac_offset to restore mac_header to fix it.
>
> Fixes: c411ed854584 ("nsh: add GSO support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>
> ---
> v2:
>   - Use skb->mac_header not skb->network_header-nhoff for mac_offset.
>
> v3:
>   - 'net' is noted in the subject.
>   - arrange local variable following reverse xmas tree order
> ---
>  net/nsh/nsh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
> index e9ca007718b7..793e0bd94558 100644
> --- a/net/nsh/nsh.c
> +++ b/net/nsh/nsh.c
> @@ -77,6 +77,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *=
skb,
>                                        netdev_features_t features)
>  {
>         struct sk_buff *segs =3D ERR_PTR(-EINVAL);
> +       u16 mac_offset =3D skb->mac_header;
>         unsigned int nsh_len, mac_len;
>         __be16 proto;
>         int nhoff;
> @@ -108,8 +109,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff=
 *skb,
>         segs =3D skb_mac_gso_segment(skb, features);
>         if (IS_ERR_OR_NULL(segs)) {
>                 skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
> -                                    skb->network_header - nhoff,
> -                                    mac_len);
> +                                    mac_offset, mac_len);
>                 goto out;
>         }
>

I do not think this patch is enough ?

This is still not nice, because mac_header =3D=3D 0xFFFF

nhoff =3D skb->network_header - skb->mac_header;
...
skb_set_mac_header(skb, -nhoff);

I would simply restore mac_header with "skb->mac_header =3D  mac_offset"
and get rid of nhoff.

(Accept the fact that GSO layer should not rely on skb mac_header being set=
)

In the future, we might be able to rewrite GSO without any assumptions
on skb->mac_header.

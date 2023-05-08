Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00DC6FB579
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjEHQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjEHQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:47:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565F4EF8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:47:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38824a025so262301cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683564441; x=1686156441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMtkKD4IXgG2tE+O0/ps83QQyTIEGdPQcNS9HibcmyM=;
        b=49R8mz76DQt8ZT8Zr/VhUAC6GLWcE8VZtLO/naxrjwog4y4kjOZLSlZz5uH+HjD2LU
         dPP6eP3vkj0QhtlN58n1d9sMx6LnbFoYEFr4dehrt7S//vkmY5pszJGN6a7rewMKuQOT
         fjigsmE8RZ1DzyGT4m+ZRPAj5tH0OqUU5jm4r1YgYgZORcmT4YpOo6A+e6aoIq71GYVj
         DpFEmPMgXxFbdqjJMF5J1lVUh6f2y+YVNhT4A/wCdc2SROJLomFzL5HT0eXlpHWmhjtb
         9WQ4OOmB44Re9fwzOFcLdV6MHg28vP2oOJDru6xJIdlfP1P9kKJIpEP0NMtBChTZgBYU
         qcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564441; x=1686156441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMtkKD4IXgG2tE+O0/ps83QQyTIEGdPQcNS9HibcmyM=;
        b=C4TTcQhsQDIAIKnhOHlRQ7qs/+k3RsO+6UWEes6dCLs6mOl/kK3CHPpop+l3x3FXYr
         8iPEOT4FJM+oVEW/kAJnPiIz9/erUIVcCH6S7pUefzt4gp3FKAN9d4502wBNk407znDE
         NiJNfjTIsRjozjYpCLEhOKJBn7aQctpcV4GWb28+ZMu/1w40CgXrRrGabIoz+4FYg9+G
         oZLZYwSVO+/aXQaN+5K/931T+ENDQJfFAmBakteZ6l4SkQz+2P3kA+YujhGFAa0WF+3N
         MIPbNPQEVdTI5y1MV+C2ub81Jv5bqlYUB0QrW7ooZk9kBLy6gbxGCTvXDzDLhHthtw6f
         ZsZg==
X-Gm-Message-State: AC+VfDyRBIN5ZyKNd8J9I+CgvROP+8IvfxI6JoxA8Jw01Hyx1fUHRqe4
        9r4FjUJbVDboaERp39LqnqSxW44bYnnRhwvGrp489g==
X-Google-Smtp-Source: ACHHUZ5NqZJjqb1/IQorFOcffO24OhacXxoGY5Cknr/bjOf/+cG7kPtpv5HhFZUmdB25k0lj/e5DztQOFC++AEWbxFE=
X-Received: by 2002:ac8:5854:0:b0:3f3:75c2:7466 with SMTP id
 h20-20020ac85854000000b003f375c27466mr641594qth.8.1683564440626; Mon, 08 May
 2023 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230508134258.496465-1-dongchenchen2@huawei.com>
In-Reply-To: <20230508134258.496465-1-dongchenchen2@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 8 May 2023 18:47:09 +0200
Message-ID: <CANn89iKDM0+TCAncVzfncdiRjuQHyx90=+HqXyZMpYOun5zecQ@mail.gmail.com>
Subject: Re: [PATCH -next] net: nsh: Use correct mac_offset to unwind gso skb
 in nsh_gso_segment()
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        jbenc@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
        weiyongjun1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 3:43=E2=80=AFPM Dong Chenchen <dongchenchen2@huawei.=
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
> ---
>  net/nsh/nsh.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
> index e9ca007718b7..17433b115058 100644
> --- a/net/nsh/nsh.c
> +++ b/net/nsh/nsh.c
> @@ -78,6 +78,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *=
skb,
>  {
>         struct sk_buff *segs =3D ERR_PTR(-EINVAL);
>         unsigned int nsh_len, mac_len;
> +       u16 mac_offset;
>         __be16 proto;
>         int nhoff;
>
> @@ -103,13 +104,13 @@ static struct sk_buff *nsh_gso_segment(struct sk_bu=
ff *skb,
>         skb_reset_mac_header(skb);
>         skb->mac_len =3D proto =3D=3D htons(ETH_P_TEB) ? ETH_HLEN : 0;
>         skb->protocol =3D proto;
> +       mac_offset =3D skb->network_header - nhoff;

I would prefer:

mac_offset =3D skb->mac_header;



>
>         features &=3D NETIF_F_SG;
>         segs =3D skb_mac_gso_segment(skb, features);
>         if (IS_ERR_OR_NULL(segs)) {
>                 skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
> -                                    skb->network_header - nhoff,
> -                                    mac_len);
> +                                    mac_offset, mac_len);
>                 goto out;
>         }
>
> --
> 2.25.1
>

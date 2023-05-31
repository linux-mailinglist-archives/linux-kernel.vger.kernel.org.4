Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A0718886
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEaReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjEaReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:34:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD31B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:33:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso5655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685554438; x=1688146438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvW+50pGnn5QOgfO3D3LncyxO2u5YNKyCZaYvFUjphk=;
        b=MzykdRuGy7oouMHUpYT99CeXMTQwcjdjbMKnveR/WpiUZ8BT91SFVFhwnB5Tu9yEHR
         byvqd+6EnQSr0I6/WuQQe2ykN85wAvnYMkUc9uT8KIm2iW9a4aMKpavUvg29l3YHw4iC
         iRK2/gjiG+NGp9Pgn8O763j7A5f071V3Mx547F1iemsomiPeGqIdQykOMaqLjJIVkH0N
         SwzUT54zgHep7K32DdSAoxoR4UJ5S3LWVakqh0q8yiPXAarQNPfjmUlqlU0HYxeaSWsQ
         OEsNQXNfUyvvv08p4xGR5zR34CQ3fTauz3D06qirunAjEC8z/9+AuwcaXpgQm7JrYXIQ
         sgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685554438; x=1688146438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvW+50pGnn5QOgfO3D3LncyxO2u5YNKyCZaYvFUjphk=;
        b=jRMMCyHEX5pqwjZf6NLidU28LhBMgmIUFx0WWfJU73egJjVL5pveqT2u+LsfsS0qwH
         5kjP0SnLVEeRnryOGkniH5/9EdGxTdcHBZ26tWMJnkspYxWF1BzvDWPVTeJapmTePATm
         BxJ3GKG0QmY2epWnShR/X9j+kJFohX1ryY0WP8fVUbW4DRqDemCbCJhG8QflM73L5k51
         M0zvritHYzm7VniwKdyiQJD2IzOg6T9cguMuaL0dgHlRHOC45LL4hEUw6Cfghdm/Euh3
         U2e+Vu1AZ2DxDELF0pwJIQYYUVInOQk4ekxN72NCVAgaqoqAl1a+Wa1Vo3sQbi2IaiCV
         pzCA==
X-Gm-Message-State: AC+VfDxJRtVFr1cg6aYge10Ww+mAt+c58ttCqE+K+FfQgd3x/BhGvM+m
        Mt99feGHKrimKgm/a+j1enjGoEgat0Oz424clNnv4A==
X-Google-Smtp-Source: ACHHUZ5NDb9GF5ZC+fL4OxsWYnV8ZY6mqPK8zGeLpJwTW1VNxqavQSnVvmXWb48MA94P7jf37vXgYTUlHUxjQog8ilo=
X-Received: by 2002:a05:600c:35c3:b0:3f4:fb7:48d4 with SMTP id
 r3-20020a05600c35c300b003f40fb748d4mr174755wmq.3.1685554437978; Wed, 31 May
 2023 10:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230531172158.90406-1-jon@nutanix.com>
In-Reply-To: <20230531172158.90406-1-jon@nutanix.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 31 May 2023 19:33:45 +0200
Message-ID: <CANn89iLE1d=MuSMTisEbLh6Q_c4rjagd8xuRj0PC-4ua0pDRPA@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: introduce skb_get_hash_symmetric()
To:     Jon Kohler <jon@nutanix.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Guillaume Nault <gnault@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Qingqing Yang <qingqing.yang@broadcom.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Felix Fietkau <nbd@nbd.name>,
        Ludovic Cintrat <ludovic.cintrat@gatewatcher.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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

On Wed, May 31, 2023 at 7:22=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> tun.c changed from skb_get_hash() to __skb_get_hash_symmetric() on
> commit feec084a7cf4 ("tun: use symmetric hash"), which exposes an
> overhead for OVS datapath, where ovs_dp_process_packet() has to
> calculate the hash again because __skb_get_hash_symmetric() does not
> retain the hash that it calculates.
>
> Introduce skb_get_hash_symmetric(), which will get and save the hash
> in one go, so that calcuation work does not go to waste, and plumb it
> into tun.c.
>
> Fixes: feec084a7cf4 ("tun: use symmetric hash")


> Signed-off-by: Jon Kohler <jon@nutanix.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: David S. Miller <davem@davemloft.net>
> ---
>

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 0b40417457cd..8112b1ab5735 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1474,6 +1474,7 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, =
bool is_l4)
>
>  void __skb_get_hash(struct sk_buff *skb);
>  u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
> +u32 skb_get_hash_symmetric(struct sk_buff *skb);
>  u32 skb_get_poff(const struct sk_buff *skb);
>  u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
>                    const struct flow_keys_basic *keys, int hlen);
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 25fb0bbc310f..d8c0e804bbfe 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1747,6 +1747,35 @@ u32 __skb_get_hash_symmetric(const struct sk_buff =
*skb)
>  }
>  EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
>
> +/**
> + * skb_get_hash_symmetric: calculate and set a flow hash in @skb, using
> + * flow_keys_dissector_symmetric.
> + * @skb: sk_buff to calculate flow hash from
> + *
> + * This function is similar to __skb_get_hash_symmetric except that it
> + * retains the hash within the skb, such that it can be reused without
> + * being recalculated later.
> + */
> +u32 skb_get_hash_symmetric(struct sk_buff *skb)
> +{
> +       struct flow_keys keys;
> +       u32 hash;
> +
> +       __flow_hash_secret_init();
> +
> +       memset(&keys, 0, sizeof(keys));
> +       __skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
> +                          &keys, NULL, 0, 0, 0,
> +                          FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> +
> +       hash =3D __flow_hash_from_keys(&keys, &hashrnd);
> +
> +       __skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
> +
> +       return hash;
> +}
> +EXPORT_SYMBOL_GPL(skb_get_hash_symmetric);
> +

Why copy/pasting __skb_get_hash_symmetric() ?

Can you reuse it ?

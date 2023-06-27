Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083273F08D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjF0BbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjF0Baf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:30:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E51993;
        Mon, 26 Jun 2023 18:30:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635e372679bso10393236d6.2;
        Mon, 26 Jun 2023 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687829426; x=1690421426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhDlakkrO33rTu0vQMvMOMEB5EZyQV3S4PB9Kp4amtA=;
        b=UhRlL3DNGbZeEZt23RGvIG9Ly/RG0mw2Rc2FyOSpAeqD7GIx6EWIa6raInkqvnBJmX
         Pt+brnZouqiDiUcailCSzKpPhXmlQUtQ3Dq5aQBLlszddbwcCYrKqxg3Z7LBbT94HSpA
         l1xxCGBRSAuUptuwwzhJ40qUgw8z3D8PC1n20AXaAOxTJWYTuqy8jymdw3Y4yb4aQhru
         VhL9jthPpbnLDpWn1PPmIt8yBsXur+ldrwPe8VduZoAmQTdqmwNTl992PIyKOph7uRjR
         TwCjpqQWweTuI1SUp4Aimia8/uveXXMw22eJwCjL4YugYsWJgqB0k6w2h5h2uVlQXigX
         wPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687829426; x=1690421426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhDlakkrO33rTu0vQMvMOMEB5EZyQV3S4PB9Kp4amtA=;
        b=fnIIxWJAaOTDBMVk+FoX3ExhSglTvWal0oPFaeTPaewq1uXuqTB2fg4pwBf5lkDApT
         B5xXRyQIVMckiYw/Ka7WEojBp28J0AQbqONSG3AAY0dwzHS10sgMzFdQ+pV7T2RLyyWq
         Ly0ruM6g6vDOn44TY2pirBaNF8CA/mrIU1QQgS7lEmE34u+PA7ikjblnL6PNdP8+abZy
         I9S4240RI25xbXvGrfIa9gEWbjsb1IWO5pJH0bZqUgLlA0ZAF10txoHxdiq0vtQmSfEM
         aj2xPc9+2SmviUVAakzMWxFPyf1H6LOTBP/U22XAWZkXT/UZtwUvLvxQkgwR+P84xAhT
         Cn9g==
X-Gm-Message-State: AC+VfDwHMJWkZMG0lHPPZ95Nug+z/CiRkFveB3xxonr33an0mGYqxJ7b
        0B9FVMla1EAx6crZp1tjtox6CZjCTfF1hXLDEns=
X-Google-Smtp-Source: ACHHUZ4kZbh1tCdR7x8U4aF2VQHX8COh1+eYDiehF3xxhPpEIWXa+rSS9P+G4CeobUe0aqQRMIHP0zEVJqPOgPQ6NSM=
X-Received: by 2002:a05:6214:2249:b0:626:3a5a:f8e9 with SMTP id
 c9-20020a056214224900b006263a5af8e9mr42430080qvc.54.1687829426301; Mon, 26
 Jun 2023 18:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230627012129.4066-1-youkangren@vivo.com>
In-Reply-To: <20230627012129.4066-1-youkangren@vivo.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 27 Jun 2023 11:30:14 +1000
Message-ID: <CAGRGNgW7oVdbriG2uTQt0hbJLErXQ4JAX8aWo9Hv7A5idadHEg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ray_cs: Replace the ternary conditional operator
 with min()
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi You,

On Tue, Jun 27, 2023 at 11:24=E2=80=AFAM You Kangren <youkangren@vivo.com> =
wrote:
>
> Replace the ternary conditional operator with min_t() to simplify the cod=
e
>
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/net/wireless/legacy/ray_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/=
legacy/ray_cs.c
> index 8ace797ce951..5f97fcf5c4ba 100644
> --- a/drivers/net/wireless/legacy/ray_cs.c
> +++ b/drivers/net/wireless/legacy/ray_cs.c
> @@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_=
t *local,
>                         rx_data(dev, prcs, pkt_addr, rx_len);
>
>                 copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_=
addr,
> -                                 rx_len < sizeof(struct beacon_rx) ?
> -                                 rx_len : sizeof(struct beacon_rx));
> +                                 min_t(rx_len < sizeof(struct beacon_rx)=
));

This is obviously bogus, did you compile this before posting it?

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

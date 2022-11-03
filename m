Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26588617BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKCLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:54:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A4DB3;
        Thu,  3 Nov 2022 04:53:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d26so4461131eje.10;
        Thu, 03 Nov 2022 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcS1ogD5RMaT4vN4BugWaTdOyuYyorDCDxxuL0275yQ=;
        b=iMVjGkJ1sZur7OAaUgFd+Sdtkj72KA/wRb1smYLytE+nhnh9GxNmdTXJmG2OipM2aA
         YELlry3DCqHNnh6QNrN+YzH0L+1yMZL+Xt3g8N9NH42LcCd/prsDp1UpQwUwnK/OLQdO
         dFFYELOHNpwv8MerRfdMIF5hdVBC2f+kOsWupT+w9EM8sXLumYOELTgS+FwNJdt5VJAV
         B3dCFPqadysatetc9CrSZ6YL1NfWkMrRUVXQlLA/I7vx9lMnfgX3+vwAUiNU87L3TOZl
         NYGYV8DZgIKdf54KDqmEfqK6zbTVcdcnGy5rI+djcMnnc55TCaAcI5nlAUt4MXuk2UGo
         Ph7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcS1ogD5RMaT4vN4BugWaTdOyuYyorDCDxxuL0275yQ=;
        b=z3DLBgibsxzGB9tGwDf1IzkhRtAk6t2/TU/jEOPKiBD0uaotYfsBSlg9sGqodr6/+e
         JAL+Whe4LlCzxqcYdlh+W9X7coFNeRszXjWf3E9Za/jKIO4uXZS9h3qpqdGbLdELqCpF
         ruGY/jE/DLdi3M1ZI6Zn6SpVmoGVVyR7kBUKo2pl59FrSCBaQnEppsbE2WBIv4A9piTc
         U6PIrfVNlzrYPNlUI7NsYIo36o61+zKFBS4ZCJV4pv2CSisvdcfQnzhqVdc8lERtU/ZC
         ARvWeLuSYKMt7/Uxf3oeCTpETnqy4nd9rdnMtoLXUxJl7tK609hkBj/ZhGZ47l0qBvE3
         pgJA==
X-Gm-Message-State: ACrzQf0kDA88bYQzGdHQtNyMJ9nYQPG1tVEqCUxma0JVqy/0sq/t1SsQ
        WiJEs/FMGscl1UKRa0EB4TIULZymb28=
X-Google-Smtp-Source: AMsMyM55jgJRmDD3iSIiCOfs5zW12Rty87tKQ0QZgLPRpF8Dw1Dp9ExAtPixJiMGijfyVfyvPAz/rA==
X-Received: by 2002:a17:907:6d8a:b0:7ad:d3a1:cbf6 with SMTP id sb10-20020a1709076d8a00b007add3a1cbf6mr18913968ejc.533.1667476438483;
        Thu, 03 Nov 2022 04:53:58 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906114600b0073dc4385d3bsm405883eja.105.2022.11.03.04.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:53:57 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:53:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v5 3/3] arm64: tegra: Add user PWM support on Jetson Orin
Message-ID: <Y2Or06mrvLmZZ5KT@orome>
References: <20220919141455.31084-1-spatra@nvidia.com>
 <20220919141455.31084-3-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y9DjAhgJL9OQknsI"
Content-Disposition: inline
In-Reply-To: <20220919141455.31084-3-spatra@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y9DjAhgJL9OQknsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 07:44:55PM +0530, Sandipan Patra wrote:
> Enable in device tree and use it to drive the PWM controllers on
> 40 pin header of Orin dev-kit.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V1->V2: Overriding by node label instead of node path.
>=20
>  arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

Thierry

--Y9DjAhgJL9OQknsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjq9MACgkQ3SOs138+
s6FXJRAAmlcrdgBbQTazfj/BmblRxClv3Ph1v+NB5qkbNCgeKg4tkE5RYHqTyC60
TaZb64oH6iPRLMxo/NFdMl90fPgXyut0tfMoyXZdk4PV/g1vjseyZZXAxrwEh4Yr
g618kp2QVs4nds2hmm1bIND8x9nQyD4X74+OYMKzO8/Wu7h6XjrXKMuEF09kP19Q
cJJilwQqmne0vyP+1yAz9iRDmNjy3Uz29NhSLQ8v3y210XBRYH7LOShaZValfIyn
/BPI/AVSuvzgrLR35rvYG8ZzDq9YDuUXexdDzISXRYM3U3Eti8L23tQGlTm4mGcy
opp8N8L+hyca/96ZJZlmPyyU6C0+5eQq9y2EuYwa1ScTOyVsSgo0aCZN4aps+YOe
nEuD8vSKUms8JtGjJm8eaO2ISZAmEYCRxQcJvPjQEr2kVr2upjL6iycZRemBTb8s
aTYI2qnu/Tqh2gw8Urr8ZDb+IyE0OH+N3vv+wJmMnLYYxMyj4NAdIZKHY6W8yKJt
HCD87d55a1UVS+AA4OOCQNt5pDxpksiqhYgO23am5C+tAcLtqlwLuOccacYi/ZCO
RfkCucpI8nQ5vKUJKz9tadFzV4FjtNkFGjj3agwuoEl2X+pd+iTQukEBxbAPQuJz
i6UV6X4HeaJQKaJmqgIc2hRg+Kxmq+hOxDLDaX9EG/DT9kMRIY8=
=3REq
-----END PGP SIGNATURE-----

--Y9DjAhgJL9OQknsI--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C52668B17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjAMFKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjAMFI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:08:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045815BA14;
        Thu, 12 Jan 2023 21:08:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ss4so42452917ejb.11;
        Thu, 12 Jan 2023 21:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtw4WHGu+OATpWcU0u4H+R8E0E8xhz+D1fXiT2aRITI=;
        b=dMQBkDVowPjcnzuTiFHOBWCdCct36UMtona+WrSRnGFGrA1UjMiZnmb4LXbxIskScC
         k7ehagq9WRleuolKvqfIrm2N0FLPuUeaqmil0cE3RV01+Si74LUV3OC4Sbx2xUW4E3NI
         1OWO2m2ZhnH9yz885DRuAZJH+gHW506l1PXNVxwA2sr7QJUz04Viis+tpIphUzqmNFzA
         zq5MT+Cg1tv97F38aQv+ZSULw576vUtxEbzVq1/lZ/EJP4Mj06Gia+fncyYB6zOkBvHZ
         xpgUhENRnLaUq6QsN+jNdLKSn55TWkSpjHkfemUs3RLm6vxkfAlDtSwS+Tf30pLF3RT8
         CXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtw4WHGu+OATpWcU0u4H+R8E0E8xhz+D1fXiT2aRITI=;
        b=ibNmWlmdWLlDuGbPhlmu7AJbSIkjweNTgdMaDqui4l08/LNjLvzhkPuO1vEnf700Xh
         /UAYIXgbR7Yl6malkBVXf7z0Me99MsBqJU38+5MbyglbBDnqJc0tHcdsno7BbBkryKhD
         kI1RAENHRwRMYk8/3pK8tRUC37s9Q4/tuG1P7UwndGoQPmWUxDtDeg7XogexmRwLPJ12
         4LdHeHDKBUWyd6IkO2vC4Z9F/30UOnReEzkTDjn9RltJVBJ/i6YjyJEPX9enCus69dV9
         dKTfd3uZDAWXsXJqy2R1rbCWwCB+8PvkPJMK3UC1u7Vm0r9GebIW2tW8kVoZpdKD5HC3
         jL/w==
X-Gm-Message-State: AFqh2kpT5TFmTZpCbB70QCQANhM1hXqKQaeiDtHcGsEVBDTO3nfP495m
        lTEtt8YVBxlFnO0fbe/BMys=
X-Google-Smtp-Source: AMrXdXteEP5DXH8667AQDCEZztPHXS5s+cR8cR1LVXg6WWAFS+f9RCRnqMToHs/+vv/OKYDslxBaEg==
X-Received: by 2002:a17:907:62a9:b0:85d:dd20:60a2 with SMTP id nd41-20020a17090762a900b0085ddd2060a2mr13187213ejc.7.1673586490507;
        Thu, 12 Jan 2023 21:08:10 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709063ca100b007af0f0d2249sm8146059ejh.52.2023.01.12.21.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:08:10 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v5 2/4] regulator: sun20i: Add Allwinner D1 LDOs driver
Date:   Fri, 13 Jan 2023 06:08:08 +0100
Message-ID: <5906718.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20221208084127.17443-3-samuel@sholland.org>
References: <20221208084127.17443-1-samuel@sholland.org>
 <20221208084127.17443-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 08. december 2022 ob 09:41:25 CET je Samuel Holland napis=
al(a):
> D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They are
> similar and can share a driver, but only the system LDOs have a DT
> binding defined so far.
>=20
> The system LDOs have a single linear range. The voltage step is not an
> integer, so a custom .list_voltage is needed to get the rounding right.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



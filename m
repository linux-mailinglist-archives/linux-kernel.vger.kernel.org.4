Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37110667D75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjALSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjALSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:04:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE13A46E;
        Thu, 12 Jan 2023 09:31:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw16so34634793ejc.10;
        Thu, 12 Jan 2023 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b1YvEduE2Lq3FWBo//yhH8lPQLXXelkFLjhNzSZXfQ=;
        b=mB6aSPZ5KWd/zfVKuH9QriTeN1gEtyxHYvUGO/x717kwWaE8xssUuDzEVKkMerTsoE
         qZJCTTWBEjFbjajR0LRC5SShevWgKAv+WnGxyhckrF2T5u35aI96L10fClwUvDiZql8c
         YS/878SsI7UvUCv0wgNQpfN3FS0Ebtn4iTbwFzSxi8nToT1flZhatlaokNUWG/rQnBWK
         944QsUcNDPnwsj2bJuTDTZyj5cYXiRoDBAYZ5x/EZSI4/PX4dgxRsw79R5eN4WVLnU1A
         uQ0fhaWEZaUU90OjXKJGnRzZDbYYwe7bm92NvMGq3GWnIkOaGgHRmeE6XPDdJuZ+zlhQ
         1/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1b1YvEduE2Lq3FWBo//yhH8lPQLXXelkFLjhNzSZXfQ=;
        b=77eNYWbzscNPRyYUOwTilNLXMfKEqQQ7e64mlU+A8rq1ZDF7FY2Ip0YH+FhE1i5k2I
         NJIHo2QNfw+UqrJxZ9j8QNnLJN5Oh8fcCJZh3i2dyTE49bQTezqXP79zUdyhZItxY7kW
         N1jutXnjq67JLk2A1bZEYi69t+osuYVlskrjRVMTirLpeoNALB6N2nCWFUrLSLXCvhRA
         IOmK3xGyDCor6CzODir5eBbxKXgFmNdO6XaqfIgkOBRRaZSJ6eycJHZl1fpJ9zldgpxh
         3k3bB7FYSfUAOqEbHnQCzRLnvafX7DzwOu6GUc/u73kXC7RoiR1Ylsi2040vlEv0Pv15
         FxcQ==
X-Gm-Message-State: AFqh2krP8K2nxRPbBdJdQ9XPwTp/Ogf48odoBogo9KqquAs6487ieDHe
        kmXsX9CLphhFAnRjytsh2BQ=
X-Google-Smtp-Source: AMrXdXvwLgmc7OIQcgcrv7byi14F85iblvv8fCg8r1qQxR7duwQM3dvEECmjIvkHON6osy4LCZgjgg==
X-Received: by 2002:a17:906:b00c:b0:7c4:fa17:7202 with SMTP id v12-20020a170906b00c00b007c4fa177202mr64973810ejy.33.1673544709194;
        Thu, 12 Jan 2023 09:31:49 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906319200b007c1651aeeacsm7644404ejy.181.2023.01.12.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 09:31:48 -0800 (PST)
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
Subject: Re: [PATCH v5 4/4] soc: sunxi: sram: Only iterate over SRAM children
Date:   Thu, 12 Jan 2023 18:31:47 +0100
Message-ID: <2674451.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20221208084127.17443-5-samuel@sholland.org>
References: <20221208084127.17443-1-samuel@sholland.org>
 <20221208084127.17443-5-samuel@sholland.org>
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

Dne =C4=8Detrtek, 08. december 2022 ob 09:41:27 CET je Samuel Holland napis=
al(a):
> Now that a regulators child is accepted by the controller binding, the
> debugfs show routine must be explicitly limited to mmio-sram children.
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Merged, thanks!

Best regards,
Jernej



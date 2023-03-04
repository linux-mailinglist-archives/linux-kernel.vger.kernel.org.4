Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5B6AA8CC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCDIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCDInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:43:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB115CA9;
        Sat,  4 Mar 2023 00:43:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z42so4605349ljq.13;
        Sat, 04 Mar 2023 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70ZWc+aPECVoIOGnXpdYWCEvBu+S9xi4hcK/1o5dA1g=;
        b=f+jiYGLCjdp88kte6Sr3DZVP2pNxla0i0slfaGRNUVkQPrYfPwWxwrWTpjwUeX1eAM
         eGAWpY9Lda33j+BmirHcvUWl5hkMyqJfUbc3H586O4PRuSv5n6WPy2yRRtd7Nx+LqfRK
         6ozNIRBux/9q+KG/o7nMD3cz5UffR9v9RDQURSFcnaWM7SZ25vwrotT6CI9QJVtDnmph
         TLZo4O5NjUhgWKHZPJRmhmMkxEp8aogeLWwunUiAbLf6vA+egtjP5Hsg0db3uF/EJ7Zd
         P+lckVE4ClTCUDTY2PVqEms1cPKzDuodzsgTMEZK1egM8J7JTcrz+vOwLs0nd69RxvVg
         8bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70ZWc+aPECVoIOGnXpdYWCEvBu+S9xi4hcK/1o5dA1g=;
        b=MeoNf/pDmo93uywQRROFKAJYBA68yiPgwihzgq7hAVRVQrdzdZWditRTynCsDRb626
         X2ALXYKJ6iASot/Q1IVE9UeJNErjtO3DdwyVnhsLEaZAGStvluSoVAnlo7lg/qXq7+PS
         wP8IVPbqu7PsSbYLOXjHMOb+nqxcCnj6LTdIG6P+TcOsXknnViXqdRryZRb7gTunBELV
         s9T6DtHnPtVNRC+nzOBJwRd37etDpMPFkTkdwsGLcRh6Yih5bgQ46/r76RTxKokd0m0y
         nbqyJtKl9sOi0mfkYDhFGzQwZf1oc8SUO/30uwPdpb9vsv0Hfe4YJrA6X9KQncKmnN6+
         4CWQ==
X-Gm-Message-State: AO0yUKUbEhG9FoKTzbEHKyyg+DcAAIcvOt4Mll6fZNBegB5XuJaWOCdZ
        7v0AnKI1c7x9O4mHKC7zew8=
X-Google-Smtp-Source: AK7set/QjskNvisTw7PCJzaFpS7u2g4mGSir56UAUiG88iga+Xb1BvwOpk3xpArRGz5Bd1I4ErXMNA==
X-Received: by 2002:a05:651c:11c6:b0:293:591d:d859 with SMTP id z6-20020a05651c11c600b00293591dd859mr1164414ljo.17.1677919424557;
        Sat, 04 Mar 2023 00:43:44 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b00293cc5f83b4sm693575ljl.27.2023.03.04.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:43:44 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Sat,  4 Mar 2023 10:43:18 +0200
Message-Id: <20230304084319.18424-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304084319.18424-1-clamor95@gmail.com>
References: <20230304084319.18424-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accelerometer mount matrix used in tf101 downstream is inverted.
This new matrix was generated on actual device using calibration
script, like on other transformers.

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index c39ddb462ad0..588845965f99 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -577,9 +577,9 @@ accelerometer@f {
 					vdd-supply = <&vdd_1v8_sys>;
 					vddio-supply = <&vdd_1v8_sys>;
 
-					mount-matrix =	 "1",  "0",  "0",
-							 "0",  "1",  "0",
-							 "0",  "0",  "1";
+					mount-matrix =	"-1",  "0",  "0",
+							 "0", "-1",  "0",
+							 "0",  "0", "-1";
 				};
 			};
 		};
-- 
2.37.2


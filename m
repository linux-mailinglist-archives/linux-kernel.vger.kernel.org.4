Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF81656035
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 06:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiLZFr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 00:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLZFrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 00:47:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE725260A;
        Sun, 25 Dec 2022 21:47:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so2059683pjk.3;
        Sun, 25 Dec 2022 21:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87f0TKfgjxiemevwHpQhVGmMoe8NuCN8KvjmmGoJcKg=;
        b=Un99RLgoUgD6VwGxVDiAWbe0ZBFbzdTF/PS3A/DVSjbwc9FYLekIr+QFeg923zh4Re
         4mGJeCzpmHxuBho1xhQx6gjiOPVp9yWqOmj+K0ehgoufuCuRejM3yC5Hol9GNkenjeFk
         0aWbXrX3/q51C6PMpQ7ZS1laJZZeH0At2w1hdsYBz7jh4Ty7sF7Y7jdywEaAyIUYtzVc
         3dDJy46pRBwtaAVku9ulK6uli8QhpKEDw2saJVmvCc302hIoXpFZFvnPvy9IeNd2yU/t
         UgqwMj6jd0BCoZf5saDtgq9/A/g22o+NjTYSKxQW33sAZrCYN65L+YUfEsayWrWZgjZt
         G9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87f0TKfgjxiemevwHpQhVGmMoe8NuCN8KvjmmGoJcKg=;
        b=6xXaXtG1jYXQwED/JNyftc+beBiXZQIB4h7/z1mh6+boPxz6j00EnFDyot/zMOuM5N
         ILkFnq1PYhoqswek7/O5HAQwozRLjn9gp5tt2kYd+6nC9GiHBRjoRQKhVPqnlEmVGfQK
         FGQyrKiu54/0I8kcQG53QmoUlz+8zgRDf0RkiGHmzEqZ7m3qlDLZbGk0D1L6Yog8W1Kz
         7RC78jIdsHNHngFE4qFyVIXHKXLE5TztGpKCbZIBZRl2q7SjduSIcXoc6/JWH8wjeFwF
         cHUQWbxNfed5LHk1Sw3fHU0N61HUTvPlXhHyrIOsiPRiX6QUA7Fbbe0KBi3JhXg3n1lj
         /9fg==
X-Gm-Message-State: AFqh2krYiqaqM4exqn3mP4nhF7zmX4QCbrGx2TnGewG6pYJXdVnfMEaO
        rjXICfH5e4UHgek1vlCKkL0=
X-Google-Smtp-Source: AMrXdXvJ52ah+JhJWrYHL09E1VzFUCxLqP8oKoLx9D+Iyg46GZa5OCS49wuCUy4jevmOlvMgK1tqig==
X-Received: by 2002:a05:6a20:2d1e:b0:af:6f24:b154 with SMTP id g30-20020a056a202d1e00b000af6f24b154mr23355221pzl.60.1672033670203;
        Sun, 25 Dec 2022 21:47:50 -0800 (PST)
Received: from localhost.localdomain (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id h35-20020a632123000000b004785d99321asm5618242pgh.86.2022.12.25.21.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 21:47:50 -0800 (PST)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: rename flash1 label
Date:   Mon, 26 Dec 2022 13:45:34 +0800
Message-Id: <20221226054535.2836110-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In OpenBMC, phosphor-software-manager use "alt-bmc" for secondary falsh
label.
Rename flash1 label to "alt-bmc" to support dual image feature inOpenBMC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index a619eec70633..791f83aaac50 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -307,7 +307,7 @@ flash@0 {
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
-		label = "flash1";
+		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.31.1


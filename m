Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFE6BA963
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCOHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCOHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:31:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394112C67C;
        Wed, 15 Mar 2023 00:29:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p20so19075721plw.13;
        Wed, 15 Mar 2023 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+0n8wKmHMGFlWU1/ByhfOV+TIKgh3PvnfTP4gSWN6c=;
        b=FJNkGFc1fBYMnFsOVBLm5Em8WKPJpxIb+jBfT4o/tV0eqQ/ks/Zq/htHrhu9t/SETC
         Ygo9oN8pWNozdI1yHJFx0PKHnOm4LzFbYchtcZbeRtfIY01LDbDoWfl2eVqAR+fU1Pyl
         hOTnVLwjkHzyVBLSI51G2qIBzp7tXnzL1nn688DM/QgpaMx1Nwcc3YvqPLA/1CwQ6PRb
         4jy6VjOI6lmQKLKOCy6xmE6fRJ5cQltUmkO5r+Xu0POU5UEOj2fk1QIiA2trmklC8F0q
         Dt6Knc98nAQmw9s2K8kcr5zy567ka7KBXOsi3z3MJzSUkibKZP1dw33avMx/V67tCVHE
         zANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+0n8wKmHMGFlWU1/ByhfOV+TIKgh3PvnfTP4gSWN6c=;
        b=EnMny5Ru8GvfKnUTY++lSqNBVZA+EXhUy+ormbL/C7g0mTtPdPtr3NHQsE96FICIVJ
         GfD/EHjxkZv8JEZIucChZEBn3ZcSQe1xNixxFZk9Oy2tDDcNaa/zwmRtsKtfF0eO1hWA
         7+WBNgyblYGu9e7CReJA/u4Ro21ukWe6HyG/m5WgY3tZjFraNiUYd5NRubd7J8ymIXFy
         mk4I/OVaOWttIRNVYeuYYBLNPd658Nv5cEsQdYl4GglvdcUsrIcvk8Z2FvggQPuen477
         +WK4lZeIcd+JgbXqOXHdmDpy9+OB22AMYXT06wj+yGvEEDwAQRJTZlLzzYEbvaiUP5Lp
         VmRA==
X-Gm-Message-State: AO0yUKX1YXzZbi6YFDz68zi8jUdt+Z6UNabcH3vpW7jJem3yqb2ymJcJ
        jjffUxUXltGbQQEBweD42bjsTOVwqfZkjw==
X-Google-Smtp-Source: AK7set806ujFMhHwrHJdvnKd7BUTN0cJlXk+28UtebQsAjiXy0G6lEBlXx1eYlTUq+1iMufAUO/DGQ==
X-Received: by 2002:a17:902:e38a:b0:19f:1e3e:a84d with SMTP id g10-20020a170902e38a00b0019f1e3ea84dmr1341206ple.64.1678865386563;
        Wed, 15 Mar 2023 00:29:46 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:46 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 15/15] MAINTAINERS: Add entry for NUVOTON MA35
Date:   Wed, 15 Mar 2023 07:29:02 +0000
Message-Id: <20230315072902.9298-16-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jacky Huang <ychuang3@nuvoton.com>

Add entry for Nuvton ma35d1 maintainer and files

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..b42d5c052863 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2535,6 +2535,18 @@ F:	arch/arm/mach-npcm/wpcm450.c
 F:	drivers/*/*/*wpcm*
 F:	drivers/*/*wpcm*
 
+ARM/NUVOTON MA35 ARCHITECTURE
+M:	Jacky Huang <ychuang3@nuvoton.com>
+M:	Shan-Chun Hung <schung@nuvoton.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/*nuvoton*
+F:	arch/arm64/boot/dts/nuvoton/
+F:	drivers/*/*/*ma35d1*
+F:	drivers/*/*ma35d1*
+F:	include/dt-bindings/*/*ma35d1*
+F:	include/linux/mfd/ma35d1-sys.h
+
 ARM/NXP S32G ARCHITECTURE
 M:	Chester Lin <clin@suse.com>
 R:	Andreas Färber <afaerber@suse.de>
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8445FAB16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJKDVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKDU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:20:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0271CFE6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:20:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so12352317pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQrtkRGGXCGLvTRxdTZLyyBV0NHkVCxaDkOQfjaMrKU=;
        b=CNMbYNUf4bUmB0Zm/bb3Y6WcTqe1w3Fcmj/WHNCRNwQy11B0xxPG77cSJm2eEGpbeV
         iWs+4oW2ClN4DD/NvRmwq0BG8BSMKTj7mo/WMn5QhbH7KmlighFgePp47E1YA5UUG5ri
         Z5+q4k2TnoG8y/tArtHuVLeEP0xpHfZr4KLJlUfBkmB895ztHmPRte4xdkSANpIn3B1P
         2OtJPYFHkgMWGTup40fpTsraoAcqrytXM2NP/C0L3bi4Eyl1Un6NfqPYTZKxZxIOyljR
         4o/13OOcrvg6lFLbIkVy8/ti59BdbT/UOu1pfh1iwS6OBmCsWH+1L2u2hAVKXyPPbpkJ
         KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQrtkRGGXCGLvTRxdTZLyyBV0NHkVCxaDkOQfjaMrKU=;
        b=HZGcCuJjxyTITa7z794mH9LYQQbuRYtRAoD8UAS/svAQuXoy/LXl9QrHpf4lCD1Yt5
         Dok4+mnFSwtK4gk8aa9VyVlRX7eiuikwvPB2Ia5/+AzqVLoZwbEcEqkoTLObLfYhAAxf
         13k3IHmnG9Vwilo4RiBAUaxF8Cfb8rhYlaacpb/7O3vyqizsauJoItxQs96a1Ii6j/UO
         Tv8TyGDncNYwmRpe+E1lGqDjTGGBxxjGHLt1TNpDuBoSsR2//gf9/r1PMeiA/jG2far8
         n5egJ3ur9m4/BVuFnpunRChJqT5a0NcyCSdWlrnnraXG6ZZ1V7lV3d4cbJtScB1uFtjY
         c13g==
X-Gm-Message-State: ACrzQf3DZcvOw+qF6Sp2jnlk2tczkrpdidi1ZTUIwrW9SqZhyYFnWdPz
        +IDzFgZ/Jpq5ofpxmBRcjTE=
X-Google-Smtp-Source: AMsMyM6/FN5j8zFZMP/I39WdWY2sIbGRRPD1qDN/1tLYNJI3DCKy081NCULF1Vxspwp0XArDpw6o/A==
X-Received: by 2002:aa7:9d11:0:b0:563:9272:b659 with SMTP id k17-20020aa79d11000000b005639272b659mr4527074pfp.86.1665458455800;
        Mon, 10 Oct 2022 20:20:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z10-20020a630a4a000000b004388ba7e5a9sm7074184pgk.49.2022.10.10.20.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:20:55 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     gregory.clement@bootlin.com
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] soc: Use generic_handle_domain_irq()
Date:   Tue, 11 Oct 2022 03:20:50 +0000
Message-Id: <20221011032050.322951-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace generic_handle_irq(irq_find_mapping()) with
generic_handle_domain_irq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/soc/dove/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..308fe45231b4 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -243,7 +243,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
 		stat &= ~(1 << hwirq);
 		done &= ~(1 << hwirq);
 
-		generic_handle_irq(irq_find_mapping(domain, hwirq));
+		generic_handle_domain_irq(domain, hwirq);
 	}
 
 	/*
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB36C1B82
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCTQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjCTQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14EB3028F;
        Mon, 20 Mar 2023 09:18:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m2so10921773wrh.6;
        Mon, 20 Mar 2023 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXC/yjTPDlVhjBbsdYnEMpB7eHy01JgObPJIfHt5/h8=;
        b=e7ldG14HRq1mrqWtcSBM3TWQpbgKYZRCVeFNOCMKVJGvZC6/bF3vYWBuZYIhhC//Zb
         e3BmGMY2KjY273oe+QFr99GBxFj3ExO4hYveo2t9OLZnBJEsTAsUH5trdHbD4Ql46NFf
         Je3iSamDMxW2cFELy88Jv4keITOnkNB/+KEAWZQwEwmvmdHSoLTLJoi4Onjk3pvg54P+
         KIr9/rZy/dKC1VDwiQpoXFBxPv/y6GAIbGdc9lHeVPOKanZebrkW2rYn6gwzYsy3FSrP
         m5J8GrORazJ6BxSKW9DEDfcS+LHGbX5v3jgPSXburjv3TRjX/RYA+gIYwLOWnQMBZdnL
         /KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXC/yjTPDlVhjBbsdYnEMpB7eHy01JgObPJIfHt5/h8=;
        b=y7yh1ZVnSUDxczZgjhkydMngUrx890MG5YnKxoD7aANEb88tNkIcxydfGpguSpCm8k
         9g5C4gpLTDUTvg9XFmWi/GDKc+0EyvGXHOb4xTS8iT4Yj6Z/J0U8UcwmqM+hu6NLUxiL
         Tl0gl2rFua0wj3k/nI4Y+VI619ZeaIgg2snmsp6e9bzKS8CgLSVWkuQdn5ozU/YtpeqG
         oWDC/7U2g8tmWIhDfeP9VsNAJCTPaLqO+yIOBungQ8D0niDVuPZEavM88B3cdjuVnZpV
         wlKgGlV3f2XpG2MQ8uQe4iWVpa/3Rd/k2PfbsL2blgdfN1W87IhZy809BzIyO1G2EE0t
         ovqA==
X-Gm-Message-State: AO0yUKWJEJCca5f/YJ7nQF5pRkBnpMfiK7fZ8bxCwRWhQrg0kcOM97hF
        i1P1vX5mIH/SxLt4uOz5s/qO2Vq1dHM=
X-Google-Smtp-Source: AK7set+4B6d6/lWeZEd7y66o/0/7t3BNaO95e51hFkikAcU7ZJYn5VELiSQwMKuqoCXi54Kk2cwDFA==
X-Received: by 2002:adf:efd0:0:b0:2cf:ed7c:29c with SMTP id i16-20020adfefd0000000b002cfed7c029cmr16406026wrp.62.1679329118045;
        Mon, 20 Mar 2023 09:18:38 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:37 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 07/10] mips: ralink: remove clock related function prototypes
Date:   Mon, 20 Mar 2023 17:18:20 +0100
Message-Id: <20230320161823.1424278-8-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
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

Clock related code has been removed from 'arch/mips/ralink' folder and put
into drivers space. Hence remove clock related prototypes which are not
used anymore.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/common.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 87fc16751281..fcdfc9dc6210 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
 
 extern void ralink_of_remap(void);
 
-extern void ralink_clk_init(void);
-extern void ralink_clk_add(const char *dev, unsigned long rate);
-
 extern void ralink_rst_init(void);
 
 extern void __init prom_soc_init(struct ralink_soc_info *soc_info);
-- 
2.25.1


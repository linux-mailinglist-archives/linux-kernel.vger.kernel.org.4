Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AACF613423
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJaLCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJaLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:02:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210C65CA;
        Mon, 31 Oct 2022 04:02:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f5so6881918ejc.5;
        Mon, 31 Oct 2022 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLN72+StQcXpBZAAYYy6O1rIIRIfs1ZDX9QoMt7mJWE=;
        b=FOAVv7XaUC/Jy5pqBIxcF4BD2OcfNj+Six3RyYWyxWdooM0K+tT0cactwzkzGq9ZG1
         luMTY1OgqPJdTwFqHV1kVm0ndt08/kCy1hJYVKChADFzzfglXP7zqRohvqrrx6k/8Ddg
         M0bk77MPhsbhN0GDEn8NeOunANCBcI9QkiXMKttWc9AhmGx5bedPHIQVcsgEvslaarYf
         H9zuvTOFMsODzbUBfywB+CTtcoAr7OExOXJ6fphiqPsn8dd3MaXXKGMBL507Wl/s+u5+
         kbhY9fj2O01Ui4LQ9wN2TWvf9TxbPfySc/zdv6Kalc3axn1+g2cWgOKhxaJqADwc9wyV
         0/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLN72+StQcXpBZAAYYy6O1rIIRIfs1ZDX9QoMt7mJWE=;
        b=D4awagEXMGkumMXtGt9VQ70tl2+jHN5NXqLprPKzSS/ln/hRaqwIpoQqVvec4cTYEj
         6HoyXHj/1KwaWNqzw1PmODzYY6qpw/1ithymD44oou2KxyEY6BNKrjyHt2QyIX83MEti
         tV+bmxS6td5SYdlg58xU0qs52GsyyBmslp6bxoPVqY8vtlAK0sjxJagKRa+OgzBCC2ee
         Xqluu+mZI06OefLXbEghDLPKGDICyYejKZ1PNZeVoj7NYdZwRH2b18qIXkivoaFqKS3c
         fcW4DqrXDvLZE2rybRQXLVWtaCC62tyvbVdlG68ZAJG9xCn6yaOUrf2wfxnXyOCcGag8
         XisA==
X-Gm-Message-State: ACrzQf0Ae1jVXjhhTqpB9t7cKbpzwKpQBT/EXSSz8dPhdsqY6LUfRLly
        WUGKO5BkUnU0anvNgDQSWKRFyPoQIXg=
X-Google-Smtp-Source: AMsMyM6bo2G+XlPIE/zC7X+zKDGq7zmtTTIDAasAsYz2KnCi4Oq1fgtwNACUlNdBStWBM8Z1ZapP6Q==
X-Received: by 2002:a17:907:9713:b0:78d:8e23:892c with SMTP id jg19-20020a170907971300b0078d8e23892cmr12437365ejc.449.1667214162776;
        Mon, 31 Oct 2022 04:02:42 -0700 (PDT)
Received: from felia.fritz.box (200116b826c494005d8b6b3bdc900ff8.dip.versatel-1u1.de. [2001:16b8:26c4:9400:5d8b:6b3b:dc90:ff8])
        by smtp.gmail.com with ESMTPSA id by6-20020a170906a2c600b0078907275a44sm2820015ejb.42.2022.10.31.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 04:02:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust ARM PRIMECELL PL35X SMC DRIVER after dt-binding renaming
Date:   Mon, 31 Oct 2022 12:02:23 +0100
Message-Id: <20221031110223.30203-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit de67fa80c669 ("dt-bindings: memory-controllers: arm,pl353-smc:
Extend to support 'arm,pl354' SMC") renames the arm,pl353-smc.yaml
memory-controller dt-binding, but misses to adjust its reference in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file entry in ARM PRIMECELL PL35X SMC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Krzysztof, please pick this patch on top of the commit above. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31b8c902b37a..205533d70dc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1692,7 +1692,7 @@ M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
 F:	drivers/memory/pl353-smc.c
 
 ARM PRIMECELL CLCD PL110 DRIVER
-- 
2.17.1


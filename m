Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9935C6B5B18
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCKLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCKLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:20:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA813E537
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g10so1878773eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1ep3IE3PEf+V+OZrFXRxt1O3+yONVLmI0s6NjZUlFQ=;
        b=rcBRanYBYO5g+ZPGYI4T03o5Nz0rKcOQIOmdHuU29YA/VsUMU8qjdiYlBwvyEZki2D
         VPzYmHnRMMUj0ttao2Cvz4zxr7dMmUDjDd5/SusHNrQCcmJKLtRtcYj2K6vZunc6FYAY
         ZQZb91Vdz+RWXQVA9LpaLjhsSo4wSMykftDYMbltvgo1/Qc6ve6XVzxcPnWgDVNI4nDI
         /Fpat5GSklfub9SP1WzZeau1AyV8isjpNzRYK2ti9SBO1DBxwWpq06HdwhsGVVPffMUU
         UrzBa+qWWIcDPzhz5mbXKVAivzAyoYe6rBxxJju9VglVm1fknEQJHMSNoOiVzgn9rPM0
         o0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1ep3IE3PEf+V+OZrFXRxt1O3+yONVLmI0s6NjZUlFQ=;
        b=P7/wzANU9F3lmhr0a1UH0QBrwFdfOpqMb2qz3elp+pXkdofey6nJHL3l/QS0iFpf9H
         IBZYttmAjS3UgAK062ZTMsB9uiUsysUjlmRmKo/6srsYUlJ/AjSOH2jaBKv/PAOGgolT
         RT978Dwzt1vphQECNoZgrHmm/QYKyk6hu4EnxvmhVPWVUBJN5Z7eJqZ9STKNblgJdoIH
         Tv/n+4AxorBTMz+IEU07MnilWs5g9u8nPzzasZVVUvwoynZ5N+3m5YF0/Scy3ukc/lQC
         VVe23sO4PPJTyzbK4Z/n1TCcw/gYEzmUX9bZnEvDneuWb9JamdSw9tQfVtvXXHnS9WNb
         XTKg==
X-Gm-Message-State: AO0yUKXcux/KX0myyGU7Z+PFYhb8pOTEm9kdGQdyOs+B6ka3DLUJ7nI5
        h8jHBnJvrbD5keGFCztmTUlYSW3iDL/JnMBUbMw=
X-Google-Smtp-Source: AK7set/jS7PpALh4febSJl8zLhGg6wVyLUUjI10zB53ChUlpdcTmeu61y15+R/E1f45fjcVkWJwCVA==
X-Received: by 2002:a17:906:434c:b0:908:6a98:5b48 with SMTP id z12-20020a170906434c00b009086a985b48mr27795110ejm.40.1678533461068;
        Sat, 11 Mar 2023 03:17:41 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w5-20020a170906b18500b0090953b9da51sm971529ejy.194.2023.03.11.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:17:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] mailbox: rockchip: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:17:38 +0100
Message-Id: <20230311111739.252080-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/mailbox/rockchip-mailbox.c:158:34: error: ‘rockchip_mbox_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/rockchip-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index e02d3c9e3693..5a4934d39ad6 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -248,7 +248,7 @@ static struct platform_driver rockchip_mbox_driver = {
 	.probe	= rockchip_mbox_probe,
 	.driver = {
 		.name = "rockchip-mailbox",
-		.of_match_table = of_match_ptr(rockchip_mbox_of_match),
+		.of_match_table = rockchip_mbox_of_match,
 	},
 };
 
-- 
2.34.1


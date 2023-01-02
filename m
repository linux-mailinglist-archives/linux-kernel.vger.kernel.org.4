Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6155C65AF10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjABJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjABJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801210D8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:47:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so29113872pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBwV2mkPeuz+bYwsA3f6iWrfsv26cm3nPyYFJXVroCI=;
        b=L1GQsIa5xrmYZGgAyxeLqivX7wIoYwpsiTB1C5osf6lUMQcy4xMYrCh5bGHv23iMUH
         aYwJG9jkt3q3I/E9VTmUKmhjhcAOFwmjBu8KI8OAs8299HFjYj22ZZoV4GNm2FkfmqY0
         eoCEB+pHOmT94kiaEoh6ga7TVlFzcWbSw+VSWFTqh+48i5TG5btjUSmi4KJnQGDImt29
         K69yGGsiL2sgyDcwrIO+ifiX42lfgdUmp8xZdUbNACvUWoB66M9WeJibunHS792JBWaV
         gux2K/UsBvaU7s/8ocP84EvfOO8RPG5OLAaUk6+l9NhVWHCgZ0tibJKPnkEdD0ZCiGmA
         dkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBwV2mkPeuz+bYwsA3f6iWrfsv26cm3nPyYFJXVroCI=;
        b=fGCMfcFlXDx4Y2s0wqvT6QWfk5LJyx/anGXezwNGP+UeolujRp1jO+y5XTOYmtSrro
         oWCmqIO9ahRzHMZ2ABz6nrBshzcz1zGqf87m4L7NOdjXHscSH9xMZw+fyR7v00POPneo
         3/WbAy1JOxvnqCUOrglIEIllJrVHE3aGcslSj4L6KY6f/lJHh+LNBfom8aMIcnKoS4ce
         ASb3g1uSwlahdwkqo/gOy3f92dcRiCjxcn3NWWVIG2D0SvkmY6HXaDAePBvHrhwyl6qG
         lX+0ykEllV2i1tsx02nM26orfLXv4r6EkNT7245TxtpHY0j+JMuwxIKglsgzU723aETW
         n4DA==
X-Gm-Message-State: AFqh2kr3gTO0rHlOCReo6h9CRm5jh3KntKQJ5styaFml5UofYjfMJFZF
        6wzKauzlog8qVQppr0LQRfiWuoY50VF9vsHE
X-Google-Smtp-Source: AMrXdXsyEajZruJ4/pBKSEHe8oH3jDHrxGO82t2KcRi3PuYbBkr7kDSxVYwEXn4mctn/u8h8fQzyrA==
X-Received: by 2002:a05:6a20:3b0f:b0:af:e129:cb7 with SMTP id c15-20020a056a203b0f00b000afe1290cb7mr44296616pzh.52.1672652861448;
        Mon, 02 Jan 2023 01:47:41 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id t66-20020a635f45000000b0046feb2754e5sm16607991pgb.28.2023.01.02.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:47:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: ux500: Fix refcount leak in ux500_pm_domains_init
Date:   Mon,  2 Jan 2023 13:47:33 +0400
Message-Id: <20230102094733.3966825-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() in the error path to avoid refcount leak.

Fixes: cd931dcfda5e ("ARM: ux500: Initial support for PM domains")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-ux500/pm_domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 427b9ac4af6c..01cae91854ca 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -65,8 +65,10 @@ int __init ux500_pm_domains_init(void)
 		return -ENODEV;
 
 	genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
-	if (!genpd_data)
+	if (!genpd_data) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	genpd_data->domains = ux500_pm_domains;
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8D733109
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbjFPMUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjFPMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:20:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095710EC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:20:44 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB0043F120
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686918042;
        bh=cVfb5EujAP+BjjN+ylN+9xCg5MYHg4RgqoLucWwVyAo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rwiOKoW5DkiZdjhFuVVpJk9sSqd+VYu2W7TwvvJJAWnVTPuiGYUomsyw/OARu9hjz
         y9HiyZMDUdU53EevL+IxHMkk50ZSnE3jgSgOl1NNOoY3BB0rIRBC+85wggHGeyvSJ8
         2C3HoifCyfHHhcmyYOq68yWXkteSg92OrB4OA3SAqiYZdk6P+5gfFXijTvdWOeyOxz
         7Ru005+FwVWMS6NBD2zNO1ToHPyZIW6raxnlAUzyIMF9a2LluRua5sat5uyrvooDRZ
         YUyXf0c2GzglRhmLSWgxsSGliIhuDe0go5zf6hFWM9VrU7qymK0zhOgDO3R6UipCIB
         wSgXxSSG6fPrg==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f8fa2ef407so1494245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918042; x=1689510042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVfb5EujAP+BjjN+ylN+9xCg5MYHg4RgqoLucWwVyAo=;
        b=LZEfbpG1EKK2tKmDzTjYulN2sEoFhQrOjjvSVoPZlqZzNAcnJoniR+CjD3JY+eXQVx
         6qkUeWltNQPfVXEWEojsK75iMA0AoAt6IoUDl3OX9y/TnZvfeWjPI03tCqbvVomWPJsu
         SyOEjgzt+mZThrJtj3Rhh/qFQQtLCjjKDGwejt0NaaSiGGXXTED1YqkuxTSpAqYNlwv2
         sANpOUEhQJlRAi2amYlU+W1YOlqENRoqEBjw22gsXTQnkDXemo9HGLwZv2fK1iBjaeYC
         BVTFUm193zirBi9M6T75JBZMt0vbPQsVrMu6cKhPmta46S3hLniei59aWxF0GYN9Ns45
         Z1yA==
X-Gm-Message-State: AC+VfDzCqwcs6LDNtPTtD3h3vvcJhRv1a0yfYAqW/xJ+MlwcqnZPm6xB
        JiOa2wmlzd8lomRP7YTifSvmpXqMutR703E6x7v1+hFziZbkIBUEZhYLE7L4XaJpYLdmCLtGxit
        FKCFyEc3B14jD4kaRZnM3cUuXOfiqsu0A21eEeHM1Jg==
X-Received: by 2002:adf:f30f:0:b0:309:3a1e:fc54 with SMTP id i15-20020adff30f000000b003093a1efc54mr986689wro.7.1686918042718;
        Fri, 16 Jun 2023 05:20:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HdxyDt9V5cfYgPWH8dnoyCBK86f7dvoh3wA3NjOpbz5PmAnzF31ff1YPXKKaFf4K5YerOkw==
X-Received: by 2002:adf:f30f:0:b0:309:3a1e:fc54 with SMTP id i15-20020adff30f000000b003093a1efc54mr986682wro.7.1686918042460;
        Fri, 16 Jun 2023 05:20:42 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i1-20020adfefc1000000b0030647449730sm23807695wrp.74.2023.06.16.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:20:42 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:20:40 +0200
Message-Id: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 5f608ef8b53c..1316bfd121fe 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1441,3 +1441,5 @@ static struct platform_driver fsi_master_acf = {
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FW_FILE_NAME);
-- 
2.37.2


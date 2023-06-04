Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220F172159C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFDIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFDIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:32:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E63DA;
        Sun,  4 Jun 2023 01:32:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso4792675e9.0;
        Sun, 04 Jun 2023 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685867564; x=1688459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoNSr+a8hKeak/jlvIJQdpZkUkH6J7s10yAW9PEDstY=;
        b=pNj3Oyg+/a18FAg4qCfrZlPrEdtNVXSOpymnHw+UFQB5bgOKFCv/+OCZA92njKoeF6
         +96kOqySqt6TrFNnIgeXgo5N/bcZf+dnoZNu2E4qbTJFp/iJUXK/hVd1d0Pk6eIIXYxS
         KFBtC3EMnY8eTOgtau+cvFnr+Qwt/YtXNrv0NmoAONZh52YCr4kIoOKQVhXFYeZYzl1N
         fL1sQZu+nn/zpeh7mN7VzUYxCs4w6krjc1xxC/HvISxOPDu07ShsBhHC+Jcp08WeYXzk
         qTA+6yGqnm/6ARoYGMlyR8ClohjVk64R6dkh1CekouBdneJmNgb9th4kbzW7qHWIylKu
         cJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685867564; x=1688459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoNSr+a8hKeak/jlvIJQdpZkUkH6J7s10yAW9PEDstY=;
        b=e/VH/UonSiCiVfXEKf44VoRcnnD93hkLixr0YMDEp619/Ph02ZjnLX6KRNoT7u4BsJ
         +F5Z3ktDjFRGaPDcj9c5rkpZXzy5YdaapjcC85QmHzJWbmpOvPiogXBn1llTwDv5rDVV
         hCyMIlpsXolk0FqdVnZSuM6ql1HgUElaKMNtIDiz+d6YlKy7+syEl6RA3ravrIhXyghh
         t3CJUCAy/xSAituf3Rn03qkdExFpZr1zU95kJxBZfGU8AvIALbIyxvsvWJ8UeLD8ennN
         MSgWx1DicQzK+EMtZaMAqd3yXT5xkCOp0EPowJQde+TJk6uDcELMN4J54tfgJ31yd8Qf
         DExw==
X-Gm-Message-State: AC+VfDzef6eEUKF3ek/6o7+VlGVqq0BvtGNUicH3qzqQEhQWIh7PMv2R
        yjSIxIs+UicMQpSPX/0fAvE=
X-Google-Smtp-Source: ACHHUZ7hlAQTqglbbeUTEkcdqQMatfDQIzDzIU2717+u3LLOMIUrwME1wrk1VRzF4edNoByT7MCRzw==
X-Received: by 2002:a05:600c:c0c:b0:3f6:11e2:b971 with SMTP id fm12-20020a05600c0c0c00b003f611e2b971mr5155835wmb.20.1685867563427;
        Sun, 04 Jun 2023 01:32:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003f60d0eef36sm10762188wmi.48.2023.06.04.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 01:32:42 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: st-asc: fix typo in property name
Date:   Sun,  4 Jun 2023 10:35:58 +0200
Message-Id: <20230604083558.16661-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the property name read in the driver according to the YAML.
According to device-tree documentation, property names should not
include underscores.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 5215e6910f68..6ef99a037a9b 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -754,7 +754,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 
 	asc_ports[id].hw_flow_control = of_property_read_bool(np,
 							"uart-has-rtscts");
-	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
+	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force-m1");
 	asc_ports[id].port.line = id;
 	asc_ports[id].rts = NULL;
 
-- 
2.40.1


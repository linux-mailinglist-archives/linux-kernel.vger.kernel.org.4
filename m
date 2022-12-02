Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0C6410B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiLBWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiLBWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608AEBCB2;
        Fri,  2 Dec 2022 14:33:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b2so14647118eja.7;
        Fri, 02 Dec 2022 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQeLaykTQhLHe0LY2chW9NXtLPDLXYYg3zfnSmdV2ko=;
        b=O61y9WQ0DLbLKnd/RASQLvTLxHIYdc9PRDkhd1Wc7w8o4N3S9Z+7SS1+lSeh4zCXY+
         PySt5j/g49kBZeOmBGFJ9KaJROd4z5SCVYNIzv5HUeqfVlhjy0P7PCtXRJtp8uIvK9bn
         JhNnfvU23O9/Z+isN5sDxEoA6PAHnbLXhudmM/o4Z5xjqHrB7rtiMt6hAvQTxKZxnAk5
         KRN/HQVwmhXcjpy4G4Ei735Vis9bq8XcK14otmfrMqUmPLnbJCmnLBZ9G+x/npQzsfzc
         f6bq4gspDnBwNbYdQDbDeBZh0agYEEvz5V7DW4sl0dqxwQCmcQgyXVTxt677Ch0nsCjr
         xcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQeLaykTQhLHe0LY2chW9NXtLPDLXYYg3zfnSmdV2ko=;
        b=wzmlC+ElPU5R972zeHMS9pE7llqP40tt6nCY7hXOmrdNM8ccesxzLjf3P+2HFVarJT
         VdbZ7wMx5N24s2lIa9ctPfdpBvEanOXTlGKvcGOR2vP5DDBmRsz9d+1tNnEuWqJw+769
         sK/iSwlRHdfB86KcIUU14tgZ0xY66Nvb8ygKlAHCbWr43DIKZ/WQvPAI7gnkUhOMyIOm
         yJvsbvSt0XqFC5xPIF13rW4/JNgKHzlUJ85J5a4Pp91nueTqkz9J+OJk2WJxf3i/M+gP
         hF/ufPh3NTMYWFdjt7X9esuGTQ+kirZ0I+YEAttwVG4It82UNkGJ7Q3/JvnBmJeZCEVc
         x4xQ==
X-Gm-Message-State: ANoB5pm+K+DZ8EjqjNA4BvBfLQdBJgCpwfkmwKJJgFvPCO2XFSYisXuu
        gasjpCHM4z1JVntwcHnI1NQ=
X-Google-Smtp-Source: AA0mqf5zoKNQjUHfweNQkwEXjXGp5n4LGq7hBQmLK4KbhpC1xCY+e2vszUCEjCw2Pf17KJEuJ02ILw==
X-Received: by 2002:a17:906:5dcd:b0:7bf:707a:7247 with SMTP id p13-20020a1709065dcd00b007bf707a7247mr22734535ejv.196.1670020425570;
        Fri, 02 Dec 2022 14:33:45 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:45 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] HID: surface-hid: Use target-ID enum instead of hard-coding values
Date:   Fri,  2 Dec 2022 23:33:25 +0100
Message-Id: <20221202223327.690880-8-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
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

Instead of hard-coding the target ID, use the respective enum
ssam_ssh_tid value.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/hid/surface-hid/surface_kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/surface-hid/surface_kbd.c b/drivers/hid/surface-hid/surface_kbd.c
index 0635341bc517..42933bf3e925 100644
--- a/drivers/hid/surface-hid/surface_kbd.c
+++ b/drivers/hid/surface-hid/surface_kbd.c
@@ -250,7 +250,7 @@ static int surface_kbd_probe(struct platform_device *pdev)
 
 	shid->uid.domain = SSAM_DOMAIN_SERIALHUB;
 	shid->uid.category = SSAM_SSH_TC_KBD;
-	shid->uid.target = 2;
+	shid->uid.target = SSAM_SSH_TID_KIP;
 	shid->uid.instance = 0;
 	shid->uid.function = 0;
 
-- 
2.38.1


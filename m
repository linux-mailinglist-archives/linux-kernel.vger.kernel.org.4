Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72965B3794
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIIMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiIIMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5978587
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:18:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r17so3514166ejy.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NM+lxSqjM8oFCbQnG31XvkQ4+xfR81iJOrwKlVfJyok=;
        b=WejafAQQbqcpEnzAtu/PpyOP7fmVQf6gG2x6M2S5Vm7Rg8NWLbgGQ5RpkHCQxTHi/m
         XW85pwdMq8KL2wN2kXynuASuLaPlphzRYSmBlEdwBWZAov0sqMhSiBdBINGTWmKVf5oE
         jQzPXuSJQSkar5SSa5QB2I7o7WFWWJyHyux6NKGKvXGK0YPK6ADoyS5ryOqX9jPuEuzt
         //RIfavaV7baPOK3aYiVw9O+s9Y8p4Lv14IXpOaj42BzbEWvIirNnXoXsyKUBGbViCda
         5s4S9JcGF5Yi4+r8xuBgOKgnuL5LLHpqGPigWXv/5o7quVKeWIHdmqtJTDaiuscpaBTD
         bfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NM+lxSqjM8oFCbQnG31XvkQ4+xfR81iJOrwKlVfJyok=;
        b=tKfU9+myTT7hHVyFrqpVgjx4b6+MfSqp7JdW0o/SjV6xWKzeKBQpY3I0gffb3Dxhes
         IF8M86hXsuJWBPZD8Y6OG+vWKlyWyP35GO5gxyt5cmZpawUUjq9Mgp2vP3lVjZx/dWgQ
         5y7yo/vmVjPxDm85g7X+cRcJkZZoJEzdUfgr4zBF2oS4vZVZUIpjBj1jLTRp5WTVxbBp
         IZYAUeVwHDBK9loJJ8e2xJ/Zq0htafIPwe8Fdkiqu1jbcoa7H5dv8g151HenumpYYBbR
         7ZsOz3FJiMBNhiE0z3RjvxAwNbGi1F3k3jRggHgLHHD0KTPlUK13fa12anV4Ei6M/A9n
         Jzmw==
X-Gm-Message-State: ACgBeo2VlzCb8z5WO+nkAjCczur7X0gnC/+OKcvy/LBfti37plucOyFZ
        BvXsfYZDaRcU/cuQVwqOIOk=
X-Google-Smtp-Source: AA6agR4AHMKVaBWkWEN5wVUo9hiOeUinsMUur891/drAYP2F99sCJd9oJx2G+nFVAs+Re4srAIay6g==
X-Received: by 2002:a17:907:6e8a:b0:779:9e32:8dff with SMTP id sh10-20020a1709076e8a00b007799e328dffmr2532629ejc.20.1662725913877;
        Fri, 09 Sep 2022 05:18:33 -0700 (PDT)
Received: from localhost.localdomain (wlan-244090.nbw.tue.nl. [131.155.244.90])
        by smtp.gmail.com with ESMTPSA id p17-20020a170906785100b0073bdb2f6f28sm167143ejm.217.2022.09.09.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:18:33 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 1/2] staging: vt6655: remove unnecessary volatile qualifier
Date:   Fri,  9 Sep 2022 14:17:55 +0200
Message-Id: <c3a7d9963b1c38c5f493786d7268c430617412dd.1662724786.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662724786.git.namcaov@gmail.com>
References: <cover.1662724786.git.namcaov@gmail.com>
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

Remove volatile qualifier for the member rd0 of struct vnt_rx_desc,
because there is no reason it must be volatile.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
index 17a40c53b8ff..3f0f287b1693 100644
--- a/drivers/staging/vt6655/desc.h
+++ b/drivers/staging/vt6655/desc.h
@@ -182,7 +182,7 @@ struct vnt_rdes1 {
 
 /* Rx descriptor*/
 struct vnt_rx_desc {
-	volatile struct vnt_rdes0 rd0;
+	struct vnt_rdes0 rd0;
 	volatile struct vnt_rdes1 rd1;
 	volatile __le32 buff_addr;
 	volatile __le32 next_desc;
-- 
2.25.1


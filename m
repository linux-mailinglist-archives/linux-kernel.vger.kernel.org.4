Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3E5FC370
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJLKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJLKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:05:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE337F9C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:05:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l1so15762674pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcWP8G1hp5qNg/Pxxjv4XCndAjHqNWMsARLGYF5eowo=;
        b=GIxoCY8WsX5MRW7J0e5Y/xbLNipkLoixAqGj/bF5QEH1LhnD7SsVSZGmieJilVhvQ/
         vrEmfj9tNVYJnyLch2YaiVp1OnOCfw8CoHlx9KTVGWp5CF5mtpzxufJ0AgQ1U4ykPy9d
         Knt+nCN/krFaeHIvtFwq1agjhrqXUfBCAT3/k/fx77Z3CRmn27GBDIjjj3YlaIb1ewok
         3zW94ICe+UQv7CppaioxcWoXs8eD9zaozoGUiswMApHl1Jv/Nzmajr+5L9urjWtTbMhg
         yMOZOtw7BV324J/xJhJonZRSyFQ0R0GKFz3MiQp4yh4Xp64Pi6NSU02/ugXKD9i6+p3b
         ejjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcWP8G1hp5qNg/Pxxjv4XCndAjHqNWMsARLGYF5eowo=;
        b=bqXHpyuYgZ4L+YUIJu5i5xKKnBGUovZ/1huoftVMHPj2pzFAZZEMtxX/y4yViQA+Jj
         /Fkttw0dwVdtUiAodGHpnYRSsYVumU5Mrn8KBgpzPEZLzQIqNesEkHbMjwG9yn0xsZh3
         FX50Iz9hAS0kIkiZHD8MHGFjgZytrDRNJB4ukhVUqjj5QjHYvGbBa0H6YaLl9A0YCqsD
         45tErS9BROJdkJA7hFKJe7CoPHZCp+EGllL7F+tZ1uFlJpAhRU8/I2l8TuyL8o7pJhy+
         r56C9sE/5itbMdfg/aruIdCPbOuopRbO49fvsG64iccl3IGclaCvjbZSuXyHuZFaAXNe
         KDSg==
X-Gm-Message-State: ACrzQf30HT8H4A3TNZ4ui4L9qxiuAIC+cyEY6LEbq0PcFb8YRWo3JbHB
        e7ve6XFOA9bi4u6Jnp7YGZyI1fkvmiQhtg==
X-Google-Smtp-Source: AMsMyM5vI8wLgbEuwVuYWslGq7b2URRB6gJYKUAfgG5X9iUJLkqyLaSWyBgMenav0sCg66NyHio/JA==
X-Received: by 2002:a17:903:22c8:b0:17f:7039:a2d4 with SMTP id y8-20020a17090322c800b0017f7039a2d4mr29496694plg.2.1665569116022;
        Wed, 12 Oct 2022 03:05:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0017f93a4e330sm3794529pln.193.2022.10.12.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:05:15 -0700 (PDT)
From:   xu.panda668@gmail.com
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] speakup: fix comparing pointer to 0
Date:   Wed, 12 Oct 2022 10:04:55 +0000
Message-Id: <20221012100454.347873-1-xu.panda668@gmail.com>
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

From: Xu Panda <xu.panda@zte.com.cn>

Comparing pointer to NULL is more appropriate, and we usually compare int
to 0 and judge bool directly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac246..a1792f3734ad 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
        else
                snprintf(filename, sizeof(filename), "%s", name);
        infile = fopen(filename, "r");
-       if (infile == 0) {
+       if (infile == NULL) {
                fprintf(stderr, "can't open %s\n", filename);
                exit(1);
        }
-- 
2.15.2

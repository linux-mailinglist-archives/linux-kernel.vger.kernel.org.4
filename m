Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6570DA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjEWKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjEWKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:11:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC68FA;
        Tue, 23 May 2023 03:11:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso4312796b3a.1;
        Tue, 23 May 2023 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684836713; x=1687428713;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V0+JklnF1lWXjvUjPvFkcBWWlpsSIsbiSMg8/2mg6A=;
        b=GlYRDboB16FDlCCecPxdOx38fiL/gc5F1eWHSgOIjfTfmK00Myl6/EIbVlOuJ/0Xik
         IuwyxY2yzaaEBQclOCFYlQgkWGGTu+r4De1fSLmnPwldiUeBkwaoV9+2Pwq0BiwNMPyD
         bFf90agTIg6f/uyvaKvMSYfoEmihlvnrGUEkLf3qOSeig6QhkQ7WGuvrDKXFQqq6M2q+
         I5Q49oXY1qDsEt6dwBdzxh7vT3YNzar/XPJjN5rxJqJsiyvoBl5ew966UsRtl8QCwQGO
         e0xFcKvPnWwUC8HrKkOPMxTrCbebvcu1NxIZOozYXr++6V5ROT4rU2HeVVt3avE5mwSY
         IhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836713; x=1687428713;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V0+JklnF1lWXjvUjPvFkcBWWlpsSIsbiSMg8/2mg6A=;
        b=Lp+Tyb4p6adPUB/FJXLuxRhHU0Q+e5Ocerxbr/e0ZVBZihxfq1+H4d4WXfqhDR73Zi
         3WaLgsB9NucYqf0Xgli8RxkRCb6qN8bMER+0aAwYAXx4ActQcnUTRqqLwqgDAyu+gApH
         AVxkychbn72zKKww5/L6CoPZ9N8ChA2umNUwnAlrA5wqXiqRxhnilI/K9n6+nRy8xE9L
         zsqvWa0Y484YlF1qH+XMUqV4s9ZYuHRqpaXh6zZCUCmWHWBd7qGBkor79NH0doPAv/M0
         euWxnG7ikpUcIBIpU0BbOBBxKFdnNNYJJ+1mwOkPvZM/ue3pYxFEA9dpoVw5jYC5ZQun
         IWvQ==
X-Gm-Message-State: AC+VfDyO1NssQzYS9/oNf2t/ElN50+ELbFRNQClSWAApyFwBmvh8rwl9
        VbP0v6Sr0ffA7JJLuJrEDSo=
X-Google-Smtp-Source: ACHHUZ4Lg7ASLe/BKcmWvxwSpuXpjSY6tq9WhaheOolF52yCPMhSJcLrIWVakxBeWNHshQbsbjKnxA==
X-Received: by 2002:a05:6a00:150d:b0:64d:5c1d:353 with SMTP id q13-20020a056a00150d00b0064d5c1d0353mr11380714pfu.19.1684836713355;
        Tue, 23 May 2023 03:11:53 -0700 (PDT)
Received: from localhost.localdomain ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id v17-20020a63f851000000b0052c3f0ae381sm5795698pgj.78.2023.05.23.03.11.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2023 03:11:53 -0700 (PDT)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Wells Lu <wellslutw@gmail.com>
Subject: [PATCH] pinctrl:sunplus: Add check for kmalloc
Date:   Tue, 23 May 2023 18:11:28 +0800
Message-Id: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Smatch static checker warning:
potential null dereference 'configs'. (kmalloc returns null)

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
 drivers/pinctrl/sunplus/sppctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 6bbbab3a6..f2dcc68ee 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -883,6 +883,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				return -ENOMEM;
 			*configs = FIELD_GET(GENMASK(7, 0), dt_pin);
 			(*map)[i].data.configs.configs = configs;
 
@@ -896,6 +898,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				return -ENOMEM;
 			*configs = SPPCTL_IOP_CONFIGS;
 			(*map)[i].data.configs.configs = configs;
 
-- 
2.25.1


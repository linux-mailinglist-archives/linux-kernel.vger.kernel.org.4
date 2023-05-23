Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7970EACF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjEXBae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjEXBac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:30:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F02F130;
        Tue, 23 May 2023 18:30:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-253310a0df7so87802a91.1;
        Tue, 23 May 2023 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684891830; x=1687483830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1orZJfj9173C/tsIWjEiuAZodQHp/rpo+HkDtAUGe9c=;
        b=Wvg1be6m+luhUM/A/XmwRXRZImnIJo4V+5DbKCPLw9+VJlXba/ecE8yW1qwAX6+uMD
         LD5GvZf0i0iYuurDQcKZkO56SDlJe727FG+rHhGg7Les2v6glqWM+ttx6JLhiogd24LP
         atIXv8KzUVMQwPR7tCifnBz7PDjpucvYsTQNvyVDwxuz7vDYT/MCzy+RIH1GO7ckv9xa
         8EVoaX7vnWC6WAg1gUq0Xi3+BAbn8oVVu4j8kA7vaf8hVsoPYVnlx1dFi0h6sYKzhnyx
         ras+P4V56EASMdygabBXz5ScRbkAxJtjd52WDlgqhWdGJbklpwnGaEpjtB158D43Kz/P
         WtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684891830; x=1687483830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1orZJfj9173C/tsIWjEiuAZodQHp/rpo+HkDtAUGe9c=;
        b=KaAV5eT2hGhLrLZ10FtUIMIkW0wWG3RJmlCC9TKvCKPmdnvhQhD2JI9Q4wkXC46J6g
         THHRMMaxfajJSdlF0mbq1mqLas+MsB9K2/PmWFzvRR1Rd+QjvdFWKmo9URGPexGhSJXa
         zQV9ieqLtUccXr0prdeIME0G4gt+Q+KQHA4atCWLA/MLxMsUV6EuR2C7Q0hDW9VzmNIA
         lgXlp8f4l1sOta1Xhfk6jvbRdcDhDfvVH1jPLg6vSbK+OTYqzSHeQPKruREdIqgmnNLe
         vWMLH3/Xh1wMSh+qWJgXq5RkC88iTN9IY2NlNi06sjbRV/hLZv5wuGpnROPjjluzATyv
         NgiA==
X-Gm-Message-State: AC+VfDzK8p+G5Rpw/f4/fxBBtKYAH9C7PCV6E7oTHaC5iVbPt9ZSbwFj
        RI8wISCqZrkT9PW6n14oH3OC2UWyP4UK0SCWzxA=
X-Google-Smtp-Source: ACHHUZ4CJROofmRGutqg0VeBUFgLRZ/aIb/oFRjC1KicX8+fjgZp9YoyrEmdulX2Dd8Z7Eun+OI1cg==
X-Received: by 2002:a17:90b:1bc1:b0:252:b875:6a57 with SMTP id oa1-20020a17090b1bc100b00252b8756a57mr1058324pjb.3.1684891830336;
        Tue, 23 May 2023 18:30:30 -0700 (PDT)
Received: from ubuntu.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id d27-20020a630e1b000000b0052cbd854927sm6484727pgl.18.2023.05.23.18.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 18:30:29 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: fix use-after-free in hci_remove_ltk/hci_remove_irk
Date:   Tue, 23 May 2023 19:56:37 +0800
Message-Id: <20230523115637.14541-1-lm0963hack@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 0f7d9b31ce7a ("netfilter: nf_tables: fix use-after-free
in nft_set_catchall_destroy()"). We can not access k after kfree_rcu()
call.

Signed-off-by: Min Li <lm0963hack@gmail.com>
---
 net/bluetooth/hci_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a856b1051d35..0164b56de12d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1416,10 +1416,10 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -1435,9 +1435,9 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
-- 
2.34.1


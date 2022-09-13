Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D015B7D97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIMXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIMXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:37:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222D71BE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:37:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b11-20020a170902d50b00b0017828988079so6216371plg.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3R3kd3ajupj3cdm7/eN6SOKkue4SpZWOLdvBLhR9NOg=;
        b=PD40MUF8Fbm96f+EH4eN6upE2dgzH6/V5FZ6SzuMdGoEo4HvZK+fJbXAWO9ldkK2lx
         kzQSobzZo1PkoYHzVvsc4e9FM5Oe0qds/6+zWntw22zR4S8nBVNl0xisR46tkpiuNeF6
         Qwjo6rOvh+Hm3kJRwyJmG9pkUFK9aQpTB0G+Wk2x+pNyqN3M8l1Rt0e3yxRZOYGpsM+b
         zO+qdXeOuJ3TSuFJjZJlMoBRd21LP2UZQ8LZHym5g/lybtCFr/ReZhe7Fyg5JnOf8E2H
         flQYwuHYKHqFGoR/HQKD4DtAsfVNxH29HqEtp4ooAqIc4K59hP2YIhJfnoLW6OUbii1P
         tQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3R3kd3ajupj3cdm7/eN6SOKkue4SpZWOLdvBLhR9NOg=;
        b=bERweyy3LvdoABU6yMImebKB7bpxA050icm9gp6rV6t0gaSEctylKNmKgeZ+ZB7RlR
         vHEdlkrXrNF451jOV51FeCtoekgNFSYmjdUZnS43R04iFySPr6jvSb60fmNxfo32deS7
         9AwWcYSVBUYR26gZOOwVytLp4hqPAIr/ZLo//KlI5cacvT4mZd4bYRSyVXL7DnEfXjy/
         Xgg1sZDSgG/fPyQOaWQm9bTS1Gsw3FGQnmr7SU1dkmk6i+mLYffhCem438pXeaI/zoG+
         dC1PokALewJcJYp8xZdZoRKpjnXfBCd0fSIEaKiog8zTuH47xn99lTpWeF2IyzRI048D
         4UCg==
X-Gm-Message-State: ACgBeo15CM4tDM7r4js2feGw7DIwXHSUE7xPjqQ1ACISDymipJ7jz9eD
        +Ld5D39rEvf875kIrWwfXypAz4ofHs5Q
X-Google-Smtp-Source: AA6agR6Rx7aJ5ESWaikv/TsLescyNMcGIubGq9nFlHDf+hu7K3rAOvznwWK4PlXHlMg1lAROBMAWgzwevRQe
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:6943:b0:178:4751:a76b with SMTP id
 k3-20020a170902694300b001784751a76bmr5349334plt.37.1663112241844; Tue, 13 Sep
 2022 16:37:21 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:37:15 -0700
In-Reply-To: <20220913233715.3323089-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20220913233715.3323089-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913163710.kernel.v2.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
Subject: [kernel PATCH v2 1/1] Bluetooth: hci_sync: allow advertise when scan
 without RPA
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address resolution will be paused during active scan to allow any
advertising reports reach the host. If LL privacy is enabled,
advertising will rely on the controller to generate new RPA.

If host is not using RPA, there is no need to stop advertising during
active scan because there is no need to generate RPA in the controller.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v2:
- Modify title to reduce length within limit

Changes in v1:
- Check privacy flag when disable advertising

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41b6d19c70b06..422f7c6911d9f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5351,7 +5351,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	/* Pause advertising since active scanning disables address resolution
 	 * which advertising depend on in order to generate its RPAs.
 	 */
-	if (use_ll_privacy(hdev)) {
+	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 		err = hci_pause_advertising_sync(hdev);
 		if (err) {
 			bt_dev_err(hdev, "pause advertising failed: %d", err);
-- 
2.37.2.789.g6183377224-goog


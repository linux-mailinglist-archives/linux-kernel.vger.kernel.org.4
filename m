Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD7623C90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiKJHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiKJHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:25:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336313DF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:25:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f5so2769651ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 23:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLIL8AWyiTyOVTowKuWveBdp9wuFqtjsOK/tusdXEg0=;
        b=n82CKx2oKYstCeHq7b45Jmr9QQxnDG+iq5wWJniMgAw80ww+xmBuBKNOd5ieCew3Mp
         7fYQPRQAP4iLplsr50ZY0nwiXVOISgNlzGhne3cys2BqNtkr/oFxrZTj0CguA+sJxoY/
         NlMA5PH9GkZWSpPnqcj72ZWnANh42gNQoMtcoX7OBTET/keZfzi3kAMDAekHmDXksYNo
         AIlUgwLhJkD0Zw+jCWrj4RlTfnUX5tW3GdnY1vuxJXOV8J9pfEzU7mEwWImWzW4jeJR0
         Tl+dW9sc9s/V0wA3IDFhjXihBai9XqnjcjWM3JIUdRiscUMB25ftkFJoccbX8bfqwFpA
         7tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLIL8AWyiTyOVTowKuWveBdp9wuFqtjsOK/tusdXEg0=;
        b=Biri7yV2oVQ/tz9SoA9qIy5LY2we6oNAq/UEBEoaNc2C74YZFTWSpSFcJiaCb9nkws
         6D1T8vdi0wK0InaBMfLp5W+nTQP0fIU6SDb8/ZHOeOa55B/Muy/7smRW0bETxGvFnx4x
         NXgCKB/Gnd/W7oVVEQAPllF8UWBGtByx8BRk5phqZWkjqd/2X+dzLOe74F9rrT5OAG1r
         k3eOOvEK6uIqOGMfF/dG5JKRcIo/xzcXJzhKWcaNTEtkehjC7bPyu+lK6NDV4LblaDVY
         TvawyPfyzaEng3G1SFnp8yyVkzFSuWNRh4KLNjk1RDJi0+hWYfi6N9JHIJnRHmcLcdIz
         YKCw==
X-Gm-Message-State: ACrzQf2bHXRxZkKXffDLGICXpm58MXA6PvoOKkk2595+XgRWPAcP838R
        00pvM3x+ZU5oXkmhCqMrJSs=
X-Google-Smtp-Source: AMsMyM7n4yP3Bw53HMpXTM9vWrjegmze60e5skOOzJZ7DwsPiTBEf/ABWnqq9Dm+Tw0HdT61T2aAwQ==
X-Received: by 2002:a17:906:fad5:b0:7a0:7333:8f1e with SMTP id lu21-20020a170906fad500b007a073338f1emr2211344ejb.493.1668065110116;
        Wed, 09 Nov 2022 23:25:10 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ca26-20020a170906a3da00b0078b03d57fa7sm6731958ejb.34.2022.11.09.23.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Nov 2022 23:25:08 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH RFC] maple_tree: should get pivots boundary by type
Date:   Thu, 10 Nov 2022 07:24:59 +0000
Message-Id: <20221110072459.23656-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If my understanding is correct, we should get pivots boundary by type.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>

---
* kernel build looks good
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 73e2e6434e2f..2123d1930a9b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct maple_enode *mn,
 				 unsigned char piv)
 {
 	struct maple_node *node = mte_to_node(mn);
+	enum maple_type type = mte_node_type(mn);
 
-	if (piv >= mt_pivots[piv]) {
+	if (piv >= mt_pivots[type]) {
 		WARN_ON(1);
 		return 0;
 	}
-	switch (mte_node_type(mn)) {
+	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
 	case maple_range_64:
-- 
2.33.1


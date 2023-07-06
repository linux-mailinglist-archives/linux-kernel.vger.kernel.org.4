Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EDB749D76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGFNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGFNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016C1BD0;
        Thu,  6 Jul 2023 06:23:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99384a80af7so81182266b.2;
        Thu, 06 Jul 2023 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649834; x=1691241834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twwRuxY6wI3Kg6heMmcwREwGj5Jtv6WXh1HJopMuo9M=;
        b=QYgxRvyqawTzN1vInTvH1KRmelQcb+xZLwjKwmBxAzsui0bJ8PfX+UtyZCMTJ1WaVc
         ZNmRehBukvKqPo8ryX7uLW37wAINUM4JXjBGUgBbbhZSDOohBGZmTI+hmXGRd5oqy+Ii
         0EUXhwdOLy+KM6eRut1aG85YH54T5fXv+v1r1OxhI57hyiintFUfmObk8wvPFDL+xGbZ
         mO9W+lvh6edsDsjPZF7mZyLgnydEPsziQBugtWXe/Al2fGark+gwCE3Yn65JmLCZYOO8
         t0x226t2MkLVbNXEDhM3vPQTPL4cGv6JzwpajWv7kQaKGHKf8dFakCwTzSAhSgHq9m0w
         ORcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649834; x=1691241834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twwRuxY6wI3Kg6heMmcwREwGj5Jtv6WXh1HJopMuo9M=;
        b=Qof1XUXj0CJZKO/ehu1Zi7DHu9MWFY3L/EzXhbtiHx+WZg3avjhjdo/TxxaBgoU+aa
         +CTNR7aM12Sd/IaTRAFhMzHKhqbgtxMwjg93dDIO5gG4m/pfYB9Emwbs9NrvTWKeKq2t
         ME+SLLUDg5Ia0vRcCHiRRhZ3iODRzO0d5vfsXGu32cJHAcEsvQSEyIAHD2A34ntLAp3+
         3ZqWMXEtTTDBv9tNV3lHokNx3K1VSwZ/m/340bfHmTe9nX5qI0bWPWCXgWVyKnlZXqac
         MoVs+sBgydYcHVc1FV/MjELNoGgH+85tfdydgqRRnEIHNyutzHRyBRmCyL+PEeJBENmo
         u3vQ==
X-Gm-Message-State: ABy/qLZvfewTC1XATiqjJwsiC3Lk3RB0xno3NBLXvGdtMzVAYehaX2QI
        x9aH7+d/lZAeNvHGCoZfVHpZJpcQjnThJLPp
X-Google-Smtp-Source: APBJJlFQ1ZTm5MXnOCMNovRcrb4d0XYaDwQW6JLJg0/mvs9uceWmfXRUx4MfIzIgrSf4b/sPDLJsGw==
X-Received: by 2002:a17:906:519d:b0:98d:ffdf:29cb with SMTP id y29-20020a170906519d00b0098dffdf29cbmr1514386ejk.2.1688649833833;
        Thu, 06 Jul 2023 06:23:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/20] selinux: netif: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:25 +0200
Message-Id: <20230706132337.15924-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the identical type sel_netif_hashfn() returns.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/netif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index adbe9bea2d26..43a0d3594b72 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -67,7 +67,7 @@ static inline u32 sel_netif_hashfn(const struct net *ns, int ifindex)
 static inline struct sel_netif *sel_netif_find(const struct net *ns,
 					       int ifindex)
 {
-	int idx = sel_netif_hashfn(ns, ifindex);
+	u32 idx = sel_netif_hashfn(ns, ifindex);
 	struct sel_netif *netif;
 
 	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
@@ -89,7 +89,7 @@ static inline struct sel_netif *sel_netif_find(const struct net *ns,
  */
 static int sel_netif_insert(struct sel_netif *netif)
 {
-	int idx;
+	u32 idx;
 
 	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
 		return -ENOSPC;
-- 
2.40.1


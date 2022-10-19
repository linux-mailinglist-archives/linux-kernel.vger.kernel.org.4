Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DD605382
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJSW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJSW5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:57:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9C1C39C4;
        Wed, 19 Oct 2022 15:57:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1038259wmb.0;
        Wed, 19 Oct 2022 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSHC7wq31eMCYA16P+fMOvgJUg3fKnJfYGKil+Kojgc=;
        b=Ak5O3zfEs/BjkGW/RnXPe11Ts1Tbd3ZkGjSrYPELf0TpHS/VMYEoi75jE2aInSKa9b
         uoA6TVJnRdQ2SecExllSufNQAMA6AlYfrIfN3CmLSfR/W9YOzhj/HROo/V4HRR05qmyS
         mZe7YqXwIWmHhdUCWAUrF7NwhcFbGa9MOZR4IvV3c3XNdotMwEySAOkvRY/P/B+FbOGu
         NeU1EidhEeW5k67cYS66frt/SwD7dwYLQpLDEvcPdo1YzaRurGjyKyYPg5A9mGBteSBr
         QeRHerr0MMM+ptJm6iNs/Jrlrk5Klt3Xm2nioqcU/x8OBySpw2jI22KLJfMfZ6zcUjhN
         rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSHC7wq31eMCYA16P+fMOvgJUg3fKnJfYGKil+Kojgc=;
        b=cxqRiKIcabcm5JKBIoBrq9zvzBB9OxiW3+UF8ZPShffInynf7oTirb9Smidl4DeXXc
         wYV5y+ClrXu0AsQm9oKZAkLlRiEGDUGFEyKT/1U+x3AYFqSjRh7zqRRSBwzQHSWvPHtd
         RJDVGdam0Bz+8pFbtdNr45XUhbuM4k4lFaMq4Hp7NgeVyP6ult5XSlAEDylDe1tm3Fmm
         BKkX3TLNs4iSy1XGS0iwp1MvFU5EMbyIqyliEv5F/N3UHNHivp89tS2+SScoHu6j0TKs
         hggnfkdAFBrSZwQFBNMIiZyiNYToLvDTsM3avP9UqW0grz8LM1E2B2F3RqrfyYh9zmi7
         yl/g==
X-Gm-Message-State: ACrzQf3T6OZuZQZXKxESielN1WX5+Y5WYXGXUuMYoOojEbLmLtZP+4fh
        SON33cJtRSBRrGQO1s8sxUc=
X-Google-Smtp-Source: AMsMyM6p1L/FHRRIe99iBQxDezEC6akEfzApRozl7WiRR1LTt2eRsRVPaPvWHrGTBdTwzPn9/ZotCg==
X-Received: by 2002:a05:600c:4e0e:b0:3c6:f5b9:957a with SMTP id b14-20020a05600c4e0e00b003c6f5b9957amr7410907wmq.45.1666220230386;
        Wed, 19 Oct 2022 15:57:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c34cc00b003b435c41103sm1512525wmq.0.2022.10.19.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:57:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: remove redundant assignment to variable len
Date:   Wed, 19 Oct 2022 23:57:09 +0100
Message-Id: <20221019225709.1506515-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable len is assigned a value that is never read. It is re-assigned
a new value in the following do-while loop and never referenced after
the loop. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/thunderbolt/xdomain.c:344:2: warning: Value stored to 'len' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thunderbolt/xdomain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f00b2f62d8e3..5e99f93ee1a1 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -341,7 +341,6 @@ static int tb_xdp_properties_request(struct tb_ctl *ctl, u64 route,
 	memcpy(&req.src_uuid, src_uuid, sizeof(*src_uuid));
 	memcpy(&req.dst_uuid, dst_uuid, sizeof(*dst_uuid));
 
-	len = 0;
 	data_len = 0;
 
 	do {
-- 
2.37.3


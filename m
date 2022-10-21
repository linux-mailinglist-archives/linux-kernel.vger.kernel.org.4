Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B222C6070EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUHX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJUHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111602465F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B79061DC5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282C8C433D7;
        Fri, 21 Oct 2022 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666336994;
        bh=bcoMgCk0yZGwHr1Q/MWzklE8eNnrm1HaRDamF/Uhm+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=uc29ucxtd8oIh6NZDZu0CjYH/bqr6SrS2tAIoV0jlVkj7TDV6ct+0aaMIiK1ImVeB
         uxe3PrSkWmi5fAOR1qpeRW1jG650EVgdJvIfEiFySUN2z9IKZL2DozqaHA+bUC134v
         meu2ECVG7Hc6y2JWQlyh+9rjyBLY/b9a7zWs/jBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject: make get_ktype() take a const pointer
Date:   Fri, 21 Oct 2022 09:23:10 +0200
Message-Id: <20221021072310.3931690-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=gregkh@linuxfoundation.org; h=from:subject; bh=bcoMgCk0yZGwHr1Q/MWzklE8eNnrm1HaRDamF/Uhm+Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlBHnddNeK7Mr6veKv40ufXT/4jfA9jpCPkQ5YrhTouvnrt 4K4bHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR58kMCy4a7HOTVpbLOyrUcUpy6p JDk/QkxBjmu/mGcdqkmy682eHHXhldzqUaJigMAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_ktype() does not modify the structure passed to it, so mark the
parameter as being const to allow other const structures to be passed to
it in the future.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 57fb972fea05..fc00cee1359c 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -198,7 +198,7 @@ static inline void kset_put(struct kset *k)
 	kobject_put(&k->kobj);
 }
 
-static inline const struct kobj_type *get_ktype(struct kobject *kobj)
+static inline const struct kobj_type *get_ktype(const struct kobject *kobj)
 {
 	return kobj->ktype;
 }
-- 
2.38.1


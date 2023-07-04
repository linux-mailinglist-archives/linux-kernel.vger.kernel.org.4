Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC51E746939
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGDFwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGDFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:52:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B762E49;
        Mon,  3 Jul 2023 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZT+Waq4/7CDQDwKeT5ati3iaCZkS+/uXn2hrAuUP5S0=; b=IvzxZFWh1WJNnhjNy2NfNHIS09
        vup5sGYDgOMT2cY5oQES/EI+Z/+RWEcdlXJGmyjlCtSwbqKe5Cv5ZshucXYXYNoJW80U3ObJ+Nzd7
        WJiEdvkRlTAXVhwsWE0dNBgX/rgGOT9wYVvWbO25Sh7LCzp7phHM3Rynty3zod/rYCphSKKA6VjNT
        qkJx5KDio0okE/wS3zLa65P9ADIGR5fydEg/6jAA0uPiP79brSprKJTBWsVI0CqGFVjfV5yraPegY
        iqp3cdkTCdm9///dPYISZ1GC4YFH6oTN8Pjb40Ctld5OBEfim88u2xvWryU3eVJo6Xhpy4v6CWpiA
        XEX/tRGw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGYxz-00CFBO-0U;
        Tue, 04 Jul 2023 05:52:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kconfig: tell the kconfig symbol of the restart reason
Date:   Mon,  3 Jul 2023 22:52:46 -0700
Message-ID: <20230704055246.22893-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running 'make oldconfig' or 'make olddefconfig' without waiting
for prompts, it can be useful to know the restart reason so that it
can be fixed manually.

This is usually when the prompt value is a number or a string,
i.e., something other than y/m/n.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
Can the test for sym->name be omitted?

 scripts/kconfig/conf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -- a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -652,8 +652,12 @@ static void check_conf(struct menu *menu
 			printf("-----\n");
 			break;
 		default:
-			if (!conf_cnt++)
-				printf("*\n* Restart config...\n*\n");
+			if (!conf_cnt++) {
+				printf("*\n* Restart config...\n");
+				if (sym->name)
+					printf("* due to symbol: %s\n", sym->name);
+				printf("*\n");
+			}
 			rootEntry = menu_get_parent_menu(menu);
 			conf(rootEntry);
 			break;

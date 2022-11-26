Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105E639601
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 13:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKZM5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 07:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKZM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 07:57:38 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D074F00C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 04:57:35 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2AQCuhbq014203-2AQCuhbt014203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 26 Nov 2022 20:56:51 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Mingyi Kang <jerrykang026@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/2] staging: vme_user: add list_del in the error handling of tsi148_dma_list_add
Date:   Sat, 26 Nov 2022 20:56:33 +0800
Message-Id: <20221126125642.16358-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports the following issue:
drivers/staging/vme_user/vme_tsi148.c:1757 tsi148_dma_list_add()
warn: '&entry->list' not removed from list

Fix this by adding list_del in the error handling code.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/staging/vme_user/vme_tsi148.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 020e0b3bce64..0171f46d1848 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -1751,6 +1751,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 	return 0;
 
 err_dma:
+	list_del(&entry->list);
 err_dest:
 err_source:
 err_align:
-- 
2.37.1 (Apple Git-137.1)


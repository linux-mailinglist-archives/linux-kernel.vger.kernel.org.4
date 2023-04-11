Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699276DD08D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDKD5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDKD5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:57:11 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 20:57:08 PDT
Received: from pesi.com.tw (mail.pesi.com.tw [59.120.71.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA21BC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:57:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pesi.com.tw (Postfix) with SMTP id 1335C61170
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:50:33 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 pesi.com.tw 1335C61170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pesi.com.tw;
        s=default; t=1681185033;
        bh=GXg5TNPseTLX/q3lrTI4oKFUZtKZaCTZne4J784F/dY=;
        h=From:To:Cc:Subject:Date:From;
        b=r6BtIqbvJnIUQj/pR7cO5x/4yOHjGAitm7yPN5nivl6X8QO5T9krEq3IYHkviXbwx
         aXhvZxiTEZSWzSrh3T7ziALVSusXn7QrIPS9gUmFjHrdQ9kYFlefstqfanXOjQO5ap
         D5pYUVDMm20GdfWnhW6TZyCIyuDSSQt8dzysI8ow=
Received: from localhost.localdomain (125-228-196-244.hinet-ip.hinet.net [125.228.196.244])
        by pesi.com.tw (Postfix) with ESMTPA id C239961101;
        Tue, 11 Apr 2023 11:50:28 +0800 (CST)
From:   Steve Chou <steve_chou@pesi.com.tw>
To:     akpm@linux-foundation.org
Cc:     Steve Chou <steve_chou@pesi.com.tw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/mm/page_owner_sort.c: fix TGID output when cull=tg is used
Date:   Tue, 11 Apr 2023 11:49:28 +0800
Message-Id: <20230411034929.2071501-1-steve_chou@pesi.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using cull option with 'tg' flag, the fprintf is using pid instead
of tgid. It should use tgid instead.

Signed-off-by: Steve Chou <steve_chou@pesi.com.tw>
---
 tools/mm/page_owner_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 7c2ac124cdc8..99798894b879 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -857,7 +857,7 @@ int main(int argc, char **argv)
 			if (cull & CULL_PID || filter & FILTER_PID)
 				fprintf(fout, ", PID %d", list[i].pid);
 			if (cull & CULL_TGID || filter & FILTER_TGID)
-				fprintf(fout, ", TGID %d", list[i].pid);
+				fprintf(fout, ", TGID %d", list[i].tgid);
 			if (cull & CULL_COMM || filter & FILTER_COMM)
 				fprintf(fout, ", task_comm_name: %s", list[i].comm);
 			if (cull & CULL_ALLOCATOR) {
-- 
2.25.1



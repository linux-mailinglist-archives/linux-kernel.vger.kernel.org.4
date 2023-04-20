Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054286E8D74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjDTJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjDTJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071629ED8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6570960DC4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA0C433EF;
        Thu, 20 Apr 2023 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681981080;
        bh=KW/cOzzz0VeUWtRrIVVV/Jvq1YUVpWtNqR0e3LlJHpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2myTk6B5eriGxsU6/qGzfQumjVeH2e3afVEFIWlU8rfbkviTzxfnFOTr+a1fbLh8
         zWtjEyNyqdlnbur6mK5cefIAqwk90StKTjTec61TpMor9Xap1uHWxS5W/22bMVHn0E
         My3fk/2N/ilyUoS/47lxI5LJL1h7Eta0vkO6AfnQ4lkq2Q9eTOrCYGHKLzLSFZNVyu
         1xuwf6mcGZ9ndyzuAsgC19Sx5DCwNqszhddBEK3f1ncrVhlmhT46kWXt+KaEpWmrXJ
         bP7Ht/9+Q95uQ9N8JkGbnU8WreQSsdGYAEM2bxB6u7NFj6zniS8LX9vFSh/FnHBWD8
         lgMm12YTBcYCw==
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: restrict noswap option to initial user namespace
Date:   Thu, 20 Apr 2023 10:57:43 +0200
Message-Id: <20230420-faxen-advokat-40abb4c1a152@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZD8Q2SzVr3xDmCgY@bombadil.infradead.org>
References: <ZD8Q2SzVr3xDmCgY@bombadil.infradead.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=brauner@kernel.org; h=from:subject:message-id; bh=KW/cOzzz0VeUWtRrIVVV/Jvq1YUVpWtNqR0e3LlJHpU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4/CtY+P1BygbWTxsmz2v3mbW68tTFF9vkznTv/rC0+Fq8 kMSC6R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATOdTB8D8nUVBgesz9L2museLMgc rL8zcymz6qnLdhWmCKaJrYpHcMv5h3cMz02syXubEt6dTWisvnC8/H9OUImU3acTB4f4qbJB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent tmpfs instances mounted in an unprivileged namespaces from
evading accounting of locked memory by using the "noswap" mount option.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Reported-by: Hugh Dickins <hughd@google.com>
Link: https://lore.kernel.org/lkml/79eae9fe-7818-a65c-89c6-138b55d609a@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/shmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 787e83791eb5..21ce9b26bb4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3571,6 +3571,10 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
 	case Opt_noswap:
+		if ((fc->user_ns != &init_user_ns) || !capable(CAP_SYS_ADMIN)) {
+			return invalfc(fc,
+				       "Turning off swap in unprivileged tmpfs mounts unsupported");
+		}
 		ctx->noswap = true;
 		ctx->seen |= SHMEM_SEEN_NOSWAP;
 		break;
-- 
2.34.1


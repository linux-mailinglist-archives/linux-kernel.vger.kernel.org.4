Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC760BB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiJXU45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiJXU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:56:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F7FB3B0A;
        Mon, 24 Oct 2022 12:03:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1217921E70;
        Mon, 24 Oct 2022 19:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666638117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oIWrFVCTFI0P8Gt8DB2CKcLBPuXOX6c8HwKwpujStPs=;
        b=usXYqPefh4eEIKMYACSLS5A/8NdFsaITAJCgUzvwEPid3GH+TQTOI23v3ll5y+QNooeUZr
        3ze7SirTSyiludyKt5GZz6rSOZ4tTwb4/lM5MDT4xrVqbSLeSQ4fcXWMk6rLmlp1uQzghA
        S91SJQQGa1p2ZsLepX1DcrVHc9wRUhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666638117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oIWrFVCTFI0P8Gt8DB2CKcLBPuXOX6c8HwKwpujStPs=;
        b=autQ68W9Wcb4TmHypUYFSXRRxqC0YVTZoahysFvUonU38+sDLf5TP/WJB83BWUqQQktFKV
        qo006gi3pzYwxRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E11FC13A79;
        Mon, 24 Oct 2022 19:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id juQiNSThVmMpLwAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 24 Oct 2022 19:01:56 +0000
Message-ID: <f70c7a11-e81e-f6b9-a403-315117f4aa3a@suse.cz>
Date:   Mon, 24 Oct 2022 21:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] block: fix Werror=format with GCC 13
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with GCC 13, since
[g3b3083a598ca3f4b] c: C2x enums wider than int [PR36113]

GCC promotes enum values with larger than integer types to a wider type.
In case of the anonymous enum type in blk-iocost.c it is:

enum {
	MILLION			= 1000000,
...

	WEIGHT_ONE		= 1 << 16,
...
	VTIME_PER_SEC_SHIFT	= 37,
	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
...

as seen VTIME_PER_SEC cannot fit into 32-bits (int type), thus one needs
to use 'long unsigned int' in the format string.

It fixes then the following 2 warnings:

block/blk-iocost.c: In function ‘ioc_weight_prfill’:
block/blk-iocost.c:3035:37: error: format ‘%u’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
 3035 |                 seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
      |                                    ~^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                     |                             |
      |                                     unsigned int                  long unsigned int
      |                                    %lu
block/blk-iocost.c: In function ‘ioc_weight_show’:
block/blk-iocost.c:3045:34: error: format ‘%u’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
 3045 |         seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
      |                                 ~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                  |                      |
      |                                  unsigned int           long unsigned int
      |                                 %lu

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 495396425bad..f165bac9bffb 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3032,7 +3032,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
+		seq_printf(sf, "%s %lu\n", dname, iocg->cfg_weight / WEIGHT_ONE);
 	return 0;
 }
 
@@ -3042,7 +3042,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 
-	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
+	seq_printf(sf, "default %lu\n", iocc->dfl_weight / WEIGHT_ONE);
 	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
 			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
 	return 0;
-- 
2.38.0


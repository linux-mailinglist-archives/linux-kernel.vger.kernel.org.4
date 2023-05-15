Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8998702751
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjEOIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEOIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1FCC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 596A2611C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A18C433D2;
        Mon, 15 May 2023 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684139652;
        bh=b5jfUGBb8JJ/0NiF7GCWAxiRgd25Y0crY5ZrPs7w7U0=;
        h=From:To:Cc:Subject:Date:From;
        b=saSSWqFNR5BBz2qvQ6WJCQigMj4d1IVXs15OGzWM0ICdrmZHIBTHwb8VCL6biv5Xf
         b4Pi/8czfxY3R1h4FfxXzWbBbx1m2fHt5FzDlOXKTzTQS1qEv6q4ibaLk5VdO8M0+X
         Y0EM+dB5RnwPzUgBoozTV6CPM4HZJCKTPkOE3FCokiSPu5lTU7I1C2RazKtyM5DfKW
         CLPNWtBYL7knMOag/MkGj9o6wkVU3//CQrERJSwphud9O95D2aFx09l22o4FgGhWOF
         6NNFefyu1pxhjmnHRXuPKTxgx6USykhQw76NgfulBhf0fwluQpZP+8Sk59Di8VIhjS
         SNN47HdBSNSyQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/secretmem: make it on by default
Date:   Mon, 15 May 2023 11:34:00 +0300
Message-Id: <20230515083400.3563974-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Following the discussion about direct map fragmentaion at LSF/MM [1], it
appears that direct map fragmentation has a negligible effect on kernel
data accesses. Since the only reason that warranted secretmem to be
disabled by default was concern about performance regression caused by
the direct map fragmentation, it makes perfect sense to lift this
restriction and make secretmem enabled.

secretmem obeys RLIMIT_MEMBLOCK and as such it is not expected to cause
large fragmentation of the direct map or meaningfull increase in page
tables allocated during split of the large mappings in the direct map.

The secretmem.enable parameter is retained to allow system
administrators to disable secretmem at boot.

Switch the default setting of secretem.enable parameter to 1.

Link: https://lwn.net/Articles/931406/ [1]
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 0b502625cd30..974b32ba8b9d 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -35,7 +35,7 @@
 #define SECRETMEM_MODE_MASK	(0x0)
 #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
 
-static bool secretmem_enable __ro_after_init;
+static bool secretmem_enable __ro_after_init = 1;
 module_param_named(enable, secretmem_enable, bool, 0400);
 MODULE_PARM_DESC(secretmem_enable,
 		 "Enable secretmem and memfd_secret(2) system call");
-- 
2.35.1


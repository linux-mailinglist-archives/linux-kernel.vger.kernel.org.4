Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37770700F21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjELTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbjELTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85872724
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B5963B29
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 19:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBFEC433EF;
        Fri, 12 May 2023 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683918149;
        bh=E2Npg22ZaCIioNRTqxsE8ZqPL1p1Do3YiLBJa9YilwI=;
        h=Subject:From:To:Cc:Date:From;
        b=swObnCJrKWQTTbkgruSjzkaAEhcaI4scadHHrUbDw5GsPbkwQMBYcb+kEPQU4aB03
         0+SZoogggMv0bf9wOV/eHGeHNM9loGBMbOSz96jysAfdLMTNU96UoT8gisTFDBmbIQ
         VvgDZitaETE5AtCDcvtdNS2dEzG5YeLMh2uuFxpun3dK/CDaB93kX0AN37l5ZSkgtE
         GPlUNiJGhxIyfQuCbbpf0CLq+I4BzOTx46QiHcuKEUS2NSgTOy2EDXd2d6+yTzmKmz
         SZ1Mf3rCwkXvdoLm1JCeWL0Pl0tUMEkvxAqfDRQX0OQrBfRfhbyt3MEoMlHEnclzDh
         pi3XsWv9jkFgQ==
Subject: [PATCH] net/handshake: Squelch allocation warning during Kunit test
From:   Chuck Lever <cel@kernel.org>
To:     naresh.kamboju@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        lkft-triage@lists.linaro.org, elver@google.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        aryabinin@virtuozzo.com
Date:   Fri, 12 May 2023 15:02:18 -0400
Message-ID: <168391812685.21298.13859211358278163731.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The "handshake_req_alloc excessive privsize" kunit test is intended
to check what happens when the maximum privsize is exceeded. The
WARN_ON_ONCE_GFP at mm/page_alloc.c:4744 can be disabled safely for
this allocator call site.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: 88232ec1ec5e ("net/handshake: Add Kunit tests for the handshake consumer API")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/request.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index d78d41abb3d9..24097cccd158 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -120,7 +120,8 @@ struct handshake_req *handshake_req_alloc(const struct handshake_proto *proto,
 	if (!proto->hp_accept || !proto->hp_done)
 		return NULL;
 
-	req = kzalloc(struct_size(req, hr_priv, proto->hp_privsize), flags);
+	req = kzalloc(struct_size(req, hr_priv, proto->hp_privsize),
+		      flags | __GFP_NOWARN);
 	if (!req)
 		return NULL;
 



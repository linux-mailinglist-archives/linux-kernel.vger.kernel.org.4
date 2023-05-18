Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B7708BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjERWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjERWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249AE64;
        Thu, 18 May 2023 15:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48BB638BE;
        Thu, 18 May 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F0CC4339B;
        Thu, 18 May 2023 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449620;
        bh=fecc2OUGYvaY7HhyWoq5AoCd5a8aYFQhBEm7VND8WRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P18tjltVWhrWdAx/t73MdYzudw5rAwtcgHmB/MnIe2y6gVDckQF6FTRGLFg5731sU
         JE8gbMwtGGjpyk1PixlH1id+rzzkUnMY7HfZjyVRsUV1HP8FnjtWswBasnQXpAHtsp
         6ir0BbvnOUsku7PcQI00Gs+RbQmLmmpQ14v5cqILduXW0oWTIcegiWs1T0oDdXfgZi
         R27bwO9Bwj80Phs8CAWxV7dquax9Pk2BNtHDLSFke/1Fc6SO/V6pXockfnzEc//t3D
         Kew9iJOBJow0x/qHQ/A+sccnynoNIEtq3gnQjfqjzmQxlnKsu4mtFw4A96Ynsalyfq
         U++W4rKV2PkHQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Docs/RCU/rculist_nulls: Fix hlist_head field name of 'obj'
Date:   Thu, 18 May 2023 22:40:07 +0000
Message-Id: <20230518224008.2468-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518224008.2468-1-sj@kernel.org>
References: <20230518224008.2468-1-sj@kernel.org>
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

The example code snippets on rculist_nulls.rst are assuming 'obj' to
have the 'hlist_head' field named 'obj_node', but a sentence is wrongly
mentioning 'obj->obj_node.next' as 'obj->obj_next'.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 94a8bfe9f560..5cd6f3f8810f 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -86,7 +86,7 @@ Quoting Corey Minyard::
 2) Insertion algorithm
 ----------------------
 
-We need to make sure a reader cannot read the new 'obj->obj_next' value
+We need to make sure a reader cannot read the new 'obj->obj_node.next' value
 and previous value of 'obj->key'. Otherwise, an item could be deleted
 from a chain, and inserted into another chain. If new chain was empty
 before the move, 'next' pointer is NULL, and lockless reader can not
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4171195E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjEYVne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbjEYVnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B410FB;
        Thu, 25 May 2023 14:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4F1064B74;
        Thu, 25 May 2023 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B759DC4339E;
        Thu, 25 May 2023 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051003;
        bh=NrQxqhDPJ98oboAlR28uGqZUlrS5AmTee+Fa9XTxEmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMEhL3qQzSUfgwpeBq+8adhjQX0oA4pjhIziNSyjvfCrbF07AwIQT5mklBCXNW4El
         ROYP9lK+EThF92y9nRLfHJuEWU1NKEtpaIIT3mXlie0WS4ayg6fTmMMImd9+G3nRcY
         rJ6eJlL4H6bqb+IIyAikKIcjHEgRmAm/WCk3WEBYhgNB1wsoa+ihRuDldcZhlI7erU
         JSKB8p5tAF8CiYaxOprLoQhCBSkcvD0IOpIMrA9tHfym3lVX38jT5MD1NMFtDVc0mB
         vvrrDIAKi7niiwB8aSS7dmA0rjtv9HQpKPqXvVqRW2ZO6Uo7dfTRWRdGDVpzr7f8vG
         ItX0vPPjynI1Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] Docs/mm/damon/design: add a section for overall architecture
Date:   Thu, 25 May 2023 21:43:07 +0000
Message-Id: <20230525214314.5204-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
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

The design doc is missing overall picture of DAMON.  Add a section for
overall architeucture and layers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0cff6fac6b7e..3b4ce873fa71 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -4,6 +4,21 @@
 Design
 ======
 
+
+Overall Architecture
+====================
+
+DAMON subsystem is configured with three layers including
+
+- Operations Set: Implements fundamental operations for DAMON that depends on
+  the given monitoring target address-space and available set of
+  software/hardware primitives,
+- Core: Implements core logics including monitoring overhead/accurach control
+  and access-aware system operations on top of the operations set layer, and
+- Modules: Implements kernel modules for various purposes that provides
+  interfaces for the user space, on top of the core layer.
+
+
 Configurable Layers
 ===================
 
-- 
2.25.1


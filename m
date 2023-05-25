Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920B711967
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjEYVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbjEYVnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2B6189;
        Thu, 25 May 2023 14:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05C864B6C;
        Thu, 25 May 2023 21:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB18C4339B;
        Thu, 25 May 2023 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051008;
        bh=FlZuBr64knJ/8JP07S/l782gvTE23ogKRh6IGqK2gr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQoq8UhP0KDP7dsBgoau7JHv8ZbqA6Mk7eyiEYs20eSZPB60Mjy409eVD8M/aQbcD
         mhvONiRVkwQMiWpQGy2aEq1iysz8wQCGutpD9He8OmINpO43C2I9f5UyxRx6vhrG4Z
         GwcABZVvgk4YVQjaRrLPmRteCzz0RDRcEUGPTHo7kGfrm/9Wut7jkkoODWdXCwnyqL
         2QSlv7J+B+eRSGGOID/CsZSG7dx3wZpcXnLYkLriEdYkwxsu2Cwwh9ggRTJ9ddWH/H
         TYT5d7LSPqBsKYp11iYGrWaFXldnJdRFsJi8Mfohaq/HnpLfAVzXP4HIjxacxLtoHc
         acztIb1xTvRQA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] Docs/mm/damon/design: add a section for the modules layer
Date:   Thu, 25 May 2023 21:43:14 +0000
Message-Id: <20230525214314.5204-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section for covering DAMON modules layer to the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0ccdd2f6af9f..da110e89cab4 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -370,3 +370,64 @@ access-aware applications using DAMON's core features.  For this, DAMON exposes
 its all features to other kernel components via its application programming
 interface, namely ``include/linux/damon.h``.  Please refer to the API
 :doc:`document </mm/damon/api>` for details of the interface.
+
+
+Modules
+=======
+
+Because the core of DAMON is a framework for kernel components, it doesn't
+provide any direct interface for the user space.  Such interfaces should be
+implemented by each DAMON API user kernel components, instead.  DAMON subsystem
+itself implements such DAMON API user modules, which are supposed to be used
+for general purpose DAMON control and special purpose data access-aware system
+operations, and provides stable application binary interfaces (ABI) for the
+user space.  The user space can build their efficient data access-aware
+applications using the interfaces.
+
+
+General Purpose User Interface Modules
+--------------------------------------
+
+DAMON modules that provide user space ABIs for general purpose DAMON usage in
+runtime.
+
+DAMON user interface modules, namely 'DAMON sysfs interface' and 'DAMON debugfs
+interface' are DAMON API user kernel modules that provide ABIs to the
+user-space.  Please note that DAMON debugfs interface is currently deprecated.
+
+Like many other ABIs, the modules create files on sysfs and debugfs, allow
+users to specify their requests to and get the answers from DAMON by writing to
+and reading from the files.  As a response to such I/O, DAMON user interface
+modules control DAMON and retrieve the results as user requested via the DAMON
+API, and return the results to the user-space.
+
+The ABIs are designed to be used for user space applications development,
+rather than human beings' fingers.  Human users are recommended to use such
+user space tools.  One such Python-written user space tool is available at
+Github (https://github.com/awslabs/damo), Pypi
+(https://pypistats.org/packages/damo), and Fedora
+(https://packages.fedoraproject.org/pkgs/python-damo/damo/).
+
+Please refer to the ABI :doc:`document </admin-guide/mm/damon/usage>` for
+details of the interfaces.
+
+
+Special-Purpose Access-aware Kernel Modules
+-------------------------------------------
+
+DAMON modules that provide user space ABI for specific purpose DAMON usage.
+
+DAMON sysfs/debugfs user interfaces are for full control of all DAMON features
+in runtime.  For each special-purpose system-wide data access-aware system
+operations such as proactive reclamation or LRU lists balancing, the interfaces
+could be simplified by removing unnecessary knobs for the specific purpose, and
+extended for boot-time and even compile time control.  Default values of DAMON
+control parameters for the usage would also need to be optimized for the
+purpose.
+
+To support such cases, yet more DAMON API user kernel modules that provide more
+simple and optimized user space interfaces are available.  Currently, two
+modules for proactive reclamation and LRU lists manipulation are provided.  For
+more detail, please read the usage documents for those
+(:doc:`/admin-guide/mm/damon/reclaim` and
+:doc:`/admin-guide/mm/damon/lru_sort`).
-- 
2.25.1


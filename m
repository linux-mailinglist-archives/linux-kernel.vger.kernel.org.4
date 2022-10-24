Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFB60B6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiJXTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiJXTMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2746918F0E5;
        Mon, 24 Oct 2022 10:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC240B81142;
        Mon, 24 Oct 2022 17:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C63C433B5;
        Mon, 24 Oct 2022 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666633587;
        bh=lV8oUGKGj7ZDIO/tmDfk1VdZPNBMnBKsnbsjH0pe+m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLsERA71D+0f1bI2hLFm02yZWXy7V4t4J5aBlCTtR7UBsixm3HQJ04xiUvdl+gWYW
         IR6ZBLnPq8d9XPQesG1OmXEH11O7o7Qi8vmRcuBUGVOExTPbnImg8uq0NYjIYW8SVC
         W1Lco5wuKDJg37THPKPkpDSBLdmcP+RyQoW0Fs2Q3rdyQwSdkeOhCAC3cN9Q2tT9Ls
         p4xuRqwCOdPp0jpN/i+04kihcUNFpWixl+ZB+apzgqC3Smw0s11nL6W4Z9Thki86f6
         iFvzyNxQUxUv4vSy3cEK8xlyutYJfHWAN8qRHlzL6MkuXDyMsDrmR8K7kuvui/MBi0
         TvZVSo1tvnB9A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinicius Petrucci <vpetrucci@gmail.com>
Subject: [PATCH 1/2] Docs/admin-guide/mm/damon/usage: describe the rules of sysfs region directories
Date:   Mon, 24 Oct 2022 17:46:18 +0000
Message-Id: <20221024174619.15600-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024174619.15600-1-sj@kernel.org>
References: <20221024174619.15600-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Target region directories of DAMON sysfs interface should contain no
overlap and sorted by the address, but not clearly documented.
Actually, a user had an issue[1] due to the poor documentation.  Add
clear description of it on the usage document.

[1] https://lore.kernel.org/damon/CAEZ6=UNUcH2BvJj++OrT=XQLdkidU79wmCO=tantSOB36pPNTg@mail.gmail.com/

Reported-by: Vinicius Petrucci <vpetrucci@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index b47b0cbbd491..89d9a4f75a29 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -235,6 +235,9 @@ In each region directory, you will find two files (``start`` and ``end``).  You
 can set and get the start and end addresses of the initial monitoring target
 region by writing to and reading from the files, respectively.
 
+Each region should not overlap with others.  ``end`` of directory ``N`` should
+be equal or smaller than ``start`` of directory ``N+1``.
+
 contexts/<N>/schemes/
 ---------------------
 
-- 
2.25.1


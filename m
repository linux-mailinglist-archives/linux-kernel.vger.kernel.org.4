Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD867D80D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjAZV5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjAZV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:57:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187DB728F6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23280B81DC2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E6C433EF;
        Thu, 26 Jan 2023 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674770178;
        bh=89eL4l2vH6KCZTfrG7vyQ7zHN+D+4zoTm+z0+a6kYA4=;
        h=From:To:Cc:Subject:Date:From;
        b=X3Ijtpavk2nl0kbJmvOx/mICvbhWFQO+eT+KZXaFBFXVtSNMzNUzEY7dqXNQSaKTs
         HCeHOSi2V6Fd8NkozdRvZfkrWcdKUnFt+YiuqmO2g2Rft23oTXh4PgmuKG2juWiXWb
         f5GEeVS3077wko+ePk0NLg+SjFiEMtKMGG2eBkjLiPn7rNU3UrhbVedKQNkAKsJ+jl
         Z5gsJHrhp+xjJCoqDDAI6xKsa5OCnt6SCqSg9im1sL8trTfyQylyo84usrcDZfvGFw
         HrHiBLRwKG51MTRJSOWaRddrNlg/l6yUrFtKjL4r/CcPia9NxdeAXY8kr/f5qyZxHa
         iVx+J1bdtqohQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        cocci@inria.fr (moderated list:COCCINELLE/Semantic Patches (SmPL)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts: coccicheck: Use /usr/bin/env
Date:   Thu, 26 Jan 2023 21:56:12 +0000
Message-Id: <20230126215612.86436-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bash is not located under /bin, coccicheck fails to run.  In the real
world, this happens for instance when NixOS is used in the host.  Instead,
use /usr/bin/env to locate the executable binary for bash.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 2956fce8fa4f..b4d0d6eb3e73 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 # Linux kernel coccicheck
 #
-- 
2.38.1


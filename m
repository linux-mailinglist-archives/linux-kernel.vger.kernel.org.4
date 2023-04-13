Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A96E1790
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDMWik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMWii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AAD2705
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A6164120
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6193C433EF;
        Thu, 13 Apr 2023 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681425515;
        bh=mxON2XWy5axtTK7Rhbe3JIQCWet3NhoTe0n5UPPbxXY=;
        h=From:To:Cc:Subject:Date:From;
        b=AJKGIVcj1S2FJ6AwXfolPCUlnmW7HczX032Lw8MHE9VHy7Xi7IsPpKHWjlzQzLYIx
         hOsljRrkzxHFR9HIWfvNYEaLSs5C6d95ucMjR5F+JO0fsq4Dh22kcLj+78crxDmewN
         w9YE1z6KNSJvGn6ilCVZ/pgBDgM1C+0WuWQ3aZWQUfu+2++bEoJdrBoTX1VCUB1sd1
         ZVfvXuqOHzUd5PwK+98HbEl061vTTVUhzidhlvkPjP40B/pYwrQ1hx8ynP4H5lBgok
         qKOchAp4xeQ9sDXGCrUnKId/he/DyYrWzpJLhMvSiLjHB8UmlbYMMBSaeeSpSCSNyM
         SkGncmLCMkLFw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 0/6] SPMI patches for v6.4
Date:   Thu, 13 Apr 2023 15:38:28 -0700
Message-ID: <20230413223834.4084793-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's the pile of SPMI patches for the next merge window. They're
mostly cleanups, one batch migrates drivers to the new platform driver
remove function and another drops of_match_ptr() from the Mediatek
driver. There's also some kernel-doc warning fixes and we allow the
'remove' callback for spmi drivers to be optional so that drivers that
don't have one don't oops when they're unbound.

Jishnu Prakash (1):
  spmi: Add a check for remove callback when removing a SPMI driver

Krzysztof Kozlowski (1):
  spmi: mtk-pmif: Drop of_match_ptr for ID table

Randy Dunlap (1):
  spmi: fix W=1 kernel-doc warnings

Uwe Kleine-König (3):
  spmi: hisi-spmi-controller: Convert to platform remove callback
    returning void
  spmi: mtk-pmif: Convert to platform remove callback returning void
  spmi: pmic-arb: Convert to platform remove callback returning void

 drivers/spmi/hisi-spmi-controller.c | 5 ++---
 drivers/spmi/spmi-mtk-pmif.c        | 7 +++----
 drivers/spmi/spmi-pmic-arb.c        | 9 ++++-----
 drivers/spmi/spmi.c                 | 8 +++++---
 4 files changed, 14 insertions(+), 15 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


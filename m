Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C780564BC25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiLMSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiLMSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:35:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4802528A;
        Tue, 13 Dec 2022 10:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7556616D9;
        Tue, 13 Dec 2022 18:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E8CC433EF;
        Tue, 13 Dec 2022 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670956548;
        bh=RwcV3yZ+zQ6XKY/GbgFiJKf5T1kYYz04kemOgRUA7uU=;
        h=From:To:Cc:Subject:Date:From;
        b=jvuhGbNITwreRiZ6mCd8ZfwFCEd3fpRlqFTzUWuRSggeVUUy1Orke/XEnuiI7x7Bb
         SrYk/T4ta/dKNEBDyThYCbgfAeeIfVCjOeuVaZJ1D0aRa+gpPvK0p2AnzqkghlIioT
         2Y+cRX+tm2izZVigmexK+TytaJrRbgQ5OBjTcD/s4Ot4vpw5RRTWtPZGNZNBs8UCJb
         dwfoR1DnFxBsPv3/FBgLWGajV9l9TKGuR07bfDPEbJ3boPmPZGjuwz7UqXfGk6BgXm
         JjylM3Xbe9FWUwzrGczbKKsyWM7yQHQb8T5KMcw1ZBnHM0QLO6LwYEYlHWQDliUOhD
         b7jXvkj3/YJ+A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 0/2] Fix lack of section mismatch warnings with LTO
Date:   Tue, 13 Dec 2022 11:35:27 -0700
Message-Id: <20221213183529.766630-1-nathan@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Hi all,

Vincent recently reported an issue with lack of section mismatch
warnings with LTO. This is due to commit 6c730bfc894f ("modpost: handle
-ffunction-sections"), which ignores all function sections for modpost.

I believe this is incorrect, as these function sections may still refer
to symbols in other sections and they will ultimately be coalesced into
.text by vmlinux.lds anyways.

The first patch fixes a warning that I see with allmodconfig + ThinLTO
builds after applying the second patch. The second patch moves ".text.*"
into TEXT_SECTIONS so that modpost audits them for mismatches.

I expect this to go via the kbuild tree with an ack from the padata
maintainers.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-crypto@vger.kernel.org

v3:
  - Stick a comment above padata_work_init() to explain presence of
    __ref (Masahiro, Daniel).
  - Expand on problem in first patch's commit message (Masahiro).
  - Adjust location of __ref within function definition (Daniel)
  - Fix typo in commit message of second patch (Masahiro).
v2: https://lore.kernel.org/20221207191657.2852229-1-nathan@kernel.org/
v1: https://lore.kernel.org/20221129190123.872394-1-nathan@kernel.org/

Nathan Chancellor (2):
  padata: Mark padata_work_init() as __ref
  modpost: Include '.text.*' in TEXT_SECTIONS

 kernel/padata.c       | 12 ++++++++++--
 scripts/mod/modpost.c |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.39.0


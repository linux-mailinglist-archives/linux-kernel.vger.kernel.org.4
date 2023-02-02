Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456FA6873F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBBDiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBBDie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:38:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA47B79D;
        Wed,  1 Feb 2023 19:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 284AAB823F6;
        Thu,  2 Feb 2023 03:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC14C4339C;
        Thu,  2 Feb 2023 03:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675309104;
        bh=8GlZd68+4GdEpugeLuTwpZAYZlhX8nffQvGke0BiXsY=;
        h=From:To:Cc:Subject:Date:From;
        b=dTL8edCYQ7BvU6RjB4z+2mTJGO3Ko15of/lXcJODalcE6Mex4LEJUssTrRzCj1zRy
         LtrEXoj20thMLOZaGqldZ3MCoxNPQv/zs6K56YLqNeknGZW29BfbPLn87A83YAocY3
         AKfB4/w1pxpORWT47j2vnksn+5SQgbGPP68uN/tC/PYSKufeXU1vALDIVTP2fUtXrA
         T+jFFitOXUdle4+t5/1MDUfpOUcqtGnIpGt57hmLQbRi2qmxz55k0ibmupxDRjdOx/
         k3ZKjJbm7cIXkSmrEHeuNXQkcJ+b0e4Urec+/mHe152rzjPAiS4mUyynCZjsCb0V4i
         yeM7L1kOyeIJQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH v4 0/6] kbuild: improve source package builds
Date:   Thu,  2 Feb 2023 12:37:10 +0900
Message-Id: <20230202033716.341858-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series improve deb-pkg and (src)rpm-pkg so they can build
without cleaning the kernel tree.
The debian source package will switch to 3.0 (quilt).

My next plans are:

 - add 'srcdeb-pkg' target

 - add more compression mode

 - rewrite snap-pkg and delete the old tar macro



Masahiro Yamada (6):
  kbuild: add a tool to generate a list of files ignored by git
  kbuild: deb-pkg: create source package without cleaning
  kbuild: rpm-pkg: build binary packages from source rpm
  kbuild: srcrpm-pkg: create source package without cleaning
  kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
  kbuild: deb-pkg: switch over to format 3.0 (quilt)

 Makefile                 |   4 +
 scripts/.gitignore       |   1 +
 scripts/Makefile         |   2 +-
 scripts/Makefile.package |  94 +++---
 scripts/gen-exclude.c    | 623 +++++++++++++++++++++++++++++++++++++++
 scripts/package/mkdebian |  23 +-
 scripts/package/mkspec   |   8 +-
 7 files changed, 706 insertions(+), 49 deletions(-)
 create mode 100644 scripts/gen-exclude.c

-- 
2.34.1


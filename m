Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58A063C7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiK2TCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiK2TCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:02:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444BA1BD;
        Tue, 29 Nov 2022 11:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9371461874;
        Tue, 29 Nov 2022 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4124BC433C1;
        Tue, 29 Nov 2022 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669748526;
        bh=76rMPn3p1fYb/OlmUR+9LC3Aio6SHBw/oxeOcaAWk9w=;
        h=From:To:Cc:Subject:Date:From;
        b=KsKrOrONiEvlBlKvrXEX0OiVBSQotOXCPTrbKjOJbp/7GWjnAYrOgYffiJ2aEIY+i
         Tovr9GCVJ2wAVvUR8bCLWC8UxRb+hHm6wAJsXKOuTnsmDtDVQIdaC/Az60aSgN4JWt
         IWBseyS/WVHS6nJ9Lugdg52Iv8bQKgXnGPfO7GiqDR7u0DEDN4/ZtADZ0lxF77qTgL
         3IJ1jie/n/iRcwcd01gIRCcjTW1BI7h/c431CXz0Kl/fmnqxzxnHCtSH5stwKVFoqH
         hFkye6zaTnM73DBTWqD78knjzqIY93eSq+VU9Ve/dJOs6g+3HvZ2ej7MtqfRiT3FGr
         6/C0P/ac9EXyw==
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
Subject: [PATCH 0/2] Fix lack of section mismatch warnings with LTO
Date:   Tue, 29 Nov 2022 12:01:21 -0700
Message-Id: <20221129190123.872394-1-nathan@kernel.org>
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

Nathan Chancellor (2):
  padata: Do not mark padata_mt_helper() as __init
  modpost: Include '.text.*' in TEXT_SECTIONS

 kernel/padata.c       | 4 ++--
 scripts/mod/modpost.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
-- 
2.38.1


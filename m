Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A193470AEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjEUQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjEUQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C43E4D;
        Sun, 21 May 2023 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D172B60FAD;
        Sun, 21 May 2023 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015A6C433D2;
        Sun, 21 May 2023 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685143;
        bh=UCxWVP1nuNc6iMk2c0zIdYZdTpbk+vNBDxDtYz2nqM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZxcDvhQWtgvKJnXTh0+9V9aHQpoBj+bUPS1D6Ckb3zGeMTReJZWF6EzEgQLFKnx6
         zzy+3ZWD0NtVMA+yJ1127F4fsAHl60c3NSv9BBfnvxPp7uQCURR5J2D2wr63F1gcoj
         ZFY7KYrjvmPe+XY43ST8t1KaXQHViBHxL974y9MQrxycihpSnDBtmo0I9QXTGOCqGP
         H7kbCfbjiSbTZ4/y0HulrxH2AgBE6maO1efS/dvFJnhHmsyuaXufsw1Nyd8M0qndfh
         k6HS6NnyFSB24AzYa/WG5kSgVnXg05ZLHTmFrZctP4iDO7DJ8LJOWLAbxH52wyAfWm
         LrWfTOW9M8VBw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 16/20] modpost: merge fromsec=DATA_SECTIONS entries in sectioncheck table
Date:   Mon, 22 May 2023 01:04:21 +0900
Message-Id: <20230521160426.1881124-17-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

You can merge these entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 516323c3910a..aea9d6cd243d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -884,12 +884,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_XXXINIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_INIT,
-},
-{
-	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { INIT_SECTIONS, NULL },
+	.bad_tosec = { ALL_XXXINIT_SECTIONS, INIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
 },
 {
-- 
2.39.2


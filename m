Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2B74F387
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGKPcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjGKPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:32:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2622133;
        Tue, 11 Jul 2023 08:32:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A543A22720;
        Tue, 11 Jul 2023 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689089538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bKfTtR4G4uL3jrD0uMXyxOPPr/sjYNuuin+JWTwmPg=;
        b=BcViP28ng5AYLIME7gvHNS5/ogh7wFI459TtyV7omXPjXYuwWZcyRJw50lbrvfzPzWdldg
        +NpUVFxIL4Nydq1mF+uCarQNYuqHKEctbulwARkCRi20rNi98nqnSQnVuiStnPKSF9DRvj
        6Y6TkkCV+pM7g1aRff87nWZcmGCA4b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689089538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bKfTtR4G4uL3jrD0uMXyxOPPr/sjYNuuin+JWTwmPg=;
        b=Uve+0m0Km99uOVm0ihyy4TbQkThEjpOH63RkxhdK5LjbdRl17P3QvYS9+k5YGaV12KlVXZ
        SCDJO/tSdohPLkBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 5C3532C143;
        Tue, 11 Jul 2023 15:32:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] man/depmod.d: Fix incorrect /usr/lib search path
Date:   Tue, 11 Jul 2023 17:31:16 +0200
Message-ID: <20230711153126.28876-2-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711153126.28876-1-msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

depmod searches /lib/depmod.d but the man page says /usr/lib/depmod.d is
reached. Aling the documentation with the code.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 man/depmod.d.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 76548e92a312..8d3d821cddc8 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -39,7 +39,7 @@
   </refnamediv>
 
   <refsynopsisdiv>
-    <para><filename>/usr/lib/depmod.d/*.conf</filename></para>
+    <para><filename>/lib/depmod.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
-- 
2.41.0


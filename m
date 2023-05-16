Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC77052E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEPPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjEPPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:53:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F4A267
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:52:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba712bb7b28so6137977276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684252351; x=1686844351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6959WuN0ggHKCECWtqI1BFMO1qmHtgjDwlimxMzTHg=;
        b=hrYser6vcVlAqu4Ki4SCD5Ny0G6dBQQyr8PpMTlpqbW3AW64W7d5bITlkJC/QZ0gT0
         Em+7kNX27BVHQcbxtS92h7IjKlfrddkdkQRRPpDcqmGxYGIIrXGm1KYt9/0J9Qir3c2u
         4MOLK0/WdurBKlYGQ1TXFZyznm7X/GdFhbQ1HPHVvPY/qibE9TeqLfKE4KhBL76FPoqH
         WjhbGGwklSWQpji3N3Vp5G+G2zQK9XCm28/SyMrO6pYJgeqdSuiD7Ps4pZEKe4nSQwPV
         ipHCgYVsmABBBCy1B7TLBVqnUoBuLEFBJ6acYWeO/Ro1pVaoKonJYoTUWoWPsAUy/fSh
         GrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684252351; x=1686844351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6959WuN0ggHKCECWtqI1BFMO1qmHtgjDwlimxMzTHg=;
        b=ZzMHAr81EeuYNKxXHb3Goez+4dID2xXaXbbQN11MRfUCT2yNesjlhDCMpT0+1noRq5
         JFLDaiiwSA7IHZT3Z/hOYwuR1AfxXp5o+zAW+wN4ZSJFdu5f9WENcBn5cNrxZ3NnSqhq
         9g7phEz8NVOnyoMhjTDxB5E7oIFUcFuS+7893sRdO7ZjV3qbLLSgM0aPIWzIdBX/94Lz
         c9lEb4Xnvku7rlxVLAwiRU0v5Z2fBTs9RpfKlbIj5U4IayqxtmR0a4qk3rNrAUiwyonf
         eU6+aIt8TV/AfEqaows/OM08LVlRi+E4b3X+fAq/eInpQUrVfhZN3omPfZ+id3/N7Wdk
         9DLw==
X-Gm-Message-State: AC+VfDwm7mHF84BTvdCZ29P/mATzwBO6K2JyUGPgneTYzIBm4hP878Lh
        W0jbPN9NgQSETbTj/nw9g4wh47BxBuGZ
X-Google-Smtp-Source: ACHHUZ5wRQjaqw8cqfARlXujudnrU75C30J83jSnrSCni9eViGX3lx4vJIlLbZk5U0I5+daIXjUOreMSvnSK
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:ee0f:923a:540e:3300])
 (user=jwylder job=sendgmr) by 2002:a81:78ce:0:b0:55d:9e7c:72c0 with SMTP id
 t197-20020a8178ce000000b0055d9e7c72c0mr25418769ywc.0.1684252351542; Tue, 16
 May 2023 08:52:31 -0700 (PDT)
Date:   Tue, 16 May 2023 10:52:23 -0500
In-Reply-To: <ZGJI2zU/bxDPxLAh@finisterre.sirena.org.uk>
Mime-Version: 1.0
References: <ZGJI2zU/bxDPxLAh@finisterre.sirena.org.uk>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516155223.2070731-1-jwylder@google.com>
Subject: [PATCH] regmap: Account for register length when chunking
From:   Jim Wylder <jwylder@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Jim Wylder <jwylder@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when regmap_raw_write() splits the data, it uses the
max_raw_write value defined for the bus.  For any bus that includes
the target register address in the max_raw_write value, the chunked
transmission will always exceed the maximum transmission length.
To avoid this problem, subtract the length of the register from the
maximum transmission.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index db7851f0e3b8c..1d1496c253ca6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2083,14 +2083,15 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
 	int ret, i;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes;
 
 	if (!val_count)
 		return -EINVAL;
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;

base-commit: ad2fd53a7870a395b8564697bef6c329d017c6c9
-- 
2.40.1.606.ga4b1b128d6-goog


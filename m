Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAF728413
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjFHPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjFHPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:46:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB630D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:45:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b28fc460bcso518041a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686239096; x=1688831096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxAq7z+oPBcRliwq8X8cOVzLHZJjYZDmvyPWxCW1HZA=;
        b=jg3GbXZgcvCu6UkfsGNYuuKUA/EjbWEwXtm/pJ82eGLGZ1iYBotW6rvmyvksZodaU/
         OnErQhHnAaLfL1XfrSnwIdeQ1YsgkUhGnNKiTJeKLHs+//RZeKMfHRUmV7wS9oOBJaaZ
         Xq862PpcNvuI9ht1km2B9ufhOXJ9CqFrss7XX2CNzHMYyIbPOoH2++DFtaiZJ2q/Wo1c
         YkxbUYAkmfYGjnCmIwLoThGEXfPkWmZXt60SIq4lfDArMTLWxgTwJ0ONu47P2ZXuBSbi
         Go41Ssi2CLIbu0PJPeCnX15u+ZRVuvLcTht5+MfXlIvEEl5eHkJllb0lT8gwXOUDwZJE
         /Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239096; x=1688831096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxAq7z+oPBcRliwq8X8cOVzLHZJjYZDmvyPWxCW1HZA=;
        b=L7262mDvRZWUzPiN3eNcEcKvN69NFGbXUg/R5NQrVXMqR6YRA2YIqjNiM/jcIvbJP4
         nHqroLBDpY4mCWzpV0Q8Vvk3zvQBwYwFjb50ieJl6FXxEpmzfRYFHOk+k9qLBQUYrYRx
         UHUlARXh0ecozZJM0/Vruf3voJi84KXFUD419SD6sPK7iu9HNDoz3mhmybMJP46Z+xLF
         Eaq9SYSoVnSYDY51zVreK6ufIX8/liUNqrc7sOtpFOM+1QZL0HAaM4YprM5sNpCVlgOR
         VJtPAI3Ub56H3uFsdlFIwrm9oKyfc/X3DCyNnKrGqsTsEmYAIMZ08cEDtqZ50qQHyWlB
         6j5g==
X-Gm-Message-State: AC+VfDyvNi1vrM1gYVOvhc9Fv2xt19c6TX+TB7FEcXbq/1SNMGEOkZuA
        jMglqfVi9WIaxnSkH9Iksyw=
X-Google-Smtp-Source: ACHHUZ76oxl9RuTZPRyAdkFKxzFM0gxTSl/SsFHwS0hwo0pY5QftEWlrUWOnCMafmmVqyIVepFX2WQ==
X-Received: by 2002:a05:6358:bba5:b0:129:be5b:fff with SMTP id df37-20020a056358bba500b00129be5b0fffmr7357082rwb.9.1686239096378;
        Thu, 08 Jun 2023 08:44:56 -0700 (PDT)
Received: from redkillpc.. ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id y185-20020a6364c2000000b0053f2037d639sm1403130pgb.81.2023.06.08.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:44:55 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     akpm@linux-foundation.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu
Subject: [PATCH] scripts: fix the gfp flags header path in gfp-translate
Date:   Thu,  8 Jun 2023 21:14:49 +0530
Message-Id: <20230608154450.21758-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since gfp flags have been shifted to gfp_types.h so update the path in
the gfp-translate script.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 scripts/gfp-translate | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index b2ce416d944b..6c9aed17cf56 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -63,11 +63,11 @@ fi
 
 # Extract GFP flags from the kernel source
 TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp.h
+grep -q ___GFP $SOURCE/include/linux/gfp_types.h
 if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
+	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
 else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
+	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
 fi
 
 # Parse the flags

base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
-- 
2.34.1


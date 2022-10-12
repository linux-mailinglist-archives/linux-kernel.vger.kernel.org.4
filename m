Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540CB5FCA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJLRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJLRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:46:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2FFC1FC;
        Wed, 12 Oct 2022 10:46:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r17so39544626eja.7;
        Wed, 12 Oct 2022 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPmXPudUvAAgxzesevvcQguQuLGlpjd/EyDpnAZuAtc=;
        b=qSNRcaQDGBvNiR2LPQyouzsn4X6roBIYCl9DBh6VFflM0wtkJRPGhQ0S+txPZ1MJdB
         VrPGBXi2kVCdr9n0LSdNangU6BKVmfsLi/jgFrPxphT/53o042LyBLYk1kK1Fh5EbCj+
         MqTcXUwcwXUX/a35figDmXFA/m1CF2W7iSRwi+k0OwhP8tJXHy3wksuIYqEJPaDbpGk4
         JRVLIEfsqDNujz0k1+ct+vR6dvdHuN5I9x47rtpq7qVnzPrfmxE7azSiSeAgSnt0w/Iq
         PO6L0DaiY+hC1HqV8grvDyDTdGTKlSKLowczuXHqS0XYQNBZMh5r5zQxHASrT3wFUHt7
         OBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPmXPudUvAAgxzesevvcQguQuLGlpjd/EyDpnAZuAtc=;
        b=Mty6QBfw7Knxa0v11E5/IOqbKArbkXtZZpxBug48slr88OPV2IsDrvr5RjcJplnorE
         eajO78eHj4q6VP+Hgr7KdAfQdajcV6TOm0QYhANdNMyJO7gh+DZjZS+KDszzcW34WcXU
         xzwE0F+ec/BO9tmdne3yR+ufCyTdyEvB4Di35//+cek1EcRcX7jsMMrrstVDjLVa/xCj
         czNiJ/Ir2X8ur908NUfxjrBMiiYfRFvhwOnbHwGvnldtnbZW6ANjIQoyglOTWZWQ8axU
         rjBncAK05CSDcLVzi/Lit5bWEXXSV1e+UH4RDXOCfw8YM5f+h8VteN7a1YkRbJ0jCwTz
         VdpA==
X-Gm-Message-State: ACrzQf0UjuocKFCzCDX4PH4hZhHXuALUYt5PzPocRVyCiiRxEysY4xPX
        rgmj2TBA+rdb0lzlVHVypPM=
X-Google-Smtp-Source: AMsMyM4wxBrlbSBVQUiR2EiAp/azvfgT7mC0zxfYBjdc8NtTQjM4JRdZsLS1hv9ppmwpVuzyQLFVag==
X-Received: by 2002:a17:907:3f13:b0:782:1266:8c10 with SMTP id hq19-20020a1709073f1300b0078212668c10mr23480980ejc.197.1665596793067;
        Wed, 12 Oct 2022 10:46:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-029-094.78.50.pool.telefonica.de. [78.50.29.94])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b00731582babcasm1613824eje.71.2022.10.12.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:46:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] of: declare string literals const
Date:   Wed, 12 Oct 2022 19:46:22 +0200
Message-Id: <20221012174622.45006-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_overlay_action_name() returns a string literal from a function local
array.  Modifying string literals is undefined behavior which usage of
const pointer can avoid.  of_overlay_action_name() is currently only
used once in overlay_notify() to print the returned value.

While on it declare the data array const as well.

Reported by Clang:

    In file included from arch/x86/kernel/asm-offsets.c:22:
    In file included from arch/x86/kernel/../kvm/vmx/vmx.h:5:
    In file included from ./include/linux/kvm_host.h:19:
    In file included from ./include/linux/msi.h:23:
    In file included from ./arch/x86/include/asm/msi.h:5:
    In file included from ./arch/x86/include/asm/irqdomain.h:5:
    In file included from ./include/linux/irqdomain.h:35:
    ./include/linux/of.h:1555:3: error: initializing 'char *' with an expression of type 'const char[5]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    "init",
                    ^~~~~~
    ./include/linux/of.h:1556:3: error: initializing 'char *' with an expression of type 'const char[10]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    "pre-apply",
                    ^~~~~~~~~~~
    ./include/linux/of.h:1557:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    "post-apply",
                    ^~~~~~~~~~~~
    ./include/linux/of.h:1558:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    "pre-remove",
                    ^~~~~~~~~~~~
    ./include/linux/of.h:1559:3: error: initializing 'char *' with an expression of type 'const char[12]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                    "post-remove",
                    ^~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/of.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6b79ef9a6541..8b9f94386dc3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1549,9 +1549,9 @@ enum of_overlay_notify_action {
 	OF_OVERLAY_POST_REMOVE,
 };
 
-static inline char *of_overlay_action_name(enum of_overlay_notify_action action)
+static inline const char *of_overlay_action_name(enum of_overlay_notify_action action)
 {
-	static char *of_overlay_action_name[] = {
+	static const char *const of_overlay_action_name[] = {
 		"init",
 		"pre-apply",
 		"post-apply",
-- 
2.37.2


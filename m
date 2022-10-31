Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA037613306
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJaJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJaJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:48:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7BD57;
        Mon, 31 Oct 2022 02:48:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y14so27954715ejd.9;
        Mon, 31 Oct 2022 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNeKrNum9y97/rCawM0h98cZgfeEAleqAKTBDI1MMmM=;
        b=Dw1Izh+o2/URx8C0/oLkEu069SDT2tF8CA4v7iXI4QHpL7nK6nMKysb6F0KoMScPKb
         /Cy6qYyvNtDeU5Ob36bQo32tMn6Ghzt/aFsbcsRZLoJrOede5VEkJPVgO5dqv88yrZNX
         9AB5zem8aoH8BpFnkIhs92/nE5C5k98702pAVcvMbxgcv4/GPe5FKWQAHlebWPX8v1t8
         LHd809e0YCFyfkNW4GlYEQ4+cavTn7gn5c8E8VF+fAKLo1ua1qIdZWwS5f0KNsUlGZyr
         5bjBaA4ma/8o6yb5DugfMLkihMIuq5zp4R/4DMTrZtTqWnqqK/BL2MW9B3yeaAShTlFJ
         Sh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNeKrNum9y97/rCawM0h98cZgfeEAleqAKTBDI1MMmM=;
        b=AgmYQTTV1GdCefh5fj9YBxUCMAKSHVXCAhTaN3BWmRH/uAAxGO6aILc8AZbtY6E/cf
         wTwCdWYt1Y1xmIxtLQTh6ZmFawYAvH7M9zgIw7TdrLdvsBQpAZLzHGFykbXy/eWqxEGs
         xmzrYA/ij534Pe8a0axthjFDetyadRd2CYqpTfV1aLlzeLY9oKcgSfAMf8S3M8NnS0BP
         J9vrAwUCNEPbDoOsVoJ5arBAHjbj9RWb3attR4YYW09THcn2oPZ4a8NgEopkPZ/wKyE+
         oVriKoQhO53FB/MGpE8VqpfsP1uqKpiVXwxyeCUhA2H5dyGXDGi3S+ICNbFtPd9UR43C
         le2Q==
X-Gm-Message-State: ACrzQf3M9Jv5MoiBoDzTPlSdnnE8NhWRoj8d87nJRRXAFQlbOPT2Svrl
        eTUgm1dS+AZSFdJzjk8XcAA=
X-Google-Smtp-Source: AMsMyM4wuFBKcYhvJf2ewm5Xr/R+f8Ue1TAWuZEdTGBSUfZ+2yPyMqePB+cx93e0R1Cf4TAgloxPkQ==
X-Received: by 2002:a17:907:783:b0:76e:f290:8b5 with SMTP id xd3-20020a170907078300b0076ef29008b5mr12207953ejb.395.1667209731578;
        Mon, 31 Oct 2022 02:48:51 -0700 (PDT)
Received: from felia.fritz.box (200116b826c494005d8b6b3bdc900ff8.dip.versatel-1u1.de. [2001:16b8:26c4:9400:5d8b:6b3b:dc90:ff8])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0078db5bddd9csm2765646eje.22.2022.10.31.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:48:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/boot: repair kernel-doc for boot_kstrtoul()
Date:   Mon, 31 Oct 2022 10:48:35 +0100
Message-Id: <20221031094835.15923-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5fafbebc86a0 ("x86/boot: Add kstrtoul() from lib/") temporarily adds
a copy of kstrtoul() to arch/x86/boot/string.c. While massaging the
provided patch, Borislav renames the kstrtoul() to boot_kstrtoul(), but
misses to adjust the corresponding kernel-doc comment.

Adjust the kernel-doc comment for boot_kstrtoul() for make W=1 happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Boris, please pick this quick kernel-doc cleanup patch. Thanks.

 arch/x86/boot/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8a3fff9128bb..1c8541ae3b3a 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -350,7 +350,7 @@ static int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
 }
 
 /**
- * kstrtoul - convert a string to an unsigned long
+ * boot_kstrtoul - convert a string to an unsigned long
  * @s: The start of the string. The string must be null-terminated, and may also
  *  include a single newline before its terminating null. The first character
  *  may also be a plus sign, but not a minus sign.
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A708B651E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLTKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiLTKNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:13:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307B6333
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:13:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fy4so11978595pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKWuiWJK1VUk2sx6mP2owWmQ2TcPLqUMaM1CIaK+WNw=;
        b=nLDU6NbS02qEIso3O1llT91Th+xwxyVdcHH2xvwS0nKtaCIC3aKIRU0gvRLlHrwcrp
         rQWK1qO4+yi4InODdFkoT4N2zxGnR5jB3KqWNMAuR5lAySOK2i0kF0aoRDMZx2U0n3u9
         c280ebDXDKhr5j4NquUcsv9m8DITxInf2uHg7fLm+J43GDizKZ/osz7IPEe6uzAPldkA
         z6ggB8hlDUFI/eQQ9kSLBLe/HMv6aD93gam8WZ0q3gtGMWD3RB879WYaztX4lBh29MJD
         yCcbjDPvshDsw+kAWLY8jZDXJDX10jtecZKycQAL/0gBEfEnuxF0pxr/2qflwMm8LPSY
         cH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKWuiWJK1VUk2sx6mP2owWmQ2TcPLqUMaM1CIaK+WNw=;
        b=XMznAIMYu49bkKNQShAebQcTl6094GMqKCisAX7KjBZFvw0F5Q8y5jCM4mm9NCmkSE
         7TZ2zH2HGBvsoBMxWQAJ6bxNe3523johlNdRDaJTI9/YDZ/bVfOgGOiH2+xnjVWUzlqb
         y0X97gJJtUVsmfmb7lgh2Sx8pYIgsm8ySqkIDYC+aNHtIUGY1BQZaRxeqTG3PYG7GHdf
         V5aAvJtbsaZXp0VNONKdCiFHwROT7Bf3GgyiWX6oJ2hn2Y6NdYzhdmo94C4i6V3bEGA9
         HGJhVKLxzMgryou+bKkTTeI22olV06mdAJbifg1EORIFzV4k5LpWzOZEYj+jN31n4qbq
         na/A==
X-Gm-Message-State: ANoB5pn9P3sIKEpV6PCY5XOYpmxy9YOq7KPBsZUedsgicecfnbKwZy13
        P36FtTn05eXKmjq7CONjzWo=
X-Google-Smtp-Source: AA0mqf7Np0s/2XeR23VVVqkPaORBn/PV5YYEGpKvssPmLDbdOtBhOfylLp1que/1ewEJPRQ5FWJ28Q==
X-Received: by 2002:a17:90a:6be6:b0:219:34cb:476c with SMTP id w93-20020a17090a6be600b0021934cb476cmr48632133pjj.9.1671531217733;
        Tue, 20 Dec 2022 02:13:37 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (203-219-149-28.tpgi.com.au. [203.219.149.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a694300b002190eabb890sm10766225pjm.25.2022.12.20.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:13:37 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tools/objtool: tolerate STT_NOTYPE symbols at end of section
Date:   Tue, 20 Dec 2022 20:13:23 +1000
Message-Id: <20221220101323.3119939-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hand-written asm often contains non-function symbols in executable
sections. _end symbols for finding the size of instruction blocks
for runtime processing is one such usage.

optprobe_template_end is one example that causes the warning:

  objtool: optprobe_template_end(): can't find starting instruction

This is because the symbol happens to be at the end of the file (and
therefore end of a section in the object file).

So ignore end-of-section STT_NOTYPE symbols instead of bailing out
because an instruction can't be found. While we're here, add a more
descriptive warning for STT_FUNC symbols found at the end of a
section.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/objtool/check.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be739f4f..4b7c8b33069e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -427,6 +427,15 @@ static int decode_instructions(struct objtool_file *file)
 			if (func->type != STT_NOTYPE && func->type != STT_FUNC)
 				continue;
 
+			if (func->offset == sec->sh.sh_size) {
+				/* Heuristic: likely an "end" symbol */
+				if (func->type == STT_NOTYPE)
+					continue;
+				WARN("%s(): STT_FUNC at end of section",
+				     func->name);
+				return -1;
+			}
+
 			if (func->return_thunk || func->alias != func)
 				continue;
 
-- 
2.37.2


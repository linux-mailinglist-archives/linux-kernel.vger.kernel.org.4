Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C356673C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjALN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjALN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:57:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7D48CEE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:57:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z11so26974106ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lAIJYoaT0aDl15YG3H1eMEMaYgD5WX/ORv2kxg7sdSw=;
        b=EiNxkia7GsR7QRi+Wd0ov/5Z9F8SvDTbRlXeI6n9fpTjMSpvusaGH4Z4ikneokmx4h
         9AJ/lD2QQLqk3AESNWWmx+vNX7X/y05xXDryrVyuG/HU71zp+ccBgmFKuDihdgeBVqP/
         kR62ZcBcE5lSXNtiPJ7LfXnvvPj4EG7NEqZpi1nS6oagEmzgXGl6kUHwLD5ACMjmiTWU
         BSq4VVG4h5ygcq+GmvRodqbWAqsXrxbAiuUBkolrYF3ws4IEgtuIU5jeeV/GNyWbnnm6
         de2mLw3xAv2wsf/O+3v+M2SHlwpj9z43Jf3vPzbqQm1lNbwE0Et37+K6goUknfrmXSEl
         RqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAIJYoaT0aDl15YG3H1eMEMaYgD5WX/ORv2kxg7sdSw=;
        b=nlbq8Do2R8Zg2sIKacWTs0rznv5geoBAqUIO/Z0FYpA4dr/2wpkWKbetD3cvjpQe6Y
         zDL6uZlPenoJ+WYwQZA6wNlggKZ4HOVgl08zHQrCPHci4J421mnt8sHExFCeG8DYyxy+
         HnbPNVVXD5tV6+NfXxdTVo7+ZYwt2CnVQvKtPT1aCf8oLMmPQL0Sqj77msRfE0wDdQ0v
         3wf1wGb+H3lAF1i6twlQpHAJQtKL4h9JHxkP5pSyQv4FH3CZYcczZDX5jdrg6UCyqCVT
         QbaJuI707t6yGnOf57LA4NkI0b2jZAuBwnZDCS6x+lWBv06qA1dDNDlsX4QjN4ZQOX+a
         AEXA==
X-Gm-Message-State: AFqh2ko/dPut43OnEfdi8ypHLlaTRu73gbLzfvidohB0Ovp+P7PxNysx
        baBjn9rX2T8JC1YAW/N3zOU=
X-Google-Smtp-Source: AMrXdXuPxZIkHJlRSR9HstBwA4XcVbGgOYYr+EwZ2ZqIgVCpXdqtj0yBeB9GCZNF7/IP3XpkNgaxLQ==
X-Received: by 2002:a05:6402:685:b0:479:ab7d:1dad with SMTP id f5-20020a056402068500b00479ab7d1dadmr81650699edy.32.1673531841776;
        Thu, 12 Jan 2023 05:57:21 -0800 (PST)
Received: from gmail.com ([31.46.242.235])
        by smtp.gmail.com with ESMTPSA id lb11-20020a170907784b00b007b935641971sm7346874ejc.5.2023.01.12.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:57:21 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Jan 2023 14:57:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fix
Message-ID: <Y8ARvWVv5gXT88Ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-01-12

   # HEAD: cad90e5381d840cf2296aaac9b3eff71a30b7c5b objtool: Tolerate STT_NOTYPE symbols at end of section

- Fix objtool to be more permissive with hand-written assembly
  that uses non-function symbols in executable sections.

 Thanks,

	Ingo

------------------>
Nicholas Piggin (1):
      objtool: Tolerate STT_NOTYPE symbols at end of section


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
 

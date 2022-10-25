Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AF60D56A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiJYUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiJYUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:18:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F699D6B9D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:18:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso4876217pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C7CkfUfWzwXgtTSIoah0XnkQ0qFYc1jCCWhpHDWDR/w=;
        b=fJTsmos5rey7JYMoKY6ndFZ4d6icJ82KMqv/nHDL04N6WZkkkMtVyQQ1nqF0Y0KtUH
         OfISz2ZVCDmkeGuYQVLesYBbEDIWR5JRL6NrcGUZkIZQpqDWZwDfON/75kyD/V2UU39Z
         t30JBhaaeGTXXf92GzykGiILyMOVl+eFiBMbOZObKdlDwhl5cmrAPv3agCtXNF8Qd1w5
         s7zVfdQ1sV8EMuKTHonj2b3YRWqJdyV87VQ7aMYGrzsb15Rrc37qg92PcxIbOcfbZOfW
         iGodEWSW391ayu/mPqRU18EFXQyWnbHBJnOiXk0IkkcF8Sz+FDJKjzWR05UFg1cnwbLX
         n17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7CkfUfWzwXgtTSIoah0XnkQ0qFYc1jCCWhpHDWDR/w=;
        b=e7G8+fgfcDDM6OrA1KoL63CwdwjkHAmWBNyyijuj+l4TYjk/iLnrD0n1VL6axuJOga
         zu5nV3G3f6jRH7kfY52vxerHHZS/WRdju4kNgXwrRp1gaV+glYwQTPvWV9P7UN4xSV5Y
         IHP9Xi2JYojpoN+dU4CqxfSgvwX34k/to/0q9oCYeRkpRk0+XxBX1EOaZDCD6LZEXNgw
         ydv/tpvsfgTxWAMdqKqzGtyYste5DWRl4HMmG2alKFi4S61mal1g8gwgjN8mG8pZiuQs
         lTsf3YBS4j561GmUqIAEh8Iw5kR47CtqeIi4jVk4fRnffPk23l0RHD8WYu85f6U94GlR
         aYkA==
X-Gm-Message-State: ACrzQf05ZfqcdcjSCDY/DqOkgHsZYLEIjW1b7fhiHggEgr2S6a5mM9cs
        n8BlTBZdgKer4puXOKviUt9NGqxjkuh+agUXIfk=
X-Google-Smtp-Source: AMsMyM5gXj+rNt9GYNmjhHqxrpnXLvG7Pt3sQ6ETQMq57QUvneQuGAvf1bWado5LSH5olUhXQ0TZBgxb1sQAOHrRrz0=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:acb:b0:555:ac02:433e with
 SMTP id c11-20020a056a000acb00b00555ac02433emr40750199pfl.3.1666729086159;
 Tue, 25 Oct 2022 13:18:06 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:17:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025201744.1155260-1-willmcvicker@google.com>
Subject: [PATCH v1] kbuild: Use '-f' instead of '--file=' for grep
From:   Will McVicker <willmcvicker@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel-team@android.com, Will McVicker <willmcvicker@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The posix grep utility doesn't support the longer '--file=pattern_file'
command line option which was introduced in commit ce697ccee1a8
("kbuild: remove head-y syntax"). Let's update Makefile to use '-f
pattern_file' to fix the compiling error:

  grep: Unknown option 'file=.../scripts/head-object-list.txt'
  (see "grep --help")

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

base-commit: 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2

diff --git a/Makefile b/Makefile
index d148a55bfd0f..e90bb2b38607 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
       cmd_ar_vmlinux.a = \
 	rm -f $@; \
 	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
+	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
 
 targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
-- 
2.38.0.135.g90850a2211-goog


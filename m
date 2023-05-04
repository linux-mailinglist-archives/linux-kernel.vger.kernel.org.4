Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F956F7707
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjEDUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEDUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC18D191F0;
        Thu,  4 May 2023 13:20:07 -0700 (PDT)
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683231556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HkQjc5wVMwVPD7qdVQEk0MlwuGYuZQZtagfPw3Kt3do=;
        b=WME3DxYUebEUIQnulIxv2YEXLiGkETWvsiMWWqvSeSi8PCoqtFoNe6vkBEDfcOoSYn8zqi
        InfBO6obsPRc8TP8qB310X8XjNRjX1pp097Jrwt+fvUdc3+yrQyk6rUHC1b1fGeA8lyb7l
        3M79PiYaXJNWb4+LznAiBvkcLIqmeSrMbT6aOPtRq3GTu5LQclHbVqyh+ffAdOmLvS72l5
        axcVhI/OwZz7WqAWEAVlXBloDsnHNyn/oTlBoPoi6wOejrVTNRM4PkJBOvUjPRPJ1c/N6W
        SCD4h4VOGcOoYqXLO+GVW2ONxKhtEF/emBVMG1xcwOm5AxN5GTjk1p9e9MTV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683231556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HkQjc5wVMwVPD7qdVQEk0MlwuGYuZQZtagfPw3Kt3do=;
        b=Zhr/yCNnLnaEqp90nedCZKGE0I//dlC0/hGhg7xmzPbapXMHOYsos1cgWmuFeq6js9OrV2
        AJBRvF9JL9sb+qAw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 0/1] scripts: Fix "make gtags" for O= kernel builds
Date:   Thu,  4 May 2023 22:18:32 +0200
Message-Id: <20230504201833.202494-1-darwi@linutronix.de>
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

Hi,

make gtags for O= kernel builds is currently broken. For example, when doing:

   make O=../build/ x86_64_defconfig
   make O=../build/ gtags

gtags generates a warning for each kernel source file to be indexed:

   make[1]: Entering directory '/home/darwi/build'
     GEN     gtags
   Warning: '/home/darwi/linux/arch/x86/include/asm/qspinlock.h' is out of source tree. ignored.
   Warning: '/home/darwi/linux/arch/x86/include/asm/hpet.h' is out of source tree. ignored.
   ...
   Warning: '/home/darwi/linux/virt/lib/irqbypass.c' is out of source tree. ignored.
   make[1]: Leaving directory '/home/darwi/build/'

and then generates an empty index:

   $ du -hs ~/build/G*
   16K	/home/darwi/build/GPATH
   16K	/home/darwi/build/GRTAGS
   16K	/home/darwi/build/GTAGS

This series includes a proposed fix. After applying it:

   $ make O=../build/ gtags
   make[1]: Entering directory '/home/darwi/build'
     GEN     gtags
   make[1]: Leaving directory '/home/darwi/build'

   $ du -hs ~/build/G*
   9.1M	/home/darwi/build/GPATH
   506M	/home/darwi/build/GRTAGS
   696M	/home/darwi/build/GTAGS

The generated files can then be integrated with editors or IDEs as
usual.

Thanks,

=>

Ahmed S. Darwish (1):
  scripts/tags.sh: Fix gtags generation for O= kernel builds

 scripts/tags.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

base-commit: 1a5304fecee523060f26e2778d9d8e33c0562df3
--
2.30.2

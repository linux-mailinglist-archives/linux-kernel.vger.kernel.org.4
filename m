Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F65FAB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJKD72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:59:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEF7FE48
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:59:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so14831499pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BzF3pkNEv1+03fuosxVKj67lIfjQVhGyuOEn4DRET40=;
        b=G1tO9KsumdDARN2GSofintmNCiAX4vPFr2kloIGNBOsTddcjVgzhjvaapqHEfhoMvp
         W+ClxtcFWMNC+zYq7WH0c5F6VeHtKG6hqpZqdgDUj6IHEPo8m+L5F4uPGkc31S1VLEqx
         MXI2+foBj4FEIMYUF6sVjw1XseVLtuSEgQUZxZIKlydJq0Z8OHG+c76a3HOj24kI6OO3
         LPKwQ4KFwpcjBbUHA7kJNTvoc5gXPox5Rn16XAobJLLfGx48SB+p75TLxXi+HPgn19mM
         ZksrrQdDIVNJsPZqbguNO5wsh2X9nk4MFB+5CtepgrQuTXpqefazxl9WctP03nPQlmNp
         DXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzF3pkNEv1+03fuosxVKj67lIfjQVhGyuOEn4DRET40=;
        b=FU2d8ZEF1HHo31W+0o2WwWRxBNj85NApesaTJQGDvlaocjoeEGkZzUDc8faP5iBBfh
         Xap/QGUgMn2DTq7Y4wQzf4QzPtK0JRXYKJdXtdnhf3g+dRoc6RqU3m4Vtc8sLxoEjqR/
         rpJLENOytOHsKoq9ZUqlSbiEZMLV+JocSsJ6QCRFfyB1Oe0j7Huaqp86ld1TLHJcZU8e
         TExKxEqio+dLyxZ9PKJCQgY/dDEe435s1nqDR+gpDRT2q0gKnklp/uO60/WSni8BYFlx
         +zdUNZvDEV/U6dQGWTaYnBVk3RijIaK/1BSacq6mD7LuIJIUzy14C+bYoSgO1qr70I9i
         JKsg==
X-Gm-Message-State: ACrzQf0zBrJdGJPDGF7/CCrIcFAlyYoDJjxK8Ev3ShVkqfx8MS5qCITb
        vpWKvuc0T8ww3BleC+0u5x2S91aNFTs=
X-Google-Smtp-Source: AMsMyM5Beqm7XN5MRIm8zBrCT6j5n7TIr4ItXPsT1tlkZqqvcNkwD+YObJbMHZdfXJ/NMTjaJLM2Ew==
X-Received: by 2002:a17:90b:4a84:b0:20a:f497:6f5d with SMTP id lp4-20020a17090b4a8400b0020af4976f5dmr24122223pjb.213.1665460762286;
        Mon, 10 Oct 2022 20:59:22 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id w187-20020a6282c4000000b0053e42167a33sm7758244pfd.53.2022.10.10.20.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:59:21 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fix 85xx build
Date:   Tue, 11 Oct 2022 14:29:10 +1030
Message-Id: <20221011035910.39171-1-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The merge of the kbuild tree dropped the renaming of the FSL_BOOKE
kconfig option.

Fixes: 8afc66e8d43b ("Merge tag 'kbuild-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 68ea30fb373e..ee2d76cb3187 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -121,7 +121,7 @@ obj-$(CONFIG_PPC_BOOK3S_32)	+= head_book3s_32.o
 obj-$(CONFIG_40x)		+= head_40x.o
 obj-$(CONFIG_44x)		+= head_44x.o
 obj-$(CONFIG_PPC_8xx)		+= head_8xx.o
-obj-$(CONFIG_FSL_BOOKE)		+= head_85xx.o
+obj-$(CONFIG_PPC_85xx)		+= head_85xx.o
 extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
-- 
2.35.1


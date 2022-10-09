Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D35F8B8A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJINNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJINNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:13:46 -0400
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874927B30
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:13:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3D85621F5;
        Sun,  9 Oct 2022 15:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1665321220; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=gG3hMKGT5zMsFTXzJUA7f6NuykxZjEN3ciFuYY+hf48=;
        b=kCs8EbW8rZpAQN1OHbubUKTg/z45I7b1I96SHQOaGbjRpZCDuyyH3sYN71c95caRoyp2ip
        QCoKVUfVTJpd8k9k7KLcsVGLKBpd7K2XEWUOweAuswoWwfiphsV1tHn2edj/kQ121E52f0
        ysVAwYbZTJ21uydYkwPWyMvJjN66i5w9heoodpwM0cHzGFptkw0G8wAlIvzDBPm57jqX9K
        qRCHiXZGRY0eIZ2TTmx0CsXRe8z6ON/RdGBpHVGv+jH5yQGp+H8gqfcbO8S2aGl1UMaOBA
        z6R+g1EhiwWeIBhIXWsHnjWZ9x5ZYRSFCF+Un7FjNJ8vHQLDS57ZVnrwrDOA2Q==
Date:   Sun, 9 Oct 2022 15:13:27 +0200
From:   Cleo John <waterdev@galaxycrow.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: fix styling in ucontext header
Message-ID: <20221009131327.GA50929@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the two comments in ucontext.h by getting them up to
the coding style proposed by torvalds.

Signed-off-by: Cleo John <waterdev@galaxycrow.de>
---
In my opinion this also improves the readability so I think
this is a useful change to do.
Please also tell me if you have a different opinion.

Changes in v2:
 - change opening comments too

 arch/riscv/include/uapi/asm/ucontext.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
index 44eb993950e5..516bd0bb0da5 100644
--- a/arch/riscv/include/uapi/asm/ucontext.h
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -15,19 +15,23 @@ struct ucontext {
 	struct ucontext	 *uc_link;
 	stack_t		  uc_stack;
 	sigset_t	  uc_sigmask;
-	/* There's some padding here to allow sigset_t to be expanded in the
+	/*
+	 * There's some padding here to allow sigset_t to be expanded in the
 	 * future.  Though this is unlikely, other architectures put uc_sigmask
 	 * at the end of this structure and explicitly state it can be
-	 * expanded, so we didn't want to box ourselves in here. */
+	 * expanded, so we didn't want to box ourselves in here.
+	 */
 	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
-	/* We can't put uc_sigmask at the end of this structure because we need
+	/*
+	 * We can't put uc_sigmask at the end of this structure because we need
 	 * to be able to expand sigcontext in the future.  For example, the
 	 * vector ISA extension will almost certainly add ISA state.  We want
 	 * to ensure all user-visible ISA state can be saved and restored via a
 	 * ucontext, so we're putting this at the end in order to allow for
 	 * infinite extensibility.  Since we know this will be extended and we
 	 * assume sigset_t won't be extended an extreme amount, we're
-	 * prioritizing this. */
+	 * prioritizing this.
+	 */
 	struct sigcontext uc_mcontext;
 };
 
-- 
2.25.1


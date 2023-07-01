Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA68744BD7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGAX7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGAX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:59:28 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E925172C;
        Sat,  1 Jul 2023 16:59:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 644672014E;
        Sun,  2 Jul 2023 01:59:20 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dQ3o_j8e3W-Y; Sun,  2 Jul 2023 01:59:20 +0200 (CEST)
Received: from begin (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 7464E2014B;
        Sun,  2 Jul 2023 01:59:19 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qFkUp-003nYC-01;
        Sun, 02 Jul 2023 01:59:19 +0200
Date:   Sun, 2 Jul 2023 01:59:18 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        Kees Cook <keescook@chromium.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave@mielke.cc
Subject: [PATCH] TIOCSTI: always enable for CAP_SYS_ADMIN
Message-ID: <20230701235918.kwfathbdklkyrbde@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave@mielke.cc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") broke BRLTTY's
ability to simulate keypresses on the console, thus effectively breaking
braille keyboards of blind users.

This restores the TIOCSTI feature for CAP_SYS_ADMIN processes, which
BRLTTY is, thus fixing braille keyboards without re-opening the security
issue.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")

Index: linux-6.4/drivers/tty/tty_io.c
===================================================================
--- linux-6.4.orig/drivers/tty/tty_io.c
+++ linux-6.4/drivers/tty/tty_io.c
@@ -2276,7 +2276,7 @@ static int tiocsti(struct tty_struct *tt
 	char ch, mbz = 0;
 	struct tty_ldisc *ld;
 
-	if (!tty_legacy_tiocsti)
+	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
 		return -EIO;
 
 	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))

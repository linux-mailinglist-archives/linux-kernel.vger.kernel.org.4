Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575060090E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJQIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJQIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400593B5;
        Mon, 17 Oct 2022 01:47:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 08:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665996474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brmrf89Lx2rRV1luJ1gwH3jh8Ci8GhQebbeeW1wEE3o=;
        b=w7hpCpFEuAi35TemtvwsyYP7hCi77zJlQ1EwkthMky7Wp3u8fYRCpp1hPu2pnYZVj2x+dz
        ZStGSCFwdFsk9bj9WvTurSaIAVPdnrZu2wHmJGcpostRaJ3WvLhVqzg8JV/xK/8uWX6EdL
        cyMh06zsSD85FqaQs9jcYPn26mJhf0sng2tn4dSHDboKs+JU4np1pevN63uo8vj6uoKF9D
        Mx8G12j6Xn+kcMNgX0qdwu+wRJiTYsKwKFdpDhB3IJhltNGJsWAsWmLWmNhHXW+u6nusex
        RvbJLni5rjJVijx3RpAkk101Gk5wPwzT0HXA8iswElwKZMm84W0Kw6yEykebGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665996474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brmrf89Lx2rRV1luJ1gwH3jh8Ci8GhQebbeeW1wEE3o=;
        b=j/1qMFsjafLX73jczsctAJ6VMo8M0C+DZF7KCxE2v98qwxBbICSBxFrlTcoczUOjjhgLav
        W82gKmCFG/fpIsCA==
From:   "tip-bot2 for Ahmad Fatoum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] Documentation/x86/boot: Peserve type_of_loader=13 for barebox
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221002125752.3400831-1-a.fatoum@pengutronix.de>
References: <20221002125752.3400831-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Message-ID: <166599647272.401.15990841004146726447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f0a8dec99a55aee896a1e6739ecf737f4524094a
Gitweb:        https://git.kernel.org/tip/f0a8dec99a55aee896a1e6739ecf737f4524094a
Author:        Ahmad Fatoum <a.fatoum@pengutronix.de>
AuthorDate:    Sun, 02 Oct 2022 14:57:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 17 Oct 2022 10:11:09 +02:00

Documentation/x86/boot: Peserve type_of_loader=13 for barebox

barebox[1], a bootloader for mostly ARM and MIPS embedded systems, can
also be built as EFI payload for x86[2] to provide redundant power-fail
safe, watchdog-supervised boot up.

Since its v2015.09.0 release, it has been booting Linux on x86 with
type_of_loader=0xff[3]. Reserve 13, the next free id, so that can be
used instead in the future.

[1]: https://www.barebox.org/
[2]: https://www.barebox.org/doc/latest/boards/efi.html
[3]: https://elixir.bootlin.com/barebox/v2022.09.0/source/common/efi/payload/image.c#L217

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221002125752.3400831-1-a.fatoum@pengutronix.de
---
 Documentation/x86/boot.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 894a198..240d084 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -455,6 +455,7 @@ Protocol:	2.00+
 	11 Minimal Linux Bootloader
 	   <http://sebastian-plotz.blogspot.de>
 	12 OVMF UEFI virtualization stack
+	13 barebox
 	== =======================================
 
   Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.

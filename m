Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4126AB1A0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCERzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCERzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:55:02 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605BEB43;
        Sun,  5 Mar 2023 09:55:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 36F1E2014B;
        Sun,  5 Mar 2023 18:54:58 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qwdomEwogYZd; Sun,  5 Mar 2023 18:54:58 +0100 (CET)
Received: from begin (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id CD3CB20148;
        Sun,  5 Mar 2023 18:54:57 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pYsZV-009vau-1B;
        Sun, 05 Mar 2023 18:54:57 +0100
Date:   Sun, 5 Mar 2023 18:54:57 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
Message-ID: <20230305175457.kp6b5lmwwdxw4ii6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <0000000000001d1fb505f605c295@google.com>
 <64026f89.170a0220.7940.49ff@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64026f89.170a0220.7940.49ff@mx.google.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook, le ven. 03 mars 2023 14:07:04 -0800, a ecrit:
> #define max_font_width  64
> #define max_font_height 128
> #define max_font_glyphs 512
> #define max_font_size   (max_font_glyphs*max_font_width*max_font_height)
> 	...
>         font.data = kvmalloc(max_font_size, GFP_KERNEL);
> 	...
>         if (op->data && copy_to_user(op->data, font.data, c))
>                 rc = -EFAULT;
> 
> it is correctly seeing "c" (4194560 in the report) as larger than
> "max_font_size" (4194304, seen reported by "folio_size(folio)"). The
> "c" calculation comes from:
> 
>         unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
> 	...
>                 rc = vc->vc_sw->con_font_get(vc, &font, vpitch);
> 	...
>         c = (font.width+7)/8 * vpitch * font.charcount;
> 
> So yes, 4194560 is larger than 4194304, and a memory exposure was,
> in fact, blocked here.
> 
> Given the recent work in this area, I'm not sure which calculation is
> wrong, max_font_size or c. Samuel?

They are not wrong. It's the vpitch value (coming from userland's
op.height) which is out of bound and missing a check.

The patch below should be fixing it, could you check?

I don't know how I am supposed to properly reference the syzbot report
etc., could somebody used to the process handle submitting the fix?

Samuel


VT: Protect KD_FONT_OP_GET_TALL from unbound access

In ioctl(KD_FONT_OP_GET_TALL), userland tells through op->height which
vpitch should be used to copy over the font. In con_font_get, we were
not checking that it is within the maximum height value, and thus
userland could make the vc->vc_sw->con_font_get(vc, &font, vpitch);
call possibly overflow the allocated max_font_size bytes, and the
copy_to_user(op->data, font.data, c) call possibly read out of that
allocated buffer.

By checking vpitch against max_font_height, the max_font_size buffer
will always be large enough for the vc->vc_sw->con_font_get(vc, &font,
vpitch) call (since we already prevent loading a font larger than that),
and c = (font.width+7)/8 * vpitch * font.charcount will always remain
below max_font_size.

Fixes: 24d69384bcd3 ("VT: Add KD_FONT_OP_SET/GET_TALL operations")
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57a5c23b51d4..3c2ea9c098f7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4545,6 +4545,9 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	int c;
 	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
 
+	if (vpitch > max_font_height)
+		return -EINVAL;
+
 	if (op->data) {
 		font.data = kvmalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)

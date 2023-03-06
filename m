Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779746ABA52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCFJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:49:25 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE608C651;
        Mon,  6 Mar 2023 01:49:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id BFA9E20137;
        Mon,  6 Mar 2023 10:49:22 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hErAdg_uF3sj; Mon,  6 Mar 2023 10:49:22 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 455092012C;
        Mon,  6 Mar 2023 10:49:22 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pZ7T7-0001Rf-1i;
        Mon, 06 Mar 2023 10:49:21 +0100
Date:   Mon, 6 Mar 2023 10:49:21 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        keescook@chromium.org,
        syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] VT: Protect KD_FONT_OP_GET_TALL from unbound access
Message-ID: <20230306094921.tik5ewne4ft6mfpo@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        keescook@chromium.org,
        syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Jiri Slaby <jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A873DE94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjFZMN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFZMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:13:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE1E52
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:13:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687781627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aT4Woirb53zn7Qml3iPHfHRgKhD8h7L6FShdJWzQSf8=;
        b=Bs55uuTTnu74Ov3W4wNMDBdoPn1n8R25Mgv3IsSfpInjiM77uwgIJ8GDuGgDn0l9iWJJJ1
        9UzjoZezICdo8gtZOwApaXjQk+jelvkphSiTT17r+05GYCgDbktw7fF+AAuJcYsUpfKQPd
        BOo9n6vUhQ9SxTpV6qymCGqs+mpKytIIxWSlokO8KQsLHraz3ImwpxIl6q154pXtUduxjN
        +l1PJ+MZJlj885v9XnIw/vcCM+QanQZdy5P+z4Vbz4l9Dmx7PJHSoBpGCuqUxCff+v0yIn
        inSfPM9DxR8W82wC3mrY5jmjCKkPR7sKqeq+fNwmkzDns926BZXe7dn9YY76nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687781627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aT4Woirb53zn7Qml3iPHfHRgKhD8h7L6FShdJWzQSf8=;
        b=qnZSmCIDXO7w+KoVlzU4xQlX6xX+mcppjSlXMMMDrz5KhBQv+thWTt/RUVIpq8pGE+YiZ8
        /fQiuXiN1c0WK4CA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.5-rc1
Message-ID: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 14:13:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2023-06-26

up to:  8b64d420fe24: debugobjects: Recheck debug_objects_enabled before repo=
rting


A single update for debug objects:

  - Recheck whether debug objects is enabled before reporting a problem to
    avoid spamming the logs with messages which are caused by a concurrent
    OOM.

Thanks,

	tglx

------------------>
Tetsuo Handa (1):
      debugobjects: Recheck debug_objects_enabled before reporting


 lib/debugobjects.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 984985c39c9b..a517256a270b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -498,6 +498,15 @@ static void debug_print_object(struct debug_obj *obj, ch=
ar *msg)
 	const struct debug_obj_descr *descr =3D obj->descr;
 	static int limit;
=20
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr !=3D descr_test) {
 		void *hint =3D descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;


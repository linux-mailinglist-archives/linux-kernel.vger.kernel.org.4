Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE06CD257
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjC2Gzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2Gzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:55:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD018211D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:55:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54629ed836aso6038957b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680072951;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb6T5Nix/3hrpi04qTRDKmlC5J5N+Z2zQezjqCwHQSc=;
        b=I70iBO8V621lm+2OBg9UTLn3NwNxaOjH81/kUFD8B1L+O1fwBhekEA+10JCdKiD3tA
         kECwcwUJvSNC88bYchl5stnbjXXBAo59zC+OgGa1lyXqpdfSBAdKUplbtKbZ6b4sx+Io
         fOQ63v3lHvtOi4jdjxoivD4NQGgJEUDTIXFSDL+0qLQm7CfslCBvEOlc6kmoSJRnTYhx
         pEEhi7f4mATzlqPFiW1w4VEErXrG7EzcULjUI2XpAcYsYU34pW9Tn9qbtYIEjkN0lEZr
         djC+4bkDVcIBW8KqxkB9oMzR05gvvb+gdeHsobNc5dq91YSjLozfTnVS9sd8c8258dDQ
         ayIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072951;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb6T5Nix/3hrpi04qTRDKmlC5J5N+Z2zQezjqCwHQSc=;
        b=LqdZuR+n4lt142LZVFnSf1hPzegTqDYeKL5zmWdyAWquig7mjonzv/IHyRffLdoHuf
         o63PUU8mwSFHkkI5OxveavCM9IWbQMUpR0sKhUHNYHp3O4M60TqXH/CRJVO+NHnZlp/D
         YhiSEhIc8P6gFnclZnTQot5ehlzIsfdUMcJ957gRPaU+Z0yRPJbu3Cpglu1C57FTRMle
         a9rDlsETJVhi2sWCuGrLua0hZl4s5qIGmJlKcWogl6NlaWbCZbl/39FdIPhQrqK1ok4D
         Hut9439sE94/WsY3y2hqrr/eZqkWx+/Ol6bjEPgla9/oYii8cIDHw/bYeUjyUDMjB8Kk
         XSrA==
X-Gm-Message-State: AAQBX9feUbY7uTZIEN1l51KnleIhPMKXscrppirgdeTzej0MeHAuEYvB
        OhBjmGa/3WSBXx8CYBIZ4PGTtLcy/pAYRw==
X-Google-Smtp-Source: AKy350bNaANkNE4LgBYqCLQFYMuy5mciHvuGb6vV8PhgtV00DdwwHufAEgSeA7hH9hghIP+DtRXhzI8HE8iwTQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr12429289ybt.6.1680072951072; Tue, 28
 Mar 2023 23:55:51 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:55:32 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329065532.2122295-1-davidgow@google.com>
Subject: [PATCH 1/2] drm: buddy_allocator: Fix buddy allocator init on 32-bit systems
From:   David Gow <davidgow@google.com>
To:     "=?UTF-8?q?Lu=C3=ADs=20Mendes?=" <luis.p.mendes@gmail.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>
Cc:     David Gow <davidgow@google.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm buddy allocator tests were broken on 32-bit systems, as
rounddown_pow_of_two() takes a long, and the buddy allocator handles
64-bit sizes even on 32-bit systems.

This can be reproduced with the drm_buddy_allocator KUnit tests on i386:
	./tools/testing/kunit/kunit.py run --arch i386 \
	--kunitconfig ./drivers/gpu/drm/tests drm_buddy

(It results in kernel BUG_ON() when too many blocks are created, due to
the block size being too small.)

This was independently uncovered (and fixed) by Lu=C3=ADs Mendes, whose pat=
ch
added a new u64 variant of rounddown_pow_of_two(). This version instead
recalculates the size based on the order.

Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
Link: https://lore.kernel.org/lkml/CAEzXK1oghXAB_KpKpm=3D-CviDQbNaH0qfgYTSS=
jZgvvyj4U78AA@mail.gmail.com/T/
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/drm_buddy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 3d1f50f481cf..7098f125b54a 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -146,8 +146,8 @@ int drm_buddy_init(struct drm_buddy *mm, u64 size, u64 =
chunk_size)
 		unsigned int order;
 		u64 root_size;
=20
-		root_size =3D rounddown_pow_of_two(size);
-		order =3D ilog2(root_size) - ilog2(chunk_size);
+		order =3D ilog2(size) - ilog2(chunk_size);
+		root_size =3D chunk_size << order;
=20
 		root =3D drm_block_alloc(mm, NULL, order, offset);
 		if (!root)
--=20
2.40.0.348.gf938b09366-goog


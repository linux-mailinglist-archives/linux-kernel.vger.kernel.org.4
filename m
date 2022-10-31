Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB2613BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiJaRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiJaRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:13:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329D13CD6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:13:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so11217792wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZh+SgP5zyZUcNsYUWyhKAXBrnVjIYJpvy+lxn9GdpU=;
        b=HDcmjahRob5SbMi1MFbmK45wpKjjNYqME8+i8Uj1rAlCSAZnB69RjO9CXNqoLeYhQG
         QnyaObBgqPzJdvO79PwQ96QrbFf6NkXOm7hYt3x6vqVrQC62NZ3igbpDNaKmm7QC+RGQ
         n3Z6GIqEbKtf+j9PBK6WSHZUPNoz8yDgd5L64BOzoNsr1BXUG3q1omJQSFujpxQb7pJ3
         ZqeODwCoWsjop3Q1VmA8jSwAf8bNoW4WWl9CRjNW7Mw23sqt5+VuQCshQ7leX66Fx74F
         iOW6kQZGsmkfT6ek2AytLUv02pVYM4gIcsPxiamoSJLVEu69A69OkNvjVLKPp5m+E/aK
         Ot/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZh+SgP5zyZUcNsYUWyhKAXBrnVjIYJpvy+lxn9GdpU=;
        b=UQPOmakh7LtUbbC+wD1PiYJQUuTp0svQ0gxQJ7rTJiWeDFtDlb+/nQv/GUWJEDmSs5
         KWgsWa8GBsKGf8eZ4geQYXIrFidaEsNwzzR7TXQ9qTkgNsZtTy2sFrGMuxY/MEb3KcaB
         4sk+xD3kZ4Jbst9mBdju1I5CL2xAK/M80ZVlSLiiLLOJUic7YUB8b/rvv+KlrV8Z6tQR
         UoQYRuPY1aDJAbOQChcHsMrE1a5SOql+/67TOmOlcSwgWVmaxZjYzckMrNVpJA4Oe64e
         wsPodFU9Z5ktCVJkWX3ZAd+2Wz/9HV08eL6Os3PD9/sf/g4pttfNzhBDhnjGHMJwFWZH
         HL+w==
X-Gm-Message-State: ACrzQf2o/vPDq0+nDGrhKG92moTPHZhMp0leh3aPxLHLufZZU1xLa9ct
        prvqKAzFOwC0+jffz7WInUA60gMrckrDng==
X-Google-Smtp-Source: AMsMyM5ip64mXY4hdlgVLYZqC914/Pj4LBawLEdZFhmsGWBXvTH/48Dexe/SqkBeK2kvCNOTZXxi+A==
X-Received: by 2002:a05:600c:2150:b0:3cf:6c05:b4ab with SMTP id v16-20020a05600c215000b003cf6c05b4abmr5916185wml.161.1667236393867;
        Mon, 31 Oct 2022 10:13:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:f03a:db2e:7a5c:b47c])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b002364835caacsm7845359wrb.112.2022.10.31.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:13:13 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [PATCH] fs: add memory barrier in __fget_light()
Date:   Mon, 31 Oct 2022 18:13:07 +0100
Message-Id: <20221031171307.2784981-1-jannh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must prevent the CPU from reordering the files->count read with the
FD table access like this, on architectures where read-read reordering is
possible:

    files_lookup_fd_raw()
                                  close_fd()
                                  put_files_struct()
    atomic_read(&files->count)

I would like to mark this for stable, but the stable rules explicitly say
"no theoretical races", and given that the FD table pointer and
files->count are explicitly stored in the same cacheline, this sort of
reordering seems quite unlikely in practice...

If this is too expensive on platforms like arm64, I guess the more
performant alternative would be to add another flags field that tracks
whether the fs_struct was ever shared and check that instead of the
reference count in __fget_light().

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 5f9c802a5d8d3..6144287ddc0fe 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1004,6 +1004,18 @@ static unsigned long __fget_light(unsigned int fd, f=
mode_t mask)
 	struct file *file;
=20
 	if (atomic_read(&files->count) =3D=3D 1) {
+		/*
+		 * If another thread is concurrently calling close_fd() followed
+		 * by put_files_struct(), we must not observe the old table
+		 * entry combined with the new refcount - otherwise we could
+		 * return a file that is concurrently being freed.
+		 *
+		 * Pairs with atomic_dec_and_test() in put_files_struct().
+		 * An alternative to using a barrier here would be to use a
+		 * separate field in files_struct to track whether it was ever
+		 * shared.
+		 */
+		smp_rmb();
 		file =3D files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return 0;

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
--=20
2.38.1.273.g43a17bfeac-goog


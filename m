Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85CC5B8A70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiINO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:27:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755711B780
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:27:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so7673863wrp.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=z5Z+1Ej59+eqFNlmwdCmpNW1qUH5otodDaXBtgZAZzE=;
        b=kD9aDfcDoRGyBlkIlekXGYPic+zFGhEuvXLgE7RPDDQrH9Nk9lKfbi+viiaRSLJcMl
         n622s2zPHFHcmELmvdXhIeyKhPDWJkjWnpdWurHJ95jjznmGVAslGY/EUXmPAwwT3oMX
         P7MJczcWWWYb0MlKDm57MFBQk4KWLHuXEejyidOB3yMPnmKXdl9uu1oF9xoSAo6hsQBr
         2GZG8aIPoMT5EtkYouvzEFPNreLIafFBN8VNbjAIxbBUZ5wRmBohlMb3Ayiw0ppa36qX
         qQxMX3LSpZ9OdwTDKvaHGmactnVeOh9WeC2eNWe9TukEYeN6irZTsDr0gszv0SygmvzA
         UQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=z5Z+1Ej59+eqFNlmwdCmpNW1qUH5otodDaXBtgZAZzE=;
        b=3ar+FurF09CLtcK16s8RRQ1YID+HrPi810h7grFHkspbfPK9dmwCgX/uDvYvM63se6
         aUjqyOPHUergkrokgPm1uNdCzg9ED/UqPhU45h2Cdwkk8Rnw/Gz1PDM5wrmG91IOCx1O
         HiprzieklcCymNA1DXqretVBIw/tCgGx2ZZmBRuVWpmPdphyTJa23bAg/q88YgxIowVY
         vrCphrX+u3FXVqQfPqSwUZdr2KGJF2Yh7V2QvsRHedSYlHdxs5t+lVNPFDSfb33hSr11
         nO4LVyhKmTuCgchvW9QGSF+jgIYFw1ZDH0gpEO2VhrqABNY7EWGmNDZHvrI3G7VXlF2w
         EGYQ==
X-Gm-Message-State: ACgBeo2Q2VCvpZe/aKJaT9ukJZ8Q5MVobT0vre7diVieAIQpvhDdnCBx
        84MUikOC+aCoDzJ5sOUurol1HA==
X-Google-Smtp-Source: AA6agR5AbBVmWtec7IrU1Z1ItVfcmPpGc+eNYVfzknzbs1n1A2Bh4xcDbunOrgVvf77cmziav0t3Xw==
X-Received: by 2002:a5d:60ca:0:b0:228:d77e:4b25 with SMTP id x10-20020a5d60ca000000b00228d77e4b25mr22118423wrt.139.1663165619449;
        Wed, 14 Sep 2022 07:26:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:b3a5:6d13:189f:405f])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003a5b6086381sm18573322wms.48.2022.09.14.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:26:58 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Remove user_ns check for FUSE_DEV_IOC_CLONE
Date:   Wed, 14 Sep 2022 16:26:32 +0200
Message-Id: <20220914142632.2016571-1-jannh@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ed1f0e22f49e ("fs/fuse: fix ioctl type confusion") fixed a type
confusion bug by adding an ->f_op comparison.

Based on some off-list discussion back then, another check was added to
compare the f_cred->user_ns. This is not for security reasons, but was
based on the idea that a FUSE device FD should be using the UID/GID
mappings of its f_cred->user_ns, and those translations are done using
fc->user_ns, which matches the f_cred->user_ns of the initial
FUSE device FD thanks to the check in fuse_fill_super().
See also commit 8cb08329b0809 ("fuse: Support fuse filesystems outside of
init_user_ns").

But FUSE_DEV_IOC_CLONE is, at a higher level, a *cloning* operation that
copies an existing context (with a weird API that involves first opening
/dev/fuse, then tying the resulting new FUSE device FD to an existing FUSE
instance). So if an application is already passing FUSE FDs across
userns boundaries and dealing with the resulting ID mapping complications
somehow, it doesn't make much sense to block this cloning operation.

I've heard that this check is an obstacle for some folks, and I don't see
a good reason to keep it, so remove it.

Signed-off-by: Jann Horn <jannh@google.com>
---
@Eric: Does this look reasonable to you? I dug through my old mails,
and in the off-list discussion back then, Linus and you were in favor
of adding this check.

 fs/fuse/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51897427a5346..920480054e1dc 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2266,8 +2266,7 @@ static long fuse_dev_ioctl(struct file *file, unsigne=
d int cmd,
 				 * Check against file->f_op because CUSE
 				 * uses the same ioctl handler.
 				 */
-				if (old->f_op =3D=3D file->f_op &&
-				    old->f_cred->user_ns =3D=3D file->f_cred->user_ns)
+				if (old->f_op =3D=3D file->f_op)
 					fud =3D fuse_get_dev(old);
=20
 				if (fud) {

base-commit: 3245cb65fd91cd514801bf91f5a3066d562f0ac4
--=20
2.37.2.789.g6183377224-goog


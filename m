Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAA6DC57C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDJKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDJKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:03:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47987270D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:03:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so8027931wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681120987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KjDWiVC9FREZXf9jIuLYMwQbdeYXF+2V10Ky+2iAZU=;
        b=hgelFPbm9bgitDC+gC/mcIFymhRKCeY9ZCC197lZsCtrqCqOd5mK+qMpdMEgo4E7EG
         gB1aLTvPTR5wR9ew0SieUMlfQiqqjRBGPS0ZPT01WWLzJ76RdMEM83O5wQadcuPvH11l
         2fJN1rlPWI+CKzNX7rURHW5kxLUFDUTmyT6GyxeJ3YZ0zUDXv9roJT3qgsn6QX2Zwj9a
         q7niKO7E+mfYRAyQZwLjfrQZ8s/Sm9/SavKtP4EDBSbI90RNLZblXwLlqLpFjrU/JeXz
         dJU5CdVTwCdLOSz3aX79xIyZ81svvbnpopt1EYwqoCbghSj3loKWFq+W/v2N5H3j+9Va
         kFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KjDWiVC9FREZXf9jIuLYMwQbdeYXF+2V10Ky+2iAZU=;
        b=Mj4c9XXef1rcEEy3f4TibluCOZe7Lzu3rnYSSxaT+VZ+BMGaPAVI5hDJ7mEpbklF+D
         MOmijITURXQJZFk7tky7/PFG2TTIrMJ3J76uRyaxzfsJTnxKOIF7/Epptfi4YdT7iDl6
         qpZIudhtKIpSXaliO5Qxs0voCcoDNDeOtYLXxoqAbGVaQ/u0eHbJjfjQAIO96zk8GB5I
         6zbztGPc82McwvgQVpXBC3yRqxSIaJPKuKyJqZ0icYAmaLAJkMpix0j+9SULxXNVstjN
         pgTbOQihbK+X3+qCi3xsxVuaoy2v5tpPjaecTaYHr7RPXpaKm0ECZiKjcj8PhR1RKKS8
         oLuA==
X-Gm-Message-State: AAQBX9dlM4t4u/vprBGElClbVXGVUxpBlz9bCWgzrf5M6fAV9sv2Uzzo
        Y62KFYVY2TfR0X9AAbfeH9w=
X-Google-Smtp-Source: AKy350Y0YJYb6ehTAcGd5lXyGAuRdT1S1aJEgut7eJEkpGRaYzt+YGtvxQh3cdbNJx4HhSrGd3h++Q==
X-Received: by 2002:a05:6000:124c:b0:2f0:595:679b with SMTP id j12-20020a056000124c00b002f00595679bmr3233385wrx.66.1681120987541;
        Mon, 10 Apr 2023 03:03:07 -0700 (PDT)
Received: from lshz10676.. ([2a01:e0a:4cc:a210:2e0:4cff:fe4b:7422])
        by smtp.gmail.com with ESMTPSA id r9-20020a5d6949000000b002e51195a3e2sm11428959wrw.79.2023.04.10.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 03:03:06 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: exclude gerrit's Change-Id line from commit description
Date:   Mon, 10 Apr 2023 12:02:55 +0200
Message-Id: <20230410100255.16755-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch rejects patches that have empty commit description and
logs them with:
	WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one
But if the patch has a gerrit's Change-Id line placed before the
line Signed-off-by, then checkpatch considers the Change-Id line
as a valid commit description text.

Use the Change-Id tag as a marker of the end of the commit message,
thus not counting its line as part of the commit description.

This patch is not relevant for the Linux kernel development process
as gerrit is not involved and the Change-Id tag is rejected. But
other projects, like OpenOCD, base the development on gerrit and
reuse kernel's checkpatch with flag '--ignore GERRIT_CHANGE_ID'.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..5b2212d5907b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3224,6 +3224,7 @@ sub process {
 
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
+			$in_commit_log = 0;
 			if (ERROR("GERRIT_CHANGE_ID",
 			          "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
 			    $fix) {

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.40.0


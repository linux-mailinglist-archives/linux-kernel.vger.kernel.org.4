Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6B669868
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbjAMNWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjAMNVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:21:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48C5C1CF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:13:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g23so7803397plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KUc5JrrEgEAQMR+uacJMHg3Y0KdkEVSfddBY4EelSU=;
        b=QcMnMEk3LEKnssiIzikEyB6Auz31cin5hOdWestRkhiTFyN1RqlvNMhymUOl7NgSgx
         yHes8XO5JE/NQa9WKpQnJ5kIB86000Lk2sZNf02tjXEg1d4hF74ZbJMS1MxQyp8VXyaP
         oMSfg0KTOTLTAwrdj3bqZS51euz2LLb7pf+qFHrHrOVqgGkLVaQtHrwJYSvP1RA01Gbq
         aMEnFmMUq4goj4o+iu1yJwcwjy/ob8Dq7WwimCxlEc4eV9srx1Eq2DAwYgZkvbXHngkD
         bwqROmENaeH4+SXna1fmDHnd0AV4S9YJejLh1BuITRPVe1EiZgN/njLSwKUxYFaXmPBN
         QOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KUc5JrrEgEAQMR+uacJMHg3Y0KdkEVSfddBY4EelSU=;
        b=qfdakCtOH+w0rEJWG/Whgdth586TXQoXeudsPuB8q6Ii5K094l3ZLDShxgVz/Y9uj8
         cKlFWtKlozEg4paDV04rXIqNqSkVxPk3a67ZmcSUGf62hq9qyyS5E2QqHeVPFau5933E
         pj8+s8j4Ne7eMM1Ps63P5A0jVB2ZeCpm2ofWTxA85Ul2O5fLO/2hwFOtd3GMYABLuwBj
         oh8XQCUokOLVzlX7hLcxFPXmJbc8cIHjida60ep3foG3XpepA1PYwMF4GR8i3bThH6TN
         b3qxl3H7niO6of1atvO0IGNlCuoz3ULH2MYAUT+ljvfzzIZSS9hO3ECmNgSVKufyffH3
         M2MQ==
X-Gm-Message-State: AFqh2kqLhNspIen0MyHxu5wg4C4tLxqBpfYSu9TFSY3iF0m/l2m5auCb
        zciazuKpn/AdgSPiyPx/X58=
X-Google-Smtp-Source: AMrXdXuiiip+ouWeSYMH7cgxi+SoCGgf2LIXdaZG/nd2fyGQeTyfKrXV2Y7KLkkwQ7eDcbHrAKfrDg==
X-Received: by 2002:a05:6a20:c193:b0:9d:efbf:8175 with SMTP id bg19-20020a056a20c19300b0009defbf8175mr12625364pzb.62.1673615587935;
        Fri, 13 Jan 2023 05:13:07 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.142])
        by smtp.gmail.com with ESMTPSA id o189-20020a62cdc6000000b0058baa6586f3sm2673696pfg.135.2023.01.13.05.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:13:07 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: ntfs3: Add check for mft_ni in mi_read()
Date:   Fri, 13 Jan 2023 21:13:03 +0800
Message-Id: <20230113131303.761464-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous commit 2681631c2973, the parameter ni of
attr_load_runs_vcn() can be NULL, and thus a NULL check is added.

However, in the same call stack, this variable is also dereferenced in
mi_read():

mi_read()
  ni_lock(mft_ni);
    attr_load_runs_vcn(mft_ni)
      if (ni) -> Add a check by previous commit (ni is mft_ni)
  ni_unlock(mft_ni);

Thus, to avoid possible null-pointer dereferences, mft_ni should be
also checked in mi_read().

These results are reported by a static tool designed by myself

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
---
 fs/ntfs3/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index defce6a5c8e1..9c5f922543c2 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -144,13 +144,13 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	if (err != -ENOENT)
 		goto out;
 
-	if (rw_lock) {
+	if (rw_lock && mft_ni) {
 		ni_lock(mft_ni);
 		down_write(rw_lock);
 	}
 	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
 				 vbo >> sbi->cluster_bits);
-	if (rw_lock) {
+	if (rw_lock && mft_ni) {
 		up_write(rw_lock);
 		ni_unlock(mft_ni);
 	}
-- 
2.34.1


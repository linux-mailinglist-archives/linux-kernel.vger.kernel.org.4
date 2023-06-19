Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032ED734B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFSEoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFSEoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:44:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A721B8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:44:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2482069a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 21:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687149855; x=1689741855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRiCzck3okYf2yD4tBPHZkTboxRNgYiqksP+cRAkLVk=;
        b=mnc3P2Qj80BPwmWZJ0SVhjnbMIysbydBl46s6xqRQvO6P7LLdvLW35FqowO6QuOymq
         cvUNzzIUItOymNe+uuS961cxI0bUV/Y5E0fc8gpnPHl7BZ7oHEM83CO+zed//5qiNaEM
         HmNOizLx4YH5oO/OYTuPPhKyqgqpz7rNuYB/gOPhwDdjPsY1l3mWx060dmu6C02y0rz2
         9yTbSORX0vuGoyvtsMUQYYZ6uIhCAxuy1Lu0KFULktlwbwO0m4PcYmCc/QpUf38NYnRc
         EtFOcyItjxj9CzqdfJG0gqvpBiDsfDOaznXs9fso72eZ/vxGbe96VP3xBriKH83rs79Z
         vWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687149855; x=1689741855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRiCzck3okYf2yD4tBPHZkTboxRNgYiqksP+cRAkLVk=;
        b=MNNLqtred+BUfwxjabtMIMznkXxoD4N4OKnM1CNUdJvlVdabN9epT05RasPEPdJA+B
         pIp/snEY3yaU7ym8rmd8PJN3fAwm5UKkdexsx+OnCMf44bfUDbio1aW2gJ5KBS+GLB6/
         M2pwez5yh6S52RfQQkuBqpdz78QZ1YxnrDm7jhxj5kouCgcKNaH+xUeyijdxYo+ZCDSU
         yZO4XoEsanGvtJq0dJNhyeFRoXewVzW/sU/ch9r7aPCjMVjsHqqq7YZWgkk1f1T6Y6RR
         Zaf/4xYJtghjmzyhvaCLpoA0NbHcRTzxtixofPZ/KiKT4DzEe2pQBo3QyfMT7+2YSbIg
         Dh+w==
X-Gm-Message-State: AC+VfDy5XBixypLkK0er+ZNIKUpbTTTQCv96d7ROirrWVNvDaSX/KIFK
        DIqz1jmqT5o+zFQm0hghlaQ=
X-Google-Smtp-Source: ACHHUZ6lV6WX6WtLXua+DDOER+macE3jWFt0K/xpjSbRgR8zXbpQqOMO/D+579fT0bGGeW9WjBl82A==
X-Received: by 2002:a05:6a20:8f15:b0:121:4ae4:ee2e with SMTP id b21-20020a056a208f1500b001214ae4ee2emr4976747pzk.34.1687149854925;
        Sun, 18 Jun 2023 21:44:14 -0700 (PDT)
Received: from aa-PC.zhaoxin.com ([180.169.121.82])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm19379400pll.307.2023.06.18.21.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:44:14 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@kernel.org,
        Liam Ni <zhiguangni01@gmail.com>
Subject: [PATCH] mm/sparse: Check the return value of first_present_section_nr()
Date:   Mon, 19 Jun 2023 12:44:03 +0800
Message-Id: <20230619044403.1519685-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

first_present_section_nr() may return -1,
which means there is no present section in system,or other errors,
so we cause panic here.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 mm/sparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index b8d5d58fe240..175727e10deb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -564,6 +564,8 @@ void __init sparse_init(void)
 	memblocks_present();
 
 	pnum_begin = first_present_section_nr();
+	if (pnum_begin == -1)
+		panic("There is no present section in system\n");
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
 	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-- 
2.25.1


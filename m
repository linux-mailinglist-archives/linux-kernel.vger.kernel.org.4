Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD7652C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiLUGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BA9599
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l4so3249791pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Av6vW65rzCVCw+6KtUm+4auWSWYrwGrHyryf2Jt46AU=;
        b=G7y7kckqpE94asqNd9FBeggI2pufctgLVCWRsh1sAlMrcjlkD6TEp4FO2yB/KvNMhv
         uAPb0WrrDkiH2s6rigO1hU3rCHIP6Juah5FlbZh7fai7F1vpHrm7N5pDWhgCDyipMbCs
         pNc/3zXntldNowC4FdVE1EbZijZCiTMR13878/wD9utgOWwCjd1ny2FPAjlkSkqnu8p0
         LAF5bRLd8/R/twDUo4xIEyQWuZf/cCKVC/JPRDpXvQLPFmpN3wWYsoZUbn21XUovcwlG
         ssDEu2uJr6B2X9IECOFPI9F6v5jnlDGcPFsDW/TXq+G6A/4R/8I9y1+k2FF/XtCxsIkp
         wyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Av6vW65rzCVCw+6KtUm+4auWSWYrwGrHyryf2Jt46AU=;
        b=VfIIy1HVXVYzblv72+EYecCKFUxallyDL6TjTB5rBiK5XpIDsRixocUu0E2b3Lk0Jb
         6IdOD5qlFh8m+ZknKYgyUtGmAfGDYI+nvnEjR3EgZMKHO9MqFyucfO0UhV2Qgyc+IfmA
         4PgCsHs1YbBiP+2j0O3WQtIVoPnkW1wfvW5XXuKi0l1/wOvrvjMMmccCVzAxJzgK82y/
         MyleoonMuXqzHU/1LatcEf/C77Dvc0XsT1fzuW+2dmSi6oLqYFU3M4+XLf68A+8vZDz5
         mObBKNLOV2ppcZyvi4D02v7K6+F5zkGyqNjBlY3/I601TqYFDzXdr6XmDlR/Wf39jcwQ
         X5MA==
X-Gm-Message-State: AFqh2ko3LdrZZsus3yWswFEBkaFRTLAKwHuiPTcTWKcN8O9ZwznjJXX7
        Z7kJHaU2j6Ld0lfXdlSH3uY=
X-Google-Smtp-Source: AMrXdXvwFUWvcu0rHuEQUje6acU9ANPY2+LiUf7TXeyiKUwnIha4WMziTS5RQRa7QkeZ2NRMU+DRkA==
X-Received: by 2002:a05:6a20:4faf:b0:b0:f6ba:e38a with SMTP id gh47-20020a056a204faf00b000b0f6bae38amr1054443pzb.33.1671602483616;
        Tue, 20 Dec 2022 22:01:23 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:23 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 0/7] Clean up and refinement for maple tree
Date:   Wed, 21 Dec 2022 14:00:51 +0800
Message-Id: <20221221060058.609003-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset clean up and refinement some maple tree code, a few small
changes make the code easier to understand and for better readability.

v2 changes:
- Add Reviewed-by Liam R. Howlett to all patches besides 6 & 8.
- Remove patch 6.
- Add an unlikely() to the if statement for patch 8.

v1: https://lore.kernel.org/linux-mm/20221220140829.1665432-1-vernon2gm@gmail.com/

Vernon Yang (7):
  maple_tree: remove extra space and blank line
  maple_tree: remove extra return statement
  maple_tree: use mt_node_max() instead of direct operations mt_max[]
  maple_tree: use macro MA_ROOT_PARENT instead of number
  maple_tree: remove the redundant code
  maple_tree: refine ma_state init from mas_start()
  maple_tree: refine mab_calc_split function

 include/linux/maple_tree.h |  6 ------
 lib/maple_tree.c           | 35 ++++++++++++-----------------------
 2 files changed, 12 insertions(+), 29 deletions(-)

--
2.34.1


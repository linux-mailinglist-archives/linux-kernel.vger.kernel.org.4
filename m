Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5618965220B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiLTOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiLTOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:09:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6393E1B1E8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:09:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a14so8595719pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OVwEEkuPuBsngehdDVCzETTIsMI352trCxfsywSxsY=;
        b=gW/RBp2SigLyvM5t4YXtjrPbAZeld2ZkK1oL4g2hfVzLrTh6vmRsI19iGkDC0YgZFn
         XEUHiDGq0AGeww3x20i8BRLQfMlVZR2pBn5TQjmbiL1PV+DCDkjz6zeJDLf2XF77SmPd
         7ZLY3koftSueWSyCi/SmGUGg5N8Sz/S5DhlAcUyl4MQHIVFmG1q2iLyAoEfnFEvClPHF
         oE7IHv1m4mRHyrG736/4OTlNsio8uzulEV0ZCJua67QYZj736ROcF5qvB8n/Q5qTpye3
         FqmVc2Sh+rkWph6dnLuv61aEbgVQJ7V068BSbj8ISvCS0QGagFyC33YtSZIMcW77A8PS
         Olmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OVwEEkuPuBsngehdDVCzETTIsMI352trCxfsywSxsY=;
        b=IACEPWnXvkn7OcP9rcYCYkaqFr8gEQLT6lq0zq8FcSgGShGBK5+YHlfxyShGcT+aCp
         ItZPgpZkXlQoxtCp+cUfYL5FKFkl2WnbV/m8aHFHDxQKWH/uKX5m0m4hs+cKFCRHUJ2h
         mYrFPyk3xqqMHHqzDhvloSEWPjXnjvjuY8HIdbvGc5TW7b8clJkcbcaTL8u+z3cqHT1A
         kOvWd9heTwur88/WqduzqnbA/2IgSfIQ6spFxfirZOxk3qFJKm7UMycyQp4rIbk+tXvB
         6W1MclKvPbe62kk24mfSBEWFDfbdTchgFLGjwOILg2usZBvksipdqFh018UNbnSx7xJO
         ldOA==
X-Gm-Message-State: AFqh2kqpjSJ3eShhr/0Ap6bv4Litlm2yLf7ZVdrqnYcXr/zJXMNWl1xR
        caLVcSR2Fccy9BKRpKDzCidvd9J43AQVnRchdSU=
X-Google-Smtp-Source: AMrXdXuU3lgrB3sZVZZXrfY16ocXgQEhhfUOk4fjtLnLxccgnmCHhlaaqdVxSpmBRAr6ajbrRerQ0A==
X-Received: by 2002:a62:14c6:0:b0:57f:a19a:385a with SMTP id 189-20020a6214c6000000b0057fa19a385amr11716694pfu.13.1671545353914;
        Tue, 20 Dec 2022 06:09:13 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id 12-20020a62150c000000b00574f83c5d51sm8654864pfv.198.2022.12.20.06.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:09:13 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 0/8] Clean up and refinement for maple tree
Date:   Tue, 20 Dec 2022 22:08:21 +0800
Message-Id: <20221220140829.1665432-1-vernon2gm@gmail.com>
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

Vernon Yang (8):
  maple_tree: remove extra space and blank line
  maple_tree: remove extra return statement
  maple_tree: use mt_node_max() instead of direct operations mt_max[]
  maple_tree: use macro MA_ROOT_PARENT instead of number
  maple_tree: remove the redundant code
  maple_tree: change return type of mas_commit_b_node()
  maple_tree: refine ma_state init from mas_start()
  maple_tree: refine mab_calc_split function

 include/linux/maple_tree.h |  6 ------
 lib/maple_tree.c           | 41 ++++++++++++++------------------------
 2 files changed, 15 insertions(+), 32 deletions(-)

--
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F465B8FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjACBpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjACBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:44:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD4AE7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 17:44:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso34490652pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 17:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHxPn2MfgMHaHkWOCEms8kh86GtTfZeksouoa6QWirk=;
        b=S3RZ5H2417PyqyrJDnKgbaPEkU49KfJ2W3TcbJj2yoRhCmNSHt/sP3rlwSUtlK73ra
         ccjZysQhvBJL/kOVA1QcMrMvwuxf/pk5JMlxIlRyopI3Zht+Hr69uaBa4so9efib5Lmw
         ydDBq9ZvPftiz76WBIUkaTaayxYc0NlZC+n7nyVoHbFsMn8XAR2gQlYdwUC/sPj1jZM+
         fT0Kq5mTgPwoq7i7abivJuGfu9liCW8buRjue2RjvgjlpVqi5YT80bV3SLXPrYhJBBR/
         VTbgEK+qbUnJspA58GEoMMPfRAyr2jrpajVl167H/BCh9YM1ujZHmFGJWutUYgfDDVu8
         bkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHxPn2MfgMHaHkWOCEms8kh86GtTfZeksouoa6QWirk=;
        b=nqd9yDi+Wpm0JMhPBG5mHeVG2YO7irgoB8IhnRYci1SCF01w90G3ARM5Ob40BwHm3/
         NXX1e7Jc9iOAqBFaFYypo/danyn1DqfNmx1k/RVXM3F1HehceOS72ZNCAncTpEPru874
         WLxNdJOB6NZYT2y/zTe7nML0z5SrUtCPzs+CMsVDhurZ80ksg1pmj2v1JUk3LTyQHY4+
         e4uIq9CpyFPyHKep2+4lhPlkIu7gqetw+HHuoqVO906Xi4Eed0xttjj4/8zi4qEmuFnK
         UWjCzoLGq96Z46mo9SY15lNBCkiQ7tjF35Wpi+SG8ugsv5/xp693qLM2MG02/t5miYQJ
         6F2g==
X-Gm-Message-State: AFqh2kqQcODB/VVX2rCgTOVHqdC6cYHmUkuMhEqbRI6fq/by78QW2B0i
        A1x86uQwFWvIh2Ak3pTUpP0fKQ==
X-Google-Smtp-Source: AMrXdXuKBAGjMvEn7pQkC7DVujql3KQKyeibbhKNE3b4HDT4AzoLVn8Rhbx7nt/6DgTMfiez+Pvrtg==
X-Received: by 2002:a17:903:2c5:b0:192:cf35:3ff8 with SMTP id s5-20020a17090302c500b00192cf353ff8mr4607512plk.21.1672710295791;
        Mon, 02 Jan 2023 17:44:55 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b001769206a766sm20588895plr.307.2023.01.02.17.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:44:55 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH v2 0/2] optimize ea_inode block expansion to fix panic
Date:   Tue,  3 Jan 2023 09:45:15 +0800
Message-Id: <20230103014517.495275-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize ea_inode block expansion to avoid memcpy if possible,
panic can be avoided in this way too.

Change vs version 1:
Only error and warning log format in patch 2 is modified per
Theodore's suggestion.

Jun Nie (2):
  ext4: optimize ea_inode block expansion
  ext4: refuse to create ea block when umounted

 fs/ext4/xattr.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.34.1


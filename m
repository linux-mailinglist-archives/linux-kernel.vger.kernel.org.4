Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC7626824
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiKLIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKLIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:33:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62912205C0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p21so6031013plr.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCXCfNSRRcnm3vfJDiUHQ+ivRlGKBS+DxKu934Py8fQ=;
        b=O9LKssH+x7xTlrzWXwaIArZsn3pK5eyM+cqYVdkK73ww7nHgX9/y6qC5XTTO+AuQFC
         lSmER58Um0akQ55wChPfzLmVlp7RgcXZVagrrvcVsdw2+WVbXXjlhKpKGyk3//FWDBRC
         JBMpm6AF5jT8K5xDcjcw8GQ5BH027xc09sCtFy269a/eRnSyeVH4u0wa4jxTm+ouPjhM
         wjw1g8wrPnlWRF6BkRgBNsb4IGoCjn/s29F8Im5PoghpTMbN0k455V4M5EgjLfjFe7hf
         pre+jR2l5NglgXwKOxriE7YexNWIcLPvGGkGEqlXv1aMzBucbO0xVwHd0O2r7r8/FBGu
         YgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCXCfNSRRcnm3vfJDiUHQ+ivRlGKBS+DxKu934Py8fQ=;
        b=cUKesDvBMzZP7EeBFjZ/yfEM14Ln2Y5TKOXHg1lT8Ilf+IdXkaef1dpO/ZV0ErOrUv
         ADN9mJwfToeZx3ae8MSUiJ7SAC6qe4bTngWz8zwksha4ZpEfqG7B6w36Ri0+N8lKaDdj
         qsBcw4kGqNabK9Swnn26Fg03y2SMe6uJpfFzyFwbxUCIJNvUKif1ohUBeZeOeSNkX++H
         qAB3xGZe5leDu67oHY+LHaj6BYs7LPO5c9UW0hozmDbxU73M85e4L+z8WCd909MhCyUs
         LHr0F9lgMXAreZQ/lKmVUXn3DgQAfpiEEJOQe8Y2eVPKJMfoP4VgKmmjLTisGoG1Qq2D
         jt9A==
X-Gm-Message-State: ANoB5pkvy0IeQ85hgfjMh17iDANbSj61GOhecUy0zm9r6Jp5GLboVVdX
        9eesN58FXuxfjxAXVtEZ6zM=
X-Google-Smtp-Source: AA0mqf5RQr1VBKfLU1+udXTucL2rFuaiKeQofFtleyvs1i4lfqNMMIe0f8/zF4xbSPHUsogyE51t7Q==
X-Received: by 2002:a17:902:6bc6:b0:17f:8642:7cb9 with SMTP id m6-20020a1709026bc600b0017f86427cb9mr5606649plt.174.1668241997938;
        Sat, 12 Nov 2022 00:33:17 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001870533c443sm3066927plt.236.2022.11.12.00.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 00:33:17 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 0/3] alloc_mode changed after remount on a small volume device
Date:   Sat, 12 Nov 2022 16:32:47 +0800
Message-Id: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
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

This series contains a fix patch for alloc_mode changed after remount
on a small volume device, and do cleanup for 'f2fs_tuning_parameters'
function.

The last one change type for sbi->readdir_ra.

Yuwei Guan (3):
  f2fs: fix to alloc_mode changed after remount on a small volume device
  f2fs: cleanup for 'f2fs_tuning_parameters' function
  f2fs: change type for 'sbi->readdir_ra'

 fs/f2fs/dir.c   |  7 +++----
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/super.c | 35 ++++++++++++++++++-----------------
 fs/f2fs/sysfs.c |  5 +++++
 4 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.34.1


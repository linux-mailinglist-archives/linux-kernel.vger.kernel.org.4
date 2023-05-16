Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1610B705341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjEPQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEPQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:09:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60134D04D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:08:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCac029111;
        Tue, 16 May 2023 11:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=l9AzgEd9FVgYOtjPpkXOXkDV5Y0LT4iZYlTcb1nMxuA=;
 b=D8p65v5BqeGGQqTGqw4LkpFUGeqxi2pLDAblHESA4QJehwhpl9+aB1ESgtjXT/O5ik47
 ri4j6q94HEfN/1IReTlcqRetUWLOdjZVZHtw8Z47SIgCuZGXG+jzJ891TEJZ634ChKWj
 RtXcrROjzdKxqV+sf5amKAB+lKfJlZJmLT0/aZo523DHD0aEQQj6/rxofV1nr1O89FvW
 IlXWGt6jMZcGQvp0VML3nqPQG/Uuh2ApXfStlxDLrc3nWtQ4oNgjH7bWs94rlyOdself
 AIzK0ulmICW7rBqBxGmmHrXw45upKF1KK8vqGBjFJM4XelLCZXNzyJ6jQtX95dR0aVfC oA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvnvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:57 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 11:07:56 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BFA99B38;
        Tue, 16 May 2023 16:07:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/5] debugfs: Fixes and improvements to debugfs_create_str()
Date:   Tue, 16 May 2023 17:07:48 +0100
Message-ID: <20230516160753.32317-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6vNdF13aEgD8RDfyQZReKc9I20BYKlQe
X-Proofpoint-ORIG-GUID: 6vNdF13aEgD8RDfyQZReKc9I20BYKlQe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL-deference bug, kerneldoc errors, minor coding style error.
Also add a wrapper to avoid having to cast a const pointer to non-const.

Richard Fitzgerald (5):
  debugfs: Prevent NULL dereference reading from string property
  debugfs: Remove kerneldoc that says debugfs_create_str() returns a
    value
  debugfs: Update debugfs_create_str() kerneldoc to warn about pointer
    race
  debugfs: Move debugfs_create_str() export to correct location
  debugfs: Add debugfs_create_const_str()

 fs/debugfs/file.c       | 21 +++++++++++----------
 include/linux/debugfs.h | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.30.2


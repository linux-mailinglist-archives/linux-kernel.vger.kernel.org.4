Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566C1702E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbjEONjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbjEONj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:39:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AD10F5;
        Mon, 15 May 2023 06:39:27 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QKgRb61TyzLlp1;
        Mon, 15 May 2023 21:38:03 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 21:39:22 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>, <brauner@kernel.org>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v2 0/2] ovl: Fix null ptr dereference at realinode in rcu-walk
Date:   Mon, 15 May 2023 21:36:27 +0800
Message-ID: <20230515133629.1974610-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
  Extract a helper to get realpath and real inode from ovl inode.
  Get realinode from realpath in do_ovl_get_acl().

Zhihao Cheng (2):
  ovl: ovl_permission: Fix null pointer dereference at realinode in
    rcu-walk mode
  ovl: get_acl: Fix null pointer dereference at realinode in rcu-walk
    mode

 fs/overlayfs/inode.c | 45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

-- 
2.39.2


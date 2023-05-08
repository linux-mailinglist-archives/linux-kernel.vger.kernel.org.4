Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C786FA13F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjEHHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjEHHmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:42:33 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5F19920
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:42:29 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vvVppzG33MVk3vvVppHiv1; Mon, 08 May 2023 09:42:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683531747;
        bh=40maiApoVL/VucoidkRFV2whGpUtUx6B9fd6pg++S/k=;
        h=From:To:Cc:Subject:Date;
        b=D2QwQF0t8cox0Q93u6udOg/olj4OPRQGaaAENj0UmMDsvgDLzBWCH3cE6bmbAyuKQ
         bvLaFuAkqOKH/UwLzQFofyuseYHHIh+TA+MUVCaSVTLx3TuPKXWqOKJxZC0ATO2BT2
         vKTMCE0F86h72lgVM7tUmYr/WN8a5SEcOBm0uRCqRXO4M2AoejHdP3KuiwPRxS1LSX
         KYzGSXcJDCZdTAc1gETCk/6dLjZMtrDBzat/2hCe9ugYjAYQbwk9URoZkw+oFwSFE/
         i7zzY14k74ruBB3uDB9LpJ1EGsrC5cMGm3VsQnqTkymlqiIpnnZTC8xLjPOM+VDF7B
         iWBgEmEjapEZg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 May 2023 09:42:27 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Reorder fields in 'struct devfreq_dev_status'
Date:   Mon,  8 May 2023 09:42:15 +0200
Message-Id: <6b1611f1440c8b73feb475723ad25f390cad3480.1683531691.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct devfreq_dev_status' from 72 to
64 bytes.

This structure is used both to allocate static variables or is embedded in
some other structures. In both cases, reducing its size is nice to have.

Moreover, the whole structure now fits in a single cache line on x86_64.

Finally, it makes the order of code match the order of the above kernel
doc.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct devfreq_dev_profile {
	long unsigned int          initial_freq;         /*     0     8 */
	unsigned int               polling_ms;           /*     8     4 */
	enum devfreq_timer         timer;                /*    12     4 */
	bool                       is_cooling_device;    /*    16     1 */

	/* XXX 7 bytes hole, try to pack */

	int                        (*target)(struct device *, long unsigned int *, u32); /*    24     8 */
	int                        (*get_dev_status)(struct device *, struct devfreq_dev_status *); /*    32     8 */
	int                        (*get_cur_freq)(struct device *, long unsigned int *); /*    40     8 */
	void                       (*exit)(struct device *); /*    48     8 */
	long unsigned int *        freq_table;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               max_state;            /*    64     4 */

	/* size: 72, cachelines: 2, members: 10 */
	/* sum members: 61, holes: 1, sum holes: 7 */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct devfreq_dev_profile {
	long unsigned int          initial_freq;         /*     0     8 */
	unsigned int               polling_ms;           /*     8     4 */
	enum devfreq_timer         timer;                /*    12     4 */
	int                        (*target)(struct device *, long unsigned int *, u32); /*    16     8 */
	int                        (*get_dev_status)(struct device *, struct devfreq_dev_status *); /*    24     8 */
	int                        (*get_cur_freq)(struct device *, long unsigned int *); /*    32     8 */
	void                       (*exit)(struct device *); /*    40     8 */
	long unsigned int *        freq_table;           /*    48     8 */
	unsigned int               max_state;            /*    56     4 */
	bool                       is_cooling_device;    /*    60     1 */

	/* size: 64, cachelines: 1, members: 10 */
	/* padding: 3 */
};
---
 include/linux/devfreq.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 7fd704bb8f3d..d312ffbac4dd 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -108,7 +108,6 @@ struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
 	enum devfreq_timer timer;
-	bool is_cooling_device;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
@@ -118,6 +117,8 @@ struct devfreq_dev_profile {
 
 	unsigned long *freq_table;
 	unsigned int max_state;
+
+	bool is_cooling_device;
 };
 
 /**
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432A65F5C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAEVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjAEVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:30:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7863F47
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:29:58 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c1456d608cso617177b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kg8e6X8QypwU6fo01tgR0TLXOAMliK1bqQELeacQNQs=;
        b=LBIxe1s13Tnk1/aAog7/AORZ2JPm3+K/T/1D2O4ZKNdhK3nXHbC08MLMVzrI79TU7J
         rr6ieT02Yx9S7cQJobVZccIPUQLZByWLYg2V+DFpxJpP+MVf36Vwz96P2UyTMz8Rb4qG
         ZXKimO7h0tQXwVS2SS2IQOlvk1pMNU5TVCQ+MMH4pu7Q/kdxeAyMBwUQHZJXcmetuI5S
         141mx6u4bbQUPh9U6c3K953Jgjbnu/xKafiBN5SqMp081jE1BY0adnXXyEOnonEOVqnF
         hiyzGqo0Y5mn8OhPmsMXpDo4KAtYkvpx0LuyAdJRDxniZNcPACFkrg4fylTu1Vfke/OX
         dVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kg8e6X8QypwU6fo01tgR0TLXOAMliK1bqQELeacQNQs=;
        b=H3b/oAV8VK1+HkK/fvgOPyVfWY2tAj+363U869l4Zb5OBliJkBdAiIHYMKy84z/c9p
         lRSmNLKUeJyT/1TiV4W4FbFRpx8ef0W02T0nctdMTUPvjEq4r3XufS5dXpISZXqnDbYB
         ipNOYEedEDJiYxUyESTOzEn/bMMnwgWM/EfQzcna1oDjrYwSVxiU9pd439TualeWUN5Y
         iPZhpz1VcUcOSWrZYb3mUN/l8h49gdw3zlEESWoeXe4xQhAiIF2Ba8J0pFdH7zG9Ndxl
         4gClvG1qUYRTX7xi2gtc578X/O37mn34VMHZc4CVAFIBDjWcha9tw7psMFiYeZjgPpic
         Lfgg==
X-Gm-Message-State: AFqh2krgwIZo8iH6xqGyeuW295EnK8QHOtAep0sEnxCJtUvfDcOLmG2h
        FYM7VZlALVG/PwUQqmsqjAM8iOyqfI1cPkyh
X-Google-Smtp-Source: AMrXdXsTxKR3Q2YRWauBZcRNoN6TbM+OJa2Nk05OHF5N/06n39nDMUGCHmbEbADUYlQOhyR0UjzMv4jVVmEtx34X
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a81:1751:0:b0:4bd:caff:589e with SMTP
 id 78-20020a811751000000b004bdcaff589emr312806ywx.502.1672954197563; Thu, 05
 Jan 2023 13:29:57 -0800 (PST)
Date:   Thu,  5 Jan 2023 16:29:52 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105212952.56321-1-zenghuchen@google.com>
Subject: [PATCH] i3c: transfer pid from boardinfo to device info
From:   Jack Chen <zenghuchen@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C device PID could be defined in device tree and stored in
i3c_dev_boardinfo. It should be passed to i3c_device_info when
allocating a i3c_dev_desc.
Rational behind this change is: when users decide to use SETDASA to
assign a dynamic address with exactly the original static address, in
step of i3c_master_reattach_i3c_dev, this address is checked to be
taken. Then device information retrieving step is skipped. As a result,
though the i3c device is registered correctly, its device driver could
not be probed.

Tested: Tested with a I3C device. If assigned-address is set to be the
device's static address, without this change, its device driver could
not probed. And with this change, its driver is probed successfully.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/i3c/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d7e6f6c99aea..4dad80338831 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1438,6 +1438,7 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
 {
 	struct i3c_device_info info = {
 		.static_addr = boardinfo->static_addr,
+		.pid = boardinfo->pid,
 	};
 	struct i3c_dev_desc *i3cdev;
 	int ret;
-- 
2.39.0.314.g84b9a713c41-goog


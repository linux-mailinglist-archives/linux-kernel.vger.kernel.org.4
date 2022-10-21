Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB3606D80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJUCRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:17:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9ED2303C2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:17:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so1038801plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWiJ8t0XiMLAp749xvo/D5nNonOax/J4OCA0QCWYKPg=;
        b=IEomqwYECzTday/X19gn4iTn2ESEbePwdvwGUqdpq6cdaCnYL+2390UN6fCz+DZ4MO
         XJq39doIV27N1eDpO4pU7FjUjD/fa5mlKjLyuB/8BdkR9AFdB2IXcKf6FCN+gdc175lO
         CDzhzU2mdRnbUahKFkcZtCmOraLq4Dw1O1Q5LxqY01YwIDWlM4ilYb8ixhMkYmV3CCWt
         VyVfwUOgmodOmazNMgZe6HDjVirJxQQgYlXixkcwsVbxps7D2QuH3Li4ExzjYNdOQWjW
         AfMg4PaBAs3bL6f69l/nuj3igv0KyXjGbvXxyU41dWQqnIc5Gbe9pLgcRaMrVjVFA5ME
         00GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWiJ8t0XiMLAp749xvo/D5nNonOax/J4OCA0QCWYKPg=;
        b=YHt99EP1KJb2X0vl3cITwXuWolXUaYYrep1bePyJaJN47DquWqCAERsNlWEA1A9e1J
         +6g0+1y+/n3g+KrjNvr9fCUu26Vl1YOd1trE7QtfIN7q2YQsicV2LoURvkWGJsTRHked
         Dyy1sJo/oikTo3oJ5EkWZ06E81OIQwgnDKJ6ep32QrVjUyKZmNIOi3Cs+WYz9MUe5cys
         i5mv9ErkA5S9XKvTb0kZ6N7xEq01GpXPWhx86fI8bKq2CSkEuw100YBThB54jxJFTHEH
         O77p+bwSgmBihVwIoSzT/w6IK9PwXEM6B0Szoc2YBHGah5FWZ+IxANUvBI+yJiVXGv8b
         izlg==
X-Gm-Message-State: ACrzQf3DJEkrqkmd2+9/N3HLMAVf/QdrS5C9NmJhsqfg137cXLRYX0yH
        mrJMx7AZk80loS3F/kdiyTk=
X-Google-Smtp-Source: AMsMyM7VA6DBUk4v8CWsrLutpzNM9vktotatoow3OtSe49K0ega/rymrJe+ulbth7DHX6vMkOPyAWw==
X-Received: by 2002:a17:90b:1649:b0:20d:2d96:6b05 with SMTP id il9-20020a17090b164900b0020d2d966b05mr55363430pjb.9.1666318667626;
        Thu, 20 Oct 2022 19:17:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:b022:150a:a87e:ab3a:9736])
        by smtp.gmail.com with ESMTPSA id q10-20020a631f4a000000b0045fcfde8263sm12021822pgm.53.2022.10.20.19.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 19:17:46 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee@kernel.org, matthias.bgg@gmail.com
Cc:     chiaen_wu@richtek.com, andy.shevchenko@gmail.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: mt6370: Add the out-of-bound check to prevent the null pointer
Date:   Fri, 21 Oct 2022 10:17:41 +0800
Message-Id: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This potential risk could happen at regmap_raw_read() or
regmap_raw_write() when accessing the over-bound register address.

For testing, I try to reproduce it with a testing attribute file.
Below's the issue trace log.

[41.314358] pc : i2c_smbus_xfer+0x58/0x120
[41.314371] lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
[41.399677] Call trace:
[41.402153]  i2c_smbus_xfer+0x58/0x120
[41.405956]  i2c_smbus_read_i2c_block_data+0x74/0xc0
[41.410991]  mt6370_regmap_read+0x40/0x60 [mt6370]
[41.415855]  _regmap_raw_read+0xe4/0x278
[41.419834]  regmap_raw_read+0xec/0x240
[41.423721]  rg_bound_show+0xb0/0x120 [mt6370]
[41.428226]  dev_attr_show+0x3c/0x80
[41.431851]  sysfs_kf_seq_show+0xc4/0x150
[41.435916]  kernfs_seq_show+0x48/0x60
[41.439718]  seq_read_iter+0x11c/0x450
[41.443519]  kernfs_fop_read_iter+0x124/0x1c0
[41.447937]  vfs_read+0x1a8/0x288
[41.451296]  ksys_read+0x74/0x100
[41.454654]  __arm64_sys_read+0x24/0x30
[41.458541]  invoke_syscall+0x54/0x118
[41.462344]  el0_svc_common.constprop.4+0x94/0x128
[41.467202]  do_el0_svc+0x3c/0xd0
[41.470562]  el0_svc+0x20/0x60
[41.473658]  el0t_64_sync_handler+0x94/0xb8
[41.477899]  el0t_64_sync+0x15c/0x160
[41.481614] Code: 54000388 f9401262 aa1303e0 52800041 (f9400042)
[41.487793] ---[ end trace 0000000000000000 ]---

Fixes: b2adf788e603 ("mfd: mt6370: Add MediaTek MT6370 support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Dear reviewers:

In v2, I refined the patch title and commit message.

If there's still something improper, please kindly correct me.

---
 drivers/mfd/mt6370.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/mt6370.c b/drivers/mfd/mt6370.c
index cf19cce..acbf960 100644
--- a/drivers/mfd/mt6370.c
+++ b/drivers/mfd/mt6370.c
@@ -190,6 +190,9 @@ static int mt6370_regmap_read(void *context, const void *reg_buf,
 	bank_idx = u8_buf[0];
 	bank_addr = u8_buf[1];
 
+	if (bank_idx >= MT6370_MAX_I2C)
+		return -EINVAL;
+
 	ret = i2c_smbus_read_i2c_block_data(info->i2c[bank_idx], bank_addr,
 					    val_size, val_buf);
 	if (ret < 0)
@@ -211,6 +214,9 @@ static int mt6370_regmap_write(void *context, const void *data, size_t count)
 	bank_idx = u8_buf[0];
 	bank_addr = u8_buf[1];
 
+	if (bank_idx >= MT6370_MAX_I2C)
+		return -EINVAL;
+
 	return i2c_smbus_write_i2c_block_data(info->i2c[bank_idx], bank_addr,
 					      len, data + MT6370_MAX_ADDRLEN);
 }
-- 
2.7.4


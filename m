Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EDF6065D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJTQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJTQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:32:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C51B94F1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:32:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2719535pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdyZhek2+MykVCKjxFxTEgC1cfdd3K346dolNmpDjdI=;
        b=BcbDsUZWZm0mWLLXO06lcwcIhKGa2roJYmuguova1NnzmR3hwGWAaSFEaIMAPJ3G0k
         YZHJzj5uq2CnbxTIyoV59ZcqWBDiwfNIycqfiUQiNz8l/86jJ2fnrFzIW31aLX393/AD
         8t6SUFcHf+qJXZqehpP07t6M4O4MYX3GpD98RO3dVTxYX8YGWrdTWiG8SJsum5FxWDkR
         250kceozN06rRLanw8zdfkPxbPdZBK4y+xW7xM0I/HrMXNrBUiLSKc5Laam0Rf6SSgZs
         IL8pyuxOa8m9FWTNjj1Q9+tG6yDQ+xmnpxlTrVtC9d9AJvtMn0sGcC9/Hp+IR09nx4qX
         ONbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdyZhek2+MykVCKjxFxTEgC1cfdd3K346dolNmpDjdI=;
        b=2kvTsamPYxWedLE7W5mELe8ePtB9FurzCg85LQ66jz6zvc6uVRm4cF11Vs46JpDvZy
         LZzHknO8etgNcfSaFLLfaFCUUP2DiUAMVk+PKz8+GEntb+42V9bI96vBKo02Lg5iecmu
         5FI9h/5dgNfOrdgSxeeLLIlFJbUyEWKOKool+c0Iads2AshXKURfZFOWJ3XP3k7nR9or
         xW7FBJaywX+Q/Q8wT0dWVIBxPe8dJvJzE7SOtjIlZOkbWDgf18h+lCkHAtMWPtrZ+aen
         I7ug84Urk/f4GtzM37KYEovRndN0cWHEjoKVXHey89L0lA98FfSTlY+k2qio7G6Gc/Z3
         amGQ==
X-Gm-Message-State: ACrzQf2cLgeeL5NqY8Z0Xc1VdSPPZwU3oLnlEgUfI6TN8X7UoAJf8Ool
        0xAD9VSOcXYBWxmqqFCWgIs=
X-Google-Smtp-Source: AMsMyM7j7u12Nvn9PZ1Mghyw6V+7mp9mrtiVFP3EoLpXt3Q318+TO7KTOqx9XgNo1TSOjR6y7YPopQ==
X-Received: by 2002:a17:903:1053:b0:185:37cb:da04 with SMTP id f19-20020a170903105300b0018537cbda04mr15070162plc.108.1666283519264;
        Thu, 20 Oct 2022 09:31:59 -0700 (PDT)
Received: from localhost.localdomain (1-171-5-81.dynamic-ip.hinet.net. [1.171.5.81])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b00561d79f1064sm13519291pfb.57.2022.10.20.09.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:31:58 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee@kernel.org, matthias.bgg@gmail.com
Cc:     chiaen_wu@richtek.com, andy.shevchenko@gmail.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: mt6370: Add the overbound check to prevent the null pointer
Date:   Fri, 21 Oct 2022 00:31:53 +0800
Message-Id: <1666283513-17005-1-git-send-email-u0084500@gmail.com>
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

This potential risk could happen at regmap_raw_read or
regmap_raw_write when accessing the over-bound register address.

Below's the issue reproduce log to access over-bound register with
regmap_raw_read function.

[   41.301385] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
[   41.307296] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   41.314358] pc : i2c_smbus_xfer+0x58/0x120
[   41.314371] lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
[   41.314376] sp : ffffffc008ceb9a0
[   41.327261] x29: ffffffc008ceb9a0 x28: 0000000000000000 x27: ffffffc008cebb94
[   41.334505] x26: ffffffe529116000 x25: ffffffc008ceba30 x24: 0000000000000008
[   41.334513] x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
[   41.334520] x20: 0000000000000000 x19: ffffff804e1e8010 x18: ffffffe529116538
[   41.348994] x17: 0000000000000000 x16: ffffffe528ae11f0 x15: ffffff804e1be01e
[   41.349002] x14: 0000000000000000 x13: ffffff804e1bd03c x12: 7220303032783020
[   41.370710] x11: 0000000000000000 x10: 000000000000000a x9 : ffffffc008cebb60
[   41.377953] x8 : 0000000000000000 x7 : ffffffe529116538 x6 : ffffffc008ceba30
[   41.385196] x5 : 0000000000000008 x4 : 0000000000000000 x3 : 0000000000000001
[   41.392436] x2 : 0000000000000000 x1 : 0000000000000002 x0 : ffffff804e1e8010
[   41.399677] Call trace:
[   41.402153]  i2c_smbus_xfer+0x58/0x120
[   41.405956]  i2c_smbus_read_i2c_block_data+0x74/0xc0
[   41.410991]  mt6370_regmap_read+0x40/0x60 [mt6370]
[   41.415855]  _regmap_raw_read+0xe4/0x278
[   41.419834]  regmap_raw_read+0xec/0x240
[   41.423721]  rg_bound_show+0xb0/0x120 [mt6370]
[   41.428226]  dev_attr_show+0x3c/0x80
[   41.431851]  sysfs_kf_seq_show+0xc4/0x150
[   41.435916]  kernfs_seq_show+0x48/0x60
[   41.439718]  seq_read_iter+0x11c/0x450
[   41.443519]  kernfs_fop_read_iter+0x124/0x1c0
[   41.447937]  vfs_read+0x1a8/0x288
[   41.451296]  ksys_read+0x74/0x100
[   41.454654]  __arm64_sys_read+0x24/0x30
[   41.458541]  invoke_syscall+0x54/0x118
[   41.462344]  el0_svc_common.constprop.4+0x94/0x128
[   41.467202]  do_el0_svc+0x3c/0xd0
[   41.470562]  el0_svc+0x20/0x60
[   41.473658]  el0t_64_sync_handler+0x94/0xb8
[   41.477899]  el0t_64_sync+0x15c/0x160
[   41.481614] Code: 54000388 f9401262 aa1303e0 52800041 (f9400042)
[   41.487793] ---[ end trace 0000000000000000 ]---

Fixes: b2adf788e603 ("mfd: mt6370: Add MediaTek MT6370 support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

The previous discussion thread can be found here.
https://lore.kernel.org/all/20220914013345.GA5802@cyhuang-hp-elitebook-840-g3.rt/

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


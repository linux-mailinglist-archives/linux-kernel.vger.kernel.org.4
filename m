Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78445666B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjALHFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjALHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:05:20 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD64BD79
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:05:19 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id jl4so19317160plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCOp7CGKuJgMZcUzydJ2EeFkj94gRUyaqxOKfxChq2U=;
        b=ObYQiTjMQ9zLQ9Y0aV/XuOTFNKjj+rOa3lZzK4STgy6OYXI34kTRdQJ4OkT4Xca/OP
         nyYAU0jRxfnlRRUVeqsZa1WSNxxop4vjw3iAhcAhjSsFWgjDT8U6X45eUk8C7wH8ZM3U
         T4+TURds0hddz4PYN9Exy+5IWJPYhFLr6ep2HRBeORiWmvvuQA5d6YPznhISvjDtrL9a
         ejQ5nMm/E57+K530iqLKxFJClpPjEmXCwQTWsdELmRd3tXiP/53CuCOHEZWerg+4x/vn
         /O3aYAkPhW7dlrmRbqqaqKUIUhu4JP4A9OgIsbcwMKpqfiHDmnj2NGpi1+09cYx1U7Gl
         tzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCOp7CGKuJgMZcUzydJ2EeFkj94gRUyaqxOKfxChq2U=;
        b=fWWl3JW48banJmAjMmya/av1YiSI86zMbWZjNyvQDNfpPIV6HuOXe3DJBEu38N8Vj5
         2NdNFmoMVySD5BZ03h9ppYSJCe0Rr2XHy13v23PTcZKXBJ3QcUIEzHi/beUgAzYO71DC
         UnOM69yvDHDGQqP5H+KDurLvFZGHV4HdJEFD6FaRZCekgxxqEqKcLUk0XhduldemoxpS
         BSX0NZD7lloxTuKK50VNc+Jqkfl+wXLeuftzjPD2zZ8lem0EX6kkXnJhMdm3AcKtA6Yz
         MPkCiMr+O7o2SX7GwfVb25/xqcEutoRgEJfv9oRfTC6ahr5ld+xTpiFVC4Vf4Jwwkytp
         oCaA==
X-Gm-Message-State: AFqh2kqaclQW40JDWaupnzGlPdgnS9aZCe6PZM5a7kPhL3icymXFUPLZ
        qRGh5acv7SrXHlMRXxEkR9J5O6b+pH1hRw==
X-Google-Smtp-Source: AMrXdXuvrDtoFen4tDX84Z/cO/8oQavnbyoLkTlBajI12yiEhuWBhoEGdnbn7p8nj4PpYns5CmS2mA==
X-Received: by 2002:a17:902:9a06:b0:189:8790:73b1 with SMTP id v6-20020a1709029a0600b00189879073b1mr4927212plp.65.1673507107951;
        Wed, 11 Jan 2023 23:05:07 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001925016e34bsm11459695plg.79.2023.01.11.23.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 23:05:07 -0800 (PST)
From:   korantwork@gmail.com
To:     ardb@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>,
        loydlv <loydlv@tencent.com>
Subject: [PATCH] firmware: fix one UAF issue
Date:   Thu, 12 Jan 2023 15:05:03 +0800
Message-Id: <20230112070503.817076-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Xinghui Li <korantli@tencent.com>

There could be the use after free issue in dmi_sysfs_register_handle.
During handling specializations process, the entry->child could be
free if the error occurs. However, it will be kobject_put after free.
So, we set the entry->child to NULL to avoid above case.

Reported-by: loydlv <loydlv@tencent.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/firmware/dmi-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 66727ad3361b..dd4ff5f7e200 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -470,6 +470,7 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 	kobject_del(entry->child);
 out_free:
 	kfree(entry->child);
+	entry->child = NULL;
 	return ret;
 }
 
-- 
2.31.1


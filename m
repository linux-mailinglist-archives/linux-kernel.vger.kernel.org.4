Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB95742671
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjF2MaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2MaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:30:05 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511010FD;
        Thu, 29 Jun 2023 05:30:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QsHpH3xrtz4f3kpX;
        Thu, 29 Jun 2023 20:29:59 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgDHLCcveZ1kP+JxMA--.20756S2;
        Thu, 29 Jun 2023 20:30:00 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Corey Minyard <minyard@acm.org>, Yi Yang <yiyang13@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: [PATCH] ipmi_si: fix a memleak in try_smi_init()
Date:   Thu, 29 Jun 2023 20:33:28 +0800
Message-Id: <20230629123328.2402075-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHLCcveZ1kP+JxMA--.20756S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDZFyxCFy3try8Gry5CFg_yoW8uryxp3
        y5u34DCr4kJr47Ca17Xry7uF98Ja1DCF4UKF47Cw1UXF1DWFyjgr10q3ya9ryDKr4FqF4f
        Arsruw4rt3yUCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Yang <yiyang13@huawei.com>

Kmemleak reported the following leak info in try_smi_init():

unreferenced object 0xffff00018ecf9400 (size 1024):
  comm "modprobe", pid 2707763, jiffies 4300851415 (age 773.308s)
  backtrace:
    [<000000004ca5b312>] __kmalloc+0x4b8/0x7b0
    [<00000000953b1072>] try_smi_init+0x148/0x5dc [ipmi_si]
    [<000000006460d325>] 0xffff800081b10148
    [<0000000039206ea5>] do_one_initcall+0x64/0x2a4
    [<00000000601399ce>] do_init_module+0x50/0x300
    [<000000003c12ba3c>] load_module+0x7a8/0x9e0
    [<00000000c246fffe>] __se_sys_init_module+0x104/0x180
    [<00000000eea99093>] __arm64_sys_init_module+0x24/0x30
    [<0000000021b1ef87>] el0_svc_common.constprop.0+0x94/0x250
    [<0000000070f4f8b7>] do_el0_svc+0x48/0xe0
    [<000000005a05337f>] el0_svc+0x24/0x3c
    [<000000005eb248d6>] el0_sync_handler+0x160/0x164
    [<0000000030a59039>] el0_sync+0x160/0x180

The problem was that when an error occurred before handlers registration
and after allocating `new_smi->si_sm`, the variable wouldn't be freed in
the error handling afterwards since `shutdown_smi()` hadn't been
registered yet. Fix it by adding a `kfree()` in the error handling path
in `try_smi_init()`.

Cc: stable@vger.kernel.org # 4.19+
Fixes: 7960f18a5647 ("ipmi_si: Convert over to a shutdown handler")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index abddd7e43a9a..5cd031f3fc97 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2082,6 +2082,11 @@ static int try_smi_init(struct smi_info *new_smi)
 		new_smi->io.io_cleanup = NULL;
 	}
 
+	if (rv && new_smi->si_sm) {
+		kfree(new_smi->si_sm);
+		new_smi->si_sm = NULL;
+	}
+
 	return rv;
 }
 
-- 
2.25.1


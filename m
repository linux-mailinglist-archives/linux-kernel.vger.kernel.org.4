Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCDD6FE96E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEKB0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEKB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:26:46 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99453C01
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fynBX
        Be0YRetn4JE0IoCqaW6RoGd8z+XaR6yIF0rwKU=; b=gA8N0d0WRlASL1ZRwHBPD
        nnFp90PfkAm5HXlbdhm7shuDwS0zvRLpZhsnF5A64GcPKO0c0m1H1lKhaGmPdnV2
        UPocstIyXlbFANWFGUJq1BRZIVl1Njr9wgyoEDfKg3ikAzdPwFEaeCqeFUHSkUSv
        Qo/ZiRI0NNFCTOQl7qc/MQ=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAnrh4uRFxk8Y0ZBg--.55424S2;
        Thu, 11 May 2023 09:26:07 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, ajones@ventanamicro.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com,
        zhangfei@nj.iscas.ac.cn
Subject: [PATCH v2 0/2] RISC-V: Optimize memset for data sizes less than 16 bytes
Date:   Thu, 11 May 2023 09:26:04 +0800
Message-Id: <20230511012604.3222-1-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnrh4uRFxk8Y0ZBg--.55424S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww17trykXw4DJF1UAr1kZrb_yoW5JrW7pr
        WfGr9xWr15trZ7G3WfJa1kWrn0qr1rtr47tF4xKa48Crn8C3Z8Ar1fCa40gFy7JrWxJr15
        Xr45Xw18uFy5u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtNVkUUUUU=
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/1tbiMhJsl1WB3tErLgAAsF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

At present, the implementation of the memset function uses byte by byte storage 
when processing tail data or when the initial data size is less than 16 bytes. 
This approach is not efficient. Therefore, I filled head and tail with minimal 
branching. Each conditional ensures that all the subsequently used offsets are 
well-defined and in the dest region. Although this approach may result in 
redundant storage, compared to byte by byte storage, it allows storage instructions 
to be executed in parallel, reduces the number of jumps, and ultimately achieves 
performance improvement.

I used the code linked below for performance testing and commented on the memset 
that calls the arm architecture in the code to ensure it runs properly on the 
risc-v platform.

[1] https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memset.c#L53

The testing platform selected RISC-V SiFive U74.The test data is as follows:

Before optimization
---------------------
Random memset (bytes/ns):
           memset_call 32K:0.45 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.30

Medium memset (bytes/ns):
           memset_call 8B:0.18 16B:0.48 32B:0.91 64B:1.63 128B:2.71 256B:4.40 512B:5.67
Large memset (bytes/ns):
           memset_call 1K:6.62 2K:7.02 4K:7.46 8K:7.70 16K:7.82 32K:7.63 64K:1.40

After optimization
---------------------
Random memset bytes/ns):
           memset_call 32K:0.46 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.31
Medium memset (bytes/ns )
           memset_call 8B:0.27 16B:0.48 32B:0.91 64B:1.64 128B:2.71 256B:4.40 512B:5.67
Large memset (bytes/ns):
           memset_call 1K:6.62 2K:7.02 4K:7.47 8K:7.71 16K:7.83 32K:7.63 64K:1.40

From the results, it can be seen that memset has significantly improved its performance with 
a data volume of around 8B, from 0.18 bytes/ns to 0.27 bytes/ns.

The previous work was as follows:
1. "[PATCH] riscv: Optimize memset"
   6d1cbe2e.3c31d.187eb14d990.Coremail.zhangfei@nj.iscas.ac.cn

Thanks,
Fei Zhang

Andrew Jones (1):
  RISC-V: lib: Improve memset assembler formatting

 arch/riscv/lib/memset.S | 143 ++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

zhangfei (1):
  RISC-V: lib: Optimize memset performance

 arch/riscv/lib/memset.S | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)


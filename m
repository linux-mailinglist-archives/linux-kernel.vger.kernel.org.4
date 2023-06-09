Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4872921D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjFIICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbjFIICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:02:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953149F6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:00:23 -0700 (PDT)
X-QQ-mid: bizesmtp75t1686297177txpqd2r4
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 15:52:55 +0800 (CST)
X-QQ-SSF: 01200000000000908000000A0000000
X-QQ-FEAT: +ynUkgUhZJmBFu75q0NPiJ6aTl945nO9gpI8bXNQ/ESzHgPsBD6fTZ5m1288J
        zUyIKDG/VCQPAvgJv00JVCR58ywZjCK6YjDdv0JYBuzp28QKvYJwqgFmgP0oldjR3hTAGFh
        PUgfCXEAj9hNkaK1ifnQvqZt2ZVmVlRKFE9S0CwxsXKkjf++zlB6yn+WLwkCpF6nmISkiYO
        l7FFfKrhTDo2/Gd5+cLEvSf5U2NFe/6FgXmSHV9azmKTFtTXoAbtfmPOnGUr+72hfELjQI2
        LQh2KPGArq0GVhIc115bdF+haP9LAbyfiuQuKkruJFA2zoeWVupU+Wjd++LJOVZKaeyn2/k
        fzwyP1B9I/hfqdM+s03OjYv6W3oVvNP2lpFAA22
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14437550590923538906
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, songshuaishuai@tinylab.org,
        steven.price@arm.com, vincenzo.frascino@arm.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        jeeheng.sia@starfivetech.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH V2 0/4] Remove WARN_ON in save_processor_state
Date:   Fri,  9 Jun 2023 15:50:45 +0800
Message-Id: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hibernation or restoration, freeze_secondary_cpus
checks num_online_cpus via BUG_ON, and the subsequent
save_processor_state also does the checking with WARN_ON.

In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
is not defined, but the sole possible condition to disable 
CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
We also don't have to check it in save_processor_state.

So remove the unnecessary checking in save_processor_state
for ARM,arm64,riscv,xtensa architechtures.

Changes since V1:
https://lore.kernel.org/linux-riscv/20230525025555.24104-1-songshuaishuai@tinylab.org/
- supplement the case of CONFIG_PM_SLEEP_SMP=n in commit message as Will suggests

Song Shuai (4):
  ARM: hibernate: remove WARN_ON in save_processor_state
  arm64: hibernate: remove WARN_ON in save_processor_state
  riscv: hibernate: remove WARN_ON in save_processor_state
  xtensa: hibernate: remove WARN_ON in save_processor_state

 arch/arm/kernel/hibernate.c    | 1 -
 arch/arm64/kernel/hibernate.c  | 1 -
 arch/riscv/kernel/hibernate.c  | 1 -
 arch/xtensa/kernel/hibernate.c | 1 -
 4 files changed, 4 deletions(-)

-- 
2.20.1


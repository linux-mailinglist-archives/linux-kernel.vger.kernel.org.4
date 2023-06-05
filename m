Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E11D7225FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjFEMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjFEMfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:35:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27980113
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:34:56 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxF_El1n1kyRUAAA--.250S3;
        Mon, 05 Jun 2023 20:33:41 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeQk1n1ktncAAA--.1930S2;
        Mon, 05 Jun 2023 20:33:41 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 0/2] Modify code about clone timens
Date:   Mon,  5 Jun 2023 20:33:28 +0800
Message-Id: <1685968410-5412-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxNeQk1n1ktncAAA--.1930S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur15uFyUWFyDurW8uF1ruFX_yoW3ArcE9a
        1xAa95GrWIgFy7ZasFv3WfJ34DJa109FnYyF1agr47JrW5tr13GF4kZw1UAr1Y9rW3Wrsx
        AFW8KF93Ar15KosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYpB-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
  -- Add a new patch to fix broken test under !CONFIG_TIME_NS,
     thanks Thomas.
  -- Add VVAR_NR_PAGES to define VVAR_SIZE, modify stack_top(),
     thanks Wang Rui and Youling.

Tiezhu Yang (2):
  selftests/clone3: Fix broken test under !CONFIG_TIME_NS
  LoongArch: Add support to clone a time namespace

 arch/loongarch/Kconfig                         |  1 +
 arch/loongarch/include/asm/page.h              |  1 +
 arch/loongarch/include/asm/vdso/gettimeofday.h | 10 ++-
 arch/loongarch/include/asm/vdso/vdso.h         | 32 +++++++--
 arch/loongarch/kernel/process.c                |  2 +-
 arch/loongarch/kernel/vdso.c                   | 98 +++++++++++++++++++++-----
 arch/loongarch/vdso/vgetcpu.c                  |  3 +-
 tools/testing/selftests/clone3/clone3.c        |  7 +-
 8 files changed, 129 insertions(+), 25 deletions(-)

-- 
2.1.0


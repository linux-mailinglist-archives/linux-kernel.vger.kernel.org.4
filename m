Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6B65766E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiL1Mbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiL1Mbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:31:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB45460E3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:31:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NhrQ4631dz9t2b;
        Wed, 28 Dec 2022 20:27:40 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 20:31:33 +0800
To:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
Date:   Wed, 28 Dec 2022 20:31:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

When I compile the mainline kernel v6.2-rc1, the below link error occurs:

ld: arch/x86/kernel/fpu/signal.o: in function `__fpu_restore_sig':
/home/linmiaohe/linux-next/arch/x86/kernel/fpu/signal.c:421: undefined reference to `convert_to_fxsr'
make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make: *** [Makefile:1252: vmlinux] Error 2
make: *** Waiting for unfinished jobs....

I think it's because convert_to_fxsr() is only defined when CONFIG_X86_32 or CONFIG_IA32_EMULATION is enabled. But it can be
call from __fpu_restore_sig() via below path:

bool fpu__restore_sig(void __user *buf, int ia32_frame):

        if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
                success = !fpregs_soft_set(current, NULL, 0,
                                           sizeof(struct user_i387_ia32_struct),
                                           NULL, buf);
        } else {
                success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate); /* Will call convert_to_fxsr() later. */
        }

__fpu_restore_sig() will call convert_to_fxsr() even if neither CONFIG_X86_32 nor CONFIG_IA32_EMULATION is enabled. So the link error occurs.
But I'm not really sure how to fix it. Any reply or fix is appreciated.

Thanks,
Miaohe Lin

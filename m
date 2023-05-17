Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A8705C19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjEQAsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjEQAsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:48:20 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A815D44A2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1684284496;
        bh=XyFTLbNY2uiLaDjguGfGJ1EZzaGbJ95POj2AKpq8ELQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=x0Q4JwCdjaHdQ9jlyf6TLJkrW9YulWkzd+En+oJ24D39hFK1V/wESHqcZp2s3T3x9
         s7xDehZUsY//QZn1Iqm0h9dZUwdzp1qHqzhdww+WE6cfE2QLUU+rzvLnX9bfOCKnfF
         YGHKDTkjY7+tILaX3YkVbbyXTg5ufKKO2qgQs36M=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id A600EE6D; Wed, 17 May 2023 08:41:32 +0800
X-QQ-mid: xmsmtpt1684284092tpri27jxb
Message-ID: <tencent_84FB1255E5E4157DD418B1DBA0418832AB05@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTPAq7WF7g3gWTnhEdpnDyrqA8tyJUc4nXD9w2ekq45Jv9kcUb6A
         O5sWVDUCk3oIOnlkxQib0eGWSjm4vJo8HyawaTqDmYXWd250bYZagJkh2kLrFowQ1b5qonpUSO4H
         qqX9i/UPy69VOaF8M6cQOHa63d1357D9sB1ceVCK5jRL9Y6oKoX/29ze5rdwQtfBYs1iUmat8Sja
         CIy0fmznK1ThShmYBgdZ+ouIxDI5G//A2NDzEcBlfxvoOVV0j/bWos+rSYUxzQHVztAf5uglMcaX
         fQRXnjxpZ758UF717a+P4KkPmT4TYrAYitwKD9Fx3lnIpGWt5ibn8S4Vso88C0qXBIGbNepWB8z8
         du3YU8lc9OaQ+VdI8bwMhzM6OX3DP2kp1Tx2DsQNIoHyE3QJ8jOZv0JZGrV3QP42p43OcLHOw9DV
         dovuzZiPaqy04YD029Gq1K92TSTNa8mHqFaH5tqWZzbh6Gsejd76tg74F+OrN+9ISG45B3ygrUwf
         d2e0of5AciaVijsgCQhkVjYby9j8GrKFJqsByu9HBP18YiES0bAI2H/9U53oYKoXWYQSfAB7KE/Z
         wwT+WRAiC9IDpHbGuUoS4ktloXBENT9xRRA5M1p+kgqOzaF3OpG/SDa/GAUHpgTPsNS9+Nn8wZVz
         too53oBsJ5M/oHe9qSoDVaNOVt28czCcvvkQNWkg/STM/+RqZipj1d6CcVQlceE+hjfco54Jh1wX
         M4C6LNA7EBIb4yEkR2J9vO244o6kyggO5k7Zf0xryqowRNtvejy0CfMZpXgC7IjHoGsWrSfNmveU
         3qVgGUA0iFmaN/6ITPmUHzUXEMmUiU8FUTzjqmzR/bOBaUP4qf38wWggo+P33W/HODO6Lk1qhm5T
         AxPLRHu6PrAvCwXtKE4iJCBdDxBI+C54D0Tx9iMxnkq0Bgtqw7aBHjrQtQPEvXpcCq44OCIL69p4
         kThbezyU2kMAfTzdaSsauWzsT6nF5Ejqz2cMkH92kugLdmq0DOtprEwMotqJ+V9B7OqL5Fr+YdB8
         ogvQ7kEg==
From:   Rong Tao <rtoax@foxmail.com>
To:     rtoax@foxmail.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de, luto@kernel.org
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rongtao@cestc.cn, x86@kernel.org
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
Date:   Wed, 17 May 2023 08:41:31 +0800
X-OQ-MSGID: <20230517004131.6173-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
References: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all very much for your responses, I tested the test code
evil-clock-test[0] provided by Andy, this patch does cause time read errors
and load errors.

    $ ./evil-clock-test.out -c monotonic
    CPU vendor   : GenuineIntel
    CPU model    : Intel(R) Core(TM) i7-10710U CPU @ 1.10GHz
    CPU stepping : 0
    TSC flags    : tsc rdtscp constant_tsc tsc_known_freq tsc_deadline_timer tsc_adjust
    Will test the "CLOCK_MONOTONIC" clock.
    Now test failed  : worst error 255 with 81902816 samples
    Load3 test failed: worst error 384 with 3284297 samples
    Load test passed : margin 32 with 18848374 samples
    Store test failed as expected: worst error 704 with 18213325 samples

Thanks again :)

[0] https://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git/tree/evil-clock-test.cc


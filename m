Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A699745441
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGCDoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:44:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35F123
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:44:29 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QvWvX6rFRzLnct;
        Mon,  3 Jul 2023 11:42:16 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 11:44:26 +0800
Message-ID: <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com>
Date:   Mon, 3 Jul 2023 11:44:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To:     <tglx@linutronix.de>
CC:     <arjan@linux.intel.com>, <ashok.raj@intel.com>,
        <ashok.raj@linux.intel.com>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <thomas.lendacky@amd.com>, <tony.luck@intel.com>,
        <tonyb@cybernetics.com>, <x86@kernel.org>,
        yangerkun <yangerkun@huawei.com>
References: <20230615193330.608657211@linutronix.de>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
Subject: [BUG REPORT] Triggering a panic in an x86 virtual machine does not
 wait
In-Reply-To: <20230615193330.608657211@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I manually trigger panic in a qume x86 VM with

        `echo c > /proc/sysrq-trigger`,

  I find that the VM will probably reboot directly, but the 
PANIC_TIMEOUT is 0.
This prevents us from exporting the vmcore via panic, and even if we succeed
in panic exporting the vmcore, the processes in the vmcore are mostly
stop_this_cpu(). By dichotomizing we found the patch that introduced the
behavior change

    45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible"),

can anyone help to see what is happening?

Thanks!
-- 
With Best Regards,
Baokun Li
.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8098704F64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEPNdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjEPNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:33:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E393C1D;
        Tue, 16 May 2023 06:33:08 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QLHD43sp4zLpx1;
        Tue, 16 May 2023 21:30:12 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 21:33:04 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <linux-acpi@vger.kernel.org>,
        <weiyongjun1@huawei.com>
Subject: [PATCH 0/2] drivers/cpufreq: gain accurate CPU frequency from cpufreq/scaling_cur_freq
Date:   Tue, 16 May 2023 21:32:48 +0800
Message-ID: <20230516133248.712242-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516133248.712242-1-zengheng4@huawei.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users want to get frequency by scaling_cur_freq under cpufreq sysfs,
they often get the invalid result like:

$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq
4294967295

So this series provides fixes to the concerned issue.

Zeng Heng (2):
  cpufreq: CPPC: keep target core awake when reading its cpufreq rate
  acpi: CPPC: read delivered_reg and reference_reg in critical section

 drivers/acpi/cppc_acpi.c       |  4 ++++
 drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

--
2.25.1


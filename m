Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06CB729809
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbjFILRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjFILRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E3C1;
        Fri,  9 Jun 2023 04:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B312565711;
        Fri,  9 Jun 2023 11:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD5C433D2;
        Fri,  9 Jun 2023 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686309415;
        bh=4WrX2SLhIZXcNbbPm+X8AVze8JMkGgf+OMnaQdflIDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0ViuyF7DVQYDXJ52IPxtKCSODRiI6e689vhUFyuYXWiiWXsffISPOTGUEyx4An3g
         YpvlzDyQ70seB/tA0hoSGEEQAK4N0jI45HfT3Dk7DyGtJDkQfFQc1b203n9Yj8Frxf
         CJ11RVWUSTNHZZXnw/uirFYJYjPcMuCN4ZortSC1rxDo2yuO+3jhWdIPkugCkZsEIb
         5opM18frCNcsLs0GfC2aa/bB6Gv7iUiiuOyJ91cyO3i2fUb2OaI03QIhqTIbK6rC6S
         hzwI3eZp07yoKbtT8LPErqUX8aeLTSTHIRMeWofhYvayVrl3D8ZTQ2UCA57t2WmCjL
         Ph2LkC+N3P3zg==
From:   Will Deacon <will@kernel.org>
To:     Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, jonathan.cameron@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, shenyang39@huawei.com,
        yangyicong@huawei.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
Date:   Fri,  9 Jun 2023 12:16:45 +0100
Message-Id: <168630624940.3062264.11759068131610200967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230608114326.27649-1-hejunhao3@huawei.com>
References: <20230608114326.27649-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 19:43:26 +0800, Junhao He wrote:
> The driver needs to migrate the perf context if the current using CPU going
> to teardown. By the time calling the cpuhp::teardown() callback the
> cpu_online_mask() hasn't updated yet and still includes the CPU going to
> teardown. In current driver's implementation we may migrate the context
> to the teardown CPU and leads to the below calltrace:
> 
> ...
> [  368.104662][  T932] task:cpuhp/0         state:D stack:    0 pid:   15 ppid:     2 flags:0x00000008
> [  368.113699][  T932] Call trace:
> [  368.116834][  T932]  __switch_to+0x7c/0xbc
> [  368.120924][  T932]  __schedule+0x338/0x6f0
> [  368.125098][  T932]  schedule+0x50/0xe0
> [  368.128926][  T932]  schedule_preempt_disabled+0x18/0x24
> [  368.134229][  T932]  __mutex_lock.constprop.0+0x1d4/0x5dc
> [  368.139617][  T932]  __mutex_lock_slowpath+0x1c/0x30
> [  368.144573][  T932]  mutex_lock+0x50/0x60
> [  368.148579][  T932]  perf_pmu_migrate_context+0x84/0x2b0
> [  368.153884][  T932]  hisi_pcie_pmu_offline_cpu+0x90/0xe0 [hisi_pcie_pmu]
> [  368.160579][  T932]  cpuhp_invoke_callback+0x2a0/0x650
> [  368.165707][  T932]  cpuhp_thread_fun+0xe4/0x190
> [  368.170316][  T932]  smpboot_thread_fn+0x15c/0x1a0
> [  368.175099][  T932]  kthread+0x108/0x13c
> [  368.179012][  T932]  ret_from_fork+0x10/0x18
> ...
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
      https://git.kernel.org/will/c/7a6a9f1c5a0a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

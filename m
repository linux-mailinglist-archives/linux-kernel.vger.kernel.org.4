Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7C7122D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjEZI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbjEZI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:58:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C712A;
        Fri, 26 May 2023 01:58:49 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QSJd26cYrzqSZW;
        Fri, 26 May 2023 16:54:14 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 16:58:46 +0800
Message-ID: <9025b93a-faec-bc84-00c4-34a3b1c01b35@huawei.com>
Date:   Fri, 26 May 2023 16:58:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>, <sumitg@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <linux-acpi@vger.kernel.org>,
        <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        Yang Shi <yang@os.amperecomputing.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/17 16:17, Pierre Gondois 写道:
> +Ionela, Sumit, Yang,
>
> Hello Zeng,
>
> I think solutions around related issues were suggested at:
>
> [1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> [2] 
> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
>
> About this patch, it seems to mean that CPPC counters of CPUx are always
> accessed from CPUx, even when they are not AMUs. For instance CPPC
> counters could be memory mapped and accessible from any CPU.
> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
> and [2] had an implementation using it.
>
> Another comment about PATCH 2/2 is that if the counters are accessed
> through FFH, arm64 version of cpc_read_ffh() is calling
> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
> to specify the function must be called with interrupt enabled.
>
> I think the best solution so far was the one at [3], suggested by Ionela,
> but it doesn't seem to solve your issue. Indeed, it is not checked 
> whether
> the counters are AMU counters and that they must be remotely read (to
> have the CPU awake),
>
> Regards,
> Pierre


Here is segment I picked from patch[3], and there is a modification is 
deserved to be discussed:

---------------------------------------------------------------------------

@@ -1336,8 +1361,25 @@ int cppc_get_perf_ctrs(int cpunum, struct 
cppc_perf_fb_ctrs *perf_fb_ctrs)
          }
      }

-    cpc_read(cpunum, delivered_reg, &delivered);
-    cpc_read(cpunum, reference_reg, &reference);
+    ctrs.cpunum = cpunum;
+    ctrs.delivered_reg = delivered_reg;
+    ctrs.reference_reg = reference_reg;
+    ctrs.delivered = &delivered;
+    ctrs.reference = &reference;
+

+    if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {

Here we call cpu_has_amu_feat() as precondition (like Sumit's mail 
mentions), which could be compatible with

any SoCs with AMU that could be accessible via sys-register and system 
memory both.


+        ret = smp_call_on_cpu(cpunum, cppc_get_cycle_ctrs, &ctrs, false);
+    } else {
+        if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
+            CPC_IN_SYSTEM_MEMORY(reference_reg)) {
+            local_irq_save(flags);
+            cppc_get_cycle_ctrs(&ctrs);
+            local_irq_restore(flags);
+        } else {
+            cppc_get_cycle_ctrs(&ctrs);
+        }
+    }
+
      cpc_read(cpunum, ref_perf_reg, &ref_perf);

-----------------------------------------------------------------------------------

If there were a new version patch released, please loop me at that time.

Thanks a lot in advance.


B.R.,

Zeng Heng



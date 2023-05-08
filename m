Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C456FADF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjEHLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjEHLje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:39:34 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54193F576;
        Mon,  8 May 2023 04:39:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vi5DWRE_1683545947;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi5DWRE_1683545947)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:39:08 +0800
Message-ID: <9f01bb3c-2f90-0784-d1ee-ff2ebcd92b1b@linux.alibaba.com>
Date:   Mon, 8 May 2023 19:39:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/5] perf jevents: Add support for Yitian 710 DDR PMU
 aliasing
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-5-git-send-email-renyu.zj@linux.alibaba.com>
 <6ca986e4-38a0-4296-5307-e6e344c62853@linux.alibaba.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <6ca986e4-38a0-4296-5307-e6e344c62853@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/4 下午3:18, Shuai Xue 写道:
> 
> 
> On 2023/4/24 17:44, Jing Zhang wrote:
>> Add support for T-HEAD Yitian 710 SoC DDR PMU aliasing.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
>>  tools/perf/pmu-events/jevents.py                   |   1 +
>>  2 files changed, 374 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>> new file mode 100644
>> index 0000000..f17f239
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>> @@ -0,0 +1,373 @@
>> +[
>> +	{
>> +		"BriefDescription": "A Write or Read Op at HIF interface. 64B",
>> +		"ConfigCode": "0x0",
>> +		"EventName": "hif_rd_or_wr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Write Op at HIF interface. 64B",
>> +		"ConfigCode": "0x1",
>> +		"EventName": "hif_wr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Read Op at HIF interface. 64B",
>> +		"ConfigCode": "0x2",
>> +		"EventName": "hif_rd",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Read-Modify-Write Op at HIF interface. 64B",
>> +		"ConfigCode": "0x3",
>> +		"EventName": "hif_rmw",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A high priority Read at HIF interface. 64B",
>> +		"ConfigCode": "0x4",
>> +		"EventName": "hif_hi_pri_rd",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A write data cycle at DFI interface (to DRAM)",
> 
> Add an ending period to BriefDescription as you do latter.
> 

Ok.

>> +		"ConfigCode": "0x7",
>> +		"EventName": "dfi_wr_data_cycles",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A read data cycle at DFI interface (to DRAM).",
>> +		"ConfigCode": "0x8",
>> +		"EventName": "dfi_rd_data_cycles",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A high priority read becomes critical.",
>> +		"ConfigCode": "0x9",
>> +		"EventName": "hpr_xact_when_critical",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A low priority read becomes critical.",
>> +		"ConfigCode": "0xA",
>> +		"EventName": "lpr_xact_when_critical",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A write becomes critical.",
>> +		"ConfigCode": "0xB",
>> +		"EventName": "wr_xact_when_critical",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "An Activate (ACT) command to DRAM.",
>> +		"ConfigCode": "0xC",
>> +		"EventName": "op_is_activate",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Read or Write CAS command to DRAM.",
>> +		"ConfigCode": "0xD",
>> +		"EventName": "op_is_rd_or_wr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "An ACT command for read to DRAM.",
>> +		"ConfigCode": "0xE",
>> +		"EventName": "op_is_rd_activate",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Read CAS command to DRAM.",
>> +		"ConfigCode": "0xF",
>> +		"EventName": "op_is_rd",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Write CAS command to DRAM.",
>> +		"ConfigCode": "0x10",
>> +		"EventName": "op_is_wr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Masked Write command to DRAM.",
>> +		"ConfigCode": "0x11",
>> +		"EventName": "op_is_mwr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Precharge (PRE) command to DRAM.",
>> +		"ConfigCode": "0x12",
>> +		"EventName": "op_is_precharge",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A PRE required by read or write.",
> 
> A non-abbreviation format is prefered here.
> 

Ok.

>> +		"ConfigCode": "0x13",
>> +		"EventName": "precharge_for_rdwr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A PRE required by other conditions.",
>> +		"ConfigCode": "0x14",
>> +		"EventName": "precharge_for_other",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A read-write turnaround.",
>> +		"ConfigCode": "0x15",
>> +		"EventName": "rdwr_transitions",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A write combine (merge) in write data buffer.",
>> +		"ConfigCode": "0x16",
>> +		"EventName": "write_combine",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Write-After-Read hazard.",
>> +		"ConfigCode": "0x17",
>> +		"EventName": "war_hazard",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Read-After-Write hazard.",
>> +		"ConfigCode": "0x18",
>> +		"EventName": "raw_hazard",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A Write-After-Write hazard.",
>> +		"ConfigCode": "0x19",
>> +		"EventName": "waw_hazard",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank0 enters self-refresh (SRE).",
>> +		"ConfigCode": "0x1A",
>> +		"EventName": "op_is_enter_selfref_rk0",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank1 enters self-refresh (SRE).",
>> +		"ConfigCode": "0x1B",
>> +		"EventName": "op_is_enter_selfref_rk1",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank2 enters self-refresh (SRE).",
>> +		"ConfigCode": "0x1C",
>> +		"EventName": "op_is_enter_selfref_rk2",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank3 enters self-refresh (SRE).",
>> +		"ConfigCode": "0x1D",
>> +		"EventName": "op_is_enter_selfref_rk3",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank0 enters power-down (PDE).",
>> +		"ConfigCode": "0x1E",
>> +		"EventName": "op_is_enter_powerdown_rk0",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank1 enters power-down (PDE).",
>> +		"ConfigCode": "0x1F",
>> +		"EventName": "op_is_enter_powerdown_rk1",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank2 enters power-down (PDE).",
>> +		"ConfigCode": "0x20",
>> +		"EventName": "op_is_enter_powerdown_rk2",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "Rank3 enters power-down (PDE).",
>> +		"ConfigCode": "0x21",
>> +		"EventName": "op_is_enter_powerdown_rk3",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A cycle that Rank0 stays in self-refresh mode.",
>> +		"ConfigCode": "0x26",
>> +		"EventName": "selfref_mode_rk0",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A cycle that Rank1 stays in self-refresh mode.",
>> +		"ConfigCode": "0x27",
>> +		"EventName": "selfref_mode_rk1",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A cycle that Rank2 stays in self-refresh mode.",
>> +		"ConfigCode": "0x28",
>> +		"EventName": "selfref_mode_rk2",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A cycle that Rank3 stays in self-refresh mode.",
>> +		"ConfigCode": "0x29",
>> +		"EventName": "selfref_mode_rk3",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "An auto-refresh (REF) command to DRAM.",
>> +		"ConfigCode": "0x2A",
>> +		"EventName": "op_is_refresh",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A critical REF command to DRAM.",
>> +		"ConfigCode": "0x2B",
>> +		"EventName": "op_is_crit_ref",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "An MRR or MRW command to DRAM.",
>> +		"ConfigCode": "0x2D",
>> +		"EventName": "op_is_load_mode",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A ZQCal command to DRAM.",
>> +		"ConfigCode": "0x2E",
>> +		"EventName": "op_is_zqcl",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "At least one entry in read queue reaches the visible window limit.",
>> +		"ConfigCode": "0x30",
>> +		"EventName": "visible_window_limit_reached_rd",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "At least one entry in write queue reaches the visible window limit.",
>> +		"ConfigCode": "0x31",
>> +		"EventName": "visible_window_limit_reached_wr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A DQS Oscillator MPC command to DRAM.",
>> +		"ConfigCode": "0x34",
>> +		"EventName": "op_is_dqsosc_mpc",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A DQS Oscillator MRR command to DRAM.",
>> +		"ConfigCode": "0x35",
>> +		"EventName": "op_is_dqsosc_mrr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A TCR (Temperature Compensated Refresh) MRR command to DRAM.",
>> +		"ConfigCode": "0x36",
>> +		"EventName": "op_is_tcr_mrr",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A ZQCal Start command to DRAM.",
>> +		"ConfigCode": "0x37",
>> +		"EventName": "op_is_zqstart",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A ZQCal Latch command to DRAM.",
>> +		"ConfigCode": "0x38",
>> +		"EventName": "op_is_zqlatch",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A packet at CHI TXREQ interface (request).",
>> +		"ConfigCode": "0x39",
>> +		"EventName": "chi_txreq",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A packet at CHI TXDAT interface (read data).",
>> +		"ConfigCode": "0x3A",
>> +		"EventName": "chi_txdat",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A packet at CHI RXDAT interface (write data).",
>> +		"ConfigCode": "0x3B",
>> +		"EventName": "chi_rxdat",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A packet at CHI RXRSP interface.",
>> +		"ConfigCode": "0x3C",
>> +		"EventName": "chi_rxrsp",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "A violation detected in TZC.",
>> +		"ConfigCode": "0x3D",
>> +		"EventName": "tsz_vio",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	},
>> +	{
>> +		"BriefDescription": "The ddr cycle.",
>> +		"ConfigCode": "0x80",
>> +		"EventName": "cycle",
>> +		"Unit": "ali_drw",
>> +		"Compat": "ali_drw_pmu"
>> +	}
>> +]
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 7cff2c6..aff4051 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -257,6 +257,7 @@ class JsonEvent:
>>            'cpu_core': 'cpu_core',
>>            'cpu_atom': 'cpu_atom',
>>            'arm_cmn': 'arm_cmn',
>> +          'ali_drw': 'ali_drw',
>>        }
>>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>>  
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Best Regards,
> Shuai

Thanks!

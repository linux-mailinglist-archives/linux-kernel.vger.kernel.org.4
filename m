Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B5633A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiKVKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKVKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:36:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061931FBD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmxZQWd4jvdNNrqP7up6KJOa2oszU27VQ3w8nDDd6Vv5uh0EoeTBO27WBSm+AFCwA+k21J36IMGuQ7WVcmoTIyEoqZAo/uvBEAXebXgURHgSirrH51FVbYRF2QWaipaFlAOTVqJWMTvsMomuuVkq/tjlu+tcR9GeRmCBLkQlcywzzR3ufrAzBQ4LVjCf+mrQVl25K/HbKMVQ3x6aZVNhfDoOjaLgnzsgwtBe1t+A+Dt+cMskZ9BhpdSfrFwtnrmfAvddA7lfaKq3CrVG9kBQ3YUHb7OYIvT2zOCC3EcjS8SiTPxok7FwXuOUewZfKD18nh4j457ZB/jP/wXm3QnK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In3DcpxyTIgGC4X+ey9X/IMQa8YHPwC3J862FMF1Ti0=;
 b=fXLfnTdd2z0fsNoisHdzrefv6HeGt0sso2gYktmOYpgmGmihI9p9Lcd6nl822ZS6iu1bynNbENrenM0SkFwyxsVbT1iKDAkOw/a5TzQT9t1CzOzhbW+N4lI/CgEWQz5AJ9i55X4jgdnNEwcJGFerckeUCCq+LTnvQBoTABbzJS3s6+NVuz2ufutPRmOrg93VUwCXOsg50IKffXyKjBiVSrLU09x40vFKpT+PM+4xysiF6LUFxFhjowqfFdLzEkMIA+UsFM2w85vlR1EyHVAVEF0y8brKaHUH+XxlE+QwknnUvokZ78RoxH01Cfl9X1PXI0WahBrGOwwZ3l36koC5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In3DcpxyTIgGC4X+ey9X/IMQa8YHPwC3J862FMF1Ti0=;
 b=loKDUDBtZNv6hLWyl5UzAdCqEyAKH//rhGEUp+/WFgcn2Mlx86MM94ytWkEWuEQF4sGrVRL2Qtfb1BtMllqsChmLwh3o3aKI/IbdJS6clomwiUMroCVPuVp+KWpK6z4OqCDgB5rbq7lUQmYH/9koYxihni2GgRbVbvwA7nZn9IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:31:56 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:31:56 +0000
Message-ID: <9b639dbe-15ec-da58-9e11-0b3b76a3fa1d@amd.com>
Date:   Tue, 22 Nov 2022 16:01:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v2 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1666531576.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1666531576.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9b4934-e414-4e0c-2f03-08dacc74c72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCcKm4dFjy6My7QLyRT8Ur4ijWmryMN4l1fagFsy1Uw9Ei/GiFVB87rXduKk31ItYqFIqMzZfVSk+Cy8Fs0sag82FIEJlJZuVbZBcW9ooPDyP6SFBmWlt26uNII2Ikv1oiN8cqmfwNZSKByHaw3McJvz6ostJF1ldUFrYC2YUhAmU3xMDiu4pUgBKgjSm3nfQhTLlGXWfWrp9WHW69HB5WIja8UmhtKuH/p3BSNWCP7agbALf7P4iLIKYAnSXf19SrEZ2cQ7GhSHIbXHY/fgnGmRAmGjEChfz2cHSdF0scIXCYJJ12RXf972Z0smQq02tBpUp6fcT3N4YTIRHrEO0RF2qDBbpZQ3t2rHXJkhzubaBnnn9Rm953F+S8Rv18hPZOB5FIWho27POaTa4y5QQCrKKsIAGx5IAXv7cIdBfiReOSQfMn1Odr1GhIlWu7ref1WxJVwNRaNWk90tWqprPMYDPz/t1jz0iaSm6XhXzphDp5HDAC4D4fbU1wHWsoK5FkGKUfYigzFlH0DlbCXCMSI/W05JD0dhT9g23UHrcflnp4hx/VGiMva46RhlYp+HN26znHI850Ye0OODhYmEx9ZY3XlhYsJxJ1gLs1o8Md2TEnlWImYPFIWqPKatZw037cLhuWDg8gm6BOHeIN7nUR4a/dMCDcv4Ns26BbqVV7bW73MRM502hNSH3nGZVxo1eCXS0ZWtpjUIP3dwOSMQeLAmMelhh4p7w1qvU96fHC9WGkwJkPxduCmzJulpCdhSBWIsNtl/cFKiSpvQORZpzux+gjNqbJjGBs8OXD05stE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(966005)(31686004)(41300700001)(8936002)(7416002)(30864003)(54906003)(316002)(66946007)(5660300002)(66556008)(4326008)(66476007)(8676002)(31696002)(86362001)(36756003)(6506007)(6666004)(478600001)(83380400001)(6486002)(26005)(110136005)(2906002)(2616005)(186003)(53546011)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1h4N3d1SUVNbEZiRHRTWm53V3pIQy9vVVZjMUI0ZTFLTmVUVndZR2FxMklv?=
 =?utf-8?B?VkhmZ3Y3ZzdpczZhVzcveGFPTjlnKzhFV3YxNFF5cHBtVUFiN1d0TS9UY0xW?=
 =?utf-8?B?Rk1LNW0rd2FjUDd5OTVPSGU3T3FnRFJQb0UvSHFVTGk4cU1uYi85dmxFWmpS?=
 =?utf-8?B?aTNtNEkzanArY0NsN1I5Y09jQ0F1RnQzVHdmSXkwWUN5TmxuYjMwZjVmT0FE?=
 =?utf-8?B?akEydzRRQ1Z2aUczU0djUCtOL3hMLzY0SWVWMUI3eG1uV2VIS0x5ZDlobmgr?=
 =?utf-8?B?SzMvQmtoVnluSEE3TWlFZDJ5Wlpjei8yUXR6YS9tbzdaMmlBK2ZHREszZ2xl?=
 =?utf-8?B?d3Y3RGM0VnZRWDBSMk50UVF3VFA2YWtHNlVoTmtwV25UZFdscDZLK00rRmV5?=
 =?utf-8?B?Mnp6UXQxMlVSOVdxV1gxemZaU1BHUWVZM3BUV2w5VFVDbkV6c3oydEVmM0g2?=
 =?utf-8?B?S1VLVDVzdWh6NFIxK3duMHZEYkE0Sll0L2pJZFI5YjZ2anJCeXl1YUpUaCtX?=
 =?utf-8?B?RjhGYkl5QVZLME1ZZVhZbHBsNWxzSUlMYVRKKzBsT3dDZlpQZlpNYzA4OUpB?=
 =?utf-8?B?RTFIMjc0TXRuZVpaaUpheU4zRU5UN283d1M1ME5sUW1jMmtUQk8xalpXTStC?=
 =?utf-8?B?YUxyVUZYZGp5RG5FRGMydWl5KzR4VzJEMlpWbk9JY1BLelNmSUZHeVVZOWRJ?=
 =?utf-8?B?Q0dudFVUSVU3VHhIRXd0ODZUQUNxSTdvejR3ZXJlakFoMFA0bC94MEpxY0pl?=
 =?utf-8?B?RjVqWTFqUmtlV2dTY2VpVEFMekpzL3JjbktuN1pscWllaFlOUFZQaGNGSGQz?=
 =?utf-8?B?UkV1dVYxOWhzb2dXQXlsVVNBQ0NPaHVCTWI2TUVtWnZod09iZWhMbVprRkVZ?=
 =?utf-8?B?d2psRDJWU3FNSHRzRlVENjhoaXVpOHEyQ1l5UXJYWTFSNlUrQlVYUmk4dHM2?=
 =?utf-8?B?VXdoazZKOHNWTExmMTZTbENYOHZsSENtUXJwdEpzWFRVa1pJUmxzVkJGeVdW?=
 =?utf-8?B?OXp4MUlzTXpuZ3liWU44c2IrZGdlSEhZZU5uT0ZKMUFNMEd5K0M4eU5MMzBW?=
 =?utf-8?B?aG1LNkpzNGpMMzA2cUlxNXEvaVBNWkhhN1h3YnpsVHN5OHJhQjd6Qy9ZMXJU?=
 =?utf-8?B?SUp2SUl5Z0VRWDFuM2w4eEdNa21ET0NrbGVVZVhra3lwbGViOExxYzhqSFFO?=
 =?utf-8?B?NVE3Nko1ZXdnQjhPWTRSNW5lQ25DTzFYemZhZWpiUXZnWjhyNkt4QmtVYzZo?=
 =?utf-8?B?SjYyUFhCc21vcUxYRGNDa2drMnhOeVVrU1dWcVI2cWhRV3pqaVQyc3RDSHBP?=
 =?utf-8?B?QS9wYmJUdmRZMGFQWHYxM0R3cjQ0UzloRTU0V04wR3l5ZUpuR3VzaVd2dnBX?=
 =?utf-8?B?V3A5UWMvWDE4L0VCQ3FOTXhCZGVML2JUOCtjWVNQVHp2akJuV296MWZvZmpI?=
 =?utf-8?B?ODAvSnVOWk1PSWhhOVBkQ1AvLzVHNUY3djZWREhaT3hCNDQ5enJQc0IzRG9n?=
 =?utf-8?B?Y2RFejk0L2RKYmFSR3NQMndEdEZvclNiQjE0OVFjalNSbWhHMUNKN3BLS25W?=
 =?utf-8?B?MXhSekV4Q0k4bG1teXdiWkVTU2QwNTVuemZNakdXdk1IeVNibERoeE1TTFFM?=
 =?utf-8?B?SjlzMEF1QlNNbzZ3aFViMXdNdDlRMU10N3dSQjl6bDZDRDErbk9HZ2JuTEFE?=
 =?utf-8?B?a0wwTGVTMmFrQzgvemVzRnBQMnhzTWsrQmlsQU1MMFJ5a09WN2tUQlR1RmF4?=
 =?utf-8?B?dEFQS090WlZkeFBhNldXY1FBSFZmalFCZUpRMGcza1ZiYVR1L1FxdTFNRVBp?=
 =?utf-8?B?N2l4Z3NTNDQ4WlhnaHNzYVV6TWlRS2pUYml5dzlyOFNlWm5mZzBCZ2xuL2FY?=
 =?utf-8?B?NXo4RXNGK29XdmN5M1RhcG54c0I0VUJhTDJkMFZxcHBnd0lPR3pvMWdPeEt0?=
 =?utf-8?B?OWR5R1djYkhEeStScnhPdEI5RkhFWHlKcmQrUnB4T21MWVVIbiszcWVuOUx4?=
 =?utf-8?B?WHdwNnJ6UFlZOGVwQm95M0poR2tIbDd0R1ZueFZ2UWtMMVZiKzljM0tKSFgz?=
 =?utf-8?B?SjNudVQrL3RQQjdBWW51K0N4ZjVUWHdHcmEzWDZMcCt4clhzS2V2YTBMNEox?=
 =?utf-8?Q?/uR+5LZw3yl2aKh/f6ACJEcUH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9b4934-e414-4e0c-2f03-08dacc74c72c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:31:56.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwF8/JCUjMBPJC2PQULWtQOE6WXGZO8OBGMOxOEAd9SjlWuX2fO9sdkr0Obh3K9c1HZ3jL0LpWdJ9IIJQE5iog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

I've tested v2 series on an dual socket Zen3 system (2 x 64C/128T) and
the results are largely positive.

tl;dr

o Hackbench results are mostly similar with tip.
o schbench sees improvements to tail latency when the system is
  loaded in NPS1 case but I do see one small regression for
  128 workers in NPS4 mode.
o tbench sees small gains in NPS2 and NPS4 mode
o Stream and Spec-JBB results remain same as the tip.
o ycsb-mongodb sees small gains in NPS2 and NPS4 mode.
o unixbench results see small to moderate gains overall.

I'll leave the detailed results below:

Following are the results from running standard benchmarks on a
dual socket Zen3 (2 x 64C/128T) machine configured in different
NPS modes.

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:          5.19.0 tip sched/core
- sis_short: 	5.19.0 tip sched/core + this series

When we started testing, the tip was at:
commit fdf756f71271 ("sched: Fix more TASK_state comparisons")

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sis_short
 1-groups:	   4.06 (0.00 pct)	   4.02 (0.98 pct)
 2-groups:	   4.76 (0.00 pct)	   4.71 (1.05 pct)
 4-groups:	   5.22 (0.00 pct)	   5.07 (2.87 pct)
 8-groups:	   5.35 (0.00 pct)	   5.31 (0.74 pct)
16-groups:	   7.21 (0.00 pct)	   7.22 (-0.13 pct)

o NPS2

Test:			tip			sis_short
 1-groups:	   4.09 (0.00 pct)	   4.05 (0.97 pct)
 2-groups:	   4.70 (0.00 pct)	   4.69 (0.21 pct)
 4-groups:	   5.05 (0.00 pct)	   4.95 (1.98 pct)
 8-groups:	   5.35 (0.00 pct)	   5.27 (1.49 pct)
16-groups:	   6.37 (0.00 pct)	   6.60 (-3.61 pct)

o NPS4

Test:			tip			sis_short
 1-groups:	   4.07 (0.00 pct)	   4.13 (-1.47 pct)
 2-groups:	   4.65 (0.00 pct)	   4.71 (-1.29 pct)
 4-groups:	   5.13 (0.00 pct)	   5.05 (1.55 pct)
 8-groups:	   5.47 (0.00 pct)	   5.44 (0.54 pct)
16-groups:	   6.82 (0.00 pct)	   6.72 (1.46 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			sis_short
  1:	  33.00 (0.00 pct)	  34.00 (-3.03 pct)
  2:	  35.00 (0.00 pct)	  36.00 (-2.85 pct)
  4:	  39.00 (0.00 pct)	  40.00 (-2.56 pct)
  8:	  49.00 (0.00 pct)	  47.00 (4.08 pct)
 16:	  63.00 (0.00 pct)	  64.00 (-1.58 pct)
 32:	 109.00 (0.00 pct)	 106.00 (2.75 pct)
 64:	 208.00 (0.00 pct)	 214.00 (-2.88 pct)
128:	 559.00 (0.00 pct)	 497.00 (11.09 pct)
256:	 45888.00 (0.00 pct)	 47424.00 (-3.34 pct)
512:	 80000.00 (0.00 pct)	 77952.00 (2.56 pct)

o NPS2

#workers:	tip			sis_short
  1:	  30.00 (0.00 pct)	  31.00 (-3.33 pct)
  2:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
  4:	  39.00 (0.00 pct)	  40.00 (-2.56 pct)
  8:	  51.00 (0.00 pct)	  50.00 (1.96 pct)
 16:	  67.00 (0.00 pct)	  67.00 (0.00 pct)
 32:	 117.00 (0.00 pct)	 114.00 (2.56 pct)
 64:	 216.00 (0.00 pct)	 214.00 (0.92 pct)
128:	 529.00 (0.00 pct)	 597.00 (-12.85 pct)    *
128:     388.00 (0.00 pct)       382.00 (1.54 pct)      [Verification Run]
256:	 47040.00 (0.00 pct)	 47424.00 (-0.81 pct)
512:	 84864.00 (0.00 pct)	 81792.00 (3.61 pct)

o NPS4

#workers:	tip			sis_short
  1:	  23.00 (0.00 pct)	  33.00 (-43.47 pct)
  2:	  28.00 (0.00 pct)	  27.00 (3.57 pct)
  4:	  41.00 (0.00 pct)	  37.00 (9.75 pct)
  8:	  60.00 (0.00 pct)	  56.00 (6.66 pct)
 16:	  71.00 (0.00 pct)	  71.00 (0.00 pct)
 32:	 117.00 (0.00 pct)	 114.00 (2.56 pct)
 64:	 227.00 (0.00 pct)	 218.00 (3.96 pct)
128:	 545.00 (0.00 pct)	 747.00 (-37.06 pct)    *
128:	 383.00 (0.00 pct)	 412.00 (-7.85 pct)    [Verification Run]
256:	 45632.00 (0.00 pct)	 47296.00 (-3.64 pct)
512:	 81024.00 (0.00 pct)	 78720.00 (2.84 pct)

Note: For lower worker count, schbench can show run to
run variation depending on external factors. Regression
for lower worker count can be ignored. The results are
included to spot any large blow up in the tail latency
for larger worker count.

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sis_short
    1	 578.37 (0.00 pct)	 568.72 (-1.66 pct)
    2	 1062.09 (0.00 pct)	 1055.45 (-0.62 pct)
    4	 1800.62 (0.00 pct)	 1833.37 (1.81 pct)
    8	 3211.02 (0.00 pct)	 3124.95 (-2.68 pct)
   16	 4848.92 (0.00 pct)	 4823.27 (-0.52 pct)
   32	 9091.36 (0.00 pct)	 9301.80 (2.31 pct)
   64	 15454.01 (0.00 pct)	 14639.52 (-5.27 pct)   *
   64	 14890.79 (0.00 pct)	 14314.95 (-3.86 pct)   [Verification Run]
  128	 3511.33 (0.00 pct)	 2740.46 (-21.95 pct)   *
  128	 19750.19 (0.00 pct)	 20006.42 (1.29 pct)    [Verification Run]
  256	 50019.32 (0.00 pct)	 50384.18 (0.72 pct)
  512	 44317.68 (0.00 pct)	 44155.90 (-0.36 pct)
 1024	 41200.85 (0.00 pct)	 41242.49 (0.10 pct)

o NPS2

Clients:	tip			sis_short
    1	 576.05 (0.00 pct)	 578.08 (0.35 pct)
    2	 1037.68 (0.00 pct)	 1098.68 (5.87 pct)
    4	 1818.13 (0.00 pct)	 1838.79 (1.13 pct)
    8	 3004.16 (0.00 pct)	 3071.73 (2.24 pct)
   16	 4520.11 (0.00 pct)	 4820.67 (6.64 pct)
   32	 8624.23 (0.00 pct)	 9264.14 (7.41 pct)
   64	 14886.75 (0.00 pct)	 14976.91 (0.60 pct)
  128	 20602.00 (0.00 pct)	 20247.46 (-1.72 pct)
  256	 45566.83 (0.00 pct)	 48786.00 (7.06 pct)
  512	 42717.49 (0.00 pct)	 44678.97 (4.59 pct)
 1024	 40936.61 (0.00 pct)	 40866.32 (-0.17 pct)

o NPS4

Clients:	tip			sis_short
    1	 576.36 (0.00 pct)	 588.43 (2.09 pct)
    2	 1044.26 (0.00 pct)	 1074.47 (2.89 pct)
    4	 1839.77 (0.00 pct)	 1852.10 (0.67 pct)
    8	 3043.53 (0.00 pct)	 3235.32 (6.30 pct)
   16	 5207.54 (0.00 pct)	 4804.41 (-7.74 pct)    *
   16    4620.29 (0.00 pct)      4714.69 (2.04 pct)     [Verification Run]
   32	 9263.86 (0.00 pct)	 8238.55 (-11.06 pct)   *
   32	 9263.86 (0.00 pct)	 9443.77 (1.94 pct)     [Verification Run]
   64	 14959.66 (0.00 pct)	 15321.44 (2.41 pct)
  128	 20698.65 (0.00 pct)	 16806.27 (-18.80 pct)  *
  128    20698.65 (0.00 pct)     20978.42 (1.35 pct)    [Verification Run]
  256	 46666.21 (0.00 pct)	 49787.15 (6.68 pct)
  512	 41532.80 (0.00 pct)	 44738.18 (7.71 pct)
 1024	 39459.49 (0.00 pct)	 41473.96 (5.10 pct)

Note: On the tested kernel, with 128 clients, tbench can
run into a bottleneck during C2 exit. More details can be
found at:
https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
This issue has been fixed in v6.0 but was not part of the
tip kernel when I started testing. This data point has
been rerun with C2 disabled to get representative results.

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			sis_short
 Copy:	 328419.14 (0.00 pct)	 336740.00 (2.53 pct)
Scale:	 206071.21 (0.00 pct)	 212682.17 (3.20 pct)
  Add:	 235271.48 (0.00 pct)	 244104.35 (3.75 pct)
Triad:	 253175.80 (0.00 pct)	 251776.26 (-0.55 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:	 328209.61 (0.00 pct)	 340132.12 (3.63 pct)
Scale:	 216310.13 (0.00 pct)	 218811.70 (1.15 pct)
  Add:	 244417.83 (0.00 pct)	 246349.22 (0.79 pct)
Triad:	 237508.83 (0.00 pct)	 260160.20 (9.53 pct)

o NPS2

- 10 Runs:

Test:		tip			sis_short
 Copy:	 336503.88 (0.00 pct)	 319171.80 (-5.15 pct)
Scale:	 218035.23 (0.00 pct)	 219061.13 (0.47 pct)
  Add:	 257677.42 (0.00 pct)	 256776.22 (-0.34 pct)
Triad:	 268872.37 (0.00 pct)	 263751.14 (-1.90 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:	 332304.34 (0.00 pct)	 320547.46 (-3.53 pct)
Scale:	 223421.60 (0.00 pct)	 220418.63 (-1.34 pct)
  Add:	 252363.56 (0.00 pct)	 254553.30 (0.86 pct)
Triad:	 266687.56 (0.00 pct)	 260009.00 (-2.50 pct)

o NPS4

- 10 Runs:

Test:		tip			sis_short
 Copy:	 353515.62 (0.00 pct)	 338973.78 (-4.11 pct)
Scale:	 228854.37 (0.00 pct)	 230319.08 (0.64 pct)
  Add:	 254942.12 (0.00 pct)	 247794.21 (-2.80 pct)
Triad:	 270521.87 (0.00 pct)	 261432.32 (-3.36 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:	 374520.81 (0.00 pct)	 363272.21 (-3.00 pct)
Scale:	 246280.23 (0.00 pct)	 241457.83 (-1.95 pct)
  Add:	 262772.72 (0.00 pct)	 261924.44 (-0.32 pct)
Triad:	 283740.92 (0.00 pct)	 274791.15 (-3.15 pct)

~~~~~~~~~~~~~~~~~
~ Spec-JBB NPS1 ~
~~~~~~~~~~~~~~~~~

--------------------------------------------------
|   Throughput  |     tip     |     sis_short    |
--------------------------------------------------
|    Max-jOPS   |     100%    |      98.84%      |
| Critical-jOPS |     100%    |      100.31%     |
--------------------------------------------------

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:                    131696.33 (var: 2.03%)
sis_short:              130844.67 (var: 2.55%)  (-0.64%)

o NPS2:

tip:                    129895.33 (var: 2.34%)
sis_short:              133104.33 (var: 1.65%)  (+2.647%)

o NPS4:

tip:                    131165.00 (var: 1.06%)
sis_short:              138180.67 (var: 0.83%)  (+5.34%)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

-> unixbench-dhry2reg

o NPS1

kernel:                                        tip                          sis_short
Min       unixbench-dhry2reg-1            48876615.50 (   0.00%)          48489507.40 (  -0.79%)
Min       unixbench-dhry2reg-512        6260344658.90 (   0.00%)        6253084311.60 (  -0.12%)
Hmean     unixbench-dhry2reg-1            49299721.81 (   0.00%)          49014780.04 (  -0.58%)
Hmean     unixbench-dhry2reg-512        6267459427.19 (   0.00%)        6261978461.64 (  -0.09%)
CoeffVar  unixbench-dhry2reg-1                   0.90 (   0.00%)                 0.98 (  -9.38%)
CoeffVar  unixbench-dhry2reg-512                 0.10 (   0.00%)                 0.17 ( -61.99%)
Max       unixbench-dhry2reg-1            49758806.60 (   0.00%)          49428847.90 (  -0.66%)
Max       unixbench-dhry2reg-512        6273024869.70 (   0.00%)        6273555460.00 (   0.01%)

o NPS2

kernel:                                        tip                          sis_short
Min       unixbench-dhry2reg-1            48828251.70 (   0.00%)          48591509.40 (  -0.48%)
Min       unixbench-dhry2reg-512        6244987739.10 (   0.00%)        6254966248.00 (   0.16%)
Hmean     unixbench-dhry2reg-1            48869882.65 (   0.00%)          49230596.10 (   0.74%)
Hmean     unixbench-dhry2reg-512        6261073948.84 (   0.00%)        6260685008.60 (  -0.01%)
CoeffVar  unixbench-dhry2reg-1                   0.08 (   0.00%)                 1.20 (-1347.66%)
CoeffVar  unixbench-dhry2reg-512                 0.23 (   0.00%)                 0.09 (  59.12%)
Max       unixbench-dhry2reg-1            48909163.40 (   0.00%)          49752650.10 (   1.72%)
Max       unixbench-dhry2reg-512        6271411453.90 (   0.00%)        6266517108.00 (  -0.08%)

o NPS4

kernel:                                        tip                          sis_short
Min       unixbench-dhry2reg-1            48523981.30 (   0.00%)          48728886.20 (   0.42%)
Min       unixbench-dhry2reg-512        6253738837.10 (   0.00%)        6260870171.70 (   0.11%)
Hmean     unixbench-dhry2reg-1            48781044.09 (   0.00%)          48969711.29 (   0.39%)
Hmean     unixbench-dhry2reg-512        6264428474.90 (   0.00%)        6277327761.28 (   0.21%)
CoeffVar  unixbench-dhry2reg-1                   0.46 (   0.00%)                 0.43 (   6.91%)
CoeffVar  unixbench-dhry2reg-512                 0.17 (   0.00%)                 0.29 ( -70.82%)
Max       unixbench-dhry2reg-1            48925665.20 (   0.00%)          49091708.50 (   0.34%)
Max       unixbench-dhry2reg-512        6274958506.80 (   0.00%)        6296828879.20 (   0.35%)

-> unixbench-syscall

o NPS1

kernel:                             tip                  sis_short
Min       unixbench-syscall-1    2975654.80 (   0.00%)  2971008.50 (   0.16%)
Min       unixbench-syscall-512  7840226.50 (   0.00%)  6586485.10 (  15.99%)
Amean     unixbench-syscall-1    2976326.47 (   0.00%)  2971920.50 *   0.15%*
Amean     unixbench-syscall-512  7850493.90 (   0.00%)  6597210.63 *  15.96%*
CoeffVar  unixbench-syscall-1          0.03 (   0.00%)        0.03 ( -14.26%)
CoeffVar  unixbench-syscall-512        0.13 (   0.00%)        0.27 (-103.14%)
Max       unixbench-syscall-1    2977279.70 (   0.00%)  2972935.80 (   0.15%)
Max       unixbench-syscall-512  7860838.90 (   0.00%)  6617515.40 (  15.82%)

o NPS2

kernel:                             tip                  sis_short
Min       unixbench-syscall-1    2969863.60 (   0.00%)  2974771.70 (  -0.17%)
Min       unixbench-syscall-512  8053157.60 (   0.00%)  7411223.90 (   7.97%)
Amean     unixbench-syscall-1    2970462.30 (   0.00%)  2975278.63 *  -0.16%*
Amean     unixbench-syscall-512  8061454.50 (   0.00%)  7437679.30 *   7.74%*
CoeffVar  unixbench-syscall-1          0.02 (   0.00%)        0.02 ( -17.72%)
CoeffVar  unixbench-syscall-512        0.12 (   0.00%)        0.34 (-179.38%)
Max       unixbench-syscall-1    2970859.30 (   0.00%)  2975972.90 (  -0.17%)
Max       unixbench-syscall-512  8072312.30 (   0.00%)  7461732.50 (   7.56%)

o NPS4

kernel:                             tip                  sis_short
Min       unixbench-syscall-1    2971799.80 (   0.00%)  2974601.20 (  -0.09%)
Min       unixbench-syscall-512  7824196.90 (   0.00%)  8242480.10 (  -5.35%)
Amean     unixbench-syscall-1    2973045.43 (   0.00%)  2974739.93 *  -0.06%*
Amean     unixbench-syscall-512  7826302.17 (   0.00%)  8261295.03 *  -5.56%*
CoeffVar  unixbench-syscall-1          0.04 (   0.00%)        0.00 (  86.39%)
CoeffVar  unixbench-syscall-512        0.03 (   0.00%)        0.37 (-1376.49%)
Max       unixbench-syscall-1    2973786.50 (   0.00%)  2974895.30 (  -0.04%)
Max       unixbench-syscall-512  7828115.90 (   0.00%)  8296830.40 (  -5.99%)


-> unixbench-pipe

o NPS1

kernel:                               tip                  sis_short
Min       unixbench-pipe-1        2894765.30 (   0.00%)    2904821.00 (   0.35%)
Min       unixbench-pipe-512    329818573.50 (   0.00%)  329565756.00 (  -0.08%)
Hmean     unixbench-pipe-1        2898803.38 (   0.00%)    2911189.71 *   0.43%*
Hmean     unixbench-pipe-512    330226401.69 (   0.00%)  330389884.94 (   0.05%)
CoeffVar  unixbench-pipe-1              0.14 (   0.00%)          0.22 ( -62.25%)
CoeffVar  unixbench-pipe-512            0.11 (   0.00%)          0.24 (-126.10%)
Max       unixbench-pipe-1        2902691.20 (   0.00%)    2917740.00 (   0.52%)
Max       unixbench-pipe-512    330440132.10 (   0.00%)  331162497.90 (   0.22%)

o NPS2

kernel:                               tip                   sis_short
Min       unixbench-pipe-1        2895327.90 (   0.00%)    2905421.90 (   0.35%)
Min       unixbench-pipe-512    328350065.60 (   0.00%)  330137916.90 (   0.54%)
Hmean     unixbench-pipe-1        2899129.86 (   0.00%)    2910562.69 *   0.39%*
Hmean     unixbench-pipe-512    329436096.80 (   0.00%)  330509036.17 (   0.33%)
CoeffVar  unixbench-pipe-1              0.12 (   0.00%)          0.20 ( -70.84%)
CoeffVar  unixbench-pipe-512            0.30 (   0.00%)          0.10 (  65.00%)
Max       unixbench-pipe-1        2901619.40 (   0.00%)    2916758.50 (   0.52%)
Max       unixbench-pipe-512    330239044.10 (   0.00%)  330814020.50 (   0.17%)

o NPS4

kernel:                               tip                   sis_short
Min       unixbench-pipe-1        2901525.60 (   0.00%)    2909864.00 (   0.29%)
Min       unixbench-pipe-512    330265873.90 (   0.00%)  330543034.40 (   0.08%)
Hmean     unixbench-pipe-1        2906184.70 (   0.00%)    2912725.52 *   0.23%*
Hmean     unixbench-pipe-512    330854683.27 (   0.00%)  331540275.79 (   0.21%)
CoeffVar  unixbench-pipe-1              0.14 (   0.00%)          0.09 (  39.44%)
CoeffVar  unixbench-pipe-512            0.16 (   0.00%)          0.27 ( -73.84%)
Max       unixbench-pipe-1        2909154.50 (   0.00%)    2914249.80 (   0.18%)
Max       unixbench-pipe-512    331245477.30 (   0.00%)  332305755.00 (   0.32%)

-> unixbench-spawn

o NPS1

kernel:                             tip                  sis_short
Min       unixbench-spawn-1       6536.50 (   0.00%)     6458.00 (  -1.20%)
Min       unixbench-spawn-512    72571.40 (   0.00%)    91525.90 (  26.12%)
Hmean     unixbench-spawn-1       6811.16 (   0.00%)     6510.74 (  -4.41%)
Hmean     unixbench-spawn-512    72801.77 (   0.00%)    91829.95 *  26.14%*
CoeffVar  unixbench-spawn-1          3.69 (   0.00%)        1.00 (  72.93%)
CoeffVar  unixbench-spawn-512        0.27 (   0.00%)        0.41 ( -50.84%)
Max       unixbench-spawn-1       7021.00 (   0.00%)     6583.60 (  -6.23%)
Max       unixbench-spawn-512    72927.00 (   0.00%)    92257.50 (  26.51%)

o NPS2

kernel:                             tip                  sis_short
Min       unixbench-spawn-1       7042.20 (   0.00%)     7411.00 (   5.24%)
Min       unixbench-spawn-512    85571.60 (   0.00%)    89549.50 (   4.65%)
Hmean     unixbench-spawn-1       7199.01 (   0.00%)     7553.53 *   4.92%*
Hmean     unixbench-spawn-512    85717.77 (   0.00%)    89751.68 *   4.71%*
CoeffVar  unixbench-spawn-1          3.50 (   0.00%)        1.68 (  51.98%)
CoeffVar  unixbench-spawn-512        0.20 (   0.00%)        0.28 ( -36.60%)
Max       unixbench-spawn-1       7495.00 (   0.00%)     7650.40 (   2.07%)
Max       unixbench-spawn-512    85909.20 (   0.00%)    90028.30 (   4.79%)

o NPS4

kernel:                             tip                  sis_short
Min       unixbench-spawn-1       7521.90 (   0.00%)     8404.10 (  11.73%)
Min       unixbench-spawn-512    84245.70 (   0.00%)    91260.20 (   8.33%)
Hmean     unixbench-spawn-1       7659.12 (   0.00%)     8526.01 *  11.32%*
Hmean     unixbench-spawn-512    84908.77 (   0.00%)    91365.07 *   7.60%*
CoeffVar  unixbench-spawn-1          1.92 (   0.00%)        2.06 (  -7.21%)
CoeffVar  unixbench-spawn-512        0.76 (   0.00%)        0.10 (  86.60%)
Max       unixbench-spawn-1       7815.40 (   0.00%)     8729.60 (  11.70%)
Max       unixbench-spawn-512    85532.90 (   0.00%)    91437.30 (   6.90%)

-> unixbench-execl

o NPS1

kernel:                             tip                  sis_short
Min       unixbench-execl-1       5421.50 (   0.00%)     5466.40 (   0.83%)
Min       unixbench-execl-512    11213.50 (   0.00%)    11720.30 (   4.52%)
Hmean     unixbench-execl-1       5443.75 (   0.00%)     5468.53 (   0.46%)
Hmean     unixbench-execl-512    11311.94 (   0.00%)    11809.97 *   4.40%*
CoeffVar  unixbench-execl-1          0.38 (   0.00%)        0.04 (  89.57%)
CoeffVar  unixbench-execl-512        1.03 (   0.00%)        0.74 (  27.60%)
Max       unixbench-execl-1       5461.90 (   0.00%)     5470.70 (   0.16%)
Max       unixbench-execl-512    11440.40 (   0.00%)    11895.60 (   3.98%)

o NPS2

kernel:                             tip                  sis_short
Min       unixbench-execl-1       5089.10 (   0.00%)     5119.50 (   0.60%)
Min       unixbench-execl-512    11772.70 (   0.00%)    11591.40 (  -1.54%)
Hmean     unixbench-execl-1       5321.65 (   0.00%)     5251.49 (  -1.32%)
Hmean     unixbench-execl-512    12201.73 (   0.00%)    11665.67 (  -4.39%)
CoeffVar  unixbench-execl-1          3.87 (   0.00%)        2.33 (  39.91%)
CoeffVar  unixbench-execl-512        6.23 (   0.00%)        1.04 (  83.38%)
Max       unixbench-execl-1       5453.90 (   0.00%)     5359.00 (  -1.74%)
Max       unixbench-execl-512    13111.60 (   0.00%)    11805.80 (  -9.96%)

o NPS4

kernel:                             tip                  sis_short
Min       unixbench-execl-1       5099.40 (   0.00%)     5352.70 (   4.97%)
Min       unixbench-execl-512    11692.80 (   0.00%)    13368.20 (  14.33%)
Hmean     unixbench-execl-1       5136.86 (   0.00%)     5404.31 *   5.21%*
Hmean     unixbench-execl-512    12053.71 (   0.00%)    14018.53 *  16.30%*
CoeffVar  unixbench-execl-1          1.05 (   0.00%)        0.84 (  20.12%)
CoeffVar  unixbench-execl-512        3.85 (   0.00%)        5.29 ( -37.45%)
Max       unixbench-execl-1       5198.70 (   0.00%)     5434.90 (   4.54%)
Max       unixbench-execl-512    12585.70 (   0.00%)    14839.80 (  17.91%)

On 10/23/2022 9:01 PM, Chen Yu wrote:
> At LPC 2022 Real-time and Scheduling Micro Conference we presented
> the cross CPU wakeup issue. This patch is a text version of the
> talk, and hopefully, we can clarify the problem and appreciate any
> feedback.
> 
> The main purpose of this change is to avoid too many crosses CPU
> wake up when the system is busy. Please refer to the commit log
> of [PATCH 2/2] for detail.
> 
> This patch set is composed of two parts. The first part is to introduce
> the definition of a short-duration task. The second part leverages the
> first part to choose a CPU where only one short-duration task is running
> on. This CPU is chosen as the candidate to place a woken task.
> 
> This version is modified based on the following feedback on v1:
> 1. Tim suggested raising the bar to choose a CPU with a short-duration
>    task, by checking if the short-duration task is the only runnable
>    task on the target CPU.
> 2. To address Peter's concern: would this patch inhibit spreading the
>    workload when there are idle CPUs around? The patch would only take
>    effect when the system is relatively busy, and only choose the CPU
>    where only one short-duration task is running.
> 3. Prateek, Honglwei and Hillf suggsted to prefer previous idle CPU to the
>    CPU with short-duration task running.
> 
> v1 link: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Introduce short duration task check
>   sched/fair: Choose the CPU where short task is running during wake up
> 
>  include/linux/sched.h   |  8 ++++
>  kernel/sched/core.c     |  2 +
>  kernel/sched/fair.c     | 99 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  4 files changed, 110 insertions(+)
> 

Except for schbench with 128 workers in NPS4 mode, I do not
see any large regressions for the above workloads and I do
see small to moderate gains overall for most workload, even
the larger ones. I'll try to get data for more workload but
overall the idea seems promising. I'll also get some numbers
with the changes Peter suggested on Patch 1.

If there is any specific workload you would like me to run
on the test machine, please do let me know.
--
Thanks and Regards,
Prateek

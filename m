Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A786774B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjAWEsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:48:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349E113F9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyOVW/P1SM5CVBLP5p5xFM+BR11WSr1u+liJ3lL04cysvJu9nhSUzEQCjQfvncY1Zm6zx3O4jHb9UR2ppHMxmEKRQAnySLpNYdVw+GVncgIyZYObm0k8+3jDDKqY2A+q3x2hgJtpn7ZWeGNpKKgrTguGUSxvnpLv/EOf7Y42iOM0eERV/rbr9EjCuObYHaB7jwjbj5eRL85Ylf0HgH/lrIVibuuipPH1lwyQJBT6Fa1C4WRAzSqV9gNIqKugMG8UyygjGVC9pdbkgyyAgICdFZrt7yK2AT7rh3xUTspDT2Ob5wgfVRFn31DNjIBiIVboTaYJ9MBgNIZD9I5Ce5/qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGDVRFtsEtXTYaWRjuhHRe3WnPNBN8wu0qTMZrTGaf4=;
 b=OGpL8O6lO8N8SSWLS3yDwzUOJwaY0CctNjgwZJ5AQXZNKi0IQMjZoznJ2MKFm3xL+9/Lq8eXnXwYvAC+/66TP7Hf/suHE2G4o+hMyLijehcnRFnz6v68P3f31DYHLDUbg5l3muA2Z1X7AF8G7JWs1XYcnEUE0or6x13pe+vgUcK9onM6nGWkom8FIJAEScNGSRxKvCIc1RIY5d4mOOYDBq6wqOolV0CdF3+c20zn8U0V+R2XNsJU/xYvl4oA0wLx+r7F4sT/zIA2UJ6gxYFie1nQhqEyxBRn9YBUTBPDw6bOAFfgGNAMwyxojf4rQcNjU/EjHEQrk0HIvob8EOUL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGDVRFtsEtXTYaWRjuhHRe3WnPNBN8wu0qTMZrTGaf4=;
 b=Dk5oo2lZHmVN/wzxNzTDb1ERamSliGSzg1H5g3xd66l4VNdvSIlT+mwluWVGbzT0N5FJGYXkb493TZAjDJTfDaF6rPwNkwEMILhVNvsJauOG0/lFVQHslow2GwjAhOISOZT5m4Ysoyjl2q1YBabpmvpk0L8Sm6gHg1QlKOcaMkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 04:48:03 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41%4]) with mapi id 15.20.6002.028; Mon, 23 Jan 2023
 04:48:03 +0000
Message-ID: <6742a778-9a9d-4457-cf0a-26218ba075dc@amd.com>
Date:   Mon, 23 Jan 2023 10:17:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>, Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
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
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Barry Song <21cnbao@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
 <Y8lrnvLzGGJmlPor@chenyu5-mobl1>
 <d3d04f60-e3d7-9abb-4cfa-57790b359dd9@huawei.com>
 <Y81YRyRpg6xsyJK6@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Y81YRyRpg6xsyJK6@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d7985a-57f4-4fd0-2ebf-08dafcfd026d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5vhljuIsV0NIoaEjB0CE/r9vnb8uwmMF2mfGmkhizeVyfsQVvyjtxq8TWQSPJj/t+OH8g0wE/oPyFrgjghkDtWA83ppkNkGhyIBNRmCUXb7xoiRP8rKtkcFL8C1orZE4WhgTh9Khvg0ApE2q/OO+3itFJlPNCRNRNBZz4FPoiw+9DbX9JVOvLWloVxpdAPfqLob8blMfGzWnUsn57GEvAgO0WdFeKKsDzNYc86+TRr22ASRdatSvW+0atr1L/OIpQnWgE3O9uEBDt+FVvpzgvxJFsC2T0/ookVNPZxNUfLJmgETPEhVJw6q2B3m94Hya7nzxnPQwfV0c/KLV9N8RSNAbTWPBlBrMnd1+jQdwO/YzrRgpPaHNUJcPn3Do7ysLLWeHqQGW7He7HKRM+NxCQRInqr5Pl7o1OBu2CW46zkB7nNB9K+nvxX9mZ+TE/rBgcfKljzzw3t+K7hOgEZUDdbMUYK1nQmPTPDQSDpeprGJS3tqpIatIMYbigZwi4Xt8wqlpV1wQ503IyUiUYX19bc3laG9+8X6Ks33Rh0KY9SUONSFARC9YFlkMWQIcbgqBJeSeUR64TvwQULGMvokt/kodudMd/h7gR6s05fOJrSZa+1FI4YbmimElURb5momrWZRBIy+j8Qu2v5klRTRKLPi0ALW2rDi6GqGKOvKtGjWoFmpUw4jz2rfLPfP5X+VqFLrCW2QWOsxYQ5/FYOT0+ww3bXho49f7IzRwPGxZzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(31686004)(53546011)(66946007)(4326008)(66556008)(8676002)(6486002)(66476007)(2616005)(6512007)(6666004)(7416002)(186003)(26005)(41300700001)(5660300002)(8936002)(2906002)(6506007)(54906003)(38100700002)(31696002)(478600001)(110136005)(316002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FOSUxOYjY2VTVEZ3RQTnA1WEM3Wi93NmpOdXBpNm4wTVc3bC9aTXcwMmdm?=
 =?utf-8?B?L1Z3WGcxK1RVN1pUZFIyMERLalZBT2JJQTcrcjlkVituWTZLOVhqaXUvRi9U?=
 =?utf-8?B?UFhnc1kyUk1XWERjNXNwQWdwRU11YmlpamFZQnA1TlNUanVMTk1TY0EvM1lR?=
 =?utf-8?B?SWhiYmVZR3lVclU0bTQzZlVNdk1oOGMzcFU0SHJmVmQ1dWd4VHJ1Qk5IWGJX?=
 =?utf-8?B?MTROYTAvM0x1bkEzUUFmYTd4cFlob1pzSTBFL1RMdlNWQk8zU01ZNjdOZDAz?=
 =?utf-8?B?U3JPSFhMMjhYTjd3VDQ3bEdEd0llb0hucUt0ZFExQlIyOXJPcTlLcFhpN1Fy?=
 =?utf-8?B?Z0FTc2QxQkxhTXBLZDdJMkJOSGM5aitrNktvb29yOVRmaEZJMVY5QUtlWFVj?=
 =?utf-8?B?WjFxdDFCSjZ3VEZYMGZHeTBNV2diOGxKU0ZjYzBnTzg5NitxZWcwaGN0MExo?=
 =?utf-8?B?NkhSRGxTZUREcHBpOEF4U0t2ZjFwWnlYdHRZRUVneUNtVzB1WTA3Tkl2U3FK?=
 =?utf-8?B?TzV6KzRuMmtzelFtakFrMldoQ2ZrT3p5djhhM29ZbTgrbkhGeG1WeU9aRWY5?=
 =?utf-8?B?azZKUW92Zmlsbms0NW9zOXFnUWhEdUo0eWtIclo5a3RmR1FrV2RqY3NJK1h0?=
 =?utf-8?B?QkhRZTFtZVZqWlhTNnB2ZkdyRyt5cDBKQk9abVJIRENHV285cTNNU2trVFBI?=
 =?utf-8?B?SWx0MFBJYXhzdmRFcjVNbXh1Z3RoV0VCS2ZtRTY5aG5kOWQ0cHh2V0RCV1Qx?=
 =?utf-8?B?YVRiZE1GbDNYWnhGQytkMUhpMXdVUEdHc094UWtoTnp5YWxUVjN6RTRCYlYz?=
 =?utf-8?B?WUVUNXpjc3lMcUJYL1N0KzlNOFZpZThiS3RHY05oOHlnNWRFbnpvNlJhZVZq?=
 =?utf-8?B?VU9IUlVaaUw0TWJib080SmFDTDlDbXk0anJaRzIvdllBVGZmcGVIVzNiU3dy?=
 =?utf-8?B?czd3K25zK1cxdWRTVmd0bjVpWlMrdmJzVFZXU0JLdmhPN0VHZzEwVGFTSU1o?=
 =?utf-8?B?WHVqWW0xRENlZk94SUJBbDFFWmRJemhyK3JnakU5cFBMRDV0akFscmlzZGRV?=
 =?utf-8?B?Y2xDTlZVdmtiQTk0b085Y1FXNk1McUl2b0ZDbGlOMkdOQlRCU2Z3c2dnMEN2?=
 =?utf-8?B?bzlNaEdUdTk3NGtVUzRJOGE1UXFQbkZ4Zjg4UUEvZ1NYOEQ4dFE4Y09WVzVk?=
 =?utf-8?B?UnBwVjRWaXkzVE5Vd0xMMExlRnFQdzR5YmRDUEc0cm1ZdnRsMlpxV0hxSEZR?=
 =?utf-8?B?SkM0RzJNbTMvalZBNzk1WG1McWg2cEt6YisxYU9ESW4xY1FvS1NKV1pSdmx4?=
 =?utf-8?B?bUNQY1dVNlBteTdiVzJacEtVbzdZTm5sREtyMWVwUXpZL2xmeUxWVGxVRlZn?=
 =?utf-8?B?eGNCSWQ5bnpNQi9SZzZoSm0xNEJNaEw5YWdHVGxKaHptZjN3WkJBYVhqL010?=
 =?utf-8?B?R1RxOFhydS9DRGNaclZ6QTZCK2twYkljK3p3SHpmb1ZkQUtRL3R2cmhXdVZk?=
 =?utf-8?B?UmNrS1pjRjFXUHpNOE5KWXh0eFhWTkhtaVFkN0Q2RDlxbHZ6MG05TkZZS2xH?=
 =?utf-8?B?YjFEbXc2a3FLYjh2c0FPY0Z6ZTQxcFhtanhJekJpL3VuK3ZhTzVncVlmaGdC?=
 =?utf-8?B?RHRaZ3B4djB5Y0lzQ3d1Y2paZEphQzFWWnF4MW5SK1BIeWxkMVNjbnRoTlVM?=
 =?utf-8?B?RnJvV3J0YjdJd3ZDU0dVdEQ5SU1INFF1UTMxbmtFUHV0NCtjSkgxWEJsU2sz?=
 =?utf-8?B?RG54ZllDZDByQTk4am5QcXZvMjF2SFA2K1VKVHVPVmtTOWxacTluQTJVZ2RO?=
 =?utf-8?B?ZlVSV3JiOHZFS29mWTI4dzhSS0tlZ2JWNXYranZ2akZzVXJyMVpSRE1PUXNP?=
 =?utf-8?B?SGllT2dlK1MwRkU0eFdUbXo2TWJPa2dVNU9acllqeGJjdTJBeUN0K1VyT0Va?=
 =?utf-8?B?cXNlT1RvOEdwU0hsSGlVWGhKTDAyczV3bGllN2NCNFhGUzFEN0tqZDFLQzJ6?=
 =?utf-8?B?N3pjTmMvT2Z5THlRSFZhUXNCYVpWVGZoY3VNd2U4cU1IMGVGZnhLcmdKN0VH?=
 =?utf-8?B?ZlVDTHJVZCtHZldiTEM5UkRydW1zMHdDVjU0ekdKa0F2TWF1MW80QjQ3M2hY?=
 =?utf-8?Q?7/4ML4/Lain18XaO9TvyTtUaM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d7985a-57f4-4fd0-2ebf-08dafcfd026d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 04:48:02.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSfTwaSJOrcYmCcEgKZvTTAfv55Qf61/KtGWxtIgd+SOol7gDqKhd8HuJVeWdXP6aQdpa/Ogw6PTb6epMJ17Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you for looking into this.

On 1/22/2023 9:07 PM, Chen Yu wrote:
> On 2023-01-20 at 17:09:28 +0800, Yicong Yang wrote:
> [..snip..]
>
> This sounds reasonable to me. I think we can further enhance it.
> And before you sending out the proposal, could you help test the following
> experimental change, to see if it makes tbench netperf and MySQL better?
> 
> Hi Prateek, could you also help check if below change would make the Spec regression
> go away?

Sure. I'll add this on top of v4 and queue some runs.
Will share the results soon.

> 
> thanks,
> Chenyu
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fc8a636eca5e..6e1ab5e2686c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4974,7 +4974,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
>  static inline int is_short_task(struct task_struct *p)
>  {
>  	return sched_feat(SIS_SHORT) && p->se.dur_avg &&
> -		((p->se.dur_avg * 8) <= sysctl_sched_min_granularity);
> +		((p->se.dur_avg * 1024) <= (__this_cpu_read(sd_llc_size) * sysctl_sched_min_granularity));
>  }
>  
>  /*


--
Thanks and Regards,
Prateek

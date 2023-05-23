Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359070D38D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjEWGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEWGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:04:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6680B109
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlzPNOVQl5jH+9xCA9awVBabdzAHPHrsoU8HJ2YioPtzwNRy3nZYsW/KoFncnx/JwSX3gfI4W7uzTAK41/Mfzno3MHWSnYNb2s1NUkv+6fwFLoDYFAV0jgJjbnXSerAYF24UGfHMQ6+Y/doNh9kUxziiDrT8ojbeJ6eZcddxIvBf5evNBurjD8ZlsZww9joZAD0krmjGhOiXbIn+KzFP76kLmzipfhUvBSl4fSeO7PHLN8LoZkMPkzt1tripImZJWonEtrQcGNs51Wm5S1+LJqHCgeNWcPjlCvjxWpu3Tmfv2ddXdbwROBlHoXKwcEJ1yGCmPQFHI2tJtaily3LzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFToY+/ru788k3j/l0EpFBBU7jWCYffxwGrMq3E+MKk=;
 b=KB3srsmcvWrAyIOe0AdP6KZ88dBtLwI6mjcs21HIRXluBofT57abtlBL0rk+g7YpOVl9GdWqyOYMo2FlizIwcLyRT6Xkfh6/4Lxfs+/l88TuDLWQ/8xmSE1p/nwB6/7NxyQijuRjyHxTAwEgnySauZbrI2iQqZJpoN1QVxGSew/RJpbdlS2TcQpnlmoFXMz/UqRVs76fNhq6GEAKlNZKnbKGACXw7SnjWlNVrSmnbhw/K+5z6mlMI6HOVnRfPqHXYGEVlrQUuYhRuNVk3mHpSlMW1Gy1Vl2GtQBWAU76tnyYb668yGoAnBfluFAsld2FG5yWIRw6XwO3M3D9XfAcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFToY+/ru788k3j/l0EpFBBU7jWCYffxwGrMq3E+MKk=;
 b=QarKwSccotcOfKmNYOTzPZ18mCV3bNnEmwNhJgelOrkvEQtIImzs3d9YvRGFdzWWfTWbmQeg5hBAT8cbSIuRznQ7kjcJU+Sa6IxOJ/7fu6tGdQ1zUhiegEjxIuu5H1lJfa+czxzMohfVx+5EnOpG/99RSrY8sT2PzENmSJLO400=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 06:04:13 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::d1a6:3a8:a6dd:b094]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::d1a6:3a8:a6dd:b094%2]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 06:04:12 +0000
Message-ID: <10695901-8f38-1177-19e3-74b42d060758@amd.com>
Date:   Tue, 23 May 2023 11:33:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 2/6] perf: Add branch stack extension
To:     kan.liang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522113040.2329924-2-kan.liang@linux.intel.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230522113040.2329924-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: d6914da4-76be-408e-f296-08db5b538782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7U7Danu28B5unuhUFCfnO+vniKVAiq8D4hDAXtE57wqQqCAtGEEtaQALxtsWMh8tjP4C+E5Zrq4ftMMykHZsBQb5NudXTJ9UzCNS/RfgYkIaXdaPV/OrRo9CKYJwVzsEajrdaqqaWO62q9zBAe+3Udeme/uiwRZHkzEV8c6kXPVOQdwb73wXNSD58OGHymTVsczgrOLZ72Laaeo65H9LIbVPfGn1GEqBcQWd6GiyrdnncmZL3URV9yGDEh1k9RPcmPjzSzm14+qi6QL7VyQBg+v7xpwn1xNVzx7LIGTcOd8HULA0wkEwmsmGeEKRJtzo/WMFJDGBmZMfxF3sTqJl++pJTIkuUFZa6rCKTAk/hzKqq4RST89T24UNz3OG/psSVIgHU672bxxNX+0tvp9urrG54wBupk84xpAOLTrSOLUhXzTUlGgAWfXGXuOUjfZN/St+g3pr32haoLCHOXvXD6VLPNqBE71Ls2cIvF49/QboNfzxwU/LyfpKCS9v0wHAkc2U/pfj23sm190mmxPtlrb+Lu4w265/oCOy8m8fmP3GJZ1EqyOBBc3FVYB7ZsQDQvwCSQCa75YZweaWfUH1EnHuFi8CG3VbeOnRxU76pPmZ4fmr0bRPoVYsx2MBDqSdF3x1pIYuWomacDjgsq3Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(5660300002)(54906003)(8936002)(7416002)(8676002)(44832011)(316002)(4326008)(6916009)(6512007)(6506007)(36756003)(186003)(26005)(66946007)(66556008)(66476007)(41300700001)(66899021)(53546011)(31696002)(6486002)(6666004)(83380400001)(31686004)(86362001)(38100700002)(2616005)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01sdytrcUg1L2lQZVVtQjIvY1hMdSt6eU1LdHJuRk5Rd0V2dm1JVW14Wlpj?=
 =?utf-8?B?Z21lWjhWdHN1MkFqZGpJMHBkYlVvVkhJNXBaa2JhbDJzNkRnZEVYVlc0eWc0?=
 =?utf-8?B?RXNPQ2pmZWh5OEs4L2ZmRlBISVRkQmRsMXV6UVdtY2VLTVdNaTVJdUx2NS9x?=
 =?utf-8?B?V0RmN3NKc0l2anRXbXZleWVqQWplZzdESnp5VWcraHFSUHNieEhYQUlYNEx2?=
 =?utf-8?B?RGFKNDJJQ25NdEpYeXZxY2FYRE1MTWRDUHkvOTZNejJFUjBMYUErTmtOeEFi?=
 =?utf-8?B?bHJEcWZ6dDVrc2UzMFB5TzZkcnFVUUtQSklXTWFPQ2xSNmgxVU10dGNyQXFx?=
 =?utf-8?B?dzhWL01NZXo4TkFySGxBQkxza0VEMEYxTXFIZ2FPSXNYTVRZWGZySWl2RFZm?=
 =?utf-8?B?K1dxQmZZMUE1RHY2bDBaY1ZVM005MDdTbzN1UE9JSzNpWFNROHpvamhONTNh?=
 =?utf-8?B?eGxnQ3lDV0ZmaCtZU3k3RlhrRmt0MUxTT0s4bmxBVllXY0g1RHB5N1NQaVow?=
 =?utf-8?B?WDJFRktVL3QzWjMwUkcyRnltY1QrNFZPM2d6T0Z5bXBEcjZLdGhwN09LWGFk?=
 =?utf-8?B?cW1nK21pZ1RSMG1jajRGdng2WGR3bTd2QXBaalpPcCtoK0pXdDFlb2toa3Iw?=
 =?utf-8?B?ZERSaGpxMENWL0I1bHpwVGZ1VWlMVWdGTU1vNWV1TC8vVCtzUWRLc3RYQTJ5?=
 =?utf-8?B?VjhYOWV4RXZMNFBpS2s5L0ZZeDVRU2VnQ2NsQ1JKNmtRSDk2RHJjeGpPQ1V5?=
 =?utf-8?B?bUUwUjlzaUZrTXhkLzVIcWlBUGF4QkVGU0dvZE1iN0NFVGNSaE1uaUhMc1pP?=
 =?utf-8?B?YUM5WWlWZndTTGVsUVBENTBaM1BPQkp5U2ozejEvb2ZtajFoUmIreHBGYVRi?=
 =?utf-8?B?SGlEZ1dxaEpNa0VvTWplN05qd0IzKzg1cEVsaUZaM1krRE9oYlV5RzRpNkVu?=
 =?utf-8?B?WVZlNU5nMm5XeXlneUtMU09aVzBnajVWa1IrMS82TDh5RVYvQk1TL1gyUjI3?=
 =?utf-8?B?RENUcXQzYWNkVjB0cTJDQkNvenJVbXNUaktMcGpIWU1WdG9GWTlnellSbnE3?=
 =?utf-8?B?QVBjWG5LeVFZRHF5ejFSN3ZURllobEJ3ZUlSM3FmQUE5RTBsVGtSWVo4eHF6?=
 =?utf-8?B?SHdXZDhnTG5NTFhuNUt2ZDh6bUdVMGxGNWcvRlJiUkVwKzAyczhRN3djaEZp?=
 =?utf-8?B?SXpMZEY2NnREWEplaFFvNkVxUFR4WEVWckRadmZaaElsZjN6ZEtocHBMRDdD?=
 =?utf-8?B?azlzR05SMEgxcDRmK214SGV5dTBaUk5XMDE5bEJ2ekloTDBNeVVUYi8vM2M0?=
 =?utf-8?B?SlJROG01bUZzdGozc0ZrbHJpUGJjSDQzdEp4VGVJYUdnaUJ1eFRJM0hUYUcz?=
 =?utf-8?B?TThLakpNQ3ptNW5UNTdPUVZmRlhHbW1qNEhJK1orelYzbnRwYzlaci9pTHVi?=
 =?utf-8?B?UHdUQ1hHMFlBRUxlVlhUcnM0R3F2ZzROZU9qUFp0NzNaQkk0Z0cwbFQyT1VF?=
 =?utf-8?B?Vm9pMklqYld4dG5zdmphMzI3SEZJWm9rUXZaWUZ2M3dKZUYva1UveE5rNDBJ?=
 =?utf-8?B?MVhwa2FGUFRpN1JJSm9jaFZxRHdmbmo5dGVBYnovMCtuYk9lRWZkMWhFZElz?=
 =?utf-8?B?SG9HaklHTnVlbDEwN1N3UUVnL0lHbHVnbVBVazBqbjI4WVR6WEtHcHMxc0tZ?=
 =?utf-8?B?ZzJwbzVER2d2TjgxSzJ0MFU3NHBTbDBpY1hudDVFMEVxSmdZWU9peU1qV1Ew?=
 =?utf-8?B?UUtDKzlEbnJBdW9sUkdTd0RDMHNPNWZqbzM1SmxBcEUxdkU2YVdFdlF1cjhy?=
 =?utf-8?B?TG1aMEUxak12ZnVFUTlHSGxmVnNrY1RkSTBablp3V1N2bmVTeFhuTzltNGpF?=
 =?utf-8?B?K1ZvN1ZPRFRWeUtlajJac2RXT012emVtejUzY2xZb1BEL1ByRS9VT0dFbERh?=
 =?utf-8?B?RGJnSXdTc01IYTB6TUdMUWFPSXhycXp2d1o4dmlGTXdyM2dsZVh6b1l2eWZW?=
 =?utf-8?B?QTJjN3NQakthaWlzL3dSQkQzQ3VqS0pZdDFoaDZKZU5PUmZtSGovcXRCT2hq?=
 =?utf-8?B?blZZMDVrTmJIcityK09YdFZzS0JzUVpJb0NWMVA4VVBEcDgvaFZsZ0xJWHdR?=
 =?utf-8?Q?NN5eeYKFc5vXhzIvgZ3cWw6IM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6914da4-76be-408e-f296-08db5b538782
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:04:12.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsTM7Ud40mlhQ9bx+HMXxSeekqvu8FLsTDkF9Qa5cv8Nmc+nSuiXbi5NYDOZVMHnE38yXT1pxbdLbP32Sia2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On 5/22/2023 5:00 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, the extra information of a branch entry is stored in a u64
> space. With more and more information added, the space is running out.
> For example, the information of occurrences of events will be added for
> each branch.
> 
> Add an extension space to record the new information for each branch
> entry. The space is appended after the struct perf_branch_stack.
> 
> Add a bit in struct perf_branch_entry to indicate whether the extra
> information is included.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> 
> New patch
> - Introduce a generic extension space which can be used to
>   store the LBR event information for Intel. It can also be used by
>   other ARCHs for the other purpose.
> - Add a new bit in struct perf_branch_entry to indicate whether the
>   extra information is included.
> 
>  arch/powerpc/perf/core-book3s.c |  2 +-
>  arch/x86/events/amd/core.c      |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/ds.c      |  4 ++--
>  include/linux/perf_event.h      | 18 +++++++++++++++++-
>  include/uapi/linux/perf_event.h |  4 +++-
>  kernel/events/core.c            |  5 +++++
>  7 files changed, 30 insertions(+), 7 deletions(-)
> 

This seems to be missing the following:

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6310fc5c9f52..b6739f63dc34 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1704,7 +1704,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
                perf_sample_data_init(&data, 0, event->hw.last_period);

                if (has_branch_stack(event))
-                       perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+                       perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);

                if (perf_event_overflow(event, &data, regs))
                        x86_pmu_stop(event, 0);


Otherwise, the changes look good to me.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>


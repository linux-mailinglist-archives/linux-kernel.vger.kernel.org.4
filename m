Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4231664589
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjAJQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjAJQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:02:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504A13F78
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfqkdLgwq7W1GVboPktug5dDQnAiuH2BUMXDWMZWzvvUv+rOJ73E3EGRb9Gz5NZ4jVSLsLAlepl+j3qfnL6alE9lP/vigh0JsBaYOgtPw/UqR7Cgnoc3p2M4L/vOpCufuVRh/aeh0TfXTQrN1pm1n+isqhgaLUN3uVm1sAY3xXIbxlqBsC6gxYkdFPOuahDX78UQWMaNjsM+Ptw6HTEPJqWCYbVn7lUXvKTNOQfHj24Ti/xUjbid2KmbpyI8qYZVrmxBnxJMYoQXpm5Dq11SLSD4I/JtMmuIZ2SBu95hVNeV6KnrP7RWA3QUZV2a/MuGl89WHiK12oZtpFqF8oO1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTGx/LfMmWRt52xxC030b6m1nexRram7VQwqk3Mfz/s=;
 b=dxCprlQDBWjNBSQdkZJvGtEaoKx8a9h0JK9khgFzzOCmuvN8o3X7TToBOrgfkBs321z9mQQRRlOWSB/VMh2PXheXbYMZ4ytDWMOWY3wyvuyvzGAFUBjpHe137D8IBdCc2S1UFwjy6Lq8Z4B7QXeUDVxYjI3rB5MUtPWhJ1TXpanar/DPh2Lz3q2m5sfciUUcNLYwBaUwpVco7El7o5zx+KVchm07otsZqTUPAu9d5rzkcB/UtFPOF5ETR34RH7ZZRCoetXAuuAuxI6TNqL2VmxKbG+MIOUjiK5/3JAIAh5mcxDyU5/BnaWJbX4jJoD0EP89wzkMZNPkp9myhjY9e3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTGx/LfMmWRt52xxC030b6m1nexRram7VQwqk3Mfz/s=;
 b=cxDhCz/W7wy1X5wnpo6kCvJT+x8Z/wlYcLfA5TJqMREX8QDeqWi09MFbGmcn6DEnrEgySPxJ7bb01s8bFPhoRIX0ceb6bMak31z5cuR7Xmi2G6J2HhyKIMe8XszOzP9hefJtyv0jjFWRTziyW4ogP/EJvK5PCHXcJsuL2MgVmsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:02:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:02:00 +0000
Message-ID: <364c2d8d-dc81-9ccc-51e8-92cd8db3c4ee@amd.com>
Date:   Tue, 10 Jan 2023 10:01:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 2/2] x86/resctrl: Avoid redundant counter read in
 __mon_event_count()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, eranian@google.com,
        hpa@zytor.com, james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, quic_jiles@quicinc.com, tan.shaopeng@fujitsu.com,
        tglx@linutronix.de, x86@kernel.org
References: <20221220164132.443083-1-peternewman@google.com>
 <20221220164132.443083-2-peternewman@google.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20221220164132.443083-2-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a8a35f-bcae-4cc6-5000-08daf32401c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqEf6Zr3EGuhAG2GnZaYHHVv6AE9juxD7TBTEX8wM6R7v3AMYVmwyHtK5KtiDAPdywWcw76qr/Y4XnNVtjIGQ18hVImfWNAUFi3dtdxU2DSfSKZEphRFUG1S/v3qUGm5nxl5VhBjvUjVfoKJWzGbYBn8o41rOiSEP8FVDdXR+Twzu18qrkiVBae6SD09Xb5w00EHKHwPd5MHvrqd+2fSvlnPHbPX8cXZZQsv+IuE4i7FLnis/Krrj06qKStCTMdmBxYgYQCa3sYYSOs3FN/GYqIaTSDFq6wYgR51NuC8OF931Kz9eZhGwMmIxNtmG9rBW4wW+Ptgdj3gs/fR9+Fq2Yp64Ifye7w4iG9TYVCj49UJtvSwFFgmKvOf4Wez7XtuMqfRYHLCy4wRsnmBuxN2PTQhNOn57hWx9qn2KG9+bkZkl8XnkKOdmPK6nvXufi27VpATj+SIyKB4RFCv5xnWyZpn8RI4z2IfBmKA4L2EcjJT3NV+Vc/Wqrv6NKFsSCmjocOWeemENZU1wwIkZ/VTTY85KyXKXPxSa4JoGBN2PUqGe9QLzUCl2UtJqU+iYKViIm8GVaTetxaeutrstgHs+chRArCGeMkPPw9rbJseEM3wtfZkMdtnY4kuT/nRq1sGndtZugt9CGzpIJSp0j7waAWcpkpIvabFvBfokEoOejEa6FeCRG8hjbsFfk1OpJL4ymH9nqIXJE2kW173NFvEPRcPGsHMguSvpbG6ZSYJAqQpT+0jI8g55F4wErx/YyG5nvoeUW+CUj7mSDTxL23tww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(3450700001)(53546011)(31686004)(2906002)(6506007)(6486002)(966005)(6512007)(26005)(6666004)(478600001)(186003)(8676002)(2616005)(66556008)(36756003)(66476007)(66946007)(316002)(4326008)(41300700001)(83380400001)(5660300002)(38100700002)(7416002)(31696002)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29oZkN4Z1ZIdW0vYjVYMnl6SXNiWEVTSEp1VyttYmlua3FkeTRJUzZ0K2lj?=
 =?utf-8?B?RUcrbE4zOTFmZWFFREtLQXBYY3l6TjVZbENRZU5kaE00TngrYXVhSGZpRk9v?=
 =?utf-8?B?MUZ0NzFvQzN0alBGN3NDaWU5aXBZRXdHR2tOU2Z2eGcyVHZCcG9FZzAxclAr?=
 =?utf-8?B?TTcwTlpBVW9pcHNjK3ZxMmZlR0dYY0V5cS9xOGRWU21sQUd3WnZIaDErN3hQ?=
 =?utf-8?B?YTlDbnBQQ0xJa1F0RkhnVDlhanJ3Q1gxTVF5dE1McUJYYURCZHJkWXhFbkdC?=
 =?utf-8?B?cmd3SDBBVzZkUjFjbks2dXM3eTNKdWRLTkYxVFMwSVdxanppWFpFaFBhZTlk?=
 =?utf-8?B?dXB5aVFZdUFEMUNQLzdUcUZGbFRDNnN4cHF5TVA3WThXMmJuRVROcTd6Ykl1?=
 =?utf-8?B?bVJ0UlRyY2FKYTNJL0t4aktidGNNd2k0NkxHaGh0cHlndEY4dUxPZzh5aTE0?=
 =?utf-8?B?Mm5jazF6Z0JFUXlKeVRUY1Y5bWVuQmJ1QzAvUUdjcG04dy94N0dHb3hWRG1X?=
 =?utf-8?B?NHdEa2ZpYWJ2dmNLT1Q2bzNoWldTZzdCWWk0MURWczhoSmdCamVFTjhXRmdL?=
 =?utf-8?B?elJsWms5Z0NIUnU5eW9qNTh4d0k3ZkZTbzFyTmFndGdmVElJcmtyRS9nQlUy?=
 =?utf-8?B?ZE1HZkx4bGhLbTh6TDRDZ293d0piZElrYTRQYU03SWUveXo0cmo4bGlqN1lh?=
 =?utf-8?B?R09oelN1UmY4RWw5ajlzR1RKdkRZaVlLdWpHZGxzZC80dUZTU1BFci8reWxr?=
 =?utf-8?B?RVFLdTFTZlRFTjJodkpYQTVxZXA4N0NMMkcrWUhoQ2M5SlNaS2pZaWt2OTBQ?=
 =?utf-8?B?SnFQVGFtWGlzbFBKcmlJVjU4UnRKL093MTFBN0huMjR4bHYyWmk0TTRGc0NU?=
 =?utf-8?B?dnhlY3R6SGhvbW5IZmtHdjUxSXpUZEFXMTBlQjVPVlFjZVZ4ZWVpc0tmVE95?=
 =?utf-8?B?Zm00d2hIOGp0R014U1IySjFuZC95ay80anUvUjM0VWlXamsxeng4NjRhSnZB?=
 =?utf-8?B?TUVVZFRLU2VYWDJyZm1mOC9URy9SYkpLdEwvb2lWQUNwZnBCaVdSeVB4SkFQ?=
 =?utf-8?B?aGhxQXF2MHF4cmV6K2JUSjlVdmR1NGVLa0hEUzY4Q0pCZ1BvV3YrRmFXUlNN?=
 =?utf-8?B?NWV1MDZjL2dTcjZValdQM0ZMWFhUVmFjQzBoMXdTQk9zMGE3RE9JNUsvZGk0?=
 =?utf-8?B?WXlvNzQzUG9kem0vQVRUZWR0RUFGek9xNjdlMjFVUXY0RzROSVBIQ2V4RXU1?=
 =?utf-8?B?b2p3UzVib3V3Z1d2dlZDa0tsU3JxTUhnV3A4NXgxell6cXdVdHJOTUJYUjJE?=
 =?utf-8?B?enN3a0l2bmVpZEZoQTh0WWlsaHZ0SzNLM2IzZFYva2Noc3Z3cW9tVVpxREQ3?=
 =?utf-8?B?Z256M2g1MGpFSDg0RTVHTW5MU3BGZk9WTnBNQ0gzUU1ocllCY2FLYUdBMmtn?=
 =?utf-8?B?b1R1SjRYQjJqT3hHU2VRdGsvYzE3dlUxYWFtbW9naXF2VEI3eWprY2hVa0Vx?=
 =?utf-8?B?SWZaQlhXOGpBd1lBWmt1SEJVcklJSjVMWHBLcmhNYXdYN1NUTUd6ZXBXb1dQ?=
 =?utf-8?B?ZjlkaFM2UHNWbE5JZFA1SVJlOEYwMFhxK2JaRE04NE4wSzZpVWczSXd1TEov?=
 =?utf-8?B?QVlvV1B2MUtoUWpaNlNSRFZ1MWRDRFYzRDYvaGE1NUx1Z1cwVHZ1MWxiTjNp?=
 =?utf-8?B?UHgwL1ZzY0ErcXNURkV4Q2VaeFo5MW5WUXhHMzl5QjlzQ0lDM2Nla0UxemhW?=
 =?utf-8?B?T3hBUk84TUxhRjlvTzBHMSswTzJDbFE3TFJsa1h6NjI4NDRDR2tQTnVDZW1E?=
 =?utf-8?B?SlVPenAyRmQ2allXemd4YjNFSk40dWhTU1BtRkI1WTZ4ZHAvdDB1MU00QzFW?=
 =?utf-8?B?VG81N1E4TXBqMkIzaHJ4QS9XSUY1a1F2MURPcUFzMkxiTER3L2NMTFJMMkcx?=
 =?utf-8?B?T1VNRnNLSTBFYkpDZk9PakhaQVBCRnQ4a0lNck8za1V0c2YvZlkyYnpuQ2pB?=
 =?utf-8?B?Zks4b2ZoU09Lc3diMjhvYUVHSlpkWGV2b1M3QVNrdzdiY3VRQ2VTUVhvS3J6?=
 =?utf-8?B?REZ3SGNRaHRYaUh3cG4wc3RZM1ZoZWRqVkpJZ2R6R0VvQVpRNElUOWxGRmZp?=
 =?utf-8?Q?kOAwomB4CG8mG/rXj7t/ZVpaY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a8a35f-bcae-4cc6-5000-08daf32401c9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:02:00.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mJGEbCxXMFop0c1TlVobCEPLLGgiCiXVhqwQWmDvid1PJf8cnUddj0LVkUGDbN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/22 10:41, Peter Newman wrote:
> __mon_event_count() does the per-RMID, per-domain work for
> user-initiated event count reads and the initialization of new monitor
> groups.
>
> In the initialization case, after resctrl_arch_reset_rmid() calls
> __rmid_read() to record an initial count for a new monitor group, it
> immediately calls resctrl_arch_rmid_read(). This re-read of the hardware
> counter is unnecessary and the following computations are ignored by the
> caller during initialization.
>
> Following return from resctrl_arch_reset_rmid(), just clear the
> mbm_state and return. This involves moving the mbm_state lookup into the
> rr->first case, as it's not needed for regular event count reads: the
> QOS_L3_OCCUP_EVENT_ID case was redundant with the accumulating logic at
> the end of the function.
>
> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v3:
>  - changelog clarifications suggested by Reinette
> v2:
>  (patch introduced)
>
> v2: https://lore.kernel.org/lkml/20221214160856.2164207-2-peternewman@google.com/
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 43 ++++++++++++---------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 77538abeb72a..e708df478077 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -366,41 +366,36 @@ void free_rmid(u32 rmid)
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  }
>  
> +static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> +				       enum resctrl_event_id evtid)
> +{
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return &d->mbm_total[rmid];
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return &d->mbm_local[rmid];
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct mbm_state *m;
>  	u64 tval = 0;
>  
> -	if (rr->first)
> +	if (rr->first) {
>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +		m = get_mbm_state(rr->d, rmid, rr->evtid);
> +		if (m)
> +			memset(m, 0, sizeof(struct mbm_state));
> +		return 0;
> +	}
>  
>  	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
>  	if (rr->err)
>  		return rr->err;
>  
> -	switch (rr->evtid) {
> -	case QOS_L3_OCCUP_EVENT_ID:
> -		rr->val += tval;
> -		return 0;
> -	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		m = &rr->d->mbm_total[rmid];
> -		break;
> -	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		m = &rr->d->mbm_local[rmid];
> -		break;
> -	default:
> -		/*
> -		 * Code would never reach here because an invalid
> -		 * event id would fail in resctrl_arch_rmid_read().
> -		 */
> -		return -EINVAL;
> -	}
> -
> -	if (rr->first) {
> -		memset(m, 0, sizeof(struct mbm_state));
> -		return 0;
> -	}
> -
>  	rr->val += tval;
>  
>  	return 0;

Tested the patches on AMD systems. Looks good.
Tested-by: Babu Moger <babu.moger@amd.com>

Thanks
Babu Moger


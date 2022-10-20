Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E3606158
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJTNS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJTNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:18:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB191B231E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LntkzugKyWwMPmXhjB7xdDMRQQKvn3DSkPivuwcQlXF0IqEMHvlZbY3ukE1d0cRksesQSYa/gJ7P1uwvzEyRn8g5Y8YbPheKP87lynzOoap40508qxYJeAUaHGcK232km8zONZjDBGjD1fkWW5fTf+L8eYpgaWaI8KYp3ZvwS1GtfDDEpQcqBCern1gSkEOCaFVb/d6MmYAT6LJo95cy5feyiE3nUCU680GhCZ8QqHiV43c65O3OvSjdY1n5IJWqP6sndv5Ohqj72A2Iy3S8pNhRrjsAFUx75Kjsq7kEbOMyzKfueBctYew8edicmDuJlRvtgbZkKpUnvUOYvAdeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph99jjmvxnSMHZwfBQi6Qqu0r728QlCQCKShM2Fdvog=;
 b=YOPMT+VBV4fCvBHelDjnd8VlpPZQa540BsJZyBjQHeszv99mXIqGhsbA/WuNwbyUlWDnptbGsskdB/HNWhL5Z2HAwzJWI1lF5zXPyYxT81OzGRi6zr2Lya1MS9Af9V6Qh5sdaDzsJ4LeUjFHVSaSq+1e+tXdFVWYRZrI1wM18ooCaXpf1EymJAmSSFw3WTAPpGPzck/SWSZLEtYVizmuQXGzOyRC3hPkIrVcvhM1pFQei5A2klygButiMeZrJNMi6FSf/roc1epOyH1jQi613S/1Atlfa/0AsrmX+mQOP/J91jO8yckRo+m+M18dXVWos77Kx+uh1XLEderAyMMGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph99jjmvxnSMHZwfBQi6Qqu0r728QlCQCKShM2Fdvog=;
 b=ry34uHVI9yus1YAmM3l9CIcLmau/KVECGe20SK1oup0c4eKtNvyhqrXNUU85ULzqU4zmvs/glPhXOu1MTctcfexrWox6yu8SfIcXS15Gt9lZjlbXHhZdxga6aLypcizwiiOgncCGw/Q5wE+NjY6EPPeN/cVFwSHKdBM8jlZgeMlMbJ//rxev2IH40jyIvr39HIssC/Z4iku9tTM+5AyE6Q/rByEwY4DwC8p7tAwLQHI+Mn1dqdqQ3HRsPU8ApcR/DWulW01MaSmNZELTXjstidhf+HE+8lrKSm3EUXCXArzXkhOc0dIJw7JwM0ZXbehP2W0qFDF6iUUCU/aX+3kP0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM8PR04MB7217.eurprd04.prod.outlook.com (2603:10a6:20b:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 13:16:04 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 13:16:04 +0000
Message-ID: <47668d94-6b55-2894-fa6d-82b1f17312bf@suse.com>
Date:   Thu, 20 Oct 2022 15:16:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] x86/xen: silence smatch warning in pmu_msr_chk_emulated()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221020113759.17402-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221020113759.17402-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0602CA0006.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::16) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM8PR04MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc33f2c-131e-4ec1-9e02-08dab29d3dbe
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vu8EDncppGjR4sdKA+DA6P0kP7VwkK/pDuzzJqScWg57f2HxMH/mwqTuE/RojanGUrNoYM6KVfcAnhi7BfgD97zeuOA+tvv1FfOEKGCnNF0MHJo32elgYZoANDTn3RtLa/AEwnHOzZsA8MLfwBeplnH+sC+rrZPA/HcdMXzih6MhUJDA+vUVc55Q5yclCW2f7sosAMufsQy5lSUkf1EA+8zjzsHU3UusKWwJBFc4F1qvb+T3ru/r0UADY/JCaexEI4tI2FIJGLYP0kbisSGtq5RTOTl64FFrX1oiKw9xjSQ1VXlWtIq1m0x5+p7xNJMcEhJMSlKoTqA9IckmVG4Wbi1nR+HSh9ZlmPE3V7INmNAQrT8pzhaQku3gfWMrCelz6V7e0MLi46ljChIY9znhfQohwZsflPXveVdsK3N5lRkVDcNjTwov6QxlxZWNYflFR3UE2bxJFyVgtlLM+cVI7hzW0Yd1yelRf5vk7un3scR8IEqgpzXoEicdSkiPXD/WlHriZD6g2GUAK1ujvO11zQ4+yxyAjsJPUM87HcZkXBuEx4HcHwUkMHOD6K1SJU7kh3r9wRiyp+LcdI4OUJJyY2w8jq5gMHjZ7XO4ZrlguNykFBaCeG3TTroimLju8/vzhPiNDDMQhDLKZBD4wwd22XPRjuhMlal3W7ZTNVjlifRQKHOSTRQ3jWTNTuzYpkaQa4sgGAVjr2bUrNJFpsNdEHpYG/esO66ic0rL0OydQYVjkc8aGgSQU4N1BnLvE03tU9nLw9jJ6aPbDtrjircSy8rxTwpYC1LiMzJp2Il+S6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(54906003)(186003)(38100700002)(2906002)(2616005)(6486002)(478600001)(4326008)(37006003)(66476007)(86362001)(66946007)(8676002)(66556008)(4744005)(6636002)(8936002)(31686004)(26005)(6512007)(83380400001)(53546011)(6506007)(41300700001)(31696002)(36756003)(316002)(6862004)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek0wTzY1dVIwSlRmOWtGdzN6eEt1RjI1Q0ZlMFZJd0xOSFl4M2YzUEVJUTA1?=
 =?utf-8?B?K2sxS3B1bE41d0kxQVQydFNvSDBudUFiSzgrRm0zbFFTc1ZuNUx1U2Jra2VZ?=
 =?utf-8?B?eFRIVHFOY3VZNzJXOU1EL1RSeVRETjVMQnJqSkZ4MitIMWNBOVhaL2ZaaDUz?=
 =?utf-8?B?clZVZm1jNlJqVmYrTVNZQTJ2OW9QTjRuUW9hUVBoQnBKaUo2T2piYTdmUFMw?=
 =?utf-8?B?SEkwNy9XdlEvYzFLTDBSaEVGaFlZdEZZMG1Qc1dNaThlUjNRZk9ZNHhDM002?=
 =?utf-8?B?RmtVb0VSWXV0cUNVYm1DRUJFajYySjIvTGo2TVE3c0ptTUNhdGQ2R1hVY05h?=
 =?utf-8?B?anY3YkJ3QndXZGZlQ3hJRE10TXd1cVU0bUdLQU1Tc1dRa0ZwTlBnT1hGaWZC?=
 =?utf-8?B?QzNlYitBekR4TTRGY2g5d0U1aDZmNjdsUWhwRlZzcjJTOUZsSzd0KzVlTUlH?=
 =?utf-8?B?WE4wUE1WRjh0UkVKSGlwOHN0bFo2aVBJSkdlaSt3U1lwWG5NWVJReTB6Rjd6?=
 =?utf-8?B?UUhDUXlUNktkeW9FNGlRS3puODVuemlFandsWkh2ckVPQ1A4eGZJTVBkVWlv?=
 =?utf-8?B?WDYxNHRnSFBQbGVhVnlRVmFFZUFGdWF6ODY1WEJXSmVsTGRmcFBRd3ZmNDYz?=
 =?utf-8?B?M3lzWG5RQXJqcGtlYVpxVmkxMGJPbXdtVHc3V3pXTTZuVzZLd0YwR2dmSEVq?=
 =?utf-8?B?a00yaGQwczVFd3ZOaldvZk00eE9sVnhlNVFQS2VEV3FKRzBpM1FaWnZNTk5C?=
 =?utf-8?B?NGdqMjZZaHJXSUNUb083TldvRVhuNkFoVTc2YzFNR2pkVFhVV1ByRVZMVGJX?=
 =?utf-8?B?Z3ZSSkpyUTFlVFpOTE95OVJMY2NTc2JqaU00TSt1WldJdUpGSXVRUWowckQ4?=
 =?utf-8?B?b2EwcldZckJWeGNYb3ZaYXRUZ2JHaGYvckNuRm5YdjRQUHI5QmFxeGFvWjAr?=
 =?utf-8?B?Zm5aU2E5RmQ1eUFoVjhqM1BFeDNJSThBQzN5YlpoaXZoSThYaWVQU1kveXZy?=
 =?utf-8?B?akZ0Smpxc0p6NXo4bXNTNEM2SWdkZ1dsZ0NkMVpEZ0RvSVNSempNMXpmejRo?=
 =?utf-8?B?ZFZGeTRPd2h6VFZDeW5PNm9MazRQVnVweTJiWWtxd0NhYkd5UTMxNktrVThK?=
 =?utf-8?B?NWhrakNGL1RRekJaY3V0M0Y4UERBMjZlVEI5U0k3d0xDdmNTODB3WkRva1p2?=
 =?utf-8?B?bFVjZ2pTSC8xaHJ2WndxQ0hjQ3d4Y1B3MHJSWHZ4UEptNmNiV29hdmFGUUJO?=
 =?utf-8?B?L3N0NUJNSXM0UjhsTFFZR1N4eG1aM1FVSzkxQjVNUFBMU3BUUklaZWl0STZx?=
 =?utf-8?B?d1JwWlh1aDFwV1F0T2tPT1U5aE1DYUFTc2hiWHlMTy84NDgzM2p5OUF1MDVN?=
 =?utf-8?B?NTczZXpxcmZ0V1FqdTY1VUJxd2Q5SUViQXlNYWE3WVc3d3VocGluS0YxNFlH?=
 =?utf-8?B?RmFldlI4bDVwVFdRK0ZrcUw3b0huNkg1Z0FhSmMwWmwzclhBd1VzcEZmRitp?=
 =?utf-8?B?TGd2RE9jRW9BUGgzaEJwVFJHbkxTc2liejhUSy9MeE1nL3ZTTjNRRnROMFFj?=
 =?utf-8?B?clVhZHhUbktQWURHNWplN05lRGVISEJzY0E0eXlOQURsRjZmSFN5TDRzRFl5?=
 =?utf-8?B?dGdmTElmL3VXUU82NVpoQmc3NFJBVmFOZ1lRa2g4S3p6Wjkvd0lZalRYVnd0?=
 =?utf-8?B?K3Y2YVB5SG9Fd0Y3OWF6SHNpRVRUMHl0QlViY3l0Q0ZqWlF4aHNpYUNxL3Rj?=
 =?utf-8?B?M0kyMmtTQUJRWXZiUE53Z09kNU9zcDFVSW16SCsydjMrOWRKb2s1c082TTlZ?=
 =?utf-8?B?K1RXNDdQTUJhT1N5dmx0YlhkNDY3em1naUg3WjQ0QndzVng5ZFNtZkJzSHl1?=
 =?utf-8?B?WjZldWtYUEQ2SUZSbDJSWGduOEc0Y0dtVUdIT3ZTcDJyOXNtKzZuWFIxTUV5?=
 =?utf-8?B?cWMzZlhQaUlzNjBuTDJDZkFzb0x1UUtHRE40UmNKSmt0Q3A3aFpHMTQ5RjlK?=
 =?utf-8?B?VGtCckdidDk0b0ZTNWVMcDhUUEJnNE8rYmwwajRIaGJ5bEdKQUVndWZjdlNL?=
 =?utf-8?B?Skd6TjFvTmVJbjRKbXp1alBES2h1U1A4TXltanhaNW9VdFd6dW9HUVU5bnlW?=
 =?utf-8?Q?t2GQgDgPqz+U2738SUOZd6eO9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc33f2c-131e-4ec1-9e02-08dab29d3dbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 13:16:04.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8kEBRFC3b8HKOsUE9aC/d/OJyqvoAfKljj6cuSRoZvrrVxIqOhHEpx/X4x/5cUz9yF7zDW7uLVCIS9erI8ItQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.2022 13:37, Juergen Gross wrote:
> Commit 8714f7bcd3c2 ("xen/pv: add fault recovery control to pmu msr
> accesses") introduced code resulting in a warning issued by the smatch
> static checker, claiming to use an uninitialized variable.
> 
> This is a false positive, but work around the warning nevertheless.

The risk of introducing a problem might be quite low here, but in general
it exists: With the adjustment you remove any chance of the compiler
spotting a missing initialization before use. And I'm not convinced using
0 in such a case would actually be ending up sufficiently benign.

Jan

> --- a/arch/x86/xen/pmu.c
> +++ b/arch/x86/xen/pmu.c
> @@ -302,7 +302,7 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
>  static bool pmu_msr_chk_emulated(unsigned int msr, uint64_t *val, bool is_read,
>  				 bool *emul)
>  {
> -	int type, index;
> +	int type = 0, index = 0;
>  
>  	if (is_amd_pmu_msr(msr))
>  		*emul = xen_amd_pmu_emulate(msr, val, is_read);


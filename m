Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9960D83E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiJYXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiJYXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:55:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804151A35;
        Tue, 25 Oct 2022 16:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JohEjFNC0AltGTegJ4llLRzc+0Vi1LrX966+T+t/o8rR92fZodblCJZzQCf97uW6IE7KP7xWQppkkAmeVaXIwJK9h7S5O6DVcWfZiX3/ibOL3wmq2FVVCL4o0pbddNwm5ZHLPKZXyyhu2mlYRyYXL3xUOhDdgEkgiNbt2qBfom85F6TaEWEQg5ps3jRQfozV0F17jV64A3cWPhX2fRszjlOTRHREf9L+tt8a/cggJhyVGp5SfhBPm+ID4kZgIPMH9irUpo4F7E1MNTMzfRdwBY9hlpHyqYTZZ0a7xK/7oYT5x19lFgcbNwiHX+ZI5WQDn0D5k/Pja6+QMaID3GSrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhfvWRkfUq1BGBcalWKl5s7d4WBpxkPQFvx++oTpJto=;
 b=A8+/jkcBKUT138YBitY4buKCcUFd5epDA1cCHAHy9NhjX5c8Ag1uC/knrFchkCBQqOb6f+567tz8jHRCZMuixUqS9qCzt5EJg58UaDsJU/AYHvqZ9ZK2IcVpbB28EeKLydfveAl9dfRRnX5C1G27slUMy7YUMw82y+uMu05jzmay84PqwrtDXCiW9KuLtLUgihr5SO1615hDPYRxM2euvsXhvn8B6GPdNZ1vomgbsNnJnZzRv2GgLuLpg8vH4un+X8xlj8mS87vwJcTA6IVmBeMP6E6hkBpv9vKnS6yPLif+RrgOZiCFp3LPMGfjWqCg3ri8WMIYtuQqvebhTQtT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhfvWRkfUq1BGBcalWKl5s7d4WBpxkPQFvx++oTpJto=;
 b=iNJIWlByPRNVYjhJ/uzEStezuQIS6uYNn7Hhvtkwtg3t/nTHwAlEa2SMl3r0OikCCK99sL7yhCKmo4+5ThkUEmvP+c/9akCppdAiTZ37pTZlEf1cwJh+XFFutmQXHLXbmEE26S55lv1lZZL7WiGDPN9W2gHHNTDydMQsNqmhTlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 23:55:30 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 23:55:30 +0000
Message-ID: <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
Date:   Tue, 25 Oct 2022 16:55:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:610:cd::34) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fe08bb-7494-4992-4b7c-08dab6e46581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYwXLBqEbd7ZSCz42dNepz2GKKdSE1kZyhxFUv7GfxO12qoksUEgtU6M7oVeXWz57gqk4Ag5V/H7J1iNuAhSEKhRwnSyFRy0psvueBDYTxjojxiOicOtkw9eL5Y00ADQBvRV7i7n9COXaAuNUaS9r+epkxLLNSeRRogknQbYYyUl7qkA5wpFU0VDpYHLCvg/CU4qBPE+kdy5EvNMtneme+MCLYr/jU9D9cXjJVIRqHxrGLOrEk00K/vkTDDa0uD76276sHfT+d0++Pf0bP1aTN9QvpilHdeXUnGK6Ir65xsmbswEG3Zqv+P7bsyX/zODZBksC/CgbNEwjB5kJ9DGVZ9QIVfVVvrkDaaQZl+cMUz2abdSfTYhdQFgQFMf4vYM3/Hl4uokE4NB9EDcWBUqBgQgVDzBUp70owuSncx5MEc6Atuk4nX2B6ApcG9bD0nKZTNjYUe2JeGLCPKF3VjiEjbE+B02kCULm+k64PEHCRqccNKD+cjS8QhnVMhHZ7NeV6xKfP3QMEvFm7blofuXy+gIdCnVuvtZxRaAr00UcgYB0ybvzzmbNzt49UCJtgkcCmmR/hMinLKd9BQC9dG1TMa8Kialv1fMbsoJQ48GVNCvx0/nVqFw2gpoJ4PINZIs5Aq1JvEYdCEuvf4yTluT1Oj/Zxf1GGHQryG/CffpDuwcv26iv6P+x+cwOjHJ6zFiN9ae47grgwCE76BI83RfqoS/pxdJTvJeHFlZKDULn1Iztkl5c2qy22WwgPWSA4fBL6sR/GOBz5WG5OMysZhWlTFrtUsRS2CTdspJozowwiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(36756003)(83380400001)(186003)(2616005)(38100700002)(4326008)(66556008)(8676002)(66946007)(66476007)(8936002)(41300700001)(5660300002)(2906002)(316002)(31696002)(86362001)(54906003)(6666004)(478600001)(53546011)(6512007)(6506007)(6486002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2NyWW16UDdUQTVYei9SMjA5Uk9wcEhmOHdVNGN2NHVEVUNRMWUxQmd4c3k5?=
 =?utf-8?B?ZGMrSEZOaEMwQmxrazNoUFV4TnpMTVpQdXJXb3pmckozc1ZpN3plaXVYWXNw?=
 =?utf-8?B?M2NFRzBKVG1WUEhpM3FBNU5CQ3ZqQ2ZZbDVzdW1VM0J3MWtPcTdhbmExa00r?=
 =?utf-8?B?czVFUjQyRXFqRnNkeStJbStXc2xlL2w0ZUFNQ1FtUzdRd0pjWjVSbGFIUlZ4?=
 =?utf-8?B?Nm94ZVpLYUVGd3V6SWhkTFZPWkFYQWcxSFpPVEw2QkVib2orcjVLYzVXTmRC?=
 =?utf-8?B?WEViVTNBb3FrN0dpVXRERTNadExDaTlaMSs2bkVRV3hCb3haZ28wSk1mWkhW?=
 =?utf-8?B?KzdNQ1Y4U3FnenRVRkdwa1NqRU1OZ3BaU1N3STdGeG9xa1RiZkFvUWhqOVE5?=
 =?utf-8?B?cGlRTUFMQ3BKR2VoK0RpeC94UWxSUU85ajdmWE03Ly9NTkFvTzBtNGZxZXNB?=
 =?utf-8?B?TFV1dHdmRFZudVNBeGJpczlwcFY0TCtBckZabU5sOFpkUzNVN1dGWG5ySnJy?=
 =?utf-8?B?blhaZHJaUXM0Vjg4b1U5NWgxOXg2NjRSN2QzOURzQWtIenFnWjlMd0xSYjFh?=
 =?utf-8?B?ZmZKUlBzVStjMnBEVCthNkIwQ1dBeDYxT2t2NW1jLzkxL25pMnJ5NUNpR1N1?=
 =?utf-8?B?R1pHK0paRzQxQ1NPeWg1UGw5d2J0TkRBNDZhbUJJekoxbUU4S2NpdHZPTGs5?=
 =?utf-8?B?VVBpampUenFtRUFaTW1LbWlmVUxkYUNEZXFSVTNRMURNYk5oMmRQSG1wOXNQ?=
 =?utf-8?B?ZEhRWjIyL2FEeERySWp5VXBBa0lVeERnZithaVEvRUZtY2poSzlrU1FnWjNM?=
 =?utf-8?B?N0NuZFZmTUx1My9RMEpJZkp6SkVxMFlCK3RWNWlSYkxLb1NmUEhkalMvK0dP?=
 =?utf-8?B?aEFEN2pPNDFtaTh5ZFFpdEpnVXdBQmROV2JMd1JIQTVaTExPelhKcHFkSEEz?=
 =?utf-8?B?Z1VKQlNCQWhQOEZhWWNtaXFqTDY4OGpLWXlidExIaTdCZ1F3UW9iRWRXcmFR?=
 =?utf-8?B?eEpnS3hwS0RvN1REbnd2amNWVDhlSm1kejZlQk5KVGtKaG90UEtqY0RjOVFz?=
 =?utf-8?B?S0hPUXpwa1BNdG9KSU5Salp4KzZoR05zMElZSkU0cUF6UVJxSHAwTHBrOXAv?=
 =?utf-8?B?ZkorQzNQaG0zMVhBTE1GTjV6RzJQcWlkem1wLzhkd3JnZkptMG91UjdIUWVl?=
 =?utf-8?B?Y3FuQXJmZ21yQVcxdVM3QnY0Y3FDT2g4ZnpQMWZwamtIM015QWIzdTNpNUZk?=
 =?utf-8?B?bkJtUWZRWXdSM1BKTktHOFZEWmgwK2dhakZwSkMrQlRFN2sxSW5HRnhNZVMy?=
 =?utf-8?B?d3h3WC9SZFR6YnZ2VzZZK0hoYjV4dXF0MFVOS2F6WVpBL3ZKUmh5THZpbnh5?=
 =?utf-8?B?bWl0VTlMcGtPYk9QYWNjcDU0bzVaekZwaUJ4Vit5Nld5SDRBS1h5U1Vid0o3?=
 =?utf-8?B?azVFbGpvWWJDZXpSN2dWTVFHUkMzQTFDaVBoeWZSbGkxS2J1ZUQvVUcraERJ?=
 =?utf-8?B?L011WWNZc3l6aW9PWlhkZVRIM1czM21rZHFHSEJqMWpoSDE4cWliNmxoZnJI?=
 =?utf-8?B?M2dhTFBJaTlVTG90dG8xZzJPVlJiRW5MZjBvemc2RXdhNnBWeDBYd2VjYzQv?=
 =?utf-8?B?a1lhUXNrakJybUE2b0hFdDlxY3BNYXBJbHZmbFluYndDemJBL2J5dzV1QW5z?=
 =?utf-8?B?aVlQejBjZGsybVFiWFBKZDZVYkFOV095YSszUDMzNGE5bWtnWkN3aVZiOWw3?=
 =?utf-8?B?S0JUck5QT3NDVDdxSHhhc1crMUZDOWFtM0t6cHNEK2FVUFlUeU1Oc05GeGxU?=
 =?utf-8?B?TWxXSXNXU05laDBiYnhvT04vSVlhUUZMeFNhNnhzdTRlQXUza29McEhnSmtB?=
 =?utf-8?B?RG4rUFlpVHJ2L3dhdXhmbzArOWdOOE9pemZFeW13akpFNDA2SWNHOWxHZGlo?=
 =?utf-8?B?SURiaGtTRUxyT3d2RFVQTUc1TU1lMCtycVVkbXhKVUVzd2NxR3Q2VmZZTmZU?=
 =?utf-8?B?SlJOSFR4VmFob004L1lKRU9CcVJYejNzREZBNVhJQjArWjl5SlA0Z3RJSXIz?=
 =?utf-8?B?NDV5VlBFUFIvN085dWk1eWh5bEtCU1JxVmlRMmZaR3BDV3RIZzljUlcyVVlU?=
 =?utf-8?Q?ZUS9UIforbkvYJKvFlgCJYGRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fe08bb-7494-4992-4b7c-08dab6e46581
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:55:29.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UX4L0azO91Rr1vvLmjiwPAhMk3k9T9NyZdzEKrWqc5OtgKUZp9y+Q4CVe/wfSDlYQP4+3GFLz5fML8Sx/HtFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 10/21/2022 3:18 PM, Dan Williams wrote:
> Hi Smita,
>
> Smita Koralahalli wrote:
>> This series adds decoding for the CXL Protocol Errors Common Platform
>> Error Record.
> Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
> drivers/firmware/efi/ patches.
>
> Along those lines, drivers/cxl/ developers have an idea of what is
> contained in the new CXL protocol error records and why Linux might want
> to decode them, others from outside drivers/cxl/ might not. It always
> helps to have a small summary of the benefit to end users of the
> motivation to apply a patch set.

Sure, will include in my v2.

>
>> Smita Koralahalli (2):
>>    efi/cper, cxl: Decode CXL Protocol Error Section
>>    efi/cper, cxl: Decode CXL Error Log
>>
>>   drivers/firmware/efi/Makefile   |   2 +-
>>   drivers/firmware/efi/cper.c     |   9 +++
>>   drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
>>   drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
>>   include/linux/cxl_err.h         |  21 +++++++
>>   5 files changed, 197 insertions(+), 1 deletion(-)
> I notice no updates for the trace events in ghes_do_proc(), is that next
> in your queue? That's ok to be a follow-on after v2.

Sorry, if I haven't understood this right. Are you implying about the 
"handling"
of cxl memory errors in ghes_do_proc() or is it just copying of CPER 
entries to
tracepoints?

Thanks,
Smita



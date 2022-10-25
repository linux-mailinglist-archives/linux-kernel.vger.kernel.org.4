Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B660C077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJYBHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJYBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:06:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFF46876;
        Mon, 24 Oct 2022 17:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrpJtpauuZasbKYsjVjc52Y7Q8r44Epy+tL3QakJxKs1VEvb4HIEC2xeDA8ZmsDtgumqBmU75HnQ8XlWbbycYd12u7MDf1CCNHCwCH964tXvTJqxxV883aJsplvlsgFeTQaT7cboD3dD7mU84nTNL+dXrqv9fOHdt6EwC3oGrTQGVDyXGR7PtajuF8oK6V4O+wXWkDCkS5RnaZ+Z3OFFPgKkLvBRuvdA9pE8slQokmNNqaMJLGN9HQLquyZwo8M7c4lCAcQt6FCuUVX8AkRbc+4JaB+Mz5b7cl8kFCTgulgLSi0tMCgkhaM2KyFk0/jGzbbi5bgkC4CDHyyhkO/rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=462CG1lQd8cFnR9KkbGfS9+y5dM0qh+K0NCFKfVTZmk=;
 b=fkLHZ62Na7tMYrG3a5biezDjMSBAegN3OLQcUlrhL5PJthVoy6vgDZNBdL6b4ArLrnaeIef2G2/gR3cnX+UqxngurZS3F44AC/3jBasLhq4TBHZEkS7ehNhsTi9UT0jwgyzAxaa8L+ZUa3JxNOqXBXGLQoBxSYtWi6fxTHGxGb88VDan3NAInFJMLOCnvog0KJqp0wlB9+wL4N8PFQSc6saiOf63EUE2xLjxS8N3UROUTehxvS/VpB23ARuw/k2bBKk8vReUOse1AyJVhVaZH2Kb+GdgCgWJSeF7xgA2b1R9MdTG+hpaHU6Y2SrMTC8r+z1xNkGr5sNPDiSLpFNVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=462CG1lQd8cFnR9KkbGfS9+y5dM0qh+K0NCFKfVTZmk=;
 b=f2wPdnGK/L9BQw54gKgdmMtq3QZfnbS0JsMkLkr9I9nKdJK7+RUDlbRsZnUd1vi3QFZs1OWqm8n9fxyTpGwtTyMWvk8QwcSczK+TDhNKYeaq45Ue+eYNxd0VumpF2Rx8Ld7uZXRCz77OkCEuKi61p3N95utSP1pj+KfoyfB+JEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Tue, 25 Oct
 2022 00:13:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 00:13:12 +0000
Message-ID: <1f80828d-4c8c-f98f-24e9-68f5c886dd40@amd.com>
Date:   Mon, 24 Oct 2022 19:13:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ACPI: x86: Add another system to quirk list for forcing
 StorageD3Enable
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dell.Client.Kernel@dell.com,
        Julius Brockmann <mail@juliusbrockmann.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221014121136.8677-1-mario.limonciello@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221014121136.8677-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:208:19b::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: ea907b55-72a6-49cb-e494-08dab61db44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In/65dCgj0Jj1tSnKY3zaaf9Dcr+SlH+i6qtxHdCAZHP2Efz2BDWe7zK7imLcyN39ZqM/bEifDp0t+EZQRAQVFefwmMx07HFDijGgCb9HiQEYnDgwJtbFOaMB2IX059NTNlXh4Bi1CAC5QsJ4JwjBQ9QEAlbznTA5pYFhHnwOMOfeYYtzHZt+molt1jJVfccVy6O2EUDAkn1YXW30vSe6FjP5uB4WF6J3AOPIojmGWq/HvBgb/mB83VsZY7ucRnHVM5LB/2YaVpoWF1O7NaUaYtccUquJytnf65VjoB0JhPJVf3jbnUwS2VxuyJ+4h3vvTYb+QmpxPUy589Jjd7AnqtoGkQLFAH/yG/BJDzQ1rXLvaaPbN0KwwaVZ2sn+E5bTCeLlJY/aVZi6tKnDMo4d0sm6AzmdWoROrmIcCOwT/8c92cH1tmhhQIspjqzizl6kwe7melVrVlS1QZEY/NKQ85hiLK+jFSdUjk20T5imC6OVvlvE7bA+EpNZcwPgt0/92PgKUMvO7mkdPtTPC6g1Nnixz6ldeFzeIj4nn9wQu1RJ/k8YCGME5BmGY5EJd/j2poVSsn5D2tUkCbI29cktbYuT1wU1JpJ2LcFp0A7Rri7+jUODjqN03vli36M4EgpRGib9lnEFjRUv6UoO6MUqkYMGzK/fWHwPFb5YAMwAYRitBuW1ixwg/br7KZn354cOlLft0oUEnPx31+9yVoaqVUaonsYNwE8REtjLJfempMxpJV39Gk8lMBPxZzadT+0ww/RJt9G3C9YBNIxuOFrH3mMw0PuV8aydU0t45LWqS3F3xOpHgkoCZ/BlPlzNtzdBSUDOdPBCV4vldjE8lHIkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(86362001)(53546011)(41300700001)(5660300002)(36756003)(6486002)(8936002)(66556008)(6506007)(6916009)(66946007)(54906003)(966005)(66476007)(4326008)(8676002)(316002)(2906002)(38100700002)(478600001)(31696002)(31686004)(6512007)(26005)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVxaDNKbFBCejZqc2FuOXpRUUM0bmxZQlRlN3d2NmJoQWtjUHVoWFh6NkpE?=
 =?utf-8?B?TXZ4Vk9rWGh6Vi85SDhKc2M0eXVRTmFEVDZUOGNsZit1bnlmVjRtc0Z4WXND?=
 =?utf-8?B?YTg3S3Fyc2pOMTErT09STUd0TzJiOXN1WWhkUFFSNzk3SGdJR0IwNjgyYTl0?=
 =?utf-8?B?Z3A3bTFPSkgzc05kMEFuOVJzRjY5bXV6TkRrS2h6ZERjUWw3U1pFTk92UDRZ?=
 =?utf-8?B?V2pwYjR0cEphT0xMckJYeHl4WkN3cHZRS0J0VFpjaFdGZjlFUzE2Q2hBWjZT?=
 =?utf-8?B?SEdxamZTMHNUd0xwaGRmdlBjdDlWZ3cyb09IR2s5Yld4TE1QSm9WblF4dFd0?=
 =?utf-8?B?Ynk2d0cvZS90Q2w5Zm1BWUlwN3g2UTBqNGFKVXFUNEN6dDJvV1ZiaUo3dnRv?=
 =?utf-8?B?V0IzWDFOZWFLeWxzaTUzSUFCdmhHN0NJUFpMYXRjZWltSHB5bGVXRWlLL2Vx?=
 =?utf-8?B?QXdFOHVzZlJDdXVYMFUxUUVlT0RjSTFnTUhNRC80eUdDOXYvSzBVa3BQMU42?=
 =?utf-8?B?aTcyNUpYcEY0N1AzcFBLZkV4YkxwM0VyS3VIeWxlV1AreWc0ZVdYVHQ1b3Rv?=
 =?utf-8?B?Wkh3d0o1SFNnK2hqdzhkMDVtN0ZqTUJERVZ3Q3ltQTBoc2I1VmdoWXFmQlMv?=
 =?utf-8?B?TVRNdWc2ekR3WnJubnJ0eXNHVVQ4Z1ZqUTJueVIzUFc5M1lLOFhsM3VSYjJI?=
 =?utf-8?B?em1oYlh1Z0s2TjB6SXpVWFk1My91WUZhSWhUcnJKSlhuL2t5aWw4bkhJWGZE?=
 =?utf-8?B?TCt0YmVtNW11aTR4Tm14d3ZrSU5HZ09pVTJIc2lCYzZ5WXVBcm5mUHRjWnJ2?=
 =?utf-8?B?ZE00U0pVVTNtNTdvLzBrWU1jQzBGN2Q2TURXYk5DbnhmbzkwanczY1N6K2kv?=
 =?utf-8?B?aStTMFc1ajM5RTNPREMyY0x3dkZqWUNON0cxK2JBSXRIaW1YZzVSbXRibURh?=
 =?utf-8?B?RXJMRUVDRTU5c2hDQjdBN0NtOWg0ekFIWnV4T1Q4MXNIZHdLSEt3b1phYVR5?=
 =?utf-8?B?bThZSmJuWkV1UzFVQlE0L2QwNmdGcFdiMkd3NlhiNWZlSzljbVMrbmYyVkx3?=
 =?utf-8?B?em9rc2cyR3M1NE1CRWhNcDdtWGpINHp1OFROd00ybW5NdXlaYzJWOHVCRXBy?=
 =?utf-8?B?MG1YZXZPclY2cGNlTk41bE50cnA1VjYyeUVtNzJsdWxoOEpYTUQ0V05vRWdt?=
 =?utf-8?B?UW1zc1BXNDYvZ0tpM21iOWp2Z3VLb3hNRWdtSllONitjd2xmWVl0dERTZk15?=
 =?utf-8?B?U2xMWHlsMkVOa3d4UEJXVXZvZGdtbEMzeGZzNWJDclZXRDZjdmw1dkN5Z3Mr?=
 =?utf-8?B?dDVvMUpWSzVnVWdJU05FTkV5Ym92VjNvVWFRSG1JMHdHTW5ISjloMXhQQWVS?=
 =?utf-8?B?YzZndWpsa1dCMTBXcy8ramNGVGxieTFhVlptakZSWGFJNy9XTzJRck1nNTcz?=
 =?utf-8?B?Q2NsL3Jxc1grajkwRXl3UXFZamRSUElINzdPazR2Z2gvend3cXo1VzFzS1M1?=
 =?utf-8?B?YWxTczQ1MzZHN2JDNXJYVXFncWx3dWZBUXdZQ2FIZWlXbFpLSndqWUUvTnNv?=
 =?utf-8?B?QXpqbktkS21wQkNQUDhTQlBWR2hOM3hUdE56MDVleU1XN2VodHh6em1rN2JQ?=
 =?utf-8?B?bmFGOHAyNFVYM3hrcmVUMmJMak9PYUszS1N1SitBcjUzbmpwNVAyempEMGJL?=
 =?utf-8?B?d2FHVTdtWHBBcVA0c1JBd2NTNmFoZHJBbFF6V3hrMVVxd0ZIQit4RGdHbW4r?=
 =?utf-8?B?eE5xOVhkdEFuSzd4NnBZNWhxQi83Y3AzYThjY1FVQVFTbzBvL2VGL2duTnZp?=
 =?utf-8?B?VERJY3RVaC9ibHNKbDZNaUZkdnlHajRtdUxyUmJlK1VNVTdZOVdrZmlybktm?=
 =?utf-8?B?a2E5N2gvS25VOFcyYytQdDZZYVhDaCtldzVRRU9WQ1RNamJMWXVienI4Mmdn?=
 =?utf-8?B?N2lCdEtqRG4wSkhmSkFGYXFvT3FtMEtPOW1rbWxROExzRGpkcnV6N3hSa0Vt?=
 =?utf-8?B?WEgzTTUwdWduMDNIQU40Q1ZIeTFkK2dnZzJETHV6VmlaOWtvMUdjdUEyMzI1?=
 =?utf-8?B?c3k5NHBiaG5iN3drdXU3YXBtalM3WHgvdTE5UXZXdUtQUVpmOEd6dzBJVG55?=
 =?utf-8?Q?rgSLL4k49MhLgl9eQk9bSN17S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea907b55-72a6-49cb-e494-08dab61db44d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:13:12.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnMOYJmtIfc4C76KdWakqTI2X9mAGWhFxWS9DDMOCghA1hR0B2k/+Tu1zjcAHHPfId4wUum/gkD2+8FAXUt4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2022 07:11, Mario Limonciello wrote:
> commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
> for StorageD3Enable") introduced a quirk to allow a system with ambiguous
> use of _ADR 0 to force StorageD3Enable.
> 
> Julius Brockmann reports that Inspiron 16 5625 suffers that same symptoms.
> Add this other system to the list as well.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
> Reported-and-tested-by: Julius Brockmann <mail@juliusbrockmann.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/x86/utils.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Hi Rafael,

This got sent near the merge window a few weeks ago.  It's a trivial fix 
so I just want to make sure it didn't get misplaced.

Thanks!

> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index f8a2cbdc0ce2b..d7d3f1669d4c0 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -219,6 +219,12 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
>   		}
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
> +		}
> +	},
>   	{}
>   };
>   


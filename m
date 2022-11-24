Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67326375E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKXKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:03:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250951CB18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA44Qm5ZhbOyMpT/YUybWk9g11QByZ0p5f+yi0YV2BlkZ+Z7A3S8+1+TxE6hkSVgl/tkPIiGDxC1q7GRQJO7+2UuVa5TCiUpF9eznTpBSzd38h/jvIDWi319HGoodaEUFnBrkEaaWd1D9K+qd0r6VXpm20Xj5R2TIUBVpQU/SSv3HjcgYLmws9/01/TGPcEgo4u41lcjXtMo1c0Z8UKFnYIIWTFOK9CzbUlgQ3BWhnV1m31d1x1CnNdJ/YANLVp6lb9V/gzUAEUrzZZK1NQjjee6XYsAlnDB+HtQ7QyFqUFPCVX+5UnCYncjLYYar4zI5Wk1hGdNZEDTTdl23tl3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6GO9HmycVcattfRGppKomO3EmI2AjV1kx/RRR9pzT0=;
 b=DwGoj0X6uLvxzSHNyzj3VNlRorJKK2QwuqYdU4hZPz2oBef09DZGUjqECTClJmZ93QpPW7sr4nUQpOz+1BP1BVT8tK4+C7RqPB7h4YT5DcBBkwwFuKWHlUDjdDTpQyPUwA9gbH01503pvCC5AUhV5c992bMmKVe53QHkeEZm/ThmhujOKaCpTyNpxFfWzIammR8cx3Y1d3l7INOYaNf9vepLoSDKiLt1nf1XLtPg0bXjJgyyJP0bEzPhYHhhLlynsBLpy3AO2/Y5zPOO/s+1aFpGEHPcqr3bQffu0DwGb8cj7hjCeRhq5LHFvzk4YqNq5JZFSXUmF1//DDr3DqjLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6GO9HmycVcattfRGppKomO3EmI2AjV1kx/RRR9pzT0=;
 b=lu/EUPjYMURX5E9uKSYHKan49pmyC0FpVJZMPICNpL4151BkoJmO7UDx32kdoTnIsPjNabb1R27Zz/fwDojajSjFwgTEeOLmqRtgi7YD+Ua2XoK/Iu4cyulLPvP7XsKs3Wh0BM+Favv5W4h5Ou0Sm6abFotDwPp8Dpga8V+Dr3eZ4koVA9xmKO5JYjWucQJ1ftMJDIpCOZGVzT/wLHBIV/2L/hkxSfhCyumdsOrPMcwLgj6n2YahPBvGmkUabpd9YZ4q1A8sV2aSEGcvZfWE/Z/ruUivlvGzZmPKoaU8h9kOrpafvS9L0Z3CoRQtOVAWG++nICeGdqm+qNCwAiuiEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS8PR04MB8690.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 10:03:50 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.018; Thu, 24 Nov 2022
 10:03:50 +0000
Message-ID: <99ca3792-19c2-fd08-ed14-d1b1ce423302@suse.com>
Date:   Thu, 24 Nov 2022 11:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic> <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
 <Y35CNdPVwq11NCYN@zn.tnic> <7DA74EEE-45F1-4F84-807A-3C04551DF6F4@zytor.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <7DA74EEE-45F1-4F84-807A-3C04551DF6F4@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaec667-062d-4d94-ac2d-08dace032eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUn950ih2BjvJI3KgBxniBgXFlaQuu3+0ddaEfL/MI8BVnOZg690XCBfYQWm7o5c0O/F/nObXL9A5rVJqdJjhIbQVeDj+4HVluc8V96gG3rSyj1IvsgrNlSetZ45qrBYAkBLoDZeor9DB+Qe3LwhcPbxE9Lqp9GfwuZOZUoOYj67BOmf63rQQpFF6WNm9MAVmowQfviezULUGiSnaNibmRUlBxZC/8wfS1JG2bH5J1a3hRhf87LuBQOYeq2m/pe1iXEEVFcz6uO8xIAuqCStAaDxsD6g37poQWPoedShOA+aRYDJx9CVSKQJa7Dpd8ir6oA1sXprtWTpv+Z3xwaZZhzPyVYNipXgf2TsTvV8oV2yqVElbuQd2/51xka8yuV+F1iN2Y+BAsgtyBQ0H8HxwRwTeK58qMSwoZPoe9TvZLbdPqll9kmTtwDjC8iZ0HrOiepIG90a7SBlmH3qzEswQhrj0Lbx4t/LomdE44jO2z6OzuI8t9uacN0doLMTHJrk/JDwSoB+uQ0Wn0I8ZUWETWpNxvg21neL4fV4355AnmPkXUiduocxQ/1jOEm9VnPl7CCFxEfRlool/2DDfPD3cuXbkLKSLDKQ8wuQX/ZzdnGutJsiemBoG65QaF8Bzg/yw+QL9yDNlo1s1gIhzgIfSeOM0gEO2Vuo3IQUXrK8vrSviF3Kd6mkD3eoj1a9+k8yYsne/8xFVzw4CPBrlLbti0Kmh8mWYY5qx/3tof5O0Yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(5660300002)(55236004)(316002)(44832011)(53546011)(110136005)(41300700001)(66476007)(66946007)(36756003)(66556008)(8676002)(2616005)(6506007)(26005)(186003)(8936002)(6512007)(7416002)(2906002)(38100700002)(31696002)(4326008)(86362001)(478600001)(6666004)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTc5TUhpcDBzcnF3T2ZHU244cE00VTRsTVg2Y1JwejJ6clJveGRUdnZBSDRM?=
 =?utf-8?B?VDFDNExXc201MzdhVEFtWWsxTFJCa0VsbllRU2ZRVys3bzJ0cjhWYUxXRjd5?=
 =?utf-8?B?WW13eFprSDNEUHp5RC84Rm9hZkxBak9uT1FrbzFjdmNYU1pIUmxIaDNrRy9D?=
 =?utf-8?B?Y0psZjlXbjlJNWg2TzQ2bEJMMFB0Znp6d1ZrR09MUUZWdjQvSm8zREM0U3BN?=
 =?utf-8?B?QkZ4azJycmZwNndLSkNjZ0lVM0JlUHA3andEWk81c1lpVmF1dm5pbjBiaUty?=
 =?utf-8?B?cUVEQS80MjNqV2dNWlZHUGZPWjUxakk2WVIyYVp3NHlIcVhlMzY1TnVUUUtm?=
 =?utf-8?B?bjlCVnJpWWlvVXM5QjhlQWZWWTNRVUVwYVhzUklhNXd1WVgwL1dxUC9uR05Q?=
 =?utf-8?B?a0lnWTBDK1JQWTlSbm53eUtXcHFtcDZOTDlsdlBpemowN3JodnJhYjRRSHR1?=
 =?utf-8?B?NFV5STQ1STZ4aVZEMXZ1cXEvT0U0MzZHWEJtSUcvb3BodHFlRHhGRHlVQWFX?=
 =?utf-8?B?N2sxeXZZYmErNnpCSEltbkR1VTRodjRzeW5zTVBGMy9CVitWbDdFbTJXSTFr?=
 =?utf-8?B?VXVNaTZ6K3gvQjBuWFRab0FTY2IrWC9SY3NiOHhua21wMmxBUlFCK1ZsUUJO?=
 =?utf-8?B?S1dMSGdueVlETmhMU3oxNmtMOUQ2Ym1MbXQ0SmJFbk5IUGVDVW1KL04well1?=
 =?utf-8?B?OU5kSWdUWmg0SUdyMDE2VUNZSDFwcEdiZTdTN3JIZzlCcmsrWFBtZ0ljTXd1?=
 =?utf-8?B?U3VhRml5aTdiVmV5UGR2RkZ0U2UxaFRWenlHMGlxYSs3YWNTRThuVGt3VVU1?=
 =?utf-8?B?OEk1SkRQSFZ0am1TenZQUHpteFZnYUlDdklQRURka2loUjhwc3hLdjgxOElB?=
 =?utf-8?B?QW1pQkMvdmYvc01BQlh6eFBDZmZXdjRucllNcDlHMFgvZlZZQ0hNenI4c1pp?=
 =?utf-8?B?NWRKcExnejZJL2daV0U3SitMU3h3eE1uMEp0ZjVISEJpVXlCTzQrMUE3SDJM?=
 =?utf-8?B?bmtEdVFEZVpabHdiamdzOEtjLzJnZmFVY25tZjcyeEtVWUV6SXRUamtYbnU1?=
 =?utf-8?B?Rmo3TDNGVFVLTHNlWG13MHBWZnltZUVtRjlDRkJ3Q0t0Nlo2YjUwUWFHUWZw?=
 =?utf-8?B?S2o5eTVZcXdhYkI4ZkkvSE1UckRvS1F3YWJ6TC9EUjNSY1hBMmx0ekZ4Ujc0?=
 =?utf-8?B?WnRuTi9YSVlja3IyclI0R1cycG9NQURESjN3Kzgwc1g4VG9OMU8ra3dPOTFM?=
 =?utf-8?B?K0EwZkszQWN3OUJpTlZFZVRHejRvb1pLbWxUaXZmNTdFa3NRbUdTYVFlMEFj?=
 =?utf-8?B?WTJTM1B5VU1jZVp4akZQRVpWSHZCRmIwaXVqWXlXM2FXQ0JwUERYSGVRTzhq?=
 =?utf-8?B?cXVvT2JPazB5eHBZNTVXM0VpcHc1SXluTTZIbENucFMyN3dkMjNDVng0M0kr?=
 =?utf-8?B?K1VXME42VVZYVlJUazdBUnlnbndabHU5RzFLeWRsYlhUN0JNRlRKTjZEZnNK?=
 =?utf-8?B?M0dDcTRKTk44Szlid1RaMXc5VmU1UXp4REsrc1oweE5OaWZxeFlSSHJTOUNY?=
 =?utf-8?B?cUhuMFkxeGl4MzZmZ1FKNjREaVNFM3czTVZSbGRTalE2bGFUVVZlZS8rNE9E?=
 =?utf-8?B?cS9FdHZudXdweXFQVHdpNXYyWXBaN0M1U05FMzJYdVE2VnkxcFF5TGVoUWta?=
 =?utf-8?B?YVVkT1pJbk9sYlB0SnBndTE3UUI0TEtDNVQ2eWdLUU1ITnQ4Qm1UTWlMVldm?=
 =?utf-8?B?Z0JJbXRCeG5GOHhHelpUN1o2U0Q5cHRRcFNTWGZiRUU3ejZ1dHZMQXJzUFBs?=
 =?utf-8?B?NjlZQWpuc25iQzBZdDRORVdZTk5xWEZhYUVudGsraDExRTZOVG5OTjNyVUpt?=
 =?utf-8?B?cFpDSmtsc3g2SnIwdmZERlkraFhuZ0FsTkh2WStGYUlkOEtVbWh5YzRpTXB3?=
 =?utf-8?B?d2c0MitqZnhYNTdhTlBTM21KYnMvV01yaksxOTNOcWVBTnpWQUdIK0ZFbWdk?=
 =?utf-8?B?Si82KzN6Mm1HNjA1a0xySWJ3bm1BSGd4Ny9oZmk2R1hoOUpPM3A5Q05FOFQv?=
 =?utf-8?B?Y0hkYU9PcHRXVG9BVDN5YzdSR3gzUDU2ZjNCTFhadGhZSlpxekc0S0NTMVB6?=
 =?utf-8?Q?EyIZxmV6I4M11O0K1ZS4RCcEW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaec667-062d-4d94-ac2d-08dace032eff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:03:49.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noQdM7koPIVWtrMXfApXS6ap8F/UHFNB5jhxq3RLG3GWikDNcaa+u1COkNYyKBjocTV58UsO2Z9llPn2iF6kUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 18:45, H. Peter Anvin wrote:
> On November 23, 2022 7:54:29 AM PST, Borislav Petkov <bp@alien8.de> wrote:
>> On Wed, Nov 23, 2022 at 04:43:20PM +0100, Petr Pavlu wrote:
>>> The only post-link analysis tool in this case should be arch/x86/tools/relocs.
>>> It produces a vmlinux.relocs file which is appended to vmlinux.bin. This is
>>> all internal to the Linux build. I'm not aware of any external tooling, such
>>> as kernel debuggers, that would require this relocation information in
>>> vmlinux.
>>
>> It would be good to know why --emit-relocs was added in the first place
>> - that might give us a hint. Lemme talk to Micha.
>>
>>> The size command used in your example includes only allocatable code, data and
>>> bss sections. It does not show size of any relocation sections.
>>
>> This:
>>
>> 361M vmlinux.before
>> 361M vmlinux.after
>>
>> is simple ls output.
>>
>> Maybe I need something else enabled in my .config which would show this
>> significant difference *and* *explain* it.
>>
>> Thx.
>>
> 
> The real question is: why does anyone care about the size of the vmlinux file specifically?

The vmlinux file is typically collected by various package build recipes, such
as distribution spec files, including the kernel's own binrpm-pkg target.
Users then have available a version of their kernel in the ELF format that
they can use with debuggers, disassemblers and other standard ELF tooling.

My initial motivation was to reduce size of vmlinux when debuginfo is enabled.
The present .rela.debug_* sections have a significant impact on the size but
they are not actually needed by debuggers. Stripping this data then saves
bandwidth and disk space required to work with vmlinux for the target users.

Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4E636796
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiKWRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiKWRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:48:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9DEAEA6A;
        Wed, 23 Nov 2022 09:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOcWMFb9AvD0PM3C33ZKPo9L++WNt2l8R3Nz++ES03TrFbuvFzT+AQKbKYrA6IueX+FwZ5FCT+kDVzmj7fFXD+OgNgalCxOk8Juwk1in54aM343UUCU2yRGzZBXPO4ltawBi9YK0v413VvzCHqNwuOS4hstefogSu1dsp95pVSwPnZ5qGJUY0pfVe+6fC9LBa2Pn8Tf+KBrT4gEoyPFg/umqYhFDhhYueMa+2Ei3C5bustThKOYhRnGmSkOyHEYKK6yveUFxjA7G8LLyxwRaITxZA9vLaF/1k/yOxC53umFhGK7/VI6BMkx9pJwVYOKaiE4YOvouwOWwZjhMgB1XTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9FCpPmo6oPoLCgKakrku89mlDfcAB2iK85j6KzeUW8=;
 b=HGftcEmqqHidCdHvdfkxRNTg4J4K7sj2WbVZLu5/4sGwJIZEIZb2XOdRsFASjP2S7szhSzFmat2+R7wy+yUkuba+/tlYRol8kv3jg8n1MmEaeN/yPj07BvQtu9BJDkFBswR7sY5Fwn7U0czjmQED8zcarPi7rskNH4n4Nvq7AK/AtVDPDRd1h68vHCdq87N07yeQK6HVPkorRpoFuGE/dZ2iVIFgZaP43+ovFwFl9QgdRrWtHVEHBL5dlwFbUBgjrBK1SuyWxLKUVDbSWCnc8QurBL46VCEiVtbjWedCjnGJjPhwoEh/Yb34QRGpVYge+XvQQVLglx0L1KI/jXsJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9FCpPmo6oPoLCgKakrku89mlDfcAB2iK85j6KzeUW8=;
 b=lydqG+BAVGfp1AH49itwA2dzi1SnXPT35PDktkQThxABHmTHDiEy9vsPSoLGcWIzCnOqPRtlb3wwjMVry1kOqZKcHsTONOXjv0QB7HGkEglr/tLbTwFUJF+SqN5taZl95u6cb8Ye9NxKJR07S7gIOklUNCtSUgrLqAu19Bo6EVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:48:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 17:48:43 +0000
Message-ID: <f5baa64b-368a-7ab3-a396-d3d4cea6f2a5@amd.com>
Date:   Wed, 23 Nov 2022 11:48:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 06/13] x86/resctrl: Remove the init attribute for
 rdt_cpu_has()
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759203614.3281208.12929995949176975687.stgit@bmoger-ubuntu>
 <8ad235bb-0cd1-184e-9b83-2f3630136ef7@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8ad235bb-0cd1-184e-9b83-2f3630136ef7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:610:b3::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6d1ad2-bcb8-48c3-0ca6-08dacd7af668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSZbShPUtPgjhhvwHcsqGPCeAa52ADqFJjXi9rDuRxSilKAk6ySqLOpj624B5zDvvH21XWtZFetoqbi9WlBhvVCwo01InLOe3tZnYMpPS/jsY9WIjuarI/9XqQjneB4t2mHxraaDkb/pvBdwxrH1MLL5z21hFuZvX54gDzpVhjchUNEuxl6nIfLWPltkDI3acr8Pl2rqI18NfYwQv07elb80XaKEO/kUiNA9pu4KbAowZdnPV/CTTuE4v/TgZDlyNmnPca9eEBE1ZnXyMI2QTKXBeeSQDo70q+DrC18brXFp1ncxwMm4es5bM0yNvEpMgL/KhKKBLTaHB5pFyOuzcfe6bn/fK73nKxN8rJro4Yu+rFKSWsQKwTXSGs44GX74n+aFn3sDZBtDGYZmtVltL5RLP3psi0VDRWOs2UPq20IX2XXorJM4aXJU6MriwS+BOOHHHS4gktY8/j4aiOYb8uG4W01Ezue1wGdCvotmug92DtvYotpUDoAHAIMoeab6LPDYUtX253PzH24qX8g02a1+eZ9J4nuwKDpfl4UFyriI1IjUoP+I16YH3eQXuxF9tC2fM9V4V7F/Pzk1Lbw+hR6+eu4VSxRRiOcrV1x81ooHYYLrwvXh5/ncR9m3xxanW4UOZYx8JisRNARcqJ4MZX12a+DXoibVX8cHsWYYbThcy/oF5N1sljDJIxOe+ztcAMleSqlOdBeN7/kYJUOuA05le1LVnEB5UqEOZ61KLZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(2906002)(31696002)(86362001)(4326008)(8936002)(3450700001)(4744005)(7416002)(5660300002)(38100700002)(83380400001)(66556008)(186003)(2616005)(316002)(6486002)(66476007)(66946007)(478600001)(8676002)(53546011)(6512007)(6666004)(26005)(6506007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGJqU09rVkI2d1JySUwrMmVnVEhwQWh6SmNXQzFtYXFoOUhNTlhNZ0MxUUJX?=
 =?utf-8?B?dGw1UlNVeTRJZWkvVkc0RkcxTVNyU0doMm5aZEtIK0FIdzFudG9ZcFNja29Z?=
 =?utf-8?B?UUp6TytZZEZCNlpVc2lrY1FaV2QyT3M5MUdaNTZDUFI3YnV1azk2VWVoM3Q0?=
 =?utf-8?B?R0NuVHFJWDZScDZieWV1MkVpajNIZVh2ME1mVjlSa3d5VHM2UGx4TWVmRlQv?=
 =?utf-8?B?a245aHRrREVEOXBpMUdnUkVxQk5URmtLOW1HV05HUTBIaEg2bG93UTdnSUhy?=
 =?utf-8?B?T0lKOFJlU2loK0VNYlJGVytCb1IrUFExQ1N2ZDM3ay9JNGpwZVE1ME03Vzdl?=
 =?utf-8?B?LzZwRjl0RE5zcVdBZFFHRitwcU9jYS9saFExbEpJVXZnSUhuS1hESXF1QWxi?=
 =?utf-8?B?OUlmL1pMUkZEWENxUTNKdkRqYkdXeWs1cUxDSE1POTZVMG42a1JDcEYrTDZm?=
 =?utf-8?B?dUgzdEl3aTA5bXNoTTVKb0RQeGlWbm5tUlFrZ05lNmU1dFZsalY0U093TFVW?=
 =?utf-8?B?TkJhbjlBZkxLeTh1YXpOeldWbU1sR3VGaG1oZ214bmdpME5vVnJtQXJudXVp?=
 =?utf-8?B?RkJadGk4dmdLQjg4MTlxMTJWM01TR2dVcXkrdTQyRXN1QjJualZ6VzJnMklk?=
 =?utf-8?B?cHNQUHBHM05JVm9ITnJ5MXRZLzRBVzBYdS9UbWJEbjRqQk5HTmVRbFJYdEpi?=
 =?utf-8?B?U2dzRGNzVTFXWWp4SW9CWWgrSkVpZEVJVjZISHBJOGNPL3dlMXJYMkV3Q0ZF?=
 =?utf-8?B?bEtKalFJOTMxNDRNdlRVSGpHQk5jRjAxVzRPRHJuazBoMnNCcmx0cE5vQ041?=
 =?utf-8?B?RWFkYjVnbDZmWFBPOG9lQys4Nk5HQ0Y0NzFzRUVETUFmNm9NVUJJOE9ORGov?=
 =?utf-8?B?UjNCRDZpNkhobHdNTnRhT3VTTE11MVZEeEZpQlVXV3A1ZDlzVExCcWhNZTly?=
 =?utf-8?B?VXhHTnNSZTB0WVhTcWNubXpSUlRlalY2RTE2bjA2L0Vhd2g3THJkekoxdmx0?=
 =?utf-8?B?WXhuQ2lyUGloT0lZMXBCT2RSdnZzTXlJSjZZbG9iaXBoWDhiMzVPcGtGUE1J?=
 =?utf-8?B?Y1I2eVk1OXNwZllIOUxMS1NVM0RMS2phRk9DMTZtc08yd1J3ZWs5UnBXVnRH?=
 =?utf-8?B?WEFLbHhPSTFuTmRGYTRhWkRRRVZiWnR5c2EvaHp0UEY4N2FDd1dyaGdyQmt1?=
 =?utf-8?B?K0poNE40dUZkdE9pLysyOGthYVhkcnYxKzQzNVMyUFBMelZsVDE2Nk1MYzAw?=
 =?utf-8?B?dWpyMXBhOE9SRlNuZm9MR1ZnYkxDWWlaU1htSDBKbDlqU1RUT3RXWHhkTENp?=
 =?utf-8?B?NmJkbytoRUYrVDZuQmhYK0xzaVEzUXBoVXAzTHVWQlQzNVBQbEw2WlU4STk0?=
 =?utf-8?B?bU1YdnNKWkVlVUJGSENCZjBxM1g5eTE1YzdzOWFJNkRNR0h4T1B3a2dZQXdV?=
 =?utf-8?B?U0hrNzJYUXI4QloycU5KOEFsVms1YkxwM085Q056U0k4US9IV2lRQXZKOTVF?=
 =?utf-8?B?UjhVZ1R3Mk03cHBoRVhXVDJjNzkzMDlzZ3BWZDZCNHBaMmdUNFpsci9OeS8v?=
 =?utf-8?B?aTVhR3Z1a3lsamVjK0xSVE5taWkrNEI5cExVM0VILzAyWmtQODNlZ1JZQ0ZT?=
 =?utf-8?B?NStTRmNFbGo4bUZIT0pQdWxOZmxwUmNSOFpBRTNyTVVjUkNDWmcvaWw0WTR1?=
 =?utf-8?B?OTlrazNLaWdkSjZrQnNUWHNmUGphTDZ1VExBMGFvVXhWaGFlUU5LRldiaU40?=
 =?utf-8?B?ZG41dENmQ3ZDa3ZDZW1RMUpkamIwRHRnVUdwc1lLQStvWkQxMkE0UDRnL1Fy?=
 =?utf-8?B?cDlxTElmV3l4dm9sc1Z4Mnk5RWZ6ejdNM1FyS0dXSTZXK0RyUkx6UmtHOGlX?=
 =?utf-8?B?UTkxNU1TNVlKMGNrTFFoYWc1cDJoV21qNXpXTkZWTk52RnVzQ3hWR1lWQkcw?=
 =?utf-8?B?YnNiWE5RSnZLVFAweSswUmlWZG51bVdPZGRrNHl3UDhpTzlvOStYRlZqOEtY?=
 =?utf-8?B?NHI3a1AyK2xFMXl2U1k0WTZaSVhIcnE0Zk5tR3AzMWVxeXFvaDVSZk80cXFU?=
 =?utf-8?B?eWdIY3FheW5kcUlxTk9xTkZPQTZVZ0dmTWsrWWRvTWZGQUh3TjhlY3FQMUhh?=
 =?utf-8?Q?fj4I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d1ad2-bcb8-48c3-0ca6-08dacd7af668
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:48:43.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq8ZEDfr88VyUPNqincNA+Iohe07cBh112RB/oYlHOgW6IWOW3UffHzA2ftUEO5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 11/22/22 18:13, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/4/2022 1:00 PM, Babu Moger wrote:
>> The monitor code in resctrl/monitor.c needs to call rdt_cpu_has() to
>> detect the monitor related features. It has the init attribute and
>> cannot be called in non-init routines. Remove the init attribute and
>> make it available for all the resctrl files.
> I think this is the wrong way to go. The rdt_cpu_has() callers are
> init code and they should rather get the __init attribute instead of
> rdt_cpu_has() losing it.

Ok. I will add __init  attribute to rdt_get_mon_l3_config. That should work.

Thanks

Babu


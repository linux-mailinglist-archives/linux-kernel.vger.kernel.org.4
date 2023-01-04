Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE165CE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjADIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjADIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:31:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2F2B6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhmVTYpDTRaBjXq/UucI1FyAs2XNrVS6bLwWz3aShLhOjYoEkr8tP1c0M43vNP/la8Qv9/IkDrEsdiO4mOgXrIozrLcRZYrEgsPQNpftS9TAAnLY77tQSKi3Yl4kg92v/P/6iOhJTfU4cZinL5dKS/6wuUd2uUeWYDiyzv0E5pimdQsAyqzJ/5I505q+NPjnp0ua+2HzxA9Ipu00q+2y/ZCPgZGu7mKRXhdO4mK7Bong8MaBJE+ilYJdsgpJJpYYOySdI5FhrUsEPwF3MyCzHidfhq1pop9+eDa0kRfhdE29w2SMtinTOFUeo1nuBcTur+aLui1G77xP3Sh6ARAY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z41OvX2AvLdrMyeP19C5M5ObnBSWq+4jnWayoWtdC5o=;
 b=We773hljTbjK8ZKrA3JZDlbadZIFZxVjsQR7qKoo234ApGdQiAEVdblUMYajdWXphjSJGmOw6YkENYNWTVa+7lSbjEbD9g2qv5s/NeY7Qiwd9/EzaN9IglfGcxGSpVvBleg0cZNDDPXg16b50Eln29OHuVVRRD2yF/Mvc1BJW+7iod0nRiB4+vgdAFDvyprD3GT4aKKjuVytS2YGLTGY78WO4Lj80Co8KAWfvdYie30n9IhwNGDpkAzd9e0JOZx2eDXni8RlW2BcFv6LLf6mcl6dVkx4DH1AszCA1rStOb7oiigI8jAw+yvg5FLHvw48IEihM+DG8YxyxS0vc9jxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z41OvX2AvLdrMyeP19C5M5ObnBSWq+4jnWayoWtdC5o=;
 b=AvhZjc9J9eFFbOZDESWCbr1HSPJKsDVkPqFpBH1QDJKqb31wYtdkDLMOy4trS/NNDYsEgMyARb0e7nT0eS+wUhPlBIrIOu0EJ/yxQkDR8fPon0EQBpRX+7tVWTBKzAMDTgCwfPbTHiYjEztaGUlJfIPLVQDoCFmgWq9RAbWxs209hUKAe3NIyTyBIZsdOyjKIVXUkO2SOi+34ZdensLg+3QhchJyeCfGkhgg4yrlnmsLRCKHKpdNElLM4YH0dJJT/pZuhPhhRfs7KdnSehZOIMRvVa+fLlz4Szd9u+U+PI9GzpiGFd4KyewZVQK1P/BkR+2BLUAD6OcmJE7EYFfeWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by GV1PR04MB9184.eurprd04.prod.outlook.com (2603:10a6:150:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:31:29 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2991:58a4:e308:4389]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2991:58a4:e308:4389%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:31:28 +0000
Message-ID: <d272122f-8459-075e-f2b5-476b2ddf7405@suse.com>
Date:   Wed, 4 Jan 2023 09:31:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/xen: Remove the unused function p2m_top_mfn_init()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, jgross@suse.com
References: <20221227082115.59000-1-jiapeng.chong@linux.alibaba.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221227082115.59000-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|GV1PR04MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1917cb-0d3f-40d4-4fa3-08daee2e135c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWcvrHrMnjOII81DDVjEyJdJVEs7u/2MNMiU3lvKq2yPJSRgpQdDASpuCF1PZWH8Bqm+6aFdJTnye/IVSi2qvNkwn6+bnDT39RXpSHFaAUr/n9Fy1/qextCvH2DY5vj/uA0zeWBCZtwEpK0tsog2ncyhdkVoPb5RFL4HOUyriJLZyYpYI+TTnf95Tlf8D2LWc+yMYogWRqwZKoempsf0R8VQemXdnYOy/NzXbZeWXrJ9GVzAFH4QeuUDNBPCqBeYF1ItDa2HPovsjFBHjdd98h1lL3PzYr/qvnlS2M3IkVaqknt50bcEPwJvAwDpeG3RVI4pVfAgp9Gce8n7nkcvbL5gSI3ZI7M4BAZeE5zUeqPu6i30WH5Sxn+3h96WEXJiBSopvH0gDYxyq+kTEs6DErVOHMp2Iq/O6qcozBEwrVJo8+ya3iB6QsNg5/PQE4xh0uO/IPEFzNI2m3zHWPrhLeC2iTgzE2ko5BThrzLDmSJ1jIfzbJG1uKoRVkUrNYZcxpxwmkVSrkA4XGlCYi+ewOTs7ZijFoXxeHDb4LPJ04I2dPHXB30CQ4xwhMhIhsgiiUQaA17FmGRDQqILG/EU3siqjrcQ8AoSYjgxur0tPRHNS47W9AlrsuNlWLdJRDc4NfMISaLwzvzNI1GLuz0/DGaG+lsbsTP0aUIqeRT4OfcesS0v+if6+n/4U9yuAg6NkI75RQU8iP5NmslX28+IOhIKVWK3W8BOPOfy8bIqDkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(7416002)(5660300002)(2906002)(8936002)(4744005)(41300700001)(4326008)(478600001)(8676002)(316002)(66476007)(66946007)(6916009)(66556008)(6486002)(31686004)(107886003)(6512007)(26005)(6506007)(6666004)(83380400001)(186003)(38100700002)(53546011)(2616005)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amwxeTIrYkJvNUdRVU10MXYvLzk4WWhidndVc2g5S0h1bnNRclVaRXpTTTRj?=
 =?utf-8?B?MTl5ZHJ0a3BwWkpxREZqc2dzSWpYaDZYM1NzSThDSFYzQ3p0MUNRZnFFdjl3?=
 =?utf-8?B?ckNISkZ3QVVjRFdWODZ0K2pxSUhPVitGYnllZEFJZFc3eis1RHl5dGJxdEtJ?=
 =?utf-8?B?NS9EUlhuNTF1cWg0WWxyaWRjMTluTmpPVEV1eDk3L2NiTG9pQU40S0VmQllk?=
 =?utf-8?B?aFRrb0NQcjFOR1I1OS9qNHMrMmJ1VTcvWmFJcy9YVGhwV0ZKeTdNUzFrSkJT?=
 =?utf-8?B?WkdlaGZBS0twN0p0M3I5QWs1QXp4dElWMjZ1Rm12Qkgxak5EWjdGQzNDZkln?=
 =?utf-8?B?QmYzTmplVUdFWDdPaERyWDVzNm9XUmI3TEJtUDhNSkpMM0NiYnZBU1RKY2dG?=
 =?utf-8?B?Unc3OE5TZ0gyazJzZXJpZVR3UjFHWjNUQUtuL1czbnNPcUhtbkRxd3FoQWc4?=
 =?utf-8?B?N3pyMGQrditOZzAxcU5CbnV6aXU2b01DaUVzQTkwVzJwektNU1ZZUldTS1Yz?=
 =?utf-8?B?UXJwNDZRamkycEhNaXBVQml6Q2xLZ0M0bWtyTStIdUZuc1Q1NUEvS0tZWE8x?=
 =?utf-8?B?TTRQYUQ2RFRwNmhXWlJabkk1Vmw2N2FTWExLSlpPRUJUbjdmczlsV05uSHph?=
 =?utf-8?B?Qk9zVk5NU0N0VTh5RnFqWUdFa2F0M3owMzRtcEJVWTlkU2Ruc2RBNzVOZklU?=
 =?utf-8?B?dVBkYW4veitZN0ZtRU1vaUlrcVdXWUI3ckJWeVF4eEZaWUFxbmtiQkNiRzZw?=
 =?utf-8?B?Mi9jdTVtV2VabFdLRGY5OVZQd0ZrVXN1bW5ZRUpXWTVVRWI4aWVUMENFZ2Ir?=
 =?utf-8?B?bFJ1d21oU01BOWR0NC9lMTNSMXlRYkJKRlRQUzdEZnpseHBBWC9NMVRibjFJ?=
 =?utf-8?B?UWZoSVQ0aC84RzcxNVhzR2JjMnJnN0ZJak9ZVzlPVUxnbnUzRmdMajhZdGRq?=
 =?utf-8?B?SUJuRy83YzdVendYZG91bU96RjdUZEFGM2VOUXpPc0cwNSs5bm56cHVjaC92?=
 =?utf-8?B?clh4b25BcEozeGdDOVBsN3JEUkN2azNRazluak5mNDRkNXcrcHp0UitWLzk3?=
 =?utf-8?B?SU1PQXRPL0dVeE5KYjAwUWpORDBBd1lJYmRtajNqMkxLZkJjSzkxaEJVQWl4?=
 =?utf-8?B?Y1QwaGxHblB3dHB0aXNBbzhLOTJjZzRsbThYY2NFUG5KUmY5RTFQaUI0dlJ4?=
 =?utf-8?B?NHZvT0N0c28xSkxFQTJVbFlXYnhDSXhud3prOFJua3dmdU5Rdkx1TnhRemYy?=
 =?utf-8?B?U0ZkZExaL0ZwbXEvQkZZUXpQdVhGYXNqSldSejZDN3JXMXpsVlJDMXl4NXUy?=
 =?utf-8?B?WFJjRWFlVC9WRHYzYTZBQUw3dTkvNjIxQ2x0SnRwNjd0TElidzlCSlFPbDhB?=
 =?utf-8?B?WFoyQ2x5WEREeHhIcFY3bjJ4cm1Ta0xGc3RBeVgyWWgrdXhGVEh4OTdzUmZT?=
 =?utf-8?B?ZXppYlFQcXZZQ0orNklaYXUyTEE1Y0hKRFpIV0M3WjNGOXp5WDlsdGJNdFUy?=
 =?utf-8?B?cU5BRjByd3Q0VE5NTnFmNUFZc01XMWxianJETDZib0xWdEVPTFUrQkRGSTJH?=
 =?utf-8?B?QXVCNkhPRElNK3RuVnFlRmkwMHczelNCcy9aMTh2L0lld2JkeU1PMEZZdVFV?=
 =?utf-8?B?TjdVMGx3K0cyL2lDSjJoc1EvMXdFanJBMXFMSXd1aXh4ZWMvc09HZFFFMERu?=
 =?utf-8?B?bUNRNUFuWlJDdGpkUHJLNWpRVys2aXEzYmdvNXR5TWpjeld3VlBLdEJKUVJ0?=
 =?utf-8?B?aUZtRFdsOHV0NEt2bXpKaTNoUGZ1d3B0bHBzUHNnajlhOHhickNSSEZhV1du?=
 =?utf-8?B?TlV3M0p0ZWI1a3lUVVEzaFkrWElLU3RWdERxNnoweHZlOFE5MHFZU0hOUUIv?=
 =?utf-8?B?akc5MVNRUXlOdG1Fc1BZVFJ2Q1VKRVhORVl3cVIzRkZoOHpYelN0TWVsOEpE?=
 =?utf-8?B?SnlHSkVQU00xUkd6YTEwTWNGWStIcHEzUTJhaWlQQkwxOVFUQ1BRT1d3VEZa?=
 =?utf-8?B?UnM3WFBSTE85SXczWlBnU3Zsb2FSNjNxb0pvRVV2UUgxMzJFcnRZTGRGU0gx?=
 =?utf-8?B?d3hTbTZGSkNlRlU0blpPQU4ydlU0SklxMkVFNTVNUUp1dEg5dHFEU3ByMCtL?=
 =?utf-8?Q?8cvKfQwAD9WGYm62juxevJCia?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1917cb-0d3f-40d4-4fa3-08daee2e135c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:31:28.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBkh0DLcUpcMeaJVX9kUPlG4J1KxVRuuIppJcLnNmBFHVQ4N3k0bx2RaDHbfHEY5b5zPj38orMojAfstZ+Kn5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9184
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.12.2022 09:21, Jiapeng Chong wrote:
> The function p2m_top_mfn_init is defined in the p2m.c file,
> but not called elsewhere, so remove this unused function.

This and the title are wrong - p2m_top_mfn_init() is used by
xen_build_mfn_list_list().

> arch/x86/xen/p2m.c:137:24: warning: unused function 'p2m_index'.

Whereas this and the actual code change look correct to me.

Jan

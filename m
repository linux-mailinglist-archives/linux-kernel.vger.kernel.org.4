Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5F6FDF52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEJN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjEJN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:56:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9CD062
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoJvr7teQKNR+bGZ+X6ErZ/H8OvCHIIk7S0rBBWqFeB4QNmUWOagQJavg3IcfEynk/JYS18nhJLFhdZoUj41xWHsKeTQ4oZ9kAuT/Wm8xGFAHA7IMRW8WdwSZf7XqbzYCUJ3m2pOrOD2AVh8HmnPootzggLiT9muOemvN1mAj1S4jYgxZU8IpVYE/nbsQXlyOE5/UlEIcDXR3GsUZuHKZLWltRyFoz/wdJlavJfNd6y55AFzDBmvd6sSKWbDEkcyJos7XPZDB6sTpqKLVYNG84LnWpa53UAufvxfUASyysOBFn2HO+UnAqgh/WNrUo+4/vFpndOGi0ccoZXGP+i3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9q3Xnn3rvT9Gdcb9qNxcVUpdOdEcHhyUN2XVhD5di0=;
 b=PFeXJD6E4K+xk3wr/P9Qelbj0f/Jp8d97lHjjJ+Jzn1990oaktJ7KkY2IfqJvYnzRyN9cPSCDX4jE/G2R2aVdCLXX62QbNi4aIz/BzpxDpykOerliqirc1ZHRs09HZHC4G+RfmGokhouDRgwC9E16RPvVkRU+eEdTux1KlBaTJ4G1tZibFFtOrsKHciwC9AhC1oq1YKQmSf5fuEw+ZqKhrPJ1exdOF05BP9Na1X5Wyd1AeXYzyhaVEBwUeAR6M3BCaoUUrkYpC1XHf4KXzBHdHr1N2CY99QTaiI8fTDQkr3C/B8sdoDRiiQsxKd3WMVyLIYgF/u2F9z6MRDwoRgk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9q3Xnn3rvT9Gdcb9qNxcVUpdOdEcHhyUN2XVhD5di0=;
 b=LAimPjB/EzOaNk9Btz0+VA0NkCEIM4WvqAeH7+J7HD3TItUwFyf3XE8t7agIrrpkpC/IBGNZgPZNeH+4MKHT+srUbGY8enXytYPOJQu7zEgxDEQ8xr7vqr62QQjWIJpvtLBEQCF9mR/J1S+Hw1YNpRAIhxR58b4QagvBvuo9vpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 13:56:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 13:56:16 +0000
Message-ID: <af23151e-e781-f220-c9de-36d16fb14f45@amd.com>
Date:   Wed, 10 May 2023 09:56:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
 <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
 <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
 <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
 <20230510113553.GAZFuBmZbhAFkbqm1a@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230510113553.GAZFuBmZbhAFkbqm1a@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:408:e0::8) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aa74c8-4cbf-45ec-52fc-08db515e52cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sbv7vHRLWDbb8maEi6Df0X54zyF2XohDKWTauGj6bU+yvs12OoA6oEb5F4r94TgkfrEtmJPdsBXvQvaX8xJ8dHWlQ4xGHshmS2r36wObb53lM0Nr9xkWprewaNQbuS8VtJnK4q95qtypHosk+QFsQb+tJLO05Q9csRFZoSe+B0dVgAKBcm15Mi0P7q5lUDDeruYik8p7//S/prdvlguKMmCuDhw+c/NAlUlRnrBwxcwYqc0Osz3t+V0ik9U+P7F/4NvvAxPnVE5klkRsgd2AWnWchA8fmN9hhTp2/TeNS6qSHKcs8vBjeBy+A8UxIJ+I1eXwD/Z5p0Nq0UKV8UXzup43vLnzejhN94i6kKrDkbvlyJ0Vu2LfG4LgMSMUdFohUIjiJ7Aww9LnwDq3N9KwrRVUhmE/sAfdT4ma2L3F3wzDu8E5VNhQN2rsLehwJypzbOkclCaGXwu3DwMOjQE47uPI03VAH4hOun56pre8m5c9/W0GOBC/wjk03Fuudrvz+PQwgubKgd9BcQ6nUUXUwplE8ORUg27luJWd8TgMrDFaHuR9gRvGKGFLJvRvLE+jxxiLe9R6Gooiv8FTu4MizimvYUww5cpTy77OS32Zy4Bv2z1zvxYXQymvetZBjQUDEGO+L0J2hn1t0/P+U7efA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(8676002)(36756003)(8936002)(44832011)(5660300002)(2616005)(86362001)(6486002)(66946007)(478600001)(41300700001)(53546011)(4326008)(316002)(66556008)(66476007)(6916009)(6506007)(186003)(26005)(4744005)(2906002)(6512007)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lySUZOeGc0TWV4eHpxbGltWmlXN0N2RStqOXNwQkFNN0VoYXFzMUJmbWI3?=
 =?utf-8?B?MUdhOGFEZHE5NCt1d3pjSU14bkdmajFTQVJBMGtGdnVoVnFVU3cwWTdNczA3?=
 =?utf-8?B?ZHVybm5ObUJ2TXY1c2VJQmNoWlFkYTJKdHovcEVzRkVjbE5jNUIvRXpGOEU0?=
 =?utf-8?B?bFB4QU12V20wNmR3Smw0WUxWaUNhaGpEVUdqR2taUmVVM1FVTXppemtKbSs1?=
 =?utf-8?B?M3JPcnY3d2RldHB4MVNBNGpHRjVCTEpwbnBqRVFMNUlMbmo3dUZHZE0vbXZD?=
 =?utf-8?B?bnJIMWkrcGlZellwR3ZjVzBqWStud2V1Y1hPeEI1Y1AzVFNlSkM2eXhuYW1r?=
 =?utf-8?B?UFNxeTN3OFpaR2llcGtCZEhHNXdoVW5rN0hUc3ZObTN4dk9vRUdDSFA4S2Nv?=
 =?utf-8?B?TlBjcWUzRnhqb0RjY0tKSVBQaHY2bjdvNjRqcDRGaVMrUHl2RU5xckI3NXJJ?=
 =?utf-8?B?U0xrUk5mTjNVeE9CSEd4WVdKUmRTMlFlcUtFNS84aHNXN1VXeit3WXNhS2Ur?=
 =?utf-8?B?SnR1OERGSTBtRE42cTErWDlFMFMwUmVCNTJsaEkvd0htdEIzbjI1Z2dtQWxs?=
 =?utf-8?B?aVJ4aG5pVTkreWFJbkhhT1kxZXV3RjdwV0RCTHdlVmhWMWdMSXFvUW56N3Ri?=
 =?utf-8?B?aGl2Q0QxMzE0Y3FheHdOZHJkcE9hYjFBcU9zcEFscWUxeDBwb3JaanVSREwv?=
 =?utf-8?B?aGJvQ0NrN3hFWVRGOHdObEN1bW9KeVJCeWFWdm5MbUxaQXhReGNPaTNab0FX?=
 =?utf-8?B?clMyT3U3TGFHNTFkVHdoY2dIRjhqN3JEV04zUGRnbXZZWFlKTFJ5UlU3OFBV?=
 =?utf-8?B?WHVEM096OG9JcG1GSDJuVlFicm5tMGE4ZlYvM1h6ZTBieCtvTXN2VE1LR1Y4?=
 =?utf-8?B?eHRkeHBPd3EySXVtNU9QV3IyUHpWejhmTmFzekFhVUN0SDBXVzZZN2NBckZO?=
 =?utf-8?B?VnpnSzEvRGRqZTNhSFJTYmphdlpEQUpyNy9yU0Y0VWkzV2Y0dCtmYkdhRmJH?=
 =?utf-8?B?bDgwVC82bVhvbmREWS8wN0pWWnMySHU2WEpFSTdwY0dqZXlJNllMcjhJYzB6?=
 =?utf-8?B?Mjd4cC9MVXpIV3VuV01TbENXczU0WnlTWkIwNFJFdEpIc2RmVEtpL1F0RHJF?=
 =?utf-8?B?UUpnYThwTUtEdkFsbTcxOVlhNmdPY21zVExNTWdzREM5cWliT3dWNmlncEpn?=
 =?utf-8?B?RktVQnVQbldJQk94Q3YwdDBGVjNTSnVrdEZPZmVWODJmWmlkcXM0K3JvWUp1?=
 =?utf-8?B?TFJUUXdySWFoM2hSdnlla1dTWVhHbktzZ0luK3BUanRWakJvbEQyNi83WDAv?=
 =?utf-8?B?eVRhVDFLR1d6NFpLdFMybitRejNaSzZNNCtYejFGRmsvVWl0enFwbHZVNWtL?=
 =?utf-8?B?cHk5MEk0eUYwbkhiNU16MGFDSWdxaFM3NDhmTkJMYTNMTkE3TDRPNkdGR1dC?=
 =?utf-8?B?TGRUTDJzaEZZM2ExeU11a3YyOVpRelZjVzJLalI3MnlKU2Q1OFF2Ly9CUWJY?=
 =?utf-8?B?S2U0aWYvRU01V0tTL2hFZERrYkxHRWxKWGtMeHNJbXIyU3hURnRIc216UEZz?=
 =?utf-8?B?MGI3dzZ0Y2MzMm9oeER5ME4vbFpVUWU2eXNmYXRJTGhSdGVlMmdyTHZXcTU2?=
 =?utf-8?B?TngzYU1sQ1l1VHp3bGRzVWIyMmV6UE5keXIwL1JEOXhIYnNoQWdFb3kwUHNH?=
 =?utf-8?B?ZEcweTZSd2VvM2l5OEZWTjZtaVN4VUlpenZzQk9BdE5zeFJ2UTBLSi9LNUV6?=
 =?utf-8?B?TGdTUjd6dDhRbFBWd1RSVEkrZGVGOFY1Q0hubVpYa2YxOG1Udnp6ZUdDdUpw?=
 =?utf-8?B?TzRRZVZTa2Z0YWVxbDdPWDNqVHdmd1MvMENTOUZRZjZVa29YVjQxRGt6MHp2?=
 =?utf-8?B?QytuZnJIaXQram91U01RZU5VWXJVMUExTk9xYnBMSE50eTJxMjhTN0Y3cEN0?=
 =?utf-8?B?RU0zM0owTThQMnYyVzcwNVFndmJJSFltaXNuSmNmVm01anl2ZVVHVXV3TGI0?=
 =?utf-8?B?VS9ucUZaQ0FRZGdTclh5dVpZR1NVWGpZRVdZUDM3bnVQZkZ1UStGZU1UUlBK?=
 =?utf-8?B?czZLNGh2OXB6SlQxTm1NL1NqRE5TN2U0ZW1xdml1eHY2UjMyNFFzdVRVMk5O?=
 =?utf-8?Q?bU0Uo8bWvecFoh282FU7wNJub?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aa74c8-4cbf-45ec-52fc-08db515e52cc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:56:16.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF8jfcMwfGkB5+rEMbyysJTmAtPBZyZcy2X8NHwS6evNzOGGOYYAgmlnoobrU7rt+7UVgdNqGme3lcYl+LkB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 7:35 AM, Borislav Petkov wrote:
> On Wed, Apr 05, 2023 at 03:10:09PM -0400, Yazen Ghannam wrote:
>> What do you think?
> 
> Yes, please put that as a comment over __amd_smn_rw() as to why callers
> should check the retval *and* make both the read and the write
> __must_check and get rid of
> 
>         if (err)
>                 pr_warn("Error %s SMN address 0x%x.\n",
>                         (write ? "writing to" : "reading from"), address);
> 
> which won't be seen in all cases. The __must_check will force the
> callers to do the proper checking which is the only sane thing to do
> with such a variety of bit behaviors.
>

Understood, will do.

Thanks,
Yazen

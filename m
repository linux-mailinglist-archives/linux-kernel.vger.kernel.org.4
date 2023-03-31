Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EA6D1505
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCaBa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCaBa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:30:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65BEB76
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNBQCH17j0dzIqIj1/3ZVXHVfC/ciBk5X1zsusESDwvEjLyg0V+DEzPPpDHil1L03IndH/InuEnljfP7+u4HGNiXWSZVPjUx43OoDKSEkcTUwV0bZSYC8HygHImKe/wb0B7tRPVv4yD6WM/DCP9j72j/coN9cCi3ETT2rOFM/ArNaPuYfL7MZgJEcVUrlUM5VKzogEfFny3dlGKuN3RPMOpi8919d11shKqgdon/gP3OrId2KWWAnyNv61knyhdMP/e8QMet7am1aDZYW6sGfa9ej4QvEv0x5gfAQa8mSTIf83t71+dES+AeCK3OTJ+PusuNJBILK8k8kZM4aIZX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5KMu5gYXKcFL8cSlHpUbxdcLr5Db8D2yeDxnKEamNE=;
 b=GmJteXAjbAe1+bJDz4J6+1H8jKYVjeobfJiKTgal3YWykqUrlzLCqLgTCVb+BoWWn51lN/HiALdli32Acj7+mM7FyYGFFJLE+HVEAE57/bhWo6zA/5HQkpk6TvtWdsUv8hzDeMwpVQti2nriqy1PwBaeh6IIaOBfMFS8f7nSDRhZYYAwXpH313nNykK7Hkq9H2wmduP65M0l7D984vFMVSEjPF0TAxtogpiFAT0E1dUMrXEWjsSBnsNnHDPfbTinvuMUMnjbihFtiwnkXU2V5UyCIBdjN1D1QEw2m9hSQH6tvZEZb8I+uEL8itLnQbGqoJx8r4joFKXyrIaA/Dn76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5KMu5gYXKcFL8cSlHpUbxdcLr5Db8D2yeDxnKEamNE=;
 b=rMCRIalqgQE2C5a0XWqphb2+lFy3WTVqD7mhbVXXmmYuNywFIzAOUhRmuCWbDrRaU/uwfzA51q0g7KaSvZ8jnl4bwRUPOsWIry0VhSGYmzFHS0pEPfd0ZJAnpTO+xzRgnFOACFCNqg28UZagCgNblLfjb+yUgNLyR+RedoaJ0d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 PUZPR02MB6307.apcprd02.prod.outlook.com (2603:1096:301:f9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.23; Fri, 31 Mar 2023 01:30:52 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::9a8c:cd43:d810:b523]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::9a8c:cd43:d810:b523%3]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 01:30:51 +0000
Message-ID: <6d7ce8e0-216c-0d53-6d13-e33be6365a2f@oppo.com>
Date:   Fri, 31 Mar 2023 09:30:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] f2fs: expand f2fs_compr_option to allow ioctl setting
 compression level
To:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org
References: <20230330153719.3085164-1-shengyong@oppo.com>
 <20230330161538.13233-1-frank.li@vivo.com>
Content-Language: en-US
From:   Sheng Yong <shengyong@oppo.com>
In-Reply-To: <20230330161538.13233-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|PUZPR02MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 158f05c8-9a40-4a57-4f4c-08db31879016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xV8TbqmQlZ6+fLWWE2LCFZSOot52NRUzpurPrnGYHWIOAicImH4xpxjYF2YmZQYjffHrgMjL7w0bImBm40FsbwsZYJKZyQ+CCCQD8aeOGuT7lhP85DAXfNQS9fhvwZ8ysC2BP1Iv7XGCgkeMhBPda60DABOO7UIkmg/so0zLZNy/z34R7P2KANdyQ/JwnkduU/lxruG0wvS1uuOqR+SjJ7mdSkDChPtSa+FCZ3FsKDq7/agSdtWgQUioxaiGXL6Bk435ErSAt/m5o9wAChI5uuDMBn5whUt/WYLm6SjSXe61t3+47gWFh6RTc4OGXOAtoO2Y2gSsWV7fATJTau2ujkSAdPrU5y8g39J104y+00fcml2+jYd5gUsjBE5tnn6Ueg+s3FF7YEqlEJNZA9XrP7G8xMB/h18xE0ATACvIKP4WcGJRkTZmHe8iv/Zuu+HhOMhmtVE4oCj5cwezXSkWxHeiZW2ozF6ALsVeXzh907xe50rFj5mWwxBbSGE1z+iErN7KBaAR34kgjrqsehgFfq4wmMRSeiaHtrviz287XPI5I5+K1e2kZh0y60yVfMlwL+21w3UADhcgkcqU4ZpyY5xtJf+cvgPh2TCGLIgD+UPl8pXLsUuAoJQRJ8SDETRc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(478600001)(83380400001)(316002)(26005)(6512007)(186003)(53546011)(6506007)(2616005)(38100700002)(86362001)(31696002)(6666004)(36756003)(966005)(41300700001)(6486002)(4744005)(2906002)(66946007)(66476007)(66556008)(4326008)(31686004)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdoOXZuR3BTOEpFK3FuTVQ3eTFRUG9DLzRHZHVtZjhJbk9oYk12M1JNdnZm?=
 =?utf-8?B?ZHpDV3R0NXd4bGxPMHk1SWZqbU9sQUdkVEllZVllTmpLNkIxOGlXUU1DL1FW?=
 =?utf-8?B?NXA0bkZOWE9UT0N4K3B1aUlMQ0NCZElvd1FjcjRxbWU5S1Nabmt1WmUyMlB6?=
 =?utf-8?B?emo4ME8ySTBSSURJZytmaHFMVVZZbnFlbnFjSXI0M25hRDZ6MG40ZXFKM2M2?=
 =?utf-8?B?UElnOGhSdkNramZra1BvQy84cnF3cVJiaEdFOW5kUGN5cC84NksrUG95L3gx?=
 =?utf-8?B?Q0xuNmpUMWhIazJIL3NpMnN6MGdqK2xwY2pobTFzMFdtZkFVTkYycjYxb0dL?=
 =?utf-8?B?WUpRRGxQbjdtbktjVmpGek05QzVMcXk0REpheE84MDlIc1p4M3kvTndrK3JM?=
 =?utf-8?B?cXNab3I3dXV0ZVpRWnpSNzBtbjcrL0VlU2kxaDMvckpLNU13WTZmTXRZbkFr?=
 =?utf-8?B?S2ZiSmYwZ1gvOEhsUDhvaVV1bnV4VmplODFPMVZTSTNXVTQ1UEtaeFNScG1j?=
 =?utf-8?B?bVZSVXQ2cUlYbkRKVXJXdXJqV25xdGNOS3VmbW1ZK0N6MGpGTjFEUVBJbFpF?=
 =?utf-8?B?RlY3dnI4eWZLWEM1YlhxUXFobXZ4Qi9KMzBLa0JIMGdHV0d1bFBzenVwQXlP?=
 =?utf-8?B?Rk84Rm1WZEE4K0ZZTVVoOXJLVytSL0pYeGs2N1IrYWc2S3NwcmxMSmRhaTVs?=
 =?utf-8?B?dzlWWEtFQkQ3WmlscEtOb0tzdXdJcnNhUHFybDF5Z01UNG4vbmFORjc5Yzhv?=
 =?utf-8?B?S3JMaFlZMXVKR1crRlNSTXZmejFFN1cxWmFYMld3QVBSNU16Y1MyWThXdjZU?=
 =?utf-8?B?R2UrTzNRcjhyc2dUcisyd3h6cmxXdVlBVFg1eFRvbDBUcFlYRGJLbnF2bWUv?=
 =?utf-8?B?RmFBTkhjZ2Rnb3Zwc0ZYbjA3R25YSTV3djQvQ25ZdHVIb0xhdTA1NytpeUc2?=
 =?utf-8?B?bGlMWml3MVhOSS94TUlrbldoS0ptVTZmYkh6c3hmY2dEbUFJODNtemhyVzJs?=
 =?utf-8?B?R3lRTC9vNmRESEZ0K0g0YWE1SzkxNUl2Zk92cFhRT3ZadG5ldUsrOUNVWHdn?=
 =?utf-8?B?Mk9DRXZwZ0xZWlMwNFdQOTZBaHJRK0VKUFY2L01BRDBlMlZYeVBWV3pYeFRP?=
 =?utf-8?B?cElkTVV6SHRYeFpOUVQzVExWQXMrZ3Z3YkFpNWwvWmo4MGVMa2hBWDE3bC9V?=
 =?utf-8?B?VEliRWpiUkRLNGZTdml6L2VMVGRqZnJrTTBMY1duSGNnUTF2aDQyb3VwZEp5?=
 =?utf-8?B?NkVwNU5GRU5OZk1wU1JvYWlrUEgwdmRzMmYxcWJHNGV6bXdKTnpxVDlDQTd0?=
 =?utf-8?B?T21YNEFjMmpWblRpSUZLRk1kSW9DbDBJWEJmbVNCaXBhSnk5SEluNFlxT1cw?=
 =?utf-8?B?dmN2eDVKTnplTlQrTmY0Z0lyN0tiVGZmaGhpNDBodEhRakoxSWRSSS9TekhF?=
 =?utf-8?B?eHhCZXJhVEhGRE1kazkyRy9VV1dTWlRMQmo4cXgzSzRGMW9hQ2l1ZW5WVVVu?=
 =?utf-8?B?eG1rN3lUdlVpMUM0T056MmZqNzNIdzk4Z0JqUmt5cjJ6UHljRXVvRHZmc1pU?=
 =?utf-8?B?UlBUUXpjaHRCd3hyRllDcFRxbjRjMjlvemRCRkY0NVFvRkk2MHF0S3pGbmRk?=
 =?utf-8?B?dExYZkpDWlJHUURzZGJqSXZWaS8rSEpmbkswVTcySG9DNzJvRXBOQXdDOW5w?=
 =?utf-8?B?b05McGM4ZXNTWEhMbmRob3d0SzZQVXNOR3drRWR1YUI4WTVYWU9OVDJHekFD?=
 =?utf-8?B?bnUvbWk2MWptREpGWTJYaUdibUlyTXFyK1UzbmtGTG5OcmZiRkxZb3dNVy9h?=
 =?utf-8?B?SW9hd2tCbllBZGtISEI5T2xTVzZZVVZIV09BSGVsdkRqQ1B6aFg1VmxzaGRa?=
 =?utf-8?B?dWUxL0xoeTYzcSt1SFFHYUp6Zzgra1J4NTFtQkRyZ0hLc3k4RS9wbzZ0Z0ls?=
 =?utf-8?B?NkpTcU16KzRtODlLWkxIMUNiNEdyNTB3bFdxU280VXYrSTBYOGM1SE1nUWNk?=
 =?utf-8?B?YzdoVEZoMXRCSEcyQmdFS3h0RU0zQ1h5SWRZVTRnK3dqTXZrN1Vmb0JnZHFy?=
 =?utf-8?B?dTlGWmtsYStGci9scWpVa0VEdDVkeW9vS0RHNUYycmowaE1YT05LOWtxR1pj?=
 =?utf-8?Q?i9M2HnP/5MzAHH4Nmj9/5tJ+1?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158f05c8-9a40-4a57-4f4c-08db31879016
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 01:30:51.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTfNO5qGPbMVPpY3RR9N7zujDa64D8BJ8qWkfubshmE9iSZsrDZJuB9H7SlZeWKziYqJSZwmORmuP5NrcGkA4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6307
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/31 0:15, Yangtao Li wrote:
> Hi Sheng Yong,
> 
> Your idea, I also put forward before.
> 
> And has been sent to version 2, but Chao and Jaegeuk have no comments yet.
> Time to talk about the series?
> 
> https://lore.kernel.org/linux-f2fs-devel/20230112133503.16802-1-frank.li@vivo.com/
> 
Hi, Yangtao

Thanks for giving me the information. The f2fs_comp_option_v2 could also help
to get/set more options for compression. And I suggest to add a version or size
at the beginning of the struct so that it is easy to expand the struct in the
future.

Thanks,
shengyong

> Thx,
> Yangtao

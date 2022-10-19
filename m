Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12383604ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJSReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJSRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:33:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C51D3749;
        Wed, 19 Oct 2022 10:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvGnEAM5BIKlJlVLjM41WcHtKfwM5n0GZa1bxgzv6me73mm+LDDQsvRy0oj45+hGok6/qExfgGeBiceCkAaoFoVGR8yi22EBunYQAkXGhQStZCpTMgcmrm/3NMmYHTErcrZivDb4TgjDqiJOYTIpUPYbH584PLmFn/5Arhho778/pZ1W5T2NrlPxpQlZljBh1YWR9O3Pb/h4X3Pxty8t/+Tf2HePh1lYstijQ2mD49vnduI8Dp9RSG+bRyuQefb+yp3XJ5jVcl0FVr+j3yP83kns4tUhFrS6UeEdHYxD+8GItMaPxKGSsy1Cy/YpBMWj6/PKeapz6eqgDYok+Fw3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV9PJgTOYcDf8dCj1wP/RzffWPEl6iIcwXgHpfeARPY=;
 b=WOeC+uBb4PfzujjXm8PBrO6ZM2yfyrDRxt683RvLoJOyN9nmAxKncAv1xtA47zeVpR0wuj4fEg00N2bqi5dA2wh8eCLi++rUykLg45iXfS3V4RZYT609mGBRSzEgAeGjAQurKJ50wFcxE4V4Y+xEIfHNTWEo9lrMWU2zEdfSGuGJtfQwR0J0Y7buRGErJFIcg7xqIxg4MZP3whKyOyZwP81y9DNEYtAf8hCfAHgDre7ZGUSziVqVNy4AMkDTeEpap5c/VAJGUczYLkQ0pSvGm/9Cq8RdaZ0P56LwpSRSKt3KJPUeppwVOW4ec1qN1/9Tha9CvD/7cOU6k/JmPjSStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV9PJgTOYcDf8dCj1wP/RzffWPEl6iIcwXgHpfeARPY=;
 b=lTRSwuYWkOpZkea2Vv/bEdiOHtOhApCauGSeDjiv7x2gpZdvolx1Gu8qpNvgvzWo3uNlcxwxuspF9xXVeaBxYNQazW98oWoW2u3A8p5dDOUG89ZRVzOUemhB/gyPtU4yp5Im50yFDI6QR8uyoxYUh4CFNPPemV5uXk1S6GsfaLcqfBGhwe9AAW0quMAKH1tHVvuPWFbKnf6dfghlsKqdvW+I1AgUddDUCvp6hO3pCBG9lGz618MG9gP1YRWgtjg9Kbc/Oab3cfGxUZBUZXSmuUUuHK4yGRVrEc9vXXgiBofGip3IltOwt/BbBz7bGbG2AFsNrZsuwiGH8kb7pgCSPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Wed, 19 Oct 2022 17:33:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 17:33:37 +0000
Message-ID: <9c3774a1-1577-2d4c-38d2-3648cc1d137e@nvidia.com>
Date:   Wed, 19 Oct 2022 18:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc: core: support zeroout using TRIM
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prathamesh Shete <pshete@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
 <3c75ca82-f889-a346-a031-2c417c57e2b0@nvidia.com> <Y1ASr6zpqobEbFmG@axis.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Y1ASr6zpqobEbFmG@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::33) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e05700-5427-413f-66a5-08dab1f80e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsraA/A0E5sCIX/v+LaCgDa/jbYaO+a7FtNtCHrph45BcGv9V8gdrlrXM+M0hW3qeoPPzLaKfJgVlU2dtnT++UaPYC2sowDQvuWZnb6xWQ9VncmKVyVvruP8/gFieNZMgMFJJzBfcZ7q2Jsmb5+lXe2jvjJLS9OsYMCDlP5TFEGLrhW7hTx06IbCjm+cJDiOxmWns3DAKfGNxi+XBPrstxeVwW57Lm7EsXy9cV2GaIagT1SAww0msQXXrCME0i5vx0si9TM4op0PUT3lkCJjFQG3JE7X7IXV/WIaeRyknXFeC3z7hkwMMJZzx8PW3pI+403uWFFLb+9Yx4vCdpvHQok47FRWLRTmWuHMSAEGG/8edbszemGdkqJ4vWvOsMjYaWFlfp4rfkABPsnhKE6M/DCqBePfuU3j77TawLRIjo65G8/ZblXjoWrxZZfHEaAk4kPFoNOeiPO5ltXlWUJOXnCMJc4Z1mus9FZutdLhwl9DNIe8MqxJqCc3s8fWZgtgx4Ehm/OsKFZTNvbvas2kzTKOJqdoDSk97Fv4uGYaWdsphlWa1drxEdYBgKuAX8WMFGEpJxnDqnw7Cmk8QxWqZkVh9Hiw+LGU8v+2e8q0yP5m3zNoM/yf0f0urX2X2DVDY0ZzsFpvcQXXhPIuyZuUp6S1e6uGsq3v+PO08YtmT/wm5ZaAU78ZYoT/PYFbsMibJKV1hFo5C9N3lV79ejnyyS39ugY42kWpaIAq5YqAPDVRUNqYTZ9Ky5FWMxPRSwvf3NE+/K0/kCQgdlTxfD7y46sM2FVM9VXhdg2x7MjplD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(31686004)(36756003)(2906002)(38100700002)(186003)(83380400001)(86362001)(2616005)(31696002)(53546011)(6506007)(478600001)(6486002)(6512007)(6666004)(45080400002)(316002)(6916009)(54906003)(8676002)(4326008)(66946007)(66476007)(66556008)(8936002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHI1eE9NUjZ0MmJXZ0N2V3A4VzJOUXExRkcvVUxzRTdQbGFQS05tOUVRTUU4?=
 =?utf-8?B?MkNjTlkvU0RiQ0NzYmg1Ynk1cmw3a25sRG1mRlBjbXNzV2hjNDlpalNPWTZo?=
 =?utf-8?B?Vk51YktWRHI0K3hrS2dVcWdTazJCSHFwaW9nQTh1eHVyTmZpZm9zTDRNelF0?=
 =?utf-8?B?Q1A5dlFnNGhtTFlBekZjY0hadEk1cTRWQkxIM0NEa3dQSHRNOTdDZEJySWo4?=
 =?utf-8?B?VnFwMUU2MzREaE5UNUp0N0duY1J2QXBtLyttZi9WcjRoSFh6dE9lK0hnbDIv?=
 =?utf-8?B?ZjVUbXdJWkQvSnEzWW54ejhRMmVaZXRtSG95NlE2VFFLWU9zd08xMlZmR2VW?=
 =?utf-8?B?VWNKTGZzQVFEd3NFOTNGWXVZcDk1VmU2SlRQSG9HaGxsMjVhVVFLcm9pNDRa?=
 =?utf-8?B?TFJqL0h5TzB0eERVWGxIY21KUmd1OEcxMWp4ekJHTHRITWpmV1AvK1VPZ3Ey?=
 =?utf-8?B?UXFhR0tGemgrUTFKdENqVnBaS0pjQVVkMS9jem9tYm96d3NONUdPbnhvZVl6?=
 =?utf-8?B?ZHJWR3dwU1FaVEY4MGJjeFN5N3dUZmxmRXB0V1hTYUtDWWg0QnhJY1R0SWRM?=
 =?utf-8?B?SlVCNEVNMVhzY3IvS2g3eC95WXBxUWs0RnYxQnlSUVp2TXoxYmo1RmYrZ3RP?=
 =?utf-8?B?dGJmb2hPQmVlT0doN21nZ0RLbnpoSUpMR055MVJuRmhUSzI0RWRkSEM1ZDFW?=
 =?utf-8?B?QmtIRXd0YzE5bndVZXMwZHpUZGhnRDdOKzhydGIxSHhBVHd3UGpXbE9PSnc3?=
 =?utf-8?B?L0ljd05rNzJrOVZSaHE3WmxpWXZmT0VyWkU4cXVlZm9BaDFYKy82UGhaQ0xE?=
 =?utf-8?B?eGMySlVLQUdDMlBLaGUrYzYweTcwWE5sMi9VRDNrMVhZSFh6V1hod1h4VUQ3?=
 =?utf-8?B?RVVxY2VQNnZpS0o0dlUyOEk0czYzQWcyZU1vNWEzK0g1eW1TQi9ZVTRFdEsz?=
 =?utf-8?B?ekhuSWthMzU1MXd5Y2twWmR4YnRwdkp5dlVlMHlxZFRlbVkzV3JrTmlHVDBT?=
 =?utf-8?B?VDBsWTNEWVhGV3lDT2NjOHlRa3JoWFB3aW1OTkVQbDRHMFZRQnRJOENUUm9z?=
 =?utf-8?B?b0lQeEp3U2FsYUZYYWtmU2RteW4wQi9pTjB4NDJZTVJ1allzRGxOMTJQMnBW?=
 =?utf-8?B?cWtyK1NzS3ZPTE1vNUhranYrdFYrTGNOUDVPUFRYZmVESFVwbzBERGVSbEhr?=
 =?utf-8?B?bVJ3UitSci8zR212YTFtVHk5V0QycUQrdXZYa2RUWndjTHlUNHJVSE50Y0d5?=
 =?utf-8?B?bW1rcWNFbUVEckE3TmhndlptMnI1ZnY5akZ4U2R0VHRpRmxYdWJRMDhpUmJI?=
 =?utf-8?B?d0tUSUc3bDdsK3RRSENwSFNiMGRVQy9WVjlzM2tlbStDWStJQTNYY1YraUVq?=
 =?utf-8?B?dVdwK1ZhT2VQY2FQcmF6TFl5TGdpdDVIbjBQTDQzNGdVT0gxVi9MRjNYV3NN?=
 =?utf-8?B?MDRsc0M3RlA4Y0ZLYnQrZHNjZGRkaDBRMWVrbGpiRklCemhYaUhtQjBrb21T?=
 =?utf-8?B?bDZqVnltdXdraGlKMU1pV1ZhaThNbFo1TTFxazRWRjYzVmUydlFXNFRNcUxo?=
 =?utf-8?B?QitoM2RuZkIrYUMzWnFiK0w0dzYzQndydjFaN3ZKdXdETWE1ZFkzaW43RVVW?=
 =?utf-8?B?VVN6bThjVGFYUVA3UE11UzdLeW0zYVRRampZMEppelkrK3ZVNUZNT05jZHZp?=
 =?utf-8?B?R1hnT3JCYStvNGVXanFINHhKSU9EY1lKbnlxTy8rU0NmNHltM0FpeXFYWCtJ?=
 =?utf-8?B?MENxeFZsWk85aUExZ3Q2d3dZaWpPVjFNT1hCb0hkWHFLZjBQb3R0N3AyTmFS?=
 =?utf-8?B?aUVlL3M4WXJsWlY0d3hVMjJqNEpHelp5VDAyYXhxMDE2SDUzWVliejNxL3NG?=
 =?utf-8?B?YnF5S2xhUEV3WWZOZEl2UE9sb2Q1cEsvMHE4Mit1MHZPMWRsUDFLamJ2UFdk?=
 =?utf-8?B?QzVsbGZBa0E1SUlpWGdOSDlJbllBTnkxWUgwVDRkd3pIckhOakZNdXVOSUlS?=
 =?utf-8?B?eTdxTWp4Qzg0cEtDOVYzaHVtay9LMlRjWWVyOFh1TkZ2bjBzV3kzT3lsRDVx?=
 =?utf-8?B?akxLS0llYTNiRTFSV3dhOHpEYlJkNy9xeERJMm9xVFhhaDBHbXI4bE5YRW1K?=
 =?utf-8?B?WE10TE5vYnVGd3Z5dmFEbFNOd1BWRlZyQUFuaUpjRCs2dzZWbk9iZUxSQmtv?=
 =?utf-8?B?RWtJQVpRdEhIcVh5aXQyUnUvNWpKclVqSnZjMTJDN2htM1ZCSDIvK1NuK05T?=
 =?utf-8?B?OEhKMG1wRGNTVzFLdTJIelFtcWpnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e05700-5427-413f-66a5-08dab1f80e4a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 17:33:37.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB+FB/ZnlYdZESawiuzcCvrDgLi4Gy5je8wW810Ba7aekYZtoKYJZy/bFLrs0JjJKU/ZsEL9zKHMQe39FPjsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/2022 16:07, Vincent Whitchurch wrote:
> On Wed, Oct 19, 2022 at 04:54:12PM +0200, Jon Hunter wrote:
>> [    4.168317] mmc0: Command Queue Engine enabled
>> [    4.176723] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>> [    4.189609] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
>> [    4.207660] mmc0: running CQE recovery
>> [    4.215332]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42
>> [    4.249403] mmcblk0boot0: mmc0:0001 HBG4a2 8.00 MiB
>> [    4.255457] mmcblk0boot1: mmc0:0001 HBG4a2 8.00 MiB
>> [    4.262063] mmcblk0rpmb: mmc0:0001 HBG4a2 4.00 MiB, chardev (511:0)
>> ...
>> [    9.034384] ------------[ cut here ]------------
>> [    9.038985] WARNING: CPU: 4 PID: 199 at /mlt/kernel/drivers/mmc/core/block.c:2379 mmc_blk_mq_issue_rq+0x370/0x820
>> [    9.049100] Modules linked in: ip_tables x_tables ipv6
>> [    9.054180] CPU: 4 PID: 199 Comm: kworker/4:1H Not tainted 6.1.0-rc1-00025-gaae703b02f92 #1
>> [    9.062399] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
>> [    9.068821] Workqueue: kblockd blk_mq_run_work_fn
>> [    9.073464] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    9.080318] pc : mmc_blk_mq_issue_rq+0x370/0x820
>> [    9.084872] lr : mmc_blk_mq_issue_rq+0x70/0x820
>> [    9.089382] sp : ffff80000b5b3ad0
>> [    9.092643] x29: ffff80000b5b3ad0 x28: ffff00008467a288 x27: 0000000000000014
>> [    9.099733] x26: ffff000082d49000 x25: ffff00008467a240 x24: ffff0000802acad8
>> [    9.106758] x23: ffff0000802aca10 x22: ffff0000802aca00 x21: 0000000000000000
>> [    9.113810] x20: ffff000080fa0800 x19: ffff800009824000 x18: 0000000000000080
>> [    9.120858] x17: 0000000000000000 x16: f8ffffffffffffff x15: 000000000000029a
>> [    9.127918] x14: 0000000000000000 x13: 0000000000002000 x12: 0000000000000000
>> [    9.134980] x11: 0000000106d66000 x10: 0000000000000001 x9 : 0000000000000002
>> [    9.142066] x8 : 0000000000000009 x7 : ffff000084650118 x6 : 00000000000000ff
>> [    9.149171] x5 : ffff000084650000 x4 : 0000000000403082 x3 : ffffffffffffca4a
>> [    9.156240] x2 : 0000000000000000 x1 : 00000000ffffffe7 x0 : 0000000000000009
>> [    9.163276] Call trace:
>> [    9.165737]  mmc_blk_mq_issue_rq+0x370/0x820
>> [    9.169993]  mmc_mq_queue_rq+0x134/0x270
>> [    9.173900]  blk_mq_dispatch_rq_list+0x14c/0x8d8
>> [    9.178500]  blk_mq_do_dispatch_sched+0x330/0x348
>> [    9.183169]  __blk_mq_sched_dispatch_requests+0xd4/0x170
>> [    9.188440]  blk_mq_sched_dispatch_requests+0x34/0x70
>> [    9.193456]  __blk_mq_run_hw_queue+0x58/0xb0
>> [    9.197666]  blk_mq_run_work_fn+0x20/0x28
>> [    9.201673]  process_one_work+0x1e0/0x348
>> [    9.205672]  worker_thread+0x48/0x410
>> [    9.209326]  kthread+0xf4/0x110
>> [    9.212462]  ret_from_fork+0x10/0x20
>> [    9.216025] ---[ end trace 0000000000000000 ]---
>> [    9.220899] I/O error, dev mmcblk0, sector 12624 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
>> [   11.500035] I/O error, dev mmcblk0, sector 16720 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
>> [   13.804317] I/O error, dev mmcblk0, sector 20816 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
>> [   16.104063] I/O error, dev mmcblk0, sector 24912 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
>>
>>
>> Reverting this makes the issue go away. Please let me know if you have any thoughts on this.
> 
> Could you please test if the below change fixes it?  Thank you.
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..3661ba0bbc87 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -48,6 +48,7 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
>   	case REQ_OP_DRV_OUT:
>   	case REQ_OP_DISCARD:
>   	case REQ_OP_SECURE_ERASE:
> +	case REQ_OP_WRITE_ZEROES:
>   		return MMC_ISSUE_SYNC;
>   	case REQ_OP_FLUSH:
>   		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;


Thanks, that does appear to fix the problem.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

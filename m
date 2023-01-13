Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421B668A83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjAMEDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAMEDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:03:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1425D5;
        Thu, 12 Jan 2023 20:03:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNGEOWIjBOQQgdZFg4YBgczfv9QxAkgeu9BUUNG+P8Im1a+W4yY+qnaKE+c0fKa+ZJ0NnYVr1fQUmkUR87JBU3Pz2h76703jrNp4LtSxSSVIOMtNODCZjK8VLA381C1PLKHtEZ1QzmgphctSS+MCwplfzWKyg2GzoIz8gejSc7UcGjDx/QYFt8RXYZxLfaOZr6ZLZ9YBWyAbnPAGatEvKhmTU+BPE953veV0/JjDnwvVnijLBbuTtj5vvJ/5JIqz81HEpIiCZMqHF6SeocPu2jkvntty9WyUnD6IdGNlO7sexKWvPDvZE5GNnWquoZOJfamN8mvjkRrEsUOAiCPQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv9RzE1by0W2UWkZIQiyCIPro5Fis5oJqlnPIMG9RGk=;
 b=gBUPWHMOsYP7kPjIGZWTwSIYs31hdAKIgE1xrZDIFhbtYbikYLLTAB6J44XaspWCz2oEJtHO1w//5lxCDUSZjAJOr3Z4mQaiXGccw9HHUqUFl/JpOdrhHFouuZBRqg0XETyaO2XPrbSBT3ZdWXsePCGPwwPLxmuG4fyR71W4BB75uf29FCOWkDr+wkIc9TEcccIKOA6U+ddcyffMKdwO/dUBjDtM3bS6TlV/QTgScZaRGzg6dnBmJsFWiU2TNM/vI2n7nmBIdWrwpSaqIxRpHh25gEv2YVQTMzpvHh9fdZNTHviq7QvFpKpODC+bAkGD6kdAzJaiX/Xjn5u3dMucNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv9RzE1by0W2UWkZIQiyCIPro5Fis5oJqlnPIMG9RGk=;
 b=PsDbEfk17PeHkBWQhi5qap6aLFCTWl6mIZKNXdk6RdsOL3V9vU0jAjntgFUK0TdASRrZBL99FBhC30iBZWPYOw0zloppz6IYawo7IoE4Hm+9aQe320yvqGxoFQ4KGlZZgg9mMYaV/m0UxSdNlv+SDsllcZe4eWAwl96rbHGLx4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 04:03:46 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 04:03:46 +0000
Message-ID: <b4109593-1aa9-bf7a-cb1b-3ccd586f31d6@amd.com>
Date:   Fri, 13 Jan 2023 09:33:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] uprobes: list all active uprobes in the system
To:     luolongjun@huawei.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luanjianhai@huawei.com, zhuling8@huawei.com,
        lizongwu@huawei.com, luolongjuna@gmail.com,
        Ravi Bangoria <ravi.bangoria@amd.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, oleg@redhat.com
References: <20230111104825.1945418-1-luolongjun@huawei.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230111104825.1945418-1-luolongjun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a0f59a-fbe4-4409-1d24-08daf51b2ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J9NKQTSwCbDrRPxFLlCFdthaSHUYLa3w0iHqC8Ywnh830YqJIQEXr0zYMJuu/2lOBXA4xwygCSSbB6BtL0ATd+sYCsnb6tprAz6chdwyVoMI9LvS9oHYYNfKMrq6nL3bGtEHcqOMV41nSX5YCjLZt0q8tqDIctjaKCBRIpjBbxXfYCcm3IvEQH6kBazhywjx945RyxCCX6oRiDbifqHoxmd+SF57+a9OvwxuyTWtU8AxdEXnBQ0+wck1xcRPpRU0oQ/PiT6y69Oa8/jrGa9a5WFjqimsNQav3nVDvggO1o1LHoInnjMhU7Sb4xgPGQ/TzILJVmm8XUXb39QGhTTHFapQOs297sHAj5PJRtQb7PSNgcytsGj/VVy/VJHbfdNMho2P19lgOcFi5N7Ge7bJWkGedmey0hgcUsb6iOfdRmlOmD8oZ+JJc2rLoDw/OBUBMSIu2Nb1i0EcEuAMWwwn+6ORek6DWRoXe2nT0mdR+Ewe7EJ5ZalYcQLztkoQKCgcC0sGjl1s1m4ObimgcKz4tXxuOwGrrhEXP536LljhNuLB/cKIvCOnJVERWnifnR0rHr+m+JNGgvMIqzaKbS6gXq7lWQQ7vX5xlsGvEkp8BnmNPX+JG4jAnPQ6P6MrrG2qlNZ8Hb2gLWW4P8mWupQ2zFLfBp8N/j7Bkc61Veb+ccFZR9GMlN4tUFKUyYCJng5gqtijnnPXB7jzvtmuwI8siTksb1meT/3hJ1DORD9UlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(44832011)(2906002)(83380400001)(478600001)(7416002)(66476007)(5660300002)(66556008)(66946007)(186003)(8936002)(53546011)(6666004)(36756003)(26005)(4744005)(2616005)(6506007)(6512007)(6486002)(31686004)(41300700001)(38100700002)(8676002)(86362001)(316002)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFrV3NnT2NPdEtmYWl6OUFZTXl4VFRHdkl3bkQ1WHVnczNhcUV1YWlDbnBL?=
 =?utf-8?B?dDdGK05vRUN5Zm5ZVklabEcwMThsdk01VXU3Z0JJRzlkc3g1eGdrZVZ6TTd2?=
 =?utf-8?B?TStRdGhGd2JyU1BUV0hxa3lZQVIxajMzSzgzZFprS056NExmVnRvZWpVODBY?=
 =?utf-8?B?Q2NNeUtJeE5nQkdNaS9ZaGJtVkdDbEpPOWdHS1V0UVhDRHVaOGNTT0wxbFRX?=
 =?utf-8?B?aTVCZ3Fsd0VvM0x3OVU4TStyM2JIWXg2U25TY0ZhUlEzSXBXTTFMV3NsOUNy?=
 =?utf-8?B?M1JURGNQYmdHTkNMSzYrS1NJenRaNmFUYlFQeUxTOW5tZE9sYmtaU292K3VK?=
 =?utf-8?B?L0hiQk9LYzhpSm5tYUZONDdEUXc2N2l6ZGJFeWZ2dHhadHA5VlNOVmVkcTVl?=
 =?utf-8?B?NFdrUGNnNTQ2NGdCMnpvSzNqb2d6QjNoY1FsNiswWllFc2R2K1VsYWtNZUdF?=
 =?utf-8?B?a0dlVGovMzlPWFoyY0ZFNU4wbFBsMS9TYWhCQXlLVTlWVStLWERlRnJocGdD?=
 =?utf-8?B?anFzMmNtem1tS1QxQ1I2cXdsd1E2NWRmc2duRGt1c1hEZHh0ZFR4SDRjeURN?=
 =?utf-8?B?OFJkZVhQWE0xQTQyWDQyOVNYNUMwdTRPWGZpbGZ3TklqMklxcmF4YjdFOUFV?=
 =?utf-8?B?S0VwcFgxcmZtT0tSb2FIS2pGS1FUNVp0MWdhdVh1Y1EzQTlqOHRiRlNVdGRL?=
 =?utf-8?B?clhIT3VucktjSndJVmhRM050N1FKdkJ6VXdISUxVSUZYWGpXZmlpTEYxZmhp?=
 =?utf-8?B?dXllNThTNnZXZTdkRkx1cFdIWHZoOFIyZUJVd1pNdStiSCsvUkNaUEI2cGFH?=
 =?utf-8?B?TzR6aFhmYXArcXJMbmQ5dURoMGx0UmczMG11aHA2QW9ZSWx0MEw5OWlaVjFJ?=
 =?utf-8?B?Y1ArS3lJUk9ENk0wNldQVDRIbTc4RTZHQll5R3c3b0RSSGN4d2dqZ244bHNM?=
 =?utf-8?B?aEJ1dWZ3Z1VPUVNhQWhsbFJ5TndtZDRFTG4rcFdyOXl2KytNYlZjVjNBeCty?=
 =?utf-8?B?bnN0T2M2UWJNcmJKZ0QvUUxJUEpuWDR1cnd1STlMN2JaenJyYnBkUFoyY2Jp?=
 =?utf-8?B?cXhkOFZQRDRTSTlJVnQ4UXI4TzlEWnlJbWdxNW5UZkcwL0g1dnZOQkNZU05W?=
 =?utf-8?B?bndNRisxai90dlltZEtpcTR4Tkh6RGFGWVFDVWVsS0xJbnMwSmlacGY3Z2Ey?=
 =?utf-8?B?NEk1T05HWFZnSHp1MGM1d1VDc09ER1U1V0VZOHJYdXJESkF0eGFXMUc2NlhF?=
 =?utf-8?B?c3RDai93cW5HZWd5UUdBNUUvb1YwVWR2Y095V2tWQVpjR3VHaWx4enJaNXFT?=
 =?utf-8?B?eEdOa0lsc09SVW5QUHF4M0EyWkRod1VncVF5ajlVVzhoaHQ5ZUtjblZYUW8x?=
 =?utf-8?B?QVhGTWpqTDdndEczZWVyaFlUbVZBNU0zMU5jMjgzT3F6a2Z1Ky9mUGdZSjgx?=
 =?utf-8?B?U1FtMzN1QW9ubHFOTDRNZk05bEg0dDMrZ2tIS1FTc3F4bUZUWElqdFRXR1VO?=
 =?utf-8?B?SkQwcStrTnFwVy9MdW9VenEzQkF6YjAzKzJRWjJWbVB2NVJ1Y3ZWZEZadW9W?=
 =?utf-8?B?U3BnSW5iTFgrWGtMVDhEOTMxV1lreXNSeFZEaUFkREZTRHh1SmVZQ3lFWnVk?=
 =?utf-8?B?bHozWjZ1bFg3ZUJlK00vdi9WSHNvQ0FpeTQyOFVmQldlSEY0S0JQZjIxdU5o?=
 =?utf-8?B?SWNNNm03M0NqUmRVNW9TOFAwemJjK09PMmVBZlkwNVFrbHpYSllJTjJGYnZx?=
 =?utf-8?B?VDBhUzI2ZUhnYU5ObVRHWWo4YWdwVUQxbkFpQ0ZaZzk0ZnNwbStzK3FMSTgv?=
 =?utf-8?B?NmZkaXdnSE5pa2xPR3NiQmxLelVtSUZ0dWhJTUhUcmg3dWszZlFXTU82cTBC?=
 =?utf-8?B?TThndVlEL3ZsSWZzRkFIbG5tVGVZSzdzazh0RlpncHBnK01hZE5zK1k0Tzh3?=
 =?utf-8?B?ekQrTjIxVUMwM0JxUUtPa2FuaU04MVZwMStRb2MzUHpjNkQ4RjhGNVJaNGN0?=
 =?utf-8?B?YjY3MGVCUFJ6czZPaCswaEhpdmFFTTljaXBCU0VZVTExWXBudHpSNEUxR1Z4?=
 =?utf-8?B?ZDBFeXZhWWpQSGRJN1NSTTdNaEd5TnhESFB1a3k2Z2RhN01DL25mVUFDUDdu?=
 =?utf-8?Q?tz//tAOnu+uNr5khYvrKXsHMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a0f59a-fbe4-4409-1d24-08daf51b2ae3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 04:03:46.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YB4+pCTeBC/xeORPGiYGjJssVZkfRNxLZBeFKS5zao+BxwdM/qE534077yGHylwZGvfevJMIjcxCCL55ayOpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc: Steven, Oleg, Masami

On 11-Jan-23 4:18 PM, luolongjun@huawei.com wrote:
> From: Longjun Luo <luolongjun@huawei.com>
> 
> Since uprobes will replace instructions in the process
> memory, it is necessary to provide one way to list
> all active uprobes. One can access this file through
> /sys/kernel/debug/uprobes/list.
> 
> Output looks like this
> =====================
> inode+offset/ref_ctr_offset    4160760670+0x30a10/0x0
>     ref                        1
>     register_rwsem             (unlocked)
>     consumer_rwsem             (unlocked)
>     consumers-1
>         handler                0xffffffffc03ee02e(handler) uprobe
>         ret_handler            0x0000000000000000( )
>         filter                 0xffffffffc03ee010(filter) uprobe
>     consumers-2
>         handler                0xffffffffc03e902e(handler_1) uprobe_1
>         ret_handler            0x0000000000000000( )
>         filter                 0xffffffffc03e9010(filter_1) uprobe_1

You can list uprobes via /sys/kernel/tracing/uprobe_events. Any specific reason
to introduce another way?

Thanks,
Ravi

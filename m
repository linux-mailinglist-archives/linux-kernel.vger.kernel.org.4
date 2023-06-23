Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6F73AF96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFWEvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFWEvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:51:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F0E75;
        Thu, 22 Jun 2023 21:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgmQp/vgFoU9AdYPYa3yKg8OZajZKOJ09WcCq4tST1re65q4F00ded+5JZ1Y9e7IYi9N+SgJgpCjsdb5Bb2XUOXquGJlhGaXoLeF0aqXNb8rmEStAa7EdOlEQr/f/R8jdCJ75yMKmuyKRB8vUQX98ipCk+vEukhtNSa5NOQiua7sAfRM85KBbfOL7zlJoHwsocRp6xvHMJvhdMHvJsRx13oxKFtCPb1KnPY0yjHYP1X2FtxF7q2aqPa+ZiYMMpvVg6ZmwLQH/J01alCdFeHVZKSD//teqbk9aUXUHaOe0jpXnCrXp4g/xyOQ3UQaI07cQ7MWjbSMOEsicaAx4AirSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyZumGw+vpZxfWiRCTnxnH19TaVLzCMzMpuvjI0VN4k=;
 b=H+J1tzif1BoYKhWH3ey1LyI1IYCkyPFhRnigR6HsvGcAGYQ5IwkZQkn5xr2mgefayTJLjYy+NsgBGo2GPl2t9KVtgqDmgdVA86TjgWkBLwXPmKooiX4Wj4fCprgb1/B01NKDUOpKUG55oSRBhy+yJoe7AhiDKY8F+oZaw8uRdXrVJzidn/wUBmE8KeGZqDJ+zayhqgrTDaQA8Bd8NYLx326HINU+H3zZcTPWpCw5Meh2hU25CS4YATbTOvvqBtjKo6K3d3xSE0mJf9a2RqQfGgatWdLzI0UBQiWsRaH/ftuITdlnngX6wa3V9wye67RjxR6ebKPLKy6CXafyZffKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyZumGw+vpZxfWiRCTnxnH19TaVLzCMzMpuvjI0VN4k=;
 b=Xn43hLOU0E6gcm6eLkhLKiZY8ryfCNaeHG5j7nYp1arOFkXrLEin23lK+UtybyKKIRsgeT/NRDRLI9Sx0jemHBpaKyMvC6RR3jVEeDs73rVpEaAFuVPMHagQS53NqK1dxuNcrK8TncfE8bYbumKlJDVrUT2FEN+itBhUMMBbvEtHy+954HEgHRF5UyC64gjrwcH+bnJSe8L1hO0fXLpPtjLP7IxW7vd1Ot3SoN7IkAEP1qI3roUWiEOfvy367eFCtdqt20Ok8wiN227uM2Z6d2Tl+/T1bG6A7zu/Ho02A8P9ulvIBp1OYDrkWXAoIQZ3v08DCJVQ7hdvZ3WBsCXGYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 04:51:43 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 04:51:43 +0000
Message-ID: <a10a5816-bfba-9bc5-e90c-39d91ad9f2cb@nvidia.com>
Date:   Fri, 23 Jun 2023 10:21:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/8] arm64: tegra: Update AHUB clock parent and rate on
 Tegra234
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-8-git-send-email-spujar@nvidia.com>
 <410e46f1-11ab-4775-9328-48aa45906b48@sirena.org.uk>
Content-Language: en-US
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <410e46f1-11ab-4775-9328-48aa45906b48@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bec6235-29f6-43dd-6643-08db73a58a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mq0hhZjHT8rNIi4gLgq+HeX0SSzc1zJTKqDCV4IVNyVbCUUDcLbZYhsDz0I0JL3Ejt/Ym60Hy9OJiMzTgkYlnOQ2eJrQHWCjuBd+cMeFZwgAeX/jSc3cZtY+4kOUJqWKy4jjIqVJTDF7yhTvUbJya9ZHS010u8eG4ol6VuY56yh9SdrB6Qkr8k6UrdTuG3IrZjyudAyGtLZ2VQXvjaEWVGWzXt69QRPripqk1XQlyhmbBNs3Sxxj4EnPjuaFaqFGY9MccVPfBgEQ1xFdKtyyDhPXbqfcC7eXRFqBnZlyXUfcKTMlFGs+iktBONXTSk54sJY1OoxmK6/pu9ffNPxiFHHaEQroDJx6l6B+t1/hiGQFml1FIL3W3bDVDwT/F889oB3FMPrKoMpZxVKYr9NeMK5+qOidjvs8rFqH7VnFxZvyeW1MpGgWRusS3/qOWUdj3M3QDjkc44MkuV+i/pa/6nQX/lk1D5JHJbdc+C1ltjptCQwypLBK4y71x9iAzZ3Jx5ghOaxC8mbW+4Xa6IUYrXoc59VL7Mlw72e4aIR0f5xep60kMHl6Uoll5XOU3wkdFoTXK2O3Hl5e+2uGyxP6rhCvIChCG0ugfG+ThUIhzPADIGEISmdvms2nr0B5Tdyn9hpVemwILVGW1+Mka6Lemg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(38100700002)(83380400001)(53546011)(6506007)(6512007)(26005)(186003)(2616005)(7416002)(4744005)(2906002)(5660300002)(8676002)(41300700001)(8936002)(36756003)(6666004)(6486002)(4326008)(478600001)(6916009)(66476007)(66556008)(66946007)(316002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9EazBkZlYwTlNBazgxTVRtZy9COTRoNlIvQmF3TDQ2bHZWUngrWEM4TEF4?=
 =?utf-8?B?dUx4a2VORXJ3UmsvemJEM25HbkN0Y2ZpcWxWQ3lLa2hsWXdBQ3pDalcwRWRx?=
 =?utf-8?B?Sm5zSWxQbVN1Z2psWmg2T0JRTmNVNVlpNDFPNlA3cjJWZmQ1SlB0NmZTMVJz?=
 =?utf-8?B?dnN0WWJISWZTU29xYVJtNHdOamU5bW9oSGYyZ3B3cW15WmFCOGtsaWpKZ0xJ?=
 =?utf-8?B?T1RzbXdBNFRxdzVIcnU2aG5DV2c3cEcwYkZqRDBEK3FIZU5NdVJ1QVlvWXlt?=
 =?utf-8?B?UFEwU0xWMXV2NWNJZ0VtLzhVOHhDYkpPTERVa1ZOUXZGTHViM0xHbmpIK2RX?=
 =?utf-8?B?VjVMUElnMUtUNXJReWwyUzhneE96WnZmNFFhVytmemlFeUdCT3NDRE0zOHFT?=
 =?utf-8?B?MzdnWWcxYVJXckxTNHVRc0dRL1EwVXpCNnZocjhkbFFkcVFWcVB6YkdrenBa?=
 =?utf-8?B?TXMwMUl4M2RKZDc1d1lFNTJNUlAxMUdqc3RUcWt5SklkUmlEdGtFbkJUM0Nm?=
 =?utf-8?B?bzJ4WFFmS2UzVmI4SEVKZjg1Ymc4WUd0SnQ0dUErakRwU2I1aWZDRnU3ays5?=
 =?utf-8?B?Y055bis4UUFiN3NZQjdWb2pPNlZ6akIxUTZRSVBGTVFHWURjd1VDZ2NtOExR?=
 =?utf-8?B?bkN3Q3dvQ1lxbTFTOGVyU2FTa2kwRzNkYWdtemNGdEpSV1Mrenh5TUtCS0h3?=
 =?utf-8?B?K0VrNEZrYXhJZWtOYnpLTjZDcG4vdGRuWUMvblNFWUNNVHJMVnorVlNQSy9Q?=
 =?utf-8?B?eFRKNXJOTTVoOUlVMW9XUTBrcUxia2FaZEg0SG5Rd05TdnRFV3hsQTVoNzZr?=
 =?utf-8?B?azhBeGJGVEpXOWM5UmQ1cW5MZjhnNC9CWEdBOEt2MWtBbkNqTk5GSGVpOUFE?=
 =?utf-8?B?YWJXMDhIbzFwRms3Wk5DYnpVYzRDb2FtU0NaM2V2M1dZSDBXT3ZPU3ZuQ0Q0?=
 =?utf-8?B?MlBQQUdOWWVIVmN1NzNQS0ZPbHFZaWJpdFZkOFdOWEVWd0plVGFOV3ZNaXdj?=
 =?utf-8?B?dURSejJpbm1OSlVMcFoxZVpvN24vMWk1Nm9aN2hFNlRnWE9NVWpXdUhkaGhF?=
 =?utf-8?B?VDkwckRIR3M5MkxOUWdkdmJ0cG9ZT2dlL0o0SkZ0WFphVGNrZ1p0UnY3MkRG?=
 =?utf-8?B?ajNOcVEycThUZkFlbWRFLzhyaDlvVlY2eVowb0Q5L1RKdnI2K2orRHN3eklr?=
 =?utf-8?B?QWRTYUdJcVZvWTdlOGxxbUdvOFlxVzNqVDBza3ZNSVFnOThvRnRMNVVnUElL?=
 =?utf-8?B?ZEtvRXhXR2NEbDBXeGdWQXNhNml5Ym5qZSs0NC9la09DcTRlUEpobkp0bDlY?=
 =?utf-8?B?SGREeEhqb1ZYbzBMYmlRSDBPK2p2YTZKU3JJdVplaE51SGVaZVRTcVZidHJU?=
 =?utf-8?B?UUg1em5mY3ZrOE9pM2lrUjJ1M1pjZkdWSml6bnQvaFMrZFVpT3VaanhKN0w4?=
 =?utf-8?B?eU1QajZTOHh4V3VFSDc5YkMzaWVaVEllUHlCVmRZQUdNbDlFS1RkSTlUWDZE?=
 =?utf-8?B?QmNVYXlsMGZ3a0JmUHBleHA3eVhZSFVRNk5GVGdEOTlkVHNYTEdPRTRPNVMw?=
 =?utf-8?B?N3NsYllvamJrUlFIcFU5aVFTZWk1VGxCVkxiYThUN1JFRVRyaGtJRkFWRzJ3?=
 =?utf-8?B?MVVIUVNWYzhvWFdFZUc1dXR0VnZyOVFiVVU5VmhnMDhpREZaVE9ZRWhibE1E?=
 =?utf-8?B?MG1oeFpJeVN1VFF2MkJhN3FRbDZaZnM0L2J6dzBXeXZPbkJSYWRScUxzNGlT?=
 =?utf-8?B?ZHJKa0hiSjVMZThkOWdaYkZSenBXWmdDQ3pMRDRyWThkblgxb1p4bmxCci9Q?=
 =?utf-8?B?Q1Q5VjdvWml3QWE3S1VKdlYvVE0yakdlWlZiREpZWnIyNTY0aEJxKzNlK2Vh?=
 =?utf-8?B?OCtLelh4MnRnTTFJR3hJWURWMW55b3haV0ZOcjVleWRyQ2FDWmFRMWV6MVlS?=
 =?utf-8?B?VERqSG1XbXgwVWNvRm5yZURsODc3ZWJKME04YkJ6eHloNnVOTTJjLytGUXJ3?=
 =?utf-8?B?NzVHTUVMYmNIYXh1aWRkRnFhVmY5TVdZTER5ZTFFdUZTa1FuR25kOFpGWVlY?=
 =?utf-8?B?M0dqaHdzanFzUHNmQTE3aU10bUFoZWNYdlVtajR6UzJPZUh4djhEWHNpQ1JB?=
 =?utf-8?Q?e4MN905wod5RypxkV8zU9I/V3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec6235-29f6-43dd-6643-08db73a58a42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 04:51:43.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFY3rnnNwMjKkWK/D0WVMBPSyHFEi0XqyWRs/B7W6vtNOQkWZt7YJBQ0ikwoRKxTvxwdWDZqnPlkdXLBWqRnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-06-2023 17:43, Mark Brown wrote:
> On Thu, Jun 22, 2023 at 05:04:15PM +0530, Sameer Pujar wrote:
>> From: Sheetal <sheetal@nvidia.com>
>>
>> I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
>> This happens because the AHUB clock rate is too low and it shows
>> 9.83MHz on boot.
>>
>> The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
>> clocks. It is recommended that AHUB clock operates higher than this.
>> Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
>> PLLA_OUT0 and fix the rate to 81.6MHz.
>>
>> Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sheetal <sheetal@nvidia.com>
> Fixes should come before cleanups in a patch series to ensure that they
> can be applied and sent as fixes without dependencies on non-fixes.

I sorted the series based on the subsystem. Will make sure to put 
'fixes' patch always first. Thanks.


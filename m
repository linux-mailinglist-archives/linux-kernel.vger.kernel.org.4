Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809CF6631A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjAIUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjAIUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:37:27 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA6640B;
        Mon,  9 Jan 2023 12:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5siZY5a8DbJ7RBnSyCT4j7glq6uw6XJmiZqcMgERftrkF7dBfIRp7C7F0YVRL1sYOzKiQVZr8yP55SHyDNqu/xZsj+w9lkZaDE+pJHwZqHBrFrZ/VC71829PxC1omS8rwKxNVdOMav2t2ICY6YG5TiUngmltkawq/C+h3NRMSHu92X5R4c4yP6q3neaz8Ff5ELuf1Hnb8Ehv7NJGjOcB0rwdEIwJ0pUNK5olm1fJpp22Dt2IloByngtPd2kOBUXLUGctZKCa66+xfO/qTRMKM0jXhzzTd7XJiRNMqthYXjHwVJW7FxnCd7jtwtCgDKdgTBfKHdF1p5OiFd9m12T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaBlBEPHZ+oJPQQoJJGvYxZ3okoSVg1rZfV0uhfKjPk=;
 b=QcptTOQXSxcyCBSvp+eVZKf0BfhpHNL1utZ+gVqhwf+wesHTVET533MQQ3uZk8xeJtxWRp5PNJ4CTQTz29NNRaBTgVsrxRroVrHWXZtUgEZB0FuC48ox8zUa5rN0ibfsEWRJCmMjseEH/IwAiayKsOIUFIQj28xsZ9d1q/logW28IMXfXe09nQ09FAlwWWaN7IDOHfDTlosibf1ut10WHIqZrb0UnyeNtyg6rOP1jVE26Dgf/b/O9CCsBuBwdOo/pVeO2TitNHY6ASjyLPpzVVh4jMdEXP6IZFnLAlN1a5lstxL4U42Qq9LbH3ZrS5vybfuHwmJhOmSfknIEAlNtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaBlBEPHZ+oJPQQoJJGvYxZ3okoSVg1rZfV0uhfKjPk=;
 b=IaDUX6H4C6NZuJs34YgF/gOK1hk/mIse+8ixI1vNfp8FHhH1Qh4fLRh9Hyq9FSsz04/ln4SXEeJDlnI+xcRlgzCrKvBPnx3Q8mTgxcsvth+8GLMoo7w6oknA2lnBaO3cTXnWBVkBA7jW8XmH/E8NsDk26J5SxRzuYyU0A2xXaGXgMGBQgQiLOFkQ/3WJomCH9scTtZXkdnQDanuRu3SwUbAnsNt2ZAxuO5uqdgg8sIIPKjTOLuuHpIrFMVsnRsny87/P6BBlvh6pGcRmSftMBtaDYEc1pjkdmzQIOuPHx0pXDkN9HNfseT5WRUGYFwxsR5M4/9Ps6UnEFbPYEgNqrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 20:37:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:37:24 +0000
Message-ID: <14dbbfdf-c096-439e-41c9-71e083138560@nvidia.com>
Date:   Mon, 9 Jan 2023 20:30:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO
 driver
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, smangipudi@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <Yhe0pCpfeCpyfPWg@orome>
 <20220816102725.14708-1-pshete@nvidia.com>
 <CACRpkdbMnRNTLcCtqNjKpxWxMbAXLssnuBEuNqAfgDfj3XVfXQ@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CACRpkdbMnRNTLcCtqNjKpxWxMbAXLssnuBEuNqAfgDfj3XVfXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0423.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::27) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cf58ce-222a-427d-d11a-08daf28150a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHnx78mny9CoKMTrZrMRaVo6NWf7iuAoFlM/fia//FrqaDB2LtjJeV2UXm+uhcelVcUsgdy9HM2kt9nMwrIB2qahYGo08bekM/hyx8VP3IOYcOWAwAH1XLp5End/Uv5MqbafBZBwJUXugRumInkaH8Fzca4CRJ4w448ZIedbkOPrR//5x+bMeeke0RpYlu7TTj8mGPICXgarTGEZ11UWUt3/y5AZMCAqakwckN2/Tm+s2Q1c4MYP2VX/XKQdj2AputU62HfDqZBdrvhggycFRn269Zm3jV+kzMDgxG0qNBvCP5qj1+kH7mmFzBryf4mpwubR79LiHJo0Pct6ViAVZh5l1jW3csXdJ8KSoPU+XdxVcXWbT0CsLPKqsyiwtQ0BuT8UAPLnMHSGwTfae7tYQARVxtgFW2VYd6ufqQuDFVrNfauT0vbwfTKUyorO2cdRCjy3InRA6gr8FfalZLC1mAC2EKPzBNAAOTh+h53N8Q79DEOQU2OTSoiQ1audxfMmJmpu5amfLa2JsfHJFX3Nt8MV1kG24UuRBTFqIRirjPCqslgObxLtQy7gAYTCGkJjp+f1uQuhnpyyEYbVeCsJmpojAqZpKtG3hdpmX2OgfBhJq9b5N1QQpXZJDTcWH+MUW9eKR4jvK+gjYmBgv88/KPTBRz6NX3wdhLt2iDKFwJdLDLWB3Bkl4uOvr8yaQ/6L5/YPvfnC8A1EHw5IdcCJn1rvyvL0xK3q4bNIZCph9Bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(4744005)(316002)(5660300002)(186003)(26005)(6512007)(6486002)(478600001)(2616005)(31696002)(41300700001)(66946007)(6636002)(110136005)(4326008)(66556008)(66476007)(8676002)(8936002)(36756003)(86362001)(53546011)(55236004)(107886003)(6666004)(31686004)(6506007)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdVRm0vMUpKcTJtYVVtVktkMTkzUlZDZ0RDME1sbVh3dGRveGpXbkRUWXpM?=
 =?utf-8?B?WTdlTnl0aVl4U0tqbU5iVkY1UHg0UnI3anY1bjdxQVdDbHBRSjZCUDR3bTFV?=
 =?utf-8?B?TkwvUkhCdEMwSWNYS2hSK0Q2OFJmK3JyODJTZTlXV3lLcW13aENGSXdVNTdt?=
 =?utf-8?B?ZVNRVUVKcUlYdytUaER4d3Q2b0dIUEdwN1A5T1BmaVNJUHkwS0hMYmVEYVZk?=
 =?utf-8?B?dTBjYXJHMVdLWlZJU0w3TzdSUWpENEpKQnpzY29zQTJ0d0NzMDFobzZxcjFh?=
 =?utf-8?B?Kzl6VnhpdzNmN24rNWV2MVhjd2Z2VDZtc1NFUkhjSlJhOVZLd20wSFpnWUhr?=
 =?utf-8?B?eE1RR0lYN3RLRndUcElIYzVsWW1VdWhuVGhyQjUxM3RaTjBvNDBxWUo5YWpW?=
 =?utf-8?B?dWJjU29yN0VVbXBVNUtMSXVzVi8yS0ZoRm1EeHBlTzJpS0tETzVpbG9RSzda?=
 =?utf-8?B?bGtzOU9TNG5wZ25Eb3pxYXg2b2hhbFUydlZMalErL0tIamQvNjBYZjRTLzZG?=
 =?utf-8?B?ZHZKUEc2aStvVW8wVlo4RzBZb2V6a3lLbjR2NEsrV0toNU9MdXVWT3JPSmJO?=
 =?utf-8?B?L1VWbHNVV0xicUZpdGpHQ1JtVG96aEE1S2ZCdUZFcnV0MXRRcUlEamFGKzU2?=
 =?utf-8?B?M055cDdLN1JIaURSRFIzdUlSdU5CU1dJWTZRNHdnWmVhQTdyMGdORVpIcHNS?=
 =?utf-8?B?cHA2M2luV0FiaXZ3Z2VEdG1IdTlEaG9JZE55U3FiV2ZQMnd4a3dHNVlKT3ox?=
 =?utf-8?B?SDRjckczMCtob0JpcnR1SFdtRHBWSXRqdXYvalljaGZKMmVyRFR6UjlNS200?=
 =?utf-8?B?Rmdvb1B2U1ZxTUFjdHdLQTZWNUdQWnZ3M2xxckdQa3IwOS9jUk1NV090QjN4?=
 =?utf-8?B?SVFIOE9ycGV5L2JKV0tPN3h4emJXdWdZSkJIMW9tMjhQN0p0eU9kY3dwU3VC?=
 =?utf-8?B?a3hxTmtKRFUvRlFhTVB4aXFRampBNk5NNDhtTUVEYS9QYW5Cb3k2OUcvbXc1?=
 =?utf-8?B?WjJJd0VGdUpUaDJxY2Q1VTdEQ1grdE4yRzF4bXBhTFR6VS9NOTJoMmlCRHIz?=
 =?utf-8?B?RkxNbUtaa1htb0hWYzRDMmEwTm9KRHFLSlVjeFBZS0lZRk1tRDJiRjZxWDFB?=
 =?utf-8?B?aFZMUXBkbEo2cWZ2L0NuZXQwczhSWDdUcEJ0dWVuelNIRCsxVlE5N280VWhC?=
 =?utf-8?B?RlBpYU9WU1NQZlQxa1dBSGxWSUYydWRFeW1tWG1LYTM5bXFiaFdnNTcyaTBi?=
 =?utf-8?B?b3ZjTGNUYUFxNWVST0xvMU1teFVzbzJJVmZFWW5NWE9kQko2VlNnT3J6TzQ5?=
 =?utf-8?B?VWxBL1YwYkhsajd5YTdlNmpyblZxNzhOSHJpUlkwMlJDVm9VZWJ1M1NXekpr?=
 =?utf-8?B?enFMVUN2aHFtUUgvck1UTDkxKy9rRElRa3JjK2hkSFpYaTE5SHg1YmpCTlFN?=
 =?utf-8?B?WEJZSFlKUEVoMHQxY1ZTc0htK215MzR1aGJCdk9iTk16eklQbkQydDlwdUQz?=
 =?utf-8?B?UWNxR3JrRHhDUy9aaWJMMU5sMCt1QmR1dEhHdmpIanpyL0lLUWJEWmZmUUZV?=
 =?utf-8?B?NUJ1OUVCNHdGdTMvVXV4bnBBWTZhNHF3V1M4UWtFaEdnT2tOUHIrTDM0cW4x?=
 =?utf-8?B?TUh1T0UxcnIyK3RVRmp5WEI3T000M2xjMm4xcmJvbkJFQ0pvd2czOG4yeXFP?=
 =?utf-8?B?YUE2WFlnSmgyRUhwYUFhZnhmMTd6YW10NmFmQXdnMGxpV1FNVzZEOEZnZzNi?=
 =?utf-8?B?MnVTNXdiQ1dpWUR3eGwrM1RFeVh4RzFQQ05SMVdSTkk4VThMU0FETWZpcFN6?=
 =?utf-8?B?ZkEwRTBxMUdDUE9hdVpYVGJJNXNROEdQMG5ZZ01aellDejFhMGJKYnhEMnpO?=
 =?utf-8?B?dUpCTFV4ZGFCeXRxbVp3dHlrRm1mUCtxQ0dCbnUyM0RvL0F2QzdLNkdsdFlL?=
 =?utf-8?B?QzlMVWpGbGt3cWcwalBkUE03VGZyWGd6cDFyeEtIL3FFblAvU1BiUEJ4UzZQ?=
 =?utf-8?B?bERFYjVnd1RMdWg0MkliWUhxQTlaTitjc1ErU3RadjJqcFpsMW5IWmE4WHcw?=
 =?utf-8?B?T05jdFpGL0crdUFDZVhpUnRaQjBPOUZEbEVtWE5BNm5vUXNLNjRtU2s0VVBp?=
 =?utf-8?B?RlZYM0tJMlY4M0FSbktRTTZmcDNjc0Q2aUdEZytQeVNTRjRoZ05uYzVCYkQr?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cf58ce-222a-427d-d11a-08daf28150a2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:37:24.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZziueDyd/ku537H+WxLgS7THdQoX3uefw4qPkkxKZT/aafLh+LuPSueO81UfZsqc86lkPXsE/EdP5y7bOS0k2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 08/09/2022 14:21, Linus Walleij wrote:
> On Tue, Aug 16, 2022 at 12:27 PM Prathamesh Shete <pshete@nvidia.com> wrote:
> 
>> Using this patch we are adding PMC compatible string for
>> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
>>
>> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
>> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It also has Thierry's ACK from v1.
> 
> Yours,
> Linus Walleij


I don't see this one in -next. Are you able to pick this up?

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

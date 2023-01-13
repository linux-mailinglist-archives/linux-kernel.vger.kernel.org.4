Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4B66A1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjAMSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjAMSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:16:20 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20D17079;
        Fri, 13 Jan 2023 10:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT//WbzyqWc0MtmdEgk4vlaQXyaCYzCV/BCUYm3w3EBwfspMzsVF8pfImB07xAIkwpBonqzYGUB1u+u/cgea3tCsDco+LFmE/EI8ClwDFJnISsHiPVc3It0COyDXTOZNE8SYXWZCmYzjvD404HBFhqfFp74JuR5kC7NuyapvRnPJAelX3I6Uu90ZM1rmMJszj6ZZAunkKHtbEY9crXhBowIIXovEoqCIJ8G4Yah/65tKgLc/mde8gtDlaBsngzedeCSZ0HHGvMKQ+vcCHubkZwrx3s0UKhHvddO6tm9d2VGH+W9HsDmT559ozmZxVfCddV4oYrldURMksFpJ6++a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3eAfLIQNUZ2hk0gFXBpa43ESKBha6aDN6p0Bv84eyg=;
 b=IgtlQQpfF4mumF5wQ1FGSDmhM3JWUM6cxhWWb8IrxgB+9phDeNVhQzqjJlh1QLZwqgRJfJw26lk9RdV5HivIRW9l3Q9BjVl1nuS/Fg+w/JDcFSs8iXSEERx/gKu9LXZyB6UmbhHvF8lVIn39yGJQB8jMEeNR3BS4iIQAvirY3kyYB8TMDhMhU7aRFVcIvs3mLa5Qm2MtLTatlbdVazNbqdcLwUanDnrdlzh5pk/16KeGWgonGlMNpcVIM5aPT1Cv3vF/GnHmEmwAIapOhCtPPU1lioGtEAMOg834yi97guEDFbwv3HsHE0C+telsrCFCXIRLm8M1C9EtUkhnHJXdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3eAfLIQNUZ2hk0gFXBpa43ESKBha6aDN6p0Bv84eyg=;
 b=sswlSWg1IR5R3ts/+s4PuIO5ZSRZD0mFK+obWTz/wevNiTjyPpfa0ejqUppA0vHLjpHGv3m6lD/D+agm09V2Q+9erqj4hXbqTkAZQGE/aCHf1TxKLAtRyNWbY/j7eQUPd2C7/udJIK6w+U2Br0YPzX1HLQzpirSb7ykPqGY/FxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 18:08:24 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 18:08:24 +0000
Message-ID: <b79f7e0a-8048-d0e1-ad0b-d15d72288fde@amd.com>
Date:   Fri, 13 Jan 2023 10:08:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: c851bbea-82f1-471a-b8f8-08daf591298a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1tCrf0J4DLDBu56PcT8eCQrPOwYMpHPolm5DIDLhU0Ck8TK+ueb+MqgztKeYI3ljKuBZashqS/hmq9eWFjhLxzgZ9goTzDLjjhT94zfm0aDXEzALq2+n7xXnJ+j7Q/N+e4++zSYtcH//mZsADg8meam7hX4b0CbABUPiT18GTfAhg4ZvKvxqG9JEwjBtOmQOq3WfpwGiUNn82EliRUiyTjgIw+QRKnKCkaNZcNL7D/AbTTt3djqv+bQtGPnAQdcIrV1qFFfh9Wf+mJ1VF4a6r+5zbY2XLIXLC6dQ1voAiTPneRt4lB9c+iHknjmZuX1xy4VNNhZefXm6k7vVXht6CNJJaeQiwd428Eh3sQvt5rYwfBKgGmKlcAgu+53zMQZ3DUZdx7Pa1OjFeTZ4dj6GibFf48doD2LweNyqQVouEosMvzK9ebmM9mVQD8Uw4B9NzN0/eYqxSv7tuTcVzF/xmqMwBjdPE5s6h3jbZUwUs4BEbrL5Ge02iApDhJCtksNiY96IHRh5w+CaR9kEZcJAKpJlQBR1Y4qcRHVbuHh2YMGRkYSWUKV//wUG5ru0Q7HzacUpRpzky+vWhkl7Zhn0RWgf58K9ZcsfyIYpCIinmye3LgPGmXPSUici8p4GrCGTGsxjkR9M3q1zeaB7qRn3slFoPpW52uhPJnBQ2VuWTCus6+321YDTwCb1zWmxtnycvvbbJ44JVZbvwUVKjIzIpEBZ1AP/5Fs2kJRin24TjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(8936002)(2906002)(5660300002)(4744005)(41300700001)(66556008)(4326008)(316002)(8676002)(66476007)(66946007)(110136005)(6512007)(2616005)(38100700002)(31686004)(186003)(31696002)(36756003)(83380400001)(53546011)(6506007)(478600001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlUSGJZYVBRUVFhLzVTYk1hRHFITUJ2bGMzK0VBRWV4ckM1STEvSXRuWnU3?=
 =?utf-8?B?MVpScXp1c29ZUlZ2cFJhTlo3UzIvRWdnbmVGeUFqYlBkeGZqMS9Gd2pmS2E0?=
 =?utf-8?B?QTNGNEIzNEhlVmc1N0hTNkxKbzNIMzJYSjc1NVZGQzRIVDZ6QW1sWVl6ZXh0?=
 =?utf-8?B?aGtqVU1rdG43bjcza1dlaGo3dzZ6TGNsM05qVm9tdFAraXo5S2dFalU2MVlu?=
 =?utf-8?B?Q0k1dFRuTS95TTJZVHU5ZWl2ZHh0TTE5dmJWM1pUbGI4Z1h6ekhtWmN4U3lD?=
 =?utf-8?B?UlpBdTc3VmtyWDh2U1ZYWGpzeDR2TkQ1V0JVbC8zUGNWK0xSNWc5Q01NMmdX?=
 =?utf-8?B?SWs0NlptZGE4Z05CSFdKckUxbWZLdXk4NFBkMEVNMTBIUWZHc0FXVWpnVnBa?=
 =?utf-8?B?L1h5T2srcG5SYjZmbmhaVmFXU094cGlaUGE3c3diQWhwazJFYVNLSGczMnlG?=
 =?utf-8?B?S2doWGg0bnJtN3FhQld5MUkvMS9CRSs3NVB1ZFRWaVJ2bm1vdi9ybEhUTndy?=
 =?utf-8?B?K1A3ZGQrSkV0cG9LREljcytSa3NzdFR6b1Q0YjY2enNBRk9pZitBUVdrdVZ5?=
 =?utf-8?B?V2xiNFVqUEpzNHEzMEJXRzBOYzRVVExyZG81czVFaVQzanM5ZzB2UXRBeWEx?=
 =?utf-8?B?Yzkwd2xLcnVwUExkNFdEdHZ5LzV6UFFoVkwrcGJYOTRKN1o5UTY4eGs0eUNI?=
 =?utf-8?B?UVBFb2ZSV1NGdkd6bXU2MHlGU1duazdVSmR2Y0Y2YTI2OFBpOVJGTnc0dDc0?=
 =?utf-8?B?UTJtWW9CU3dmY2NVMVBBQ2VBUmF5eHUzbVppbkQ0WnEreXlrVXBYaFoyNm1Z?=
 =?utf-8?B?VmVSeFhWSFJPdG45bTlJYVFnbmx6bjlENmJvUGJHSmpDQ3pIWXJTcVZFckdY?=
 =?utf-8?B?ZUhpMDdqM0dONXVYdnlFME14N29ERWxUU0FnUzFLQ1k1UG1qTFFEVEtFNjl0?=
 =?utf-8?B?L2VJeGNVK28zMkh4QWtmS29ocDRLMFp2Wi8vdzhkOTRQR1lTcGYzOEdiajVW?=
 =?utf-8?B?WDg3alJEOWVGVDBjck9JZVE2U3h5cmhEam93VXozTWRtLy9hZi9jY3lWOVI4?=
 =?utf-8?B?Uk9ZT2NabW5FUDVjbXdrdGlyMUVLQkJkVUVZR3pKSmgzU3FNWjN6VGZCMVNm?=
 =?utf-8?B?QlA5Tkd3Y1VjSzZISEw1bWszZUd2MkFNS2l0REdlK291MzZTd1pFTEpTMGd2?=
 =?utf-8?B?OXZZMWsxMWJZdWFESEw4WTd0UEEzdnNYWUQyMmZwaG5ock9pMEtkSFJNRzAr?=
 =?utf-8?B?Z1FxQVV0NkJlV0hBOFlueE0rcXhWTUhHcnBUclpPUUozUlVQRmo5bVNCQitV?=
 =?utf-8?B?VTBLcXFmdjc1bUtPNEN0bTJ2NjlUNURxL1VQSFVadEhqWTlTTlBTdFduYWRt?=
 =?utf-8?B?dHlpeE8xYy9MeHMzbnJweHlMcTdVZkJJK21hbmFncVFMR1VFMnNySmlVQmhP?=
 =?utf-8?B?Ukpzb3ExdWY0bmx4Yi8xY25GK2wwNmlVYVdUVVhueGxOaWpyOUNIekJHQ0xR?=
 =?utf-8?B?RjJ0Ti81d2c4T0cvTmw3eWFjaE5aL2VNaWNJMTRlQjFsanBSNGl5NnluTGFM?=
 =?utf-8?B?b1R4dWY3ZG1SeFE2NzZnaW42Vi81UFdWNkdYNDBENDFCMHZBMm15SzZ5cWU4?=
 =?utf-8?B?ZWI1QjBhWE5obzNmRHN4UnlGOFlYOVZGM0l1ZjM2WjVBdi9MK2VNcmpBU3ht?=
 =?utf-8?B?VWE3OWZGcHJnMEZnNm94YUM1dUdndVZnbXFWejRQcW1CYUh6SXZMMGpRMmxM?=
 =?utf-8?B?bjYyY0I5QTU0a1NZc0QzOHpDdkl1UlZqMU13aVo0Mmo1K055ZklHRkJKYWFv?=
 =?utf-8?B?ZnZIYmx4RnVwQldXK25vV1JQc3ZJQzZMTDgvb2JGcjQ5VVBLUExLa2o4L1N6?=
 =?utf-8?B?cHViNjdaaG9OTlo1YUtNU25yZUlvVlZ2Z1Mxb05LbGthaXk2U3JtRGJYYmNL?=
 =?utf-8?B?dXB5MzJ1a25vdkVzYURGczhYZzNwQUg5MGRtUnVzTnJpdkx1QjU5dHF5M2pH?=
 =?utf-8?B?TmZWejNZSHMzbmhrNWhOOWF2TE0vUkM1cU9BQXVOeGtmUXU1SzE2ck9tNmJa?=
 =?utf-8?B?dG9TeXZxTlpCN01zTE9lREdIUHJ6VWpzT3c3YWxuVCtMam8xTHFkS0JuTmtk?=
 =?utf-8?B?SWZKempBTUUyUFRCajBYSHQ0SnpTeFg4TEFpYnZhbWloSk4xUWdJMHBBNkh0?=
 =?utf-8?Q?a0Kd8Mg9OZVuoPbSp+Cl5p0myXJb38tdfU4HxkN7Uh61?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c851bbea-82f1-471a-b8f8-08daf591298a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 18:08:24.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHWy4fEVmAZ+7QnSOQwfAb202Gk10u1ySZcUjxnIbQ9yQVbbL699ducc56V8Tc62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
> On 13/01/2023 08:30, Tanmay Shah wrote:
>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>> driver. This bindings will help in defining TCM in device-tree and
>> make it's access platform agnostic and data-driven from the driver.
>>
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.

Ack.


>
> Where is driver or DTS? Are you now adding a dead binding without users?


TCM is used by drivers/remoteproc/xlnx_r5_remoteproc.c driver. Howerver, 
we have hardcode addresses in TCM as bindings are not available yet.


>
> Best regards,
> Krzysztof
>

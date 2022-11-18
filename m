Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D0862FCBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbiKRS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242612AbiKRS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387F942F5;
        Fri, 18 Nov 2022 10:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTmXwlmvNsDNgyERGDrKOvZhChvjp7/dElClV1H3zv8J4qDfk9lkTYOuhKxHLU0A1/4AbfnG1epjAGjur5UXvJ3XOpPbexPPIDOvXIx+z7pw1GjNeAwZK8EzS/LoNIHRfCpS2Z1S+DnYj/s164h0o3BmBxt6973aYLZILv/idivr/bIlbTmgAEJwJScKBUQZTRmOS+ihCIBbl0MN/XokmG/yWJhS9bfp339WNhYW8ufA01PJ3gBEk38LbnKbefX/kNOH/kj5iveNnTqpwnDySjl+afEtg3FhdmtYkqYKd66dOorW+vE5wNh5hHrsHIJTWfkZ1JHVg+Pn0xFqeFBj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2U4VI3wlMLc7OEtZunO4AdODmrsS4R16Nua5YB2Rns=;
 b=YwcAQ4lzF1fS2n0Q9Dff/LQF3Wy3PzZ2LGVa1L7GXd0dVzOu0AOG8mScrMckxcvlvC+kts63kxkRuAzvP+c+WsCCAzmjIceZzxJyWC73bbV+XzukN6rzO4Wl9oKmHvf34wGqreq6F176t7N6eKgDJ6YWX7+/e+tjmxhZgsqcYmz6LVGLREXrCz9DxqM6L2uZHkH64QKyAIXmtJdO86HuvtuZHVyPdHi551j4BgERKv9PIVv59dVvM+ii09dW9YYy0N06RN7joWLBEovE2urntn8V+V+FjrOqYKNVOp0QJFkqzWZLJO8l2VqzsOfG/1tEiclz6NhQG+Uy0i0h+qfzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2U4VI3wlMLc7OEtZunO4AdODmrsS4R16Nua5YB2Rns=;
 b=EwD4jRT1ES8ewU0wxTlyLhxIB1YHHKdDxZFbMzXn8sox1llf5IGoABVX97svKQiQhO6n24PBpDqWmXV7Ri8Ds4KfIqwlaSBHWV/WDDkXbCDJV6TbQA4G7uz2tl5AYUV+BZ6gnnFMmGg1iONBlfj2ZKmYLhQksbg4hv4MvRBvTxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 18:27:40 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 18:27:39 +0000
Message-ID: <1ee66e1e-4ea0-1a6e-92fd-60831dd938b4@amd.com>
Date:   Fri, 18 Nov 2022 12:27:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] docs: Update maintainer of kernel-docs.rst
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, Dhaval.Giani@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <20221118170942.2588412-2-carlos.bilbao@amd.com>
 <CANiq72nN7i4yXjnLftdKZ7zo8Qw8c=aM6L+D2SvzH47PVALJYQ@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72nN7i4yXjnLftdKZ7zo8Qw8c=aM6L+D2SvzH47PVALJYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:610:e6::13) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 852beafd-54ed-488d-147a-08dac9929316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndkR36M+/BngapnhlrFY32QTyaNfENC/BXWQNHDpb3tV8Hn6J/fuku1j+ZE8Nme/7FY4Iud68a+jRRbPqFuRDWz9yNgbTDrjP6Zg1IskglNbzS4cwiEwZoC/Db9MurIX7cBldB6LaTti09T3/SPwWKfmQwPwpCuWYZgWyb3exyxKUSRMub6fcASq7L+5T9gsbnEadnJyT32rdAXNQO8QKePdTvOVHY4lnxeBBFTqY2dlLtjmrR32becXgGFhjVh1IqdV5FvGBpfL8QKUdufD+3m8Whl3JlAZcgQSP+bDF4Uh07g9u02BK/EoMjcqLxgzV5D/lFHYx6E+Hrf7lDSVSoCD88pxwKHhPKoLjuGsRZyym5c2VudEPIS8lgjHTZ+uy/s/szreZmr3lhfPjtPybi6mO1TxNTEtiv7sAi5Topn5yM873PDh9J4+6nUlLvBWPNBxpFDuScI4Tffd8gWYVS90HusNGJ7jGTQuttS7Y1MR3XNFrnMnrNAcmcXgPtjbEwdDwnjWmrVUe3c9uIyRPWBEzjcRekLCVbdniHPF3jmLxYS95f47T6DQupBBj4z1Ui7GcdqwiaLMOXMtFeEGPxfilHEXdUwAUCgvjVtM13Mzu4QIGHJ+hvGbqQifv3R81Qh3gST+it2swhrrDMji+5F4vT/28A/f9ZgtziUZ4FTIbRut/IcmLe4r49SwD2okDBZQNMo2XzieLD8Vw1uEVAr+Wx2SsQUuYWYLiXqZgp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(26005)(31696002)(53546011)(86362001)(6512007)(316002)(8936002)(6916009)(186003)(2616005)(44832011)(4744005)(5660300002)(8676002)(36756003)(4326008)(66946007)(38100700002)(66556008)(66476007)(2906002)(41300700001)(31686004)(6486002)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VDVzUyU1NDMUdDM0ZFb1ZFVy9rRXZWbjMrUlJiWTRTVWNwNG5iVHpkd0xB?=
 =?utf-8?B?S3NNenluNGlUc1RCbFlHcURtZHZTZ0pPWU9xT243TUc3bG5QSVh2RFdKRUNn?=
 =?utf-8?B?K3dwQStub2VYL2R0VHZJUjdHZGJ6RVdIWE16TkRLMmh4MExiTjc5T1pvSDha?=
 =?utf-8?B?blJVUWZaeFpzNGM2MW9TeHg5ME9Xa3ZEVCs2VlpiWFpSNTJ1bEZscTJPZy9P?=
 =?utf-8?B?VU9kT3ZselV2WWlsaTVxWnUzdTQ4ZE9weS9Ydm9oK3huQUJSVHhkektFWSsy?=
 =?utf-8?B?OUFmQ1U0K2NQTkQ3cFNGK2ZwNHp4WWZKU3YxeHJzYm0yM0Z6eUNoZjNsSnhX?=
 =?utf-8?B?MVhCaEpiR0pWM2I3WWowMTFZZW1nTngrM2NuelJVd2pKdkNpVkFlaWhRYWg2?=
 =?utf-8?B?MTMwNkpHTXV0aTV4SSsranNUdGpVbFJtNlFNZHd1UVpicVAySWs3ODE4YVlM?=
 =?utf-8?B?YVd6WUpOS3EvZHJreFh1QlFoR2RDek9YZjFTbnI4QUJyS1RjdGxmKzlzZG9E?=
 =?utf-8?B?UTFZKzRybUdSNzFDOG5MZ2tuK3NvMEl0S2xhTW9iL3ZqMnJMcjJlcERTTDRN?=
 =?utf-8?B?azFhRk03YWN6Zm9FUUllOTVWY21ZRmZPc1hIbkZ2RHVQbXR6Yk5IdFdkTnJ4?=
 =?utf-8?B?K2hXNk9oRzJXMUlXeGJSUWNUZ3d3cUxmY2pQclM2SU1yaENJZzJBNHhOendZ?=
 =?utf-8?B?L2tNT0trdG40dUszV3J0c2VlV3h6UEpMcmpkVUt4NVhDeVpoN2t0bEtjYWJW?=
 =?utf-8?B?SEsyRGVZQnhMZXZYTGVmVEhvZnZub1ZHYmRLbEkzc01WWjRKSWZ6OExCYyts?=
 =?utf-8?B?cC9kaFc1UjJlRHQ5YW1hUjdaYW9JTWJwZXNLeDlwNzJRQVpTSko0WkZkSm8y?=
 =?utf-8?B?K0JoZSsxTjlCS1ZBbEhHSmdoblgyM1NjRHJoTjBsSFJRZFdZQWV3SkltTTZQ?=
 =?utf-8?B?ZE1lUnVPYjMvb3l2VWJRd0ZKMTVxZEl6L2VJSUtTd25MUWh1U29wbjFXZWlU?=
 =?utf-8?B?TFlzZTBqM2pDd3BhczkzdkduUVhTWDRkMEcyYmJ2QmtDVjRyWVZnMVVlYkw4?=
 =?utf-8?B?YWp0dzAxcERaakdZSWE1cUlvS1RlWHVUdFkwTk4xRi9GRHVKbTh4aFdFdjJh?=
 =?utf-8?B?K2NUUzNBT1R2Vjl6d0NJaC9uS1YxKzQrU3pELzJCREpYTlBBWlRRMHBEV3pi?=
 =?utf-8?B?YmlhT2UvRmxUTG8yNlhtK2tWeExlMUY4ZzFzNHNNUWVxdC85azQ2NHVWSVMr?=
 =?utf-8?B?bDJ3Y2FnM1VTS0Y3aUZoNCtKMmZ4c2dROCt4NWRyeU03YjVBTlZuL2E4Wktv?=
 =?utf-8?B?WDd2Y3NuMGNSenlJSFdjMVEza0owdHJ6SEpEN2FHbkVNS2NEMkxSUk53N1pB?=
 =?utf-8?B?UGRXeHNLZHVRMHM2QVZEbkthTW84VEt4czFkVHB5Sm93RDZaS0xqZGRSTkNu?=
 =?utf-8?B?WTYybmFHWVg0S0UrNkhaNUdGc1dmZk9aaStKMzlCY2xrNWJZUEt3MEVhMDRX?=
 =?utf-8?B?MzFjRGRmRDBoU01pVlEzL2RnVjFzNjhEWUNPT1R1dmVXQU1TMFJNZFpDUE5h?=
 =?utf-8?B?WmVyWnRpT2xrTzUzSVE2SGFGRDZtTU1XbHhJb29WZ3J6N3ordERsNFZ0VlBy?=
 =?utf-8?B?WVJPdkwzdS9MVTh0cVJ4QUtDWUdaQ1VHSjRVTldwTHpoQkhZTHl4UWR1VDZn?=
 =?utf-8?B?bEZVTmpDVE8yRXppSFpwdFpSOGVpN2ZCQVJBODB4MisrcnBycnVSbkhoYjFX?=
 =?utf-8?B?VHhCVzhkZmNITG9LU3JRR0E4NXBqWS9WV2xuR3Y4VURRYkNRQ2E1ekpwZnVv?=
 =?utf-8?B?UkRULzM4cTVoK1Bieml5TEJxY3ZsZkNWZzZacmkvVXk2T0g4TG5sYzd5YzVB?=
 =?utf-8?B?QlNwdnBtL0dlMEV6SjRMTEJiV1RIK3NTLzhVcG1qVDJrSUxkR2IyTjgyR2NF?=
 =?utf-8?B?NDB2S3d0WjVNdHFldXNVMXBHbEJrOXMyd1hhK0hBYm5qYXl1eEhyZEFFcmxi?=
 =?utf-8?B?czBVVTdsUzdFTkw0Qng0ZnFuWEwzZnU5L21mQkN1MHBJMjBaL3J1NTgxVFFl?=
 =?utf-8?B?ajlvcHNEVmxwdk9yZGJmWjFlaEd2Mk9GSkdNWXZzWk5NdG1xUzFTY3V0WVJY?=
 =?utf-8?Q?datyM8ezH+E2RmvfsuSRE9msl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852beafd-54ed-488d-147a-08dac9929316
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:27:39.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH9xgYGOaJlWs+1QWmWnmezexpfwPMdrk7h3kuMhXtFyweTOgTmO3Rf0PY+whYpkXBG2ncAG0dAlaXnQretCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:52, Miguel Ojeda wrote:

> On Fri, Nov 18, 2022 at 6:09 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>   Index of Further Kernel Documentation
>>   =====================================
>>
>> +Current Maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
>> +
>>   Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
>>   email address is defunct now.)
> Shouldn't this be covered via `MAINTAINERS`?


Ah, you are right, something like in:

CODE OF CONDUCT
M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
S:      Supported
F:      Documentation/process/code-of-conduct-interpretation.rst
F:      Documentation/process/code-of-conduct.rst


>
> Cheers,
> Miguel


Thanks,
Carlos


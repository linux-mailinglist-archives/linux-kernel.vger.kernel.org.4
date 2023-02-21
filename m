Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6169E939
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBUVDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBUVDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:03:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508EEFA2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:03:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNENJuD0V06ktPY1Bw9ZQZz3/6zKwdWmYOrCrXzS01LLVBHLEqZCsHsZZUh+FIX8y9XkBieQ8+f5+8khit6LoYuwxp117Xi6IK1ol+bF7TFzux2nFbM1MMSBCOtduV+1dO7ntRE/hHAoTAV+dLNcp64Fx31d87OpHqwXc3Zph3MpfPSV8f6g1zwfGxQi9eLdl9oTZu/1sE2fq711eifPMKTZHJ3LAhABdmygkirmi4sFtAcdqJ8i8js7YXcQNwaJSbpAFngBRQPdC9ua/gFzsKYZ4dCnpx1H/0xe5vMqmE44rWqPgfXZftXEE/atC4C+zNf1cC7V4pBNSPypfB1ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3x62QWdWBjKz0UvujRjnrAjHfMSBa24Cv0OcA9BnTM=;
 b=YHRV7NLhNPkx3opp2dclqenT0smieIJY3MB1UH3mBOX7hYSxV2aBSbMp/LRPCdqA+CtNsnuDiYHZUcHxfCU6BWiD9NACSnZnvjwfcE1hBpyRXf3msK0ZTRYsNMK0/ru34b9NgELi2exp8ZVYS04YRkA1NohdcoWdFzp/R8VYLsj43TIqoRFMVnk73yb8HhnCVtEiUSyY4e5Qyp8ae9Gdy3M/dIy+aaKKehbK6z25ykLHrLL5ZN8BVGivONojXTfLncon1ll5Ta1iJmGnUc1sbYKsS0BQovMKB6nQ0x+FOFnvZnnxShs2AabwLk+NwnNmazvRd+zKO/RNx0oUsEcvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3x62QWdWBjKz0UvujRjnrAjHfMSBa24Cv0OcA9BnTM=;
 b=ijOaJtfiFnwHMNPDHmLykpuxauldfC/a3Z67aw3gS0CMOU+g656wilLAfvCRBr+r/IcRYVwS46WFHz1ViA7i/+5UPFfD4AbAjCMWPSvmzsHA3X5QAQidazAzLRCaDtXcJTQ8UBRPFmDNHvyUI937dm3YuSgad4+S+zabW9EtyBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 21:03:15 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 21:03:15 +0000
Message-ID: <70f873a4-5b41-aede-55b5-8a731c892198@amd.com>
Date:   Wed, 22 Feb 2023 02:35:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-4-Vijendar.Mukunda@amd.com>
 <b6f06e29-22cb-a996-5dfb-91544059051f@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <b6f06e29-22cb-a996-5dfb-91544059051f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd2fbb0-5ba2-4977-dfec-08db144f0cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8z+jbpQ1KW4Ks1OUC/p/0sApOTytbiOUov9y6R93/uDXM6jPPckR66Xn8pU/IKtddWhTSympyT2/nYMfrtJy2nZVYJerL7KVJPGzdWi+xrTTiVCpepr8CvRmM9YWQvNSIrHUVERsczXsM/0X9Gyp6z8ia2i/WEj1UUkWh/LrBgTc+BQtDsTSfkOAmdSGMDQp5Ba9Qdm0+UOqf1uqQj4+QwyEUnCO4EMCgjelgYCUfC1qxeo9PD+kvEiS4jhA9UH0a716a4ajLdNYwKjVz9ChJ82mluShBx6fxG22j739rcEaBPB7/IpZG6O4oHK0tkEFHHbqhJ7pUtMp2OQasuhJq/Dly8TFh9mXEcbXzUqW6XVq6MsUEWfUiPuatYBAP6Id0SBmSiyjsUbFYgfXliSv3MEpOVKtJwkyjeUPXAqZ5FolV3nbyqO0K7D0+MnYsj74hBZo6eZr+h4yu1Zti/UOPCbbifkF2lyCYvuQcq7dxOYeoxtcob8hzgbRU2veqRAOZOiQ5MbLn1PXLbZqOcxk4+9LFE9xuz+5yEPvGQmggJ6xTljHoogzWbC3FkUu7nVV4HknHkivrstjD4GWAP0UbhKFr1emuB6yXmz2UD1l2bsiw1xyPtn6v2EOTIKGoCyGMQtNQCVjvmcm7DonDu1UZg3FjiVO3wqUs2gVWspLGsmdWc6RVxMqa3nyQSMYydL1J4Tb/qMz1DfVkI6mVmjiYznyNr4FP3BYJoGvYEwSmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(66899018)(8676002)(66476007)(316002)(6486002)(8936002)(54906003)(41300700001)(4326008)(5660300002)(66556008)(36756003)(31696002)(86362001)(66946007)(6512007)(53546011)(6506007)(186003)(38100700002)(26005)(478600001)(6666004)(31686004)(2616005)(4744005)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lucjhYU0dGMTY4S0c3bytkUjBTN1M0VmhBbGNmVFJjb1NOYWRVMWsrd21O?=
 =?utf-8?B?RlhrTVdYSGpVUnZpeUhNMDZXdUtUUjhaT0p0Z25yV2o4V0xIMWFZTi9HZjQ4?=
 =?utf-8?B?UjhndWdnd1MwUHhab2hoQ0lENldUczRXYllRRnJnZGppTVlZMkt4dGhpOHZl?=
 =?utf-8?B?OWRBeUUwbFkwSUFjUGxoNXlTWVNrU2hPdnZoTnFRbEN3Y3Y5aEZPdndxYStZ?=
 =?utf-8?B?VFdGdXQzT1RxQUxtajhZV0Q5bnFqN3JKRTF5ajlkRTkwRVpBNkFLckx2V0t5?=
 =?utf-8?B?SFQyK0ZtOXZvUUl6MDlpbGMxUVhCTXhQeXU4cVRIS01CM2tYUUUyVXZ4MDIw?=
 =?utf-8?B?MjFKTzNteXUreW02Z0ZKREdNNTBVWWRxbXFMRWovT1l5VTQxSjN6TkhhUFQ0?=
 =?utf-8?B?NE5GWHU4aTJvOElvVGNCeGExeFV2eXRiWVBGdWk4STUzZk4vSndNSkx6S1RQ?=
 =?utf-8?B?SG9xeDlxT1Y2cUxxNU5WVDgyUlk3ck9KWmtWemk2SjZreDVYRGpTV3Z2RGMz?=
 =?utf-8?B?TlVuTDFtVlh0VGZxUUljNkVpODhobzQxYUxRUGVsVVRQd3FGSFhxZnZYaWNE?=
 =?utf-8?B?VlZURDQ5b0dUTTJlUjVsTHdqNTdMaVFUQ1IzemNTRlhONTJRd0ViZXNDK2VW?=
 =?utf-8?B?L1g4KzRUVHdIcUdrZk9XTzMrb3p2VDZlSStia2pYVkNITkJmZHo0MmN2TDdq?=
 =?utf-8?B?MStsVUNyVENMK3RGT3ZUMW5EQnNkcnlvM3pWTVFXZjB3L1NDWmJKby96Sldw?=
 =?utf-8?B?d3VTUGtPOW82MVpSQS9PV0NheTAwbEtKVHpvRHZ6Z2g2T2V4T29hTk9hVjB0?=
 =?utf-8?B?VFR3dGdCMktndUZDYW9DTldPT1grUkREbk45V2lRcTVRRUVrM1VkRnJFY2Rz?=
 =?utf-8?B?Njl5R0ZZVlVMMkRZT0huT0habDgvenVRV3dPUDhlL2J2RjNFcXh2VHBnUU55?=
 =?utf-8?B?NHRFVkdxRmkxdTdJSHJUNXpYVFVPMVVRdnRWY1FrSUNlWHMyUWx5S1ZVUDlL?=
 =?utf-8?B?YmFobGg1dDgxd3dWRENQdjAxekpZRGcyUTVRY2dtQ2g4eEZhbW0vMzFtNXNW?=
 =?utf-8?B?dUhXOGNWTmhONFNxR3BVNjQyT3BlSVk4N2R6RUpxMEdJbFNGc1ZhbmJIckVu?=
 =?utf-8?B?dzkvQ3lTaXZ5S1JlYjkrOVlDdzlCcVJwQ016WnJVVThwZWNoVFk3a2h2V0Z2?=
 =?utf-8?B?ZmwxdC9OVDJFUFVJaURwRWNGaDRrVHVMVm5sYlB3WjMrNjNyamhjYXdteHpy?=
 =?utf-8?B?ZythVkhDcnBvbURoeWtsNUZDbldkSytBZ2kyR2wyR1AwUUFLMFlvVVY2VGx5?=
 =?utf-8?B?bEdmbGhjcmhoYStrYkl3eFJXQXBudm9wVXYzbEdGSEVzYU5BSU9Nem1mY2NH?=
 =?utf-8?B?RlhMdUtMbHpENVVJMng2emJCVEZOWmJVME9idllmS0puMW9FeHVmRXg3QlFo?=
 =?utf-8?B?MG93V2JIUkhKODU4QzBvRmJxdVZxdDl5VUFjL08rY08vVGlkMUh2SU8vTVE4?=
 =?utf-8?B?ZkZYaXUrS3IwaU93SldqbWZ5eElScFVCVm9IMmpOS3Y5dWdUVlNJRHVBdldB?=
 =?utf-8?B?VTdXd3pNMm1pekVXb1FhdW9rYmJqTkt5dURyV3BmSXJ2YmJZYWNOUkVqeld5?=
 =?utf-8?B?S3V0dlZlUTlKSXpKVEUvaFkxMHgzM1l1T0RFeGNqL3NVM2pNZlRDQndPOEcv?=
 =?utf-8?B?d1ErdkRQS1lBUk1oTmlZS1M0T291Z2Zaczkvam9aOTlwcDUvWTFJYlhYTnc5?=
 =?utf-8?B?OTU5RHgxNDBRcVZtUmsxcGxBdDdKVGd6aEpkZXVOWkN0QVFPSUc1bjBNMmI0?=
 =?utf-8?B?UzRGb0E4emc0ZFRPSjMrWnN0cUVxdlJ0UjRuZEo3b1FTeUdaQU9RNTFtZ3po?=
 =?utf-8?B?WFhmWGd4bXF2b3o2aUZ6WXZncmlxcjB5aEJvc0hWRHlHQ0IySk1rZExQMGNH?=
 =?utf-8?B?V1hoSkxzMWo5d2Nyd1Nhc1Bxb2Jjb1d4ZzdMWHAxTnBUQ2pheDZGcVUraU4z?=
 =?utf-8?B?L0FOZnN2OENnYkV2SmphNEo2KzZJZmxjd1k1a1FRcEw3MnIyeGlDWGlsOTVo?=
 =?utf-8?B?eW93V2srNTREaTFkSmk1NlR5N1dFcG96d3VvL2FaUjREYWdOUlREemVHNlZo?=
 =?utf-8?Q?iJgAoxwtdtDaTz/eRZZGENN1Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd2fbb0-5ba2-4977-dfec-08db144f0cb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 21:03:15.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfCFC8VTaF0WljkLcaVfwv5ARFGKpo24KUHS6yqSUOVB00hVY9yW80hEvjYB6YS0EYw3zR+4xpa3w/mOB6DfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/23 21:29, Pierre-Louis Bossart wrote:
>
>
>> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
>> +	.hw_params = amd_sdw_hw_params,
> don't you need a .prepare to deal with suspend-resume?
DSP based solution is not implemented yet.
As per our understanding In .prepare () callback, there is
no extra logic needs to be implemented. Because of it,
we have dropped .prepare() callback.

>
>> +	.hw_free = amd_sdw_hw_free,
>> +	.set_stream = amd_pcm_set_sdw_stream,
>> +	.get_stream = amd_get_sdw_stream,
>> +};


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97966DC88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjAQLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbjAQLeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:34:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAF2DE6C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7rl8yJrlUZfqTCLPL7oZ71jq3+qJO2SlcSoZkVp4Rkc6rjHR0/RV0rYJtRmGwhNZCEjud3c5OCPLUyBooWfXB3B8rgq0dnwxTh6aM9Uu3+SJRa8T2ebUTg1NkjcvhPUWPdQvYF3HYsqTvLKb5YDdBm4pTKTNRI7B4sjlGOrXX88mM5+k7xyx2WEmD8M+jCD24I6SBobLb0PKFFQXpAiJx8F5zCwuDtK/e4AlCLJx3xgDyB3XX5NE+tVG/bBJhroD8Gs3guwDBAMQqXOjcUayASJfbdQjCBMISLQO9d6+1B3XxmAQjfrqRBTNb9DMshJlKfQ/GHoMltp2iUrFpBYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWvw/aiTzrxFNDhvMOHoAZGdthNleXvtCXLRezkknhQ=;
 b=F4OHiOlmfH/TGxHqN+bQx2WvRvPd15g/QOdKnD8vdi1Z3hntNIK/kkusEBAirU9HtRY48q5kMMnOAkriWJfvwyQfeZokLaLiL8ey4Rt8mO1vHDvqlagO7OyFeLjzVcaPydVrknQT7UJn1ComS1YS7ZzPMoDfzVTJi4xnxUJAqFjsvJ5LZM5tYIYyV2nJQBKs77QAp6jH+EwuQJtU5VHQBHoVuQAPVdd7n5xAoXDBEsE4x0rlo2cQLS9qNd9U2J2ZJTyzsjfGN/pOgeDlLJzzslR5T6SW8WNLvJzrOsPTbDccYhSNJ30PceR+LUB3USuyScmPWAykKRCbYUjVlddbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWvw/aiTzrxFNDhvMOHoAZGdthNleXvtCXLRezkknhQ=;
 b=UjE5oOe9AF9984gNwhP9OurK5L54bKkQfSa/XsG9beOyTlO01R7SFVh9XnQlSYYv4EJIjQQaUOaFOL+L2/+mrbx/R+tkZWvkw64Fms//0Y/Nbtc0gt8hD3wsMODyhDrFQfzFdA1vPdLe8F6vQ2/1YlriukFCFJudj50fl6UGooE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 11:34:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 11:34:00 +0000
Message-ID: <646c7286-79ec-db5e-cceb-4a910292f3e9@amd.com>
Date:   Tue, 17 Jan 2023 17:07:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
 <991ff630-17a7-eef3-1436-e4a905fe0541@linux.intel.com>
 <78741dee-9257-77c2-8950-0519ccb462e6@amd.com>
 <420258d4-1f66-5288-f421-b26b2a2a35ea@linux.intel.com>
 <dbf20726-3900-9bff-7a72-14608702f636@amd.com>
 <d5638ec8-3fa4-4643-9740-ef87a4ba5833@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <d5638ec8-3fa4-4643-9740-ef87a4ba5833@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f48c46-321e-418e-308e-08daf87eba5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMVEOcJayxECfPIPRKNq+qAd+ylSHDIwP9wHQalVQeGNyhcLYYHEOhq5No9OX2oKWIz4X8+ODkSlPHGP1PxgZFaz1/p72YQdhwLZeBSRb2FOdpKFs85SAeV90sWVqIRRBfaG89pxsgjS1i+7el1Z34DnWccIhKOMWKGaURlehXdU6ZkYAv4KICxQYVYcpCH+O7JJg8tbpcYJdSQ+/LYkOKqO64s0tb1FWRd1lBYzU5uShcL60ovbMPcFEzXM5N4e/4BN9WyOqOoap8fnb1RS9FxlK7WhhZii8UuHYxv5EVMWJUVbkBE+/Wr5lG6TfWBFAmpINaU8ceUNStHOqRLznEWv/dhT2Z8sl3cBw9F448oBOAdpelBSLaZq3mUs8qCfRHwLLO9GXJqq452+wtxRHin57UoMyle2V2/amNvioDkhDZqbiidsuht/5ljnh/cIrlHCbsCPyexB5IONyuIGxA3LBL0llEH+1Fu1fmAHnNLS7neBLiSJ5yCyInHkv0Pl5dg5SjBATQzrtBh5kalhXIw3gOtGzcfQNlY+byNYKLrsXQzxowszXl/+8M7AaVY+u1IErOvv1CZQ7DBOmKCdcUZWNa2x/3TwIRGsFDUap7dvvuNJRTWqkIIL0soGOZRHIAdDskj7fj43gTH8T6k9Va4LbwyLPKaelfefbWGSLN0IQ0N9hBnPivtMgQ3Qrn5H+lEgA3a0m+b6gLNlKJB0eG08BgRlCuXK74CIN3o4EKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(6506007)(31686004)(2906002)(66476007)(66946007)(4326008)(8676002)(31696002)(26005)(41300700001)(66556008)(8936002)(38100700002)(36756003)(6512007)(186003)(54906003)(6486002)(478600001)(86362001)(5660300002)(53546011)(316002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm4vZEtaRWZ6TUQ4SDNDSm5CZnM1bFRLbEt3MHlTeVdBV3JmbjJkTVE4b1du?=
 =?utf-8?B?MEtxek5mcHVacUhiNDQ4MWYwZzl3eXFXbkN4QXNTQjg0eGMyTmVYWEhkbDdo?=
 =?utf-8?B?bmJ3bEpRYjI4N2dxNkRXdEgxWjJCWTR4RnNTcFlIMGNYUzJjb1ROQUsrTHhP?=
 =?utf-8?B?L2hvNy9lR1UzakpqZXFXVC9jVFFQS3pwbGZhMVk5c2xZQnBCWXBCNmxOYm1i?=
 =?utf-8?B?c1Q4YzlGS1VuMVpPaXVISFBPa3pJdzZLQ01DT3RadGpPQzZzTW5pQk9jZm5I?=
 =?utf-8?B?VzRrVlJEdUtRdXJLNWdUUVdjWVBWWUlkVkJ2U1BMWTRPb25mdnhtTXBqVW04?=
 =?utf-8?B?bVY4dlh6c2NEMUpaSDN4TUZUK0hQTHRDclVjQkRUMkFxUFBpWnV6bWZPQ2FC?=
 =?utf-8?B?STE2OWQ4RVNGQlNNditwMVhxZWVsSmZBOXpodnVTTnZuV0VhWmFuSTNiQ2dF?=
 =?utf-8?B?K0VIN25jVEc1RWk1bXlrandBc1lpTUFVRytJZE1rQ1lKdm5nRmRkaXJMcWpt?=
 =?utf-8?B?Um9SdWpjdjRBcWVKRnMxa21XM1dsUWEwNW5jdjc5RVpqU0xRbzdCMnhUR2p3?=
 =?utf-8?B?L2hqajNId3RaOFUxREtBRk12RTllN2w1VHdxajBHbHVYYVlybi9MVFFJa2U5?=
 =?utf-8?B?SndqOVE0SVpQWGZMbENkRyt1c3BkN0VKS0g5SEhEaC9TN2c1WVRjcnQwUVBU?=
 =?utf-8?B?bGFsRy9adkNWZm9kMkJHN3k3WkhxVVh0dHRYWDNpVDNTSnRTMDVyVisrWmdz?=
 =?utf-8?B?Y1hMZkk1NCt4dFFycXh6UXNDZ0d2UmlmTU5OTTVoWUNleEhheGVZc2s1SW1i?=
 =?utf-8?B?R2ZzbWh2RjU0Q3FZSTF5ZkJZK3BSdlNMYUc4ZmI1azd1T05FQnRaTk5JTEZs?=
 =?utf-8?B?UnRLVUlkQldRbkpnUk5JRDJEd1p2ODBwa01Zc2oxNWk3VmNrKzBxc3BJUzE1?=
 =?utf-8?B?YUlpUDlQZ1FOc1V0U1JxenZua2grYWVVQmpJQkY3bkxETnQyOEdQUjRDRC9V?=
 =?utf-8?B?Y3YwNDQ4eEkxOG1hbk5CRmt2bk0rVkpYaDQrbmx6MzdUUU0rbjhvVU5IRSs5?=
 =?utf-8?B?c0VpejMxSDFGZ1dTaDJmOCttQWIwaG1uL051MkRCSWxLWnZCdlN2ZjRKMVZx?=
 =?utf-8?B?RVJYaEFHM2dKWjZ2ZS8zNmFmdUdHUHZRR1IyWFhMeExHT1h4NFBGMU9meHJE?=
 =?utf-8?B?VzRlYllBOWNqdXR4L3J1R2J2blBBRmNYZUtpOERTckQwOTZMalFoc1J1YXBj?=
 =?utf-8?B?MW9udXV5bDVHL1BpTml0OGVJVGQzZ2J0UjNHM3RzQUhrV2c4V3M3Vi9tclR1?=
 =?utf-8?B?ZVFDODZwN3ZVSThjNDhjVWJVazRjM0o5dk9HY1p3dEQxK0gxRWVnQUtreVJO?=
 =?utf-8?B?R0VPZ3U1Sk1kRmJrNERMNlBNYlB3N0JEazRyd1JzVDRqRGE0d1AwTFRLWnVo?=
 =?utf-8?B?dnRtV2pOcmIrU3FWcnRrTE9yUkVUYVpUMy9nWENaNmREWGdJNnUzUHZmc2Q0?=
 =?utf-8?B?WlRXSkVlemhFMnR5TEEyZE9qRDE3dnVaaWJld2tWWWFyWDlDb0UrUGd5Y1BR?=
 =?utf-8?B?bktvOWkwUHhGN0JKU2xXOFQ2bVN0YmxMaXB1ajlaaG5KYmxuRjZFUlROMW9q?=
 =?utf-8?B?MzN4Z1dxUm1aN3lRdWtzQzArSmhOSWZPUjRNa0N5cXRQY0VkWGxkYnhGd3hV?=
 =?utf-8?B?K3BzM21MbWpncVJWR1VZZzAxNUZGSHNDSXBNZzRKbTZXSXhmbmJhcmpTYjF1?=
 =?utf-8?B?eGhDUlNMUEs3VHg0YWRRaUFVKzZwdElXT2JwVUgyb0YwRFFHL0xML3g4R2d6?=
 =?utf-8?B?aFpNWVBKTktadEp2VVQrcEhMZGRMZXFvbmtBcDA5QnVzVjZhajdBNFl3bjM4?=
 =?utf-8?B?cW5zUGlUbkN0T1BCVkxjanhZaDlNQ2FiendBQUxCdndIcnBJVkRGKzBDenhT?=
 =?utf-8?B?bjZjdHo3VmdlSkhMQVBRbXF0eXZ4ejIrWmErUldPQXZScWdTNlZ1NWpnUWdG?=
 =?utf-8?B?emZyWWlmeCsrSHdtcWpSMitaTE1wYW42OXp4ejRVR0dTYW9nM1RBUmFBV01l?=
 =?utf-8?B?RXgrNFJBVmZmeWM4cll1ZVhuNzdIUGVEZk9NK3VzTTZrM1NsQldpc3NNT1pE?=
 =?utf-8?Q?f1oPAKBrGujsYOKW98Qn8q9Ch?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f48c46-321e-418e-308e-08daf87eba5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:34:00.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loo+NkNicQXCrArdy5i6RGuFP0eC8kWDfAQJpfxwStsymL56x561AbgL0GAg3dhzO4U0DgfsdgAIu1T1EkRh5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/23 20:27, Pierre-Louis Bossart wrote:
>
> On 1/16/23 01:53, Mukunda,Vijendar wrote:
>> On 14/01/23 00:11, Pierre-Louis Bossart wrote:
>>>>>> +	for (index = 0; index < 2; index++) {
>>>>>> +		if (response_buf[index] == -ETIMEDOUT) {
>>>>>> +			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
>>>>>> +			timeout = 1;
>>>>>> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
>>>>>> +			no_ack = 1;
>>>>>> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
>>>>>> +				nack = 1;
>>>>>> +				dev_err(ctrl->dev, "Program SCP NACK received\n");
>>>>>> +			}
>>>>> this is a copy of the cadence_master.c code... With the error added that
>>>>> this is not for a controller but for a master...
>>>> Its manager instance only. Our immediate command and response
>>>> mechanism allows sending commands over the link and get the
>>>> response for every command immediately, unlike as mentioned in
>>>> candence_master.c.
>>> I don't get the reply. The Cadence IP also has the ability to get the
>>> response immediately. There's limited scope for creativity, the commands
>>> are defined in the spec and the responses as well.
>> As per our understanding in Intel code, responses are processed
>> after sending all commands.
>> In our case, we send the command and process the response
>> immediately before invoking the next command.
> The Cadence IP can queue a number of commands, I think 8 off the top of
> my head. But the response is provided immediately after each command.
>
> Maybe the disconnect is that there's an ability to define a watermark on
> the response buffer, so that the software can decide to process the
> command responses in one shot.
>
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	if (timeout) {
>>>>>> +		dev_err_ratelimited(ctrl->dev,
>>>>>> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
>>>>>> +		return SDW_CMD_TIMEOUT;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (nack) {
>>>>>> +		dev_err_ratelimited(ctrl->dev,
>>>>>> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
>>>>>> +		return SDW_CMD_FAIL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (no_ack) {
>>>>>> +		dev_dbg_ratelimited(ctrl->dev,
>>>>>> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
>>>>>> +		return SDW_CMD_IGNORED;
>>>>>> +	}
>>>>>> +	return SDW_CMD_OK;
>>>>> this should probably become a helper since the response is really the
>>>>> same as in cadence_master.c
>>>>>
>>>>> There's really room for optimization and reuse here.
>>>> not really needed. Please refer above comment as command/response
>>>> mechanism differs from Intel's implementation.
>>> how? there's a buffer of responses in both cases. please clarify.
>> Ours implementation is not interrupt driven like Intel.
>> When we send command over the link, we will wait for command's
>> response in polling method and process the response immediately
>> before issuing the new command.
> On the Intel side we use an interrupt to avoid polling, and in case of N
> commands the watermark will be set to N to reduce the overhead. That
> said, most users only use 1 command at a time, it's only recently that
> Cirrus Logic experimented with multiple commands to speed-up transfers.
>
> Even if there are differences in the way the responses are processed,
> whether one-at-a-time or in a batch, the point remains that each command
> response can be individually analyzed and that could be using a helper -
> moving code from cadence_master.c into the bus layer.
>
> will implement a helper function to analyze the response.


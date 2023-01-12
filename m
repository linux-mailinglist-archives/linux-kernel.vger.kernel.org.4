Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3600666F31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbjALKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjALKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:11:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FDE2BC1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:11:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/FBXvLcI31+wEzUafGo8Yz9SRnpVRIjLoMKZSce38d2/nkRfpP/Z+pnnEfwd12tll2r3wsIsay8g/SpChISTeplrGQJepbheLiDEbeobZDgY3QpxrmmhSxBmHnPwYvxyO2HrWQW11x6HmHKwWQPrnnjnKorFlDawH9Q+coILcbA3LQmdpE0qgv+U1WMoWFGE5bEpu+lAIbectaPvuOCmCDhuFJNBDA0YbeDBZ2jQLIaAzAOGBl5Xnhx0ODk4U8eqruZ5VssB3q+4woCMLDa0UTHScPGH3MF3w0slASzdUy1PPcLnW6JU+UqU0ArknVs4izaiy9TkOi2NlGbh/Se7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVdKSkgBUXteEYYm8mipEznI6k+FOPXt/Loo2ef7+JI=;
 b=i7RAEnDpa975TM1L2/rMaJvc1uYQNsjCklbpT1j/Z9jMKkqTSEfnHzVVZZUUNZ1eHLoj9kPN82jvRYfkSianEKKZ+UUd+WTPeRmoPw9/KaOdXGv+MC8hLKclMe/N0Ha6LVTlH6oMc4bDMDt3806aJg+EPYd6qRtTwCsipOloEv2rKceWiebLAj5SaQCGpLzMtZAWl5H54WqkZShQOKr5qVQUwZkW4IyGpN4hmTc3m9yQJ0lR2zmHf07rSgVKTU/c+wn2KXd7tALGE7DHV230ofsaLggHEMubvyLQeaHapkonntGuQjtByIIl1J3UcgQXXx/N6aBWZpPJJpFuVVc8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVdKSkgBUXteEYYm8mipEznI6k+FOPXt/Loo2ef7+JI=;
 b=Ele/POYuwR92LlCS4+yBdBrTljhFky1u3FaI2iAOPgD59ODzHIAeMek3Rb4VYG9ccc6lj1y2+bf16wI2M/GMv6nayoknaA4KNSs3abl1NIcprHexYmczTZq+h3YHVbj5YAwyEx4UeEPWrkWOXvKJPP6jX5sW4SwkZrabTdp3G9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:11:07 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:11:07 +0000
Message-ID: <8bc313ad-aaad-8d4e-b851-d08229dd5d55@amd.com>
Date:   Thu, 12 Jan 2023 15:44:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 17/19] soundwire: amd: add pm_prepare callback and pm ops
 support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-18-Vijendar.Mukunda@amd.com>
 <a76043ad-c212-f625-8d0e-ef9460a078a5@linux.intel.com>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <a76043ad-c212-f625-8d0e-ef9460a078a5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee3f8b2-268a-4ded-c8b8-08daf48551e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvhwRemPEN+4SmK+Eq9IW5H116tOSG7aqHyY+fwIrv2M5idVfRoovzUkjvgfoxKMt7k8Cv8c7a+zzhvnm4xRbNQYzGAdD3O3u2xKoHGGXrLAJ1Wbd6lLKO0mL+NDf/RUqpGB+17m8RNYLwHDiMkXvUUHSDUKU1kjFQx4FiHalUzpJJNWv6qFlxxAAapSU54UxROxVy0pEMEkiuAF7WxRyvHPVIh8PyiDUoNaiMKjrQQybmd1zi3J4UhENAtSXiKZSRXEwQmpTA66zkip8xhyINBgyOYmO5PEYMVtQLOUBH1Pll9zS/3LDnE2grxPfAKQEThOMpBtauhjZVJFMONQw1dbrkFElQQhgUkcX8GQNLAhTb4YC5mUN6PSvDTJDi6Jl+TNBqw68i2IKho32Citn5kYE56l63azfYOXBQk2zX476Hv3aa8W59AH9EyOSxVBaC66xJqI0IA02yCNC2zuAlpSMu/aGCiwlfN/VAO5JNKzsD6aX2mLMMO7fLQNNc3X6QZEnjrd/2szOVB2T9PRjvt5rweNRrrLzFgG3m9nVZRjIsbxG3eB07BHSqiOUBTwTVuAc0SPkls1XLb0vfFCmPOGwGr32IvEzvY9DVJ2NRon+i81UO8YMY/m7mHxpS5Lp0H8LnXEzyvLGED7Iu38jAnnhJkn1AkkvUoEv2faQGzFeofLIUV8CYgjOgfQwKE2VzEtLGrDCjk5aLAe7rqE4p3eVAocIrs5yFwUhwkrojg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(2616005)(36756003)(6486002)(6506007)(53546011)(316002)(478600001)(6666004)(86362001)(31696002)(66946007)(41300700001)(66556008)(8676002)(66476007)(5660300002)(38100700002)(4326008)(54906003)(8936002)(31686004)(6512007)(186003)(26005)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJSUWRlMXRkUVhNVENtY3hlQllyUTloVXUvenhQaWtSTU05ZDBvS0dHNkpP?=
 =?utf-8?B?ZWpXRGo2TmZzZ2M2TkhrMzZGVU05b0ZhYnJsMGplY2JNODcyOFA3OFRtM2RP?=
 =?utf-8?B?a2o5d05aOUppRzRKWTlmUDFaV3YyRWovT3FjTm53NldFWVk3MWRwdXI0NzVP?=
 =?utf-8?B?ekl3c2JRTUxJWTFSdzMzeW5IM2JCbmR6a2tPc2ZwQnJudnJ6b1pZMGJwSFpG?=
 =?utf-8?B?aThDQ2pqbkh1UnJRSTJ1MWVReEgrT0d2TTd1OGoyZjc3TnlzSEtHZFZoRXBo?=
 =?utf-8?B?dkRLUU9GUUFqUnNsMHBFVzVoTmpSSTdMaGYxdmppaGVyRm1VUzlKWWQrMDNV?=
 =?utf-8?B?cUlnSE1ZR1pFNzBmeCtPZkUxYksvU1RxUzRZMDBtbG5kQmVzT0Y0djRQNTlO?=
 =?utf-8?B?L2sybWVpN3dHeml3R3NSV1Z3SUpGMEh6dllaUldnQThlbVZnSHFhR2FwMENr?=
 =?utf-8?B?L29ma01WM1J6c0VvdTFpZUxVdUhVOTBlSW53Tm5sK1VKRWVLVkJaVXovaXZR?=
 =?utf-8?B?Ny9YdVdGelpvZE1ZWUpwRG03WUswMFpWcXhtaG5QZm5XZlViZnJraFVJMlFt?=
 =?utf-8?B?a1VubGNEQkFEVlFaY1ZxbTQ1c3JsREt0MzJ6OVFZRHVDZk1zZ1lnYThXRnV3?=
 =?utf-8?B?THptRnZTaXpGb0V6QUhPT2FSbTFTaGxqMFhJL1B2WjdzdGxIZ2YrNlFEZlBD?=
 =?utf-8?B?VStuMjVVTDREVkhnTGYweTZuY3BIcFJxRFc5M0R4SHlQbGNYTUVnUldJRG5M?=
 =?utf-8?B?Ym1vdjBXNnA0MlF0d2lPblFTaHdUNDVRWi9rMTIrdjdFTHlGQ2w3ODFLVmVY?=
 =?utf-8?B?R2V4QTU0a3VCZnpWSDdldklmWGwwa1NqVmNlUUJJYVBTY1c3MlJxaVg4TjB1?=
 =?utf-8?B?T1hWOTY3dmVmc2ZSRTFQUjBpenRJZVRiUHdPeGtnQVRtWEhkL3B1SjZ4OFli?=
 =?utf-8?B?RDB0N2tlUkhYVGd0UTFMSVVBb00xYXQ4NWR1amd3U2VTRy9ySXVsK2RJSHN4?=
 =?utf-8?B?VmhoTVhpVHdtejZSUllGSzNqV2pYQitxMWNER0sxYWNuUUt1NmhFVXVLcXFV?=
 =?utf-8?B?VWE3YXI3ZytxcGZHL3VhdUdtaVU4aERpWk9ZSVZjaFFhY3dqcWJwU2c2MmtU?=
 =?utf-8?B?WldBVVNPRDI2MEtZMW0xNWRIRE1aV0VpdS9RdTBoL055UVNDc3VUNmtQcDBk?=
 =?utf-8?B?L0YycTRWWFlGNlJ3OFNNa1haQnkvWEcyajFaemphV2tycUhMYmJ5SytoODNh?=
 =?utf-8?B?cE5pcDIrRkQ0NEwrVEVWRjlGbTd4eldSVVMyRkk4dWFLZng4Z3JZMkRjbUhE?=
 =?utf-8?B?Zkd1bW9HcGcxZ0NVcjVqQy90MDNYa2pCaXlnZDQ1QjB3NExIYnduNVVqZlB2?=
 =?utf-8?B?Rm1JM2R4T3pTVytqRXRMdGZZNHo2TXpiRDdjM2pPVmFuVXM2VlRFNnhzOWNv?=
 =?utf-8?B?dzRIQUJOZmpUVFZhSitPZXQ1SlRCS0JRbU5VVWdmdkcxcklEZ2w5cHVLNDhz?=
 =?utf-8?B?WjAxaXpxYVViSTM1YjFiVmkvUzNjN1lXNThETlBRTm1IcU9ndXVtOVVTbHBl?=
 =?utf-8?B?Tm1LSnB5YzByRVZCUWMxR3ZZQ3dhT0E2ODFlWnVmZFhJeTkrbkJuZENYblZ4?=
 =?utf-8?B?dUZha2M3bWs2OFhjbUQ1UzVqREs1ZnpjZDdwR0V5ek5pbmwwVTJCZXRSQnQv?=
 =?utf-8?B?M0E4SWVTS1hYdWFqeFRHSytLc3JWU1JoL2o3VFlESE9EaW8wYmZNNUhMYTRs?=
 =?utf-8?B?ejZDYTB4RHA1Z2EyZEN5SVBXd1hjWEtmYldBYTJNbWdGSHk4SlF1VWpjRjE2?=
 =?utf-8?B?aFAva3ZqdEMvZ1RwRHJONCt0eW85YkJwTVN3NFFjNlJvT3p0dWE1bzkzZnIy?=
 =?utf-8?B?STNhdzFqZzNXWmhNYkVEYThqOEx0eXJuRVFaRFZ5R2drN2NOZlFpM1pUeVZq?=
 =?utf-8?B?L0RSdTYvTnNxQ2dqMnZKVE1Xdlo0bGRiUmFaek9NS3RJSloweS83d2ZRKytY?=
 =?utf-8?B?OHZQOWdZN1FPU3ZYMlZ3UHNoNTZLWE9wejFXWUhObVVCRHZOekQxaldHQVl3?=
 =?utf-8?B?YWU2K0Z0UGQxV0lWbEcrNDZZbUIxOFBMejZ2R0IxMHE5WjhFc2VBa1lROUtu?=
 =?utf-8?Q?8gMsjziJQ8trXERAeTf8yDW4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee3f8b2-268a-4ded-c8b8-08daf48551e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:11:07.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNxMX9YMP2v9mbjlZdr88brdd9Yt5SB2jzzoPM5TmWfY9viuttAQ98GmnQ/PMn5nZY260qNMZLnlLFM3ceUEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:28, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Add pm_prepare callback and System level pm ops support for
>> AMD master driver.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_master.c | 76 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
>> index 2fd77a673c22..f4478cc17aac 100644
>> --- a/drivers/soundwire/amd_master.c
>> +++ b/drivers/soundwire/amd_master.c
>> @@ -1552,6 +1552,80 @@ static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
>>  	return 0;
>>  }
>>  
>> +static int amd_resume_child_device(struct device *dev, void *data)
>> +{
>> +	int ret;
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +
>> +	if (!slave->probed) {
>> +		dev_dbg(dev, "skipping device, no probed driver\n");
>> +		return 0;
>> +	}
>> +	if (!slave->dev_num_sticky) {
>> +		dev_dbg(dev, "skipping device, never detected on bus\n");
>> +		return 0;
>> +	}
>> +
>> +	if (!pm_runtime_suspended(dev))
>> +		return 0;
>> +	ret = pm_request_resume(dev);
>> +	if (ret < 0)
>> +		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __maybe_unused amd_pm_prepare(struct device *dev)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &ctrl->bus;
>> +	int ret;
>> +
>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
>> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
>> +	if (ret < 0)
>> +		dev_err(dev, "%s: amd_resume_child_device failed: %d\n", __func__, ret);
>> +	if (pm_runtime_suspended(dev) && ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = pm_request_resume(dev);
>> +		if (ret < 0) {
>> +			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
>> +			return 0;
>> +		}
>> +	}
>> +	return 0;
>> +}
> This seems to be inspired by the Intel code, but is this necessary here?
No It's not inspired by intel code. Initially, we haven't included
pm_prepare callback. We have observed issues without
pm_prepare callback.
> For Intel, we saw cases where we had to pm_resume before doing a system
> suspend, otherwise the hardware was in a bad state.
>
> Do you actually need to do so, or is is possible to do a system suspend
> when the clock is stopped.
>
> And in the case where the bus is in 'power-off' mode, do you actually
> need to resume at all?
Our platform supports different power modes. To support all
combinations, we have included pm_prepare callback.
>> +
>> +static int __maybe_unused amd_suspend(struct device *dev)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &ctrl->bus;
>> +	int ret;
>> +
>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
>> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +
>> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = amd_sdwc_clock_stop(ctrl);
>> +		if (ret)
>> +			return ret;
>> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>> +		ret = amd_sdwc_clock_stop(ctrl);
> do you actually need to stop the clock before powering-off? This seems
> counter intuitive and not so useful?
Yes, as per our design, we need to stop the clock
before powering off.
>> +		if (ret)
>> +			return ret;
>> +		ret = amd_deinit_sdw_controller(ctrl);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int __maybe_unused amd_suspend_runtime(struct device *dev)
>>  {
>>  	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>> @@ -1638,6 +1712,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops amd_pm = {
>> +	.prepare = amd_pm_prepare,
>> +	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
>>  	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
>>  };
>>  


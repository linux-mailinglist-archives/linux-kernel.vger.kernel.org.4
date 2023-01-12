Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496C8666FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjALKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbjALKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:38:37 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843D559F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENVBt1e7RO9W52NbVvzGD6jvyWxfUMUekdPkTPlvBFjFMs0WOnO0hoeYLZ6DteOJRVPE+IZ/QHYSA03cKO6/WFzZlR6awZXV2c/NzVRQnTIkYOo4XdChOo/hC3WKFnAEqOYowcn1QG90L1xL0uUQ5UrIJYAof1hCAoYhttLFy30hbiFTyFSU5v+Po3twbj9ltPTWRQHgs4KCZ7Uk3emuDHFUfjleyJcGWZ9dX3VYZKxvenpFSLxprr91dUSc43AWu5hBCXRwlp1oxO/RawADDTb3UOGxk+0KkszXE24+qeXYCKSnf36+vwZP7IVAUo5FIBJ6PmwqXuaX0Yw1xl7REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yQZsEUAcmkGASIuLrGbwQ13dHkhYAM7e4JWz6set1I=;
 b=NRiDEk4DaG65garEGEb9nC6/wyG7y5DimFeY0beSlVHLWyFzi5+Mx1ua+1cX/FpnpMyayh1jywOhmbR3VPAjCkROr5ZrSZXQ0U4bfrE0JxkBBVEyxQXHJ/rnFrT+sukaELeakN5nImXQrMpiOuq3NRtwBjvEzHPwS/NkBy5+3QYjKov1U5nbUecwExwA4NmzPSx3k74ComZdc14WbZzGHf+MzuFHNdeMqXZXCsDEzimJG/GTAgq0y6r7HA7LfIlYVWhBE7Zx7rLaaA8iBtvHbON1gUg0Yt1c0ay2D47nf6kATFTax5zTpTdXWJC8oRd0bUcezO/2LXv5IVzYwCKjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yQZsEUAcmkGASIuLrGbwQ13dHkhYAM7e4JWz6set1I=;
 b=2qHKMCDS32RvV5tJSAiNpOR+wHd4A1RXxQbYSBfP248Ln0TDHwtLxJA+Jd9VNRPzEWb087NBycc+DPmiXpDPyHPFzpkTCd9yr/UsNVVv2BIAyD6OA0wyBkT1PcVoVTfueWSqr1rmKre91gHK/6qBvYwRvCh/QdFc4ZFjR1pVMME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:32:17 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:32:17 +0000
Message-ID: <216b288d-16d3-5806-86fb-fc6ba83b757a@amd.com>
Date:   Thu, 12 Jan 2023 16:05:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 14/19] soundwire: amd: add runtime pm ops for AMD master
 driver
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
 <20230111090222.2016499-15-Vijendar.Mukunda@amd.com>
 <1af8aa6a-9896-4d35-48de-f084fd16ebc7@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <1af8aa6a-9896-4d35-48de-f084fd16ebc7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 258eaffe-2887-4af1-8564-08daf48846ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5O8UQI/FrgpUU05le4xQjBsUxbxk0F+PCqT1zHK4OA4y7eOl7wDOcmbjdvb4aBR1HEhb1Q3npkeqjb5BO8mTpAuJ40x+GD96dAgUgytvhmOiTE240t4apMYK59Sat0ahiZ9vDfqtetYYYn/tVAYpiItIbaIvd6gfGyHLW+FDbuUDcjE+aDwDoIuVM+RsdYRUixTwPXkMwRdrHDiU2xutXjiDoVw5kQJAd9zSlgMfhbUeyCp7EERz0CXTqQMkhp7h5XKuAz0GpBoN0dBfpGBya30G4Kdr0BytdvLPTEgVJMzbY5peR+uWpEXfh8KtaImvIQUrUX3jjLFwgyj9pp5iqtpEA3KAcyfbxGLm/s3Wl9CV6W6zA/i/Ab+hxhfuelX+fc/4ZUxw9RdOyfCJ6UZHey49i30x7RNr1Qo6TZrd9KLgDLHdXx0zlG/11b/kmLFs0HXjJWLCHr98ibU2Z9BVhwVKZE8SI4udYPLWxhrjEjYELL4a+vkIMdwER8oOXOl0fupq/cH+M2FzoAm0c5aPkBCDNdZ0rBqI0L9gAs295oEjYHBEx3i8RLV6wk0B8Pq0LeBf1+wAOAXCszGdxmA+5DTQSxJqjz2VUnAIwTefq4HQNp36WgBIgmVlOUYLp/EQUqMupk3tU1f6oZ+4XDmnQkIG1Mnd96Kla8PLKKkW48sBHa5sZ2YD22XSVRk3jbHH4cw0UMfx3dhXLNZMSNn1pYmcL4LyWGNtos3b7M2m+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(36756003)(478600001)(8676002)(66946007)(86362001)(4326008)(38100700002)(66556008)(5660300002)(66476007)(31696002)(41300700001)(8936002)(316002)(53546011)(6486002)(83380400001)(2906002)(31686004)(26005)(54906003)(6506007)(186003)(6512007)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THV5dUZHTlpkSFcvNFJWMHI2Z0xJUGU2VVVqMnQ2NnJUanc0OUF3dmdGRkNl?=
 =?utf-8?B?dit3clE0b1ZFeHNtUWxTY2h0eTlTNGNGM3J5TEJ6aTBUMTVXUjQ2aDB3UTBC?=
 =?utf-8?B?NjBhZnZ6cld2WTB5cFFtb0NRSmttSWJTdW1iTGtJZEcxcUdFRFcyV0ovUHIz?=
 =?utf-8?B?MWY1cjZDZGprQ3ZNaE4xdEM5YmRpSG0wV0Z4eGp0YXYydVR0cVJjUy9pYVcz?=
 =?utf-8?B?U2U4RVpiZ082VHkrcVRpV1dtWnkzdDFSbWRKekttZjVaNTV3d0hod1hiQ0k1?=
 =?utf-8?B?S3ovYlkrUDB0OEk2Z1JGTEYwdkVFZmtBYm9UaE1tLzR6dHhKemZRbjVjUWFj?=
 =?utf-8?B?aEU1Zi9jcDFaNTdrYWVmWFBiZEJsRTdKWlJ3V0poTlZYWUsyK2NST3JTNnll?=
 =?utf-8?B?WXk4VFpLMW0wbkpOckRpOVRFc1VVcnRHUkE5MTVnSTdKNUFoVkdPMW9hK1Nl?=
 =?utf-8?B?b1l4ZjdURGFEeWpyNnFuQXBMZlNjcDI3NTBSdFJ2VXlsQUZIUUFiUUlVOWxD?=
 =?utf-8?B?eGplZ2FCTnZFeTdndjVIenpCNHVaV1d3RktSSm9MMUlvMEhQM0xxMkUydC96?=
 =?utf-8?B?and3d250UFZ2TmJDN3VGZGdVWVB1aUFuMi9mNmxTMmNGa3JMV0orRlVKVi9H?=
 =?utf-8?B?RGRHSnpUZEdSM2RicHovZUx3U0NnUE9LMHZmQVdsSXg4OGJNYjljeTB4MnQz?=
 =?utf-8?B?OTduSjl5TjhIeE9GRStWNkxadlNOa2w5R3E2K1hLZmxpaHpQQ3d3cTA5bGEz?=
 =?utf-8?B?YWU3cGpYUCtHSTA5bnF3YnR3QTZ1eVIyU1BCWGp1OGxkMGREVzRKR3hQdnp3?=
 =?utf-8?B?emo4eDJQUjZTRElCYWZUa1RKby9pRzArUVlHbWNJNS82bEFMK3lkMkg5REpU?=
 =?utf-8?B?ekNlZFFzbmZLS2o3NVJnMDZRc1VObVJkcU1QeHJsbnBscVVoRklPQnhqR0Y0?=
 =?utf-8?B?OUFBdFRSTEk3Y2Fpd0pzUkcvem5TcG1GQWxqNmxjZVBhSlJiUkpxQ1lvTG0z?=
 =?utf-8?B?YlRqM096K2tkaHNSblM1UXIyWTkrYjhYY2ZlemU3dkNheG9mMEswblBLK0ly?=
 =?utf-8?B?azdkRlE2L2crbnJLQmJMaGV4TTNZcUxUODZXenI1Z2NPS2traUQyUXQxOHV0?=
 =?utf-8?B?NFZ5ZkVWMGthVitPUW1vNVNqVXVodGJyOGtWTUZUSkpBWEZYZ2lISjB6M0Rr?=
 =?utf-8?B?T0ZNZndYY1kxTGg5aGplOWRjenh4SC9rT1NGS2JIbjJmUXJhekh1N0plc25T?=
 =?utf-8?B?VDlNek0zMnVoeHdYT0J3M3RtMTBvM1BKMVJraXRjc2xyenRGMUpidlJDaGtD?=
 =?utf-8?B?N2t3MVkxUEljUnVxRHJVek0yQk13aU5BUmdyakVKTjRIcnNFcGtKdXdDSm1X?=
 =?utf-8?B?V2ZUK2JUS0Z4WlRENGNEdWErY0UrYW9sMXhkUXB0SGlrSUhiYm5xNFFRdGZt?=
 =?utf-8?B?dXlocEpZeGZxaDdEYlpxWHI5MjBUd2dXdG8xR2xFc3Y4NFM5WFNMOEl3d2s2?=
 =?utf-8?B?Y2JZL1V3ZGI2NkZUcWpHZ3Q0ZEk5Ky9XZUhzTFJIL2F2Y0FiOUZwRWJ6QklZ?=
 =?utf-8?B?M0FzMWhLRWx0RjZoWUtoVXVQbWJYTkwrc3dUNS9XSG4wU2ZaS3BIZGFxTTht?=
 =?utf-8?B?SEFJSjE5Nmw1bDdBa3N0UVpuZjRQVENUa0gzbmk5YUVSVkYwSUMvY1VSV0xp?=
 =?utf-8?B?ZkhWTnVmMnRKR1VHTGNqWXgvdnAyQTZpSkM3STVmanM2MkNMMGxrTVhCVWx0?=
 =?utf-8?B?RGFMQUJIdUlUajJZZG8ya0cxbGdqWVJ4VmNmWmFnY0tiUm9tMVNNNVRGSHJ2?=
 =?utf-8?B?U004VHB5dFVaa0J0bTZTaXdvZURtcnlpa3BsMVo1UnBZT1p0T2cvMmpWLy9C?=
 =?utf-8?B?RXlNN21yT0F3MXVoM0hpK2hTdlZxbHk3SFdINHIzY1hnRGhqc0cvN2Z3L1NU?=
 =?utf-8?B?RFFxMFY3bk9TWTdraHlXVHFHVXVSdWNBTUF5YjYrMWtSU2FYb2MxZ20xREVw?=
 =?utf-8?B?VzVObWttUkVYclEyUm5yNVFHNndXQW95eFhUaE5HUlptQUpWNmhiT0JHUVc0?=
 =?utf-8?B?ak01aTQ1MmdMLzVhc2NpSm1CK2dBVzBMcVZoeFNLODluZm8vNW5NQzl6WUZy?=
 =?utf-8?Q?fQ98Zp6bQgZ3xjjPbYdTQtxbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258eaffe-2887-4af1-8564-08daf48846ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:32:17.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCzogOKKKzmEbRbo9+Rtg49veXjl5YCgxaCDm/Rr7keNhBXDNSkHi1RWCg/xrv7icuAzOKJTpYyAzgBUnr196Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:17, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Add support for runtime pm ops for AMD master driver.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_master.c    | 205 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_master.h    |   3 +
>>  include/linux/soundwire/sdw_amd.h |   1 +
>>  3 files changed, 209 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
>> index c7063b8bdd7b..d2d7f07de202 100644
>> --- a/drivers/soundwire/amd_master.c
>> +++ b/drivers/soundwire/amd_master.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/soundwire/sdw.h>
>>  #include <linux/soundwire/sdw_registers.h>
>>  #include <linux/soundwire/sdw_amd.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/wait.h>
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>> @@ -290,6 +291,17 @@ static int amd_disable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
>>  	return 0;
>>  }
>>  
>> +static int amd_deinit_sdw_controller(struct amd_sdwc_ctrl *ctrl)
>> +{
>> +	int ret;
>> +
>> +	ret = amd_disable_sdw_interrupts(ctrl);
>> +	if (ret)
>> +		return ret;
>> +	ret = amd_disable_sdw_controller(ctrl);
>> +	return ret;
>> +}
>> +
>>  static int amd_sdwc_set_frameshape(struct amd_sdwc_ctrl *ctrl, u32 rows, u32 cols)
>>  {
>>  	u32 sdw_rows, sdw_cols, frame_size;
>> @@ -1387,6 +1399,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
>>  	INIT_WORK(&ctrl->amd_sdw_work, amd_sdwc_update_slave_status_work);
>>  	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
>>  	schedule_work(&ctrl->probe_work);
>> +	/* Enable runtime PM */
>> +	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>>  	return 0;
>>  }
>>  
>> @@ -1398,14 +1416,201 @@ static int amd_sdwc_remove(struct platform_device *pdev)
>>  	amd_disable_sdw_interrupts(ctrl);
>>  	sdw_bus_master_delete(&ctrl->bus);
>>  	ret = amd_disable_sdw_controller(ctrl);
>> +	pm_runtime_disable(&pdev->dev);
>>  	return ret;
>>  }
>>  
>> +static int amd_sdwc_clock_stop(struct amd_sdwc_ctrl *ctrl)
>> +{
>> +	u32 clk_resume_ctrl_reg;
>> +	u32 wake_en_reg;
>> +	u32 val;
>> +	u32 retry_count = 0;
>> +	int ret;
>> +
>> +	ret = sdw_bus_prep_clk_stop(&ctrl->bus);
>> +	if (ret < 0 && ret != -ENODATA) {
>> +		dev_err(ctrl->dev, "prepare clock stop failed %d", ret);
>> +		return ret;
>> +	}
>> +	ret = sdw_bus_clk_stop(&ctrl->bus);
>> +	if (ret < 0 && ret != -ENODATA) {
>> +		dev_err(ctrl->dev, "bus clock stop failed %d", ret);
>> +		return ret;
> You need to be very careful here, because returning an error may prevent
> the device from suspending.
>
> If it's safe and possible to recover during the resume step, you
> probably want to log the error but let the suspend continue.
will fix it.
>> +	}
>> +	switch (ctrl->instance) {
>> +	case ACP_SDW0:
>> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
>> +		wake_en_reg = ACP_SW_WAKE_EN;
>> +		break;
>> +	case ACP_SDW1:
>> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
>> +		wake_en_reg = ACP_SW1_WAKE_EN;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> why not store these offsets during the probe and use them directly here?
> You know at probe time which master you're using.
will fix it.
>> +
>> +	do {
>> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
>> +		if (val & AMD_SDW_CLK_STOP_DONE) {
>> +			ctrl->clk_stopped = true;
>> +			break;
>> +		}
>> +	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
>> +
>> +	if (!ctrl->clk_stopped) {
>> +		dev_err(ctrl->dev, "SDW%x clock stop failed\n", ctrl->instance);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	if (ctrl->wake_en_mask)
>> +		acp_reg_writel(0x01, ctrl->mmio + wake_en_reg);
>> +
>> +	dev_dbg(ctrl->dev, "SDW%x clock stop successful\n", ctrl->instance);
>> +	return 0;
>> +}
>> +
>> +static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
>> +{
>> +	int ret;
>> +	u32 clk_resume_ctrl_reg;
>> +	u32 val = 0;
>> +	u32 retry_count = 0;
>> +
>> +	switch (ctrl->instance) {
>> +	case ACP_SDW0:
>> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
>> +		break;
>> +	case ACP_SDW1:
>> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ctrl->clk_stopped) {
>> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
>> +		val |= AMD_SDW_CLK_RESUME_REQ;
>> +		acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
>> +		do {
>> +			val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
>> +			if (val & AMD_SDW_CLK_RESUME_DONE)
>> +				break;
>> +			usleep_range(10, 100);
>> +		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
>> +		if (val & AMD_SDW_CLK_RESUME_DONE) {
>> +			acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
>> +			ret = sdw_bus_exit_clk_stop(&ctrl->bus);
>> +			if (ret < 0)
>> +				dev_err(ctrl->dev, "bus failed to exit clock stop %d\n", ret);
>> +			ctrl->clk_stopped = false;
>> +		}
>> +	}
>> +	if (ctrl->clk_stopped) {
>> +		dev_err(ctrl->dev, "SDW%x clock stop exit failed\n", ctrl->instance);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	dev_dbg(ctrl->dev, "SDW%x clock stop exit successful\n", ctrl->instance);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused amd_suspend_runtime(struct device *dev)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &ctrl->bus;
>> +	int ret;
>> +
>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
> do you have a case where the startup is not done? This was an
> Intel-specific thing.
We have included startup_done flag in probe_work to check whether Manager
has started. In case if manager init sequence fails, then there is no need
to apply any PM ops.

>> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = amd_sdwc_clock_stop(ctrl);
>> +		if (ret)
>> +			return ret;
>> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>> +		ret = amd_sdwc_clock_stop(ctrl);
>> +		if (ret)
>> +			return ret;
>> +		ret = amd_deinit_sdw_controller(ctrl);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused amd_resume_runtime(struct device *dev)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &ctrl->bus;
>> +	int ret;
>> +	u32 clk_resume_ctrl_reg;
>> +	u32 val = 0;
>> +	u32 retry_count = 0;
>> +
>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
> same here
>
>> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +
>> +	switch (ctrl->instance) {
>> +	case ACP_SDW0:
>> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
>> +		break;
>> +	case ACP_SDW1:
>> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> select registers in the probe.
will fix it.
>> +
>> +	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = amd_sdwc_clock_stop_exit(ctrl);
>> +		if (ret)
>> +			return ret;
>> +	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>> +		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
>> +		if (val) {
>> +			val |= AMD_SDW_CLK_RESUME_REQ;
>> +			acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
>> +			do {
>> +				val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
>> +				if (val & AMD_SDW_CLK_RESUME_DONE)
>> +					break;
>> +				usleep_range(10, 100);
>> +			} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
>> +			if (val & AMD_SDW_CLK_RESUME_DONE) {
>> +				acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
>> +				ctrl->clk_stopped = false;
>> +			}
>> +		}
>> +		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
>> +		amd_init_sdw_controller(ctrl);
>> +		amd_enable_sdw_interrupts(ctrl);
>> +		ret = amd_enable_sdw_controller(ctrl);
>> +		if (ret)
>> +			return ret;
>> +		ret = amd_sdwc_set_frameshape(ctrl, 50, 10);
> this should be defined at probe time, using magic numbers like this will
> not work in all cases and totally depends on the frame rate and
> bandwidth needs.
Will fix it.
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}


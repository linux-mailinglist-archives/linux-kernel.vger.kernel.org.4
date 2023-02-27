Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD76A49E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjB0SiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0SiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:38:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336C9EFE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4PmPJRPKTZ9njc1f98QKlxkJ62O0MOgN3wQFM176BB7bGWfAtK6uH+Xz8AKV83kLn6DW3AXZQD+rvq4wDgU08obXSp7/6/uV9DvDPvNeCs1dFmKLMyl3KnWGQWkVSljFNkXvxgYqE9sh8Azby3lAoufW78Z1YmmgksGdOUZGVao7BfgDCGJVBA0/Xpu1lKmxr1uyBSntxGyfoc90FKm0xipeCs0rLEZdk32DgHzS9vcNl+hqlpb/jhK5bIMQWfOPkexkWyU/n9KpNacZ92tjASO1QeiOOK+5Dv3iCvWwtzN3n54yp4DK/rR6CD+/G4XDEB3DwZ41sfgfzzg+PVVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLEPUMD9CNdgJIfLG/+5zjKB0j9JfE6O+5VR/Wz9/qk=;
 b=nxk54kDn9h+Jl0aaRoWiyY3hbrZ417UMk+BYxHq8He/bhmVIJjzgr2JmRoR4dlLZs6Q3Pl8nOwYpWtWymPzPqvHPzDfMsp3H7Rh2xdTMdhM3IdxwfSusB5EzRUylnE4oMPzpb+k1EogLWb97InyWSKX3lieZF5xGMDZaeeMaJk6OnMMBqjRKG1LMsMMl+kESBXRpcsD/p8EJXubOf898+udP0OxZGoPzLgDv+lQ0DLNIjB1DxSOxybzfKilcwg4ZIdRGi910oCR/MDenSLsVHkT2SBhqZu1ZwH8IRP21mI9hhgcNy7gI+PxeRhIb1fSDmJkgid7u+0gabpAo0X8Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLEPUMD9CNdgJIfLG/+5zjKB0j9JfE6O+5VR/Wz9/qk=;
 b=4IkIo6pitJ4akUjnr4MqpJd/Hsg5ZoPj4+g+WueUMy2eIJYRlEM8qRDGtfgMV1igy7y2oRJ4ZKTlg+gPmlHcgtlavc4VWeuX5dJVbqUFHl9ryodL367rtJwp9rb0qxEfBBdm2V9I6t0HnBHSSUUTMsLoc6GHedQJYE2QSKXERgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 18:37:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 18:37:59 +0000
Message-ID: <acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com>
Date:   Tue, 28 Feb 2023 00:12:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V4 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
 <82c7303b-131e-0633-2c08-5b4b414ad941@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <82c7303b-131e-0633-2c08-5b4b414ad941@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b97fb21-c91f-428e-5588-08db18f1bfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yWg2xUdGe26+n4XaFJ57f7sjNON4GmPeh7y/9WfflPkWWhx7c/a9TLZ/ZrdYYnIla2Fg2KZglVDrn7MOeCtJQYh0BmiMptZ6V86GZhSHXbCim1/0x5jBQBu0WgdKHURpKO2aR8uEjTmsoyuuk0RYNowBmwnKspguiQ47gFosa5X8N8hNVRxD5337AS94B9QZLP0GDhF+KMbIxJlGz0AFg8wV5blGxMKbOp3QjoQuI00jvxmbwi5nPP2ngAx4DVVFhatTOBkN89NSSoIrjjFYOvaVWWr/TA1ZMVwHRR5oeKC+bMIBWf8soiIjqPfOyKXqnaO8uHiEWYa8Oczm7GSRwFSm7BHJvtxF1imq1PFXpS198D4J6cgij0KOiBLSwujJXIBXjSElNqdApJ7UzGdUIj6ecAIDIb+MJCu1E+G1671MH0JeJ0P6DZRVKycx69up1wdRlIm/tLCDVnls1Oxym527JUA9x4N2RP5NJQZq3lFQ47HTXnbqTGdD+nw0YgzGRFkL1pIR+V/pdsPq2pB+40God6Mhram/KHf028od5KtH9td8oHnAK7TQCGt5j/A3PzCSpN8pRfvj9Xk6NouSRvRC+HHbZOoNDuYtG4ykQLPNUXVu7EOy9IC41AKSQ2FPr/XUQD6m2H5mmOUiRPs3DlT/cXr/Ti34EXMge0dv+8+CAmcyh6BGEH5dIaaYxnuO58vUr1rKxJXvsFZdNHpqHrG9Tn2HUoioa44eDKXTe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(8676002)(8936002)(316002)(54906003)(36756003)(6512007)(53546011)(478600001)(186003)(26005)(31696002)(966005)(86362001)(6486002)(6666004)(6506007)(2906002)(2616005)(38100700002)(5660300002)(83380400001)(4326008)(66556008)(66476007)(66946007)(31686004)(41300700001)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZyUE5oR3k3ZFFyS3lhRkVMckFlM0ZIUTExY3JkUFRKai9GOVRxa1ptU3Q1?=
 =?utf-8?B?cDg1akpUbzZYelhkdWdFMG1yY2RHdnovS1JaalRYNEFzMndnTHVGQ3JmcXJU?=
 =?utf-8?B?QklmVHpaaU5MVzJMMFZoc0ZxM3ZGMkwrUWJmTFpIbkhlZlgyMEJaWVp2ano2?=
 =?utf-8?B?T0EyL0lzb1hUYXcyb0xhbDVjaXBIYmJPNTNMZmpRMVpUd295TlNWcHRUNlpX?=
 =?utf-8?B?Y1M1YnlSN3dIV1Q0aGRpNXc2dFNieVlPNjBpUWx2TlhXU1kraFV2N3NScDEz?=
 =?utf-8?B?VmU3WXVkMzR2Z2JOZ1pTRlZnVFBHYkhaZ3g5VFNpMmVqUFVlb2h5a0JjaTh3?=
 =?utf-8?B?QUs2Tmc1UFhwT2NYSDB1V1Y5MUo5d0NmN3M2QUxyb3EyTThUQkJtQUpMbERR?=
 =?utf-8?B?QTJUYlMwZGFlWHFHRVZXLzBSSndLcXhlK3dURXpnZGs2d2UvYzJ2UW1NL0Jq?=
 =?utf-8?B?RzVnaWs1bjEzNnovS0UxTDV3b2xPR3BlU1BheVN6dXhGdDNrTmZYaWxDTGt5?=
 =?utf-8?B?MTFrSWdHbGtpUENmNXYvODRMWVpKMmhKalNpQWI5T1J3OEtKUk42elJVdHlm?=
 =?utf-8?B?a0g4QmQ2aWRNYnBza2JtMERoeUo4TDlRbGF3UU5ZNlJ3RitiaFFKVzFNNVhJ?=
 =?utf-8?B?b0ZRRVJ1Qk16RGtvcWhFcE4wTDJZK3VySy9vcjZWTStWN0VCMklzMExKQ3Nv?=
 =?utf-8?B?M2l6bmZzQjZCbllsWitiTHFGK0ZLZCtRZlRqa3htNmUya3YvZGMrVThaQ3kw?=
 =?utf-8?B?Rkc5YkIzZEpxUExBVExNM2lMekNFZnlZWnhsakFTR3AvVGh2WTJnbzdCQWMv?=
 =?utf-8?B?L3dqNng0Q1JGVFkvOGhaNWFpT3BPWmdERTh0N0UrRGk1VmN0RG5yRDhaY0tk?=
 =?utf-8?B?c1RjS2RxeDNpZko5dWlTYWZ6b2laRDU2emtjcHpTcXU5TjJVWkdwS0o5VDZN?=
 =?utf-8?B?aWxqYzF1Zm5EajRRWnNMdCt2cTdISXdxN3FacEgwRy9uelUxMFJWby9jN3g4?=
 =?utf-8?B?eTZCd2xCUkdmZHNNMnppbHFnTit3UXVUU29iL0xSSVFQQWpnVFpCNytkYm4v?=
 =?utf-8?B?MVFjY28rY2NvOFdhUk16QURmRFJQdGNkV0JBamNWMXorcWRqQ1c4c3NGdU1J?=
 =?utf-8?B?ZWlqUnZOMTNxamdNQjNNS0FCUTBPN2toTmpRQTdhcHRKY2U1a2YyRlRnZjlN?=
 =?utf-8?B?SG00Vk5nbFVoaS9Qd3R2bCs2UDdTSmJBRFNuTkNUVFQxdlpWMlpQUXQxSnYx?=
 =?utf-8?B?NnZjM2dPdVZ5em1pSjBQZllydndENFRMRUliQkJpdGg3bGc2VzFiQjhqdkVD?=
 =?utf-8?B?TDREOXdnVCt0S2t5YStEekFqYVNnT2JhdEJ4RHFOeXdNRDcxc1c3bWtUNXZE?=
 =?utf-8?B?OURRZXhLa2lYVHZjS0FRYTNLS1lDa3Q4UTR0MzlGeHhOajFYVk1uNkd3aWJY?=
 =?utf-8?B?ZWhnMGhtZVFURnVYSDdwaER3MmhiSDl3RzhLVHhQRzU5dm9XREpaNVRaNzIv?=
 =?utf-8?B?emRReWh2YVJPajkxc0crOHV6b3VxbzR1T0hKVGRYcnJvenhXc0o2dU5sSko3?=
 =?utf-8?B?UGNtVEFsS2VoeGVpUWh1RzhBaDVnNEE1cEpSWW8zcVNMcmZyTVROUzVTNklm?=
 =?utf-8?B?M0M1eHpGdHZVVnN1bkJZUi9yNU9XSjBkSmQ5SEtDL1VoNDZ6ek10Yjl4VVdx?=
 =?utf-8?B?cmg1RzVlSzNkcTJpcUJWRmFiMi9SWmw3VitlUjZyQWtvcUFJS01wWW9aSFdC?=
 =?utf-8?B?dzZ6RS9lTFhhY2xvT1RSM0FrRERWQ01uaU5LRVRKTWZONmlkeDM3MU5qNjNC?=
 =?utf-8?B?elNxQmdJZWY1Vld6R0VUT1ZGcXF0NGdibktRN25QbWF5MkNjUGttWTJWeVYv?=
 =?utf-8?B?OWM5OWdBRE0xVTBRL1VkTURvNGc1UWxINlRZT3IrYnltd1NtdkRNMXdMM0Fk?=
 =?utf-8?B?ZVNJODNWblptOExnWmUzMlZkbFdQS29PNm0vSXNmcHgyS2ZtR0hyYkR4b3VU?=
 =?utf-8?B?RHhSTTdvVy8rZEFJMm56TzlYdy95YTQrTnhwQk9TYXRDb2l6ZWh6NkM0bHMv?=
 =?utf-8?B?cU83WldSUlJYSkJvMGljb3pCdElsZVI0SHptV1VaUGU5R0JHRDBOcUlYd0tZ?=
 =?utf-8?Q?PaaZisuOSrcmAOn6/QpPsuYC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b97fb21-c91f-428e-5588-08db18f1bfb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:37:58.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FI1osdYIyrdJ8jFgjyf4NwyHM4wB4Qer8VvNn6hFkZijBr48QAzKIqY25jOkSSGnZJVu7ywOC4Hr/Qn5DBiQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/23 22:37, Pierre-Louis Bossart wrote:
>
> On 2/27/23 10:48, Vijendar Mukunda wrote:
>> Add pm_prepare callback and System level pm ops support for
>> AMD SoundWire manager driver.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> seems like you missed my comments in
> https://lore.kernel.org/alsa-devel/7d32d552-6ca0-3c40-11ce-c8d727cadc05@linux.intel.com/
you missed my mail in reply thread. That's why we couldn't
get a chance to check your review comments.
>
>> ---
>>  drivers/soundwire/amd_manager.c | 89 +++++++++++++++++++++++++++++++++
>>  1 file changed, 89 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 88f0ad7ea7ec..5337443d9aea 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1141,6 +1141,93 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
>>  	return 0;
>>  }
>>  
>> +static int amd_resume_child_device(struct device *dev, void *data)
>> +{
>> +	int ret;
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +
    will fix inverting above two lines.
>> +	if (!slave->probed) {
>> +		dev_dbg(dev, "skipping device, no probed driver\n");
>> +		return 0;
>> +	}
>> +	if (!slave->dev_num_sticky) {
>> +		dev_dbg(dev, "skipping device, never detected on bus\n");
>> +		return 0;
>> +	}
>> +	if (!pm_runtime_suspended(dev))
>> +		return 0;
This will break when multiple peripheral devices connected
over the same link and any of the peripheral devices is active.
As amd_resume_child_device() will check for each peripheral
device on the bus. We want to resume peripheral devices,
which are runtime suspended. Rest of it, it should return 0
so that it could continue the iteration for the bus.

The other way we can fix it by always return 0 from
amd_resume_child_device(). In this case no need to check
whether device is runtime suspended or not.
>> +	ret = pm_request_resume(dev);
> I think it's just better to let the pm_runtime framework deal with the
> states than do this is two steps.
>
>> +	if (ret < 0)
>> +		dev_err(dev, "pm_request_resume failed: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __maybe_unused amd_pm_prepare(struct device *dev)
>> +{
>> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &amd_manager->bus;
>> +	int ret;
>> +
>> +	if (bus->prop.hw_disabled) {
>> +		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +	/*
>> +	 * When multiple peripheral devices connected over the same link, if SoundWire manager
>> +	 * device is not in runtime suspend state, observed that device alerts are missing
>> +	 * without pm_prepare on AMD platforms in clockstop mode0.
>> +	 */
>> +	if (pm_runtime_suspended(dev) && amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = pm_request_resume(dev);
> same here.
will check.
>> +		if (ret < 0) {
>> +			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
>> +			return 0;
>> +		}
>> +	}
>> +	/* To force peripheral devices to system level suspend state, resume the devices
>> +	 * from runtime suspend state first. Without that unable to dispatch the alert
>> +	 * status to peripheral driver during system level resume as they are in runtime
>> +	 * suspend state.
>> +	 */
>> +	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
>> +	if (ret < 0)
>> +		dev_err(dev, "amd_resume_child_device failed: %d\n", ret);
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused amd_suspend(struct device *dev)
>> +{
>> +	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
>> +	struct sdw_bus *bus = &amd_manager->bus;
>> +	int ret;
>> +
>> +	if (bus->prop.hw_disabled) {
>> +		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
>> +			bus->link_id);
>> +		return 0;
>> +	}
>> +
>> +	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>> +		ret = amd_sdw_clock_stop(amd_manager);
>> +		if (ret)
>> +			return ret;
will fix it.
>> +	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>> +		/*
>> +		 * As per hardware programming sequence on AMD platforms,
>> +		 * clock stop should be invoked first before powering-off
>> +		 */
>> +		ret = amd_sdw_clock_stop(amd_manager);
>> +		if (ret)
>> +			return ret;
>> +		ret = amd_deinit_sdw_manager(amd_manager);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int __maybe_unused amd_suspend_runtime(struct device *dev)
>>  {
>>  	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
>> @@ -1213,6 +1300,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops amd_pm = {
>> +	.prepare = amd_pm_prepare,
>> +	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
>>  	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
>>  };
>>  


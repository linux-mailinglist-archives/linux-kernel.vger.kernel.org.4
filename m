Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82870D3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjEWGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjEWGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:20:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776419B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSOTo3/fH0J6y8meKgfH51X1Vt9gs195cPsGZPpAlrK7S02tzh0Q+/gV/KaY8AY20CS3/A6lLNZxlJOXP2/m8G05eAmxnh89SYy6A+QkdMrwK53FjcDH7/j5cnu2r+86IMAHfzg8jk+gqVFweMr1VvxVH/omK1uU+t9v8c+9d3MXXTD1/TDqRpdKMtxgz3btsbBEDs2s3newKGtwpIeJIl9/e8IpwHlRrPMx1BPqJ5drekRkmOEW3CHQJ9Zjh82NvetM4129aNv0sBfmoUTsRo0IY6cI6Yn7Jv9v/m2KzaOKzlRiGTj+WZmzRYLT/QP5zG0OttPaynr+jN/yKq5jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrE+USzOXNuOWpnjQGp6cI4jm3V+ougno7uSCbDqVR0=;
 b=cN9SKepG2IJ1gVzSNJpNdtROnRKbYW+asw7rixz13ywM5/+spa9+wOp7FiZkZY8oQBY4v41yPFAreYbNcDov7nQOVzRvwNOBRCx+D87AD79JJRAReaRlEj+E8P52EwnQeNibu/g9RGKtoBpEEkDrZGnnVyL0daVnpUyZ1nDjJqBD7FrxahcFaaiRcJx8ejIYC2w8/MeOSJ0OVGitiPdJ28O4e4XTE44gvulYtbhxiD4h9HDshtQa0/o/Q4tpyAWVpDxShxFvVXtNK5x7tNNRw6C2QtTv+vZLOnVD2I2wL8LRhzBQaTiX6IRv14LGET+LmXbBY0nH/DMZPEPow1QVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrE+USzOXNuOWpnjQGp6cI4jm3V+ougno7uSCbDqVR0=;
 b=tZBARZJF1ZztefeQJQSe7CSp2ex7JbYrwAEnAdTMvbTGXO6keXzGEb2ivaaIY9E8ELOZBRIQSr5FGBrDTRYt3Iu7wi88OldoWTHgsrWz+wVz0RFWZuV2hpONzC20H6/c64xzRM13ejeiFAdFZQ57mb8KEyjXbQE2ATDF/lvhiNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:20:26 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:20:26 +0000
Message-ID: <a9723614-2ee8-279c-8a95-28535ca47709@amd.com>
Date:   Tue, 23 May 2023 11:55:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/9] ASoC: amd: ps: create platform devices based on
 acp config
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-2-Vijendar.Mukunda@amd.com>
 <1d73963a-de26-a147-6ccb-e5c8c65f579b@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <1d73963a-de26-a147-6ccb-e5c8c65f579b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: d465fff1-701b-4717-42cf-08db5b55cbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoNzUq0x5NJJqCDdnkUYweyPTv8ZEhTXjFY+v2BgbnPj5+FLhQzUH/dkkmeDz2dMQhUdwL36d9Q2N+A8/f2gO36Gi78Qo0iDAL2i7+ZOMrL2EB0xL7LLqALhXrc83LTlXS9TgIchutnRFjdB2t+lUHQTu2IbgUnuAPnmGnVrC/UsfhK8Ocw5dQcDsd5awCAFl6AjIcEmM85W4GHLfNgjUuLPDeaLeYu7/TZbo6sK2MaBw8J5g2Bd2YZV7hNP/l5r3v8XhTIO/b4NKb+tb/0F5DRNRxTERCKWc4Inl3sUfLHUioHRSe3a62fSpnZvRDgOz8cuKrZ7B6Q3VFOjB0E2lXUfcFrU+Pl1B8apw+hdnOEaZIl5ZHglMdT9tzwIgItQ3Yp3We3u68C297FfEInrFdpHGZCgZs4fb1lHpwh2oChBLsDRBcvpR8r5wXRDVWkEGsgQf3Kg0j/auaHnLJ9waiqnSu4T1/lDq01ZSwUNUoT+wKSODzGYWHagjhPRiBn2quVzDwiuuIEzlW1cehdV76y5Rc7sY/FwTDUUlUHIQcQK3dWGCKgXqALKSxPFHa7X9kXKUS23QyUHlZhL9xC+wEzXg4q1o6unLQ4R1O6czWn0YqQ0djwCpCbu1MlZ0mfBraPn8Pe85OyHAc7+j9tNgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(186003)(53546011)(6512007)(6506007)(31696002)(2616005)(86362001)(26005)(38100700002)(83380400001)(6666004)(41300700001)(6486002)(66476007)(66556008)(66946007)(316002)(478600001)(36756003)(4326008)(54906003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhQekQ2TFZQY1lrZnUzRVA4dXNzT0s4WFc5bG5CYjN4S2dBWmd4YWtJMTJn?=
 =?utf-8?B?T1dpaElQSUp2NVo2bU9JTUhHZU9VYW9QV2FKMzV1U3E4K1loeHA0dDY4OXQ5?=
 =?utf-8?B?eTNtaWZSMG9vanB6RVI3ZGJ0THpsREpoTVBpR0txL3hrdU5hcmJlK3RTckZK?=
 =?utf-8?B?bllGOHQvN1pPMS9uR1EvcThpeXRLR0pPaE5rUm5zZVV6TERNNXFRNmVFSTFR?=
 =?utf-8?B?c1RtODZIQjhWWk5sbTNTa09KN0l4M2hhYVNuRnBvTzM4R3hoUmlUVDNMM013?=
 =?utf-8?B?dWZrbExIKzYzQXBwbXM0czIybTV2QWJudVQyblNpOUR4anFxcEFhMXRxTXVP?=
 =?utf-8?B?UU5oVzBHVjAvZnR4Q1FjWkFJUjBTNFNOaXZ3bEZhK2x4bC9ML21CYnVHMldS?=
 =?utf-8?B?aXhuQ054dWVWQmZqWGpxYmFoY0Zsb1lsSGFLcWdnQWRBWmUzeWVnTkkvbmxO?=
 =?utf-8?B?NStPSHU2ZHJxdmxBcUFCZXdsRFo4SEtPRnNKdkIyeHlXK1l1VlNIVnczdmN4?=
 =?utf-8?B?WUhvR2tJVzhkRUNmNXFlbzVQK3c5S0VIMHR4a1VnRHVMbGtlQXVqQ0xKcDYz?=
 =?utf-8?B?cG4zZVplS0t3WURXSGJjS3NiSjhWekJ1VHBuVnVSWGR6KzBtZHFuRUJFMG10?=
 =?utf-8?B?OHI5dnFUazA2VFJldkVoNnZlM1pqSVUxQ3JlQWttNFRXK244Wm1GQllHUFZQ?=
 =?utf-8?B?dXRaSW5ZbmtHYmpBZnRRbllFSllZWGgwVjFFdnE3ZE1mN01ic2k5V0NlRFpQ?=
 =?utf-8?B?MFdnZTg3MWlsTUdJWk91RVg1NEZCTk1xWWhPQ0RlbGJTNk0yWkIvUnhrVjdH?=
 =?utf-8?B?M2Ixa2l5eEVlaGxXdjJCR2RNWmNIcXdXQVBSMDMzZXBpVFVvVU5rTzVyaGZH?=
 =?utf-8?B?MzVRaEtidEFhaU93MFZndkIraERqdmdmbkhvMUs5eXFYWEo1U2hFV21YQ3Rl?=
 =?utf-8?B?VEo1dzFRQllYbjlnNjk1TDV5VlU3WjQvOXJPVXRyWTU4b3BvQ3pKb0NPVTRp?=
 =?utf-8?B?YTZoQTlYUndHOXVRWHgraHpiOEhTZjRMTDZROUZkQ0pUUnViQ3FtcVpvYTJx?=
 =?utf-8?B?NEFUSUFabVd2bC9ZUmVabmoxdkRRenU3eUdkM3RJRTB3cXRVMWNRWHJWSmkz?=
 =?utf-8?B?elMzT2lZZGlMcTI0dWQwQTFJM0gyWHpzUjJVNHc2ZWJrSWp3MEJOU0dEcTJZ?=
 =?utf-8?B?V2NWWEhOVm9vQlVtRkZydzViajhJT2ZTT1FBQzZDdDFaSGRJQlhwSS85aVBs?=
 =?utf-8?B?Qjd2Q1R5aG9ZZnR6OXF3blZuM3RpdG9XZmcrUWYyY3phQTBsVTNoY2hQTGNB?=
 =?utf-8?B?bHg1bTRBYWJ5K0ZKUUpDczJPbGxtRVdHOVd1eGl2cGMyR29NU0xxcHI0WFFD?=
 =?utf-8?B?TG1NczJLaUtSYWFIbEZackRhMXAyUFFaQTlnMWphYTFPRjJhZm1DNGtldTh1?=
 =?utf-8?B?eU9vVXM4dUVnMnJSL3RrUm5HT29uYmhKTW1sL0REOUVaVm5KeVdCc3oyZFpp?=
 =?utf-8?B?NWpobmdxUTVHQ2QvUDFYTG8zdzBkZWNucHFPb0pCUUN1M2x5ajA5bzV2akw1?=
 =?utf-8?B?c3dBNFMvc28vQTE0aXY2OE11bUlTSFZjQWhzaTh6MTdjYWhrNFFrRDJmUFBp?=
 =?utf-8?B?N00xblFCa3BPemh5emJIaXN0K0hWVDhGRTNvQWVHSngzVzRja2FiRHBteVd5?=
 =?utf-8?B?bXZ4RldkK0xiZld6MWMrcUV5a1d2eHVFUDFEVnlZS2JlSWpiRVZ5TjcxVTZm?=
 =?utf-8?B?MVJySzNpa1lsSWpnSTMveGV1eVVqR29LSVFQd1c4UWNyaVZyYWJLOU5Yc0JB?=
 =?utf-8?B?UEsvQWxQbE9uZUVwK0VPSXpPTTQ3eDdZVnJPYzRSKzh6dDRUVWx1SWdLVWVJ?=
 =?utf-8?B?N1JiR1U4dzQ3NDBUQmNDcU5yeWg5SzZSNnNzaDh5dnBxTGt4dnphVklWcHNo?=
 =?utf-8?B?amVUZGxzNGZHTXlhSFdmWjcrUE43cWs5OEFZT21PdTYvUTdUUjEyQldzTmNF?=
 =?utf-8?B?RkhnNDR1SElrR2ljSXdnSm1QWVdEc3FmeUtXYjFmTlNKZXBzS05WUmVpZjM2?=
 =?utf-8?B?OCtPcVdlNTNqZWRYTmdrYjNNcnRGc3Q3SHBSVHJmMHJ2RE9BR2JVb1k5aTNP?=
 =?utf-8?Q?+MkTbOw9+MTtH+jJNmq45veOr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d465fff1-701b-4717-42cf-08db5b55cbe6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:20:25.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUvsmCl7VkMI4W0Azgids5t3zb03Ydp5N42gTMfgpREZU/unsTl0b+g7mJ/eLYRwbhdMt0/aIMBJ0515gDruPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/23 21:46, Pierre-Louis Bossart wrote:
>> +static int sdw_amd_scan_controller(struct device *dev)
>> +{
>> +	struct acp63_dev_data *acp_data;
>> +	struct fwnode_handle *link;
>> +	char name[32];
>> +	u32 sdw_manager_bitmap;
>> +	u8 count = 0;
>> +	u32 acp_sdw_power_mode = 0;
>> +	int index;
>> +	int ret;
>> +
>> +	acp_data = dev_get_drvdata(dev);
>> +	acp_data->acp_reset = true;
>> +	/* Found controller, find links supported */
>> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>> +					     &sdw_manager_bitmap, 1);
>> +
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>> +		return -EINVAL;
>> +	}
>> +	count = hweight32(sdw_manager_bitmap);
>> +	/* Check count is within bounds */
>> +	if (count > AMD_SDW_MAX_MANAGERS) {
>> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!count) {
>> +		dev_dbg(dev, "No SoundWire Managers detected\n");
>> +		return -EINVAL;
>> +	}
>> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
>> +	acp_data->sdw_manager_count = count;
>> +	for (index = 0; index < count; index++) {
>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +		if (!link) {
>> +			dev_err(dev, "Manager node %s not found\n", name);
>> +			return -EIO;
>> +		}
>> +
>> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
>> +					 &acp_sdw_power_mode);
> What happens if this property is not found or doesn't exist?
>
> acp_sdw_power_mode is zero, so....
>
If acp_sdw_power_mode is zero then ACP PCI driver won't apply
ACP de-init sequence while entering D3 state.

It's a miss. loop should exit when property is not found.
will modify the code.
>> +		/*
>> +		 * when SoundWire configuration is selected from acp pin config,
>> +		 * based on manager instances count, acp init/de-init sequence should be
>> +		 * executed as part of PM ops only when Bus reset is applied for the active
>> +		 * SoundWire manager instances.
>> +		 */
>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
>> +			acp_data->acp_reset = false;
> ... here this branch is taken.
>
> Is this intentional?
This loop should be exited if acp_sdw_power_mode is not set to power off mode.
will modify code.
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>  {
>>  	struct acpi_device *dmic_dev;
>> +	struct acpi_device *sdw_dev;
>>  	const union acpi_object *obj;
>>  	bool is_dmic_dev = false;
> useless init
We are checking is_dmic_dev & is_sdw_dev flags in same code.
Either we need to explicitly update value as false when no ACP PDM
/SoundWire manager instances not found.
>
>> +	bool is_sdw_dev = false;
> and useless init as well...
>
>> +	int ret;
>>  
>>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>  	if (dmic_dev) {
>> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>>  					   ACPI_TYPE_INTEGER, &obj) &&
>>  					   obj->integer.value == ACP_DMIC_DEV)
>>  			is_dmic_dev = true;
>>  	}
>>  
>> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
>> +	if (sdw_dev) {
>> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
>> +		ret = sdw_amd_scan_controller(&pci->dev);
>> +		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
>> +		if (!ret)
>> +			is_sdw_dev = true;
> sdw_amd_scan_controller() can return -EINVAL, how is this handled?
> Shouldn't you stop execution and return here in the < 0 case?
As per our design, ACP PCI driver probe should be successful, even
there are no ACP PDM or Soundwire Manager instance configuration
related platform devices.

The ACP PCI driver is multi-use and that even if SoundWire manager
instances or PDM controller is not found, it will still be used to set the
hardware to proper low power states. i.e ACP should enter D3 state
after successful execution of probe sequence.
>
>> +	}
>> +
>> +	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>>  	switch (config) {
>> -	case ACP_CONFIG_0:
>> -	case ACP_CONFIG_1:
>> +	case ACP_CONFIG_4:
>> +	case ACP_CONFIG_5:
>> +	case ACP_CONFIG_10:
>> +	case ACP_CONFIG_11:
>> +		if (is_dmic_dev) {
>> +			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>> +			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>> +		}
>> +		break;
>>  	case ACP_CONFIG_2:
>>  	case ACP_CONFIG_3:
>> -	case ACP_CONFIG_9:
>> -	case ACP_CONFIG_15:
>> -		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>> +		if (is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +		}
>>  		break;
>> -	default:
>> -		if (is_dmic_dev) {
>> +	case ACP_CONFIG_6:
>> +	case ACP_CONFIG_7:
>> +	case ACP_CONFIG_12:
>> +	case ACP_CONFIG_8:
>> +	case ACP_CONFIG_13:
>> +	case ACP_CONFIG_14:
>> +		if (is_dmic_dev && is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +		} else if (is_dmic_dev) {
>>  			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>>  			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>> +		} else if (is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>>  		}
>>  		break;
>> +	default:
>> +		break;
>>  	}
>> +	return 0;
>>  }
>>  		dev_err(&pci->dev, "ACP platform devices creation failed\n");


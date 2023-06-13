Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C772D966
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjFMFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjFMFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:41:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AE2125
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Q+MPFFFE0KRQZziumZSirzyZT4ZRBr8JCYoOkUmpB0CJf4h25FYDCfxd3BUZU9NuzMTblpBDQSuUn/567pcMKpesPG7NJmfjV7TJUPo9IJxA9F35NX5TYT79oO/Nalx3hXpRnXV1SSrW0Pb/EcLwOtCuGOtD+5WBiwPMYFXDWKQ3vFbtKBoMHq14PbblFnj8Yg7ypUB3L7i/6n9LVWHaLNF6H/pe7I4Jpi6awSrhHVtkX0b0URY9qz0Jz5470kAThKrlDbblZ+KrbxEfMzeiGdZDoOWcx0q/pjgIwjDYeqaXmS5hOV+9cN0ciVki2VXEaplyX3bNXGalqYNOOkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc2A++/yIdKOoFtnTlOciV4dUuOwz3h03Ml3nb9hrAg=;
 b=OM1T4GoX9kFK96J338NROcmVMwZC6C9O3/vsd3Qfm8G8AXlPUngc1IVmFR8kot3TtSda5xwwoCrxbBsB8INDwZN0Eemdl/BTz0nx48rrjI3YrqvG2te5elPp1+vy+BtXnXfYM9TJgEhSZ6RN+OVhjWi3Q5KSBeK63+ASYP26IBonuo1kHTiKAOkFXwhaJZaQi2UJACSQ4Gk2P6mW2RK1zSlghOrhfkkL5AK2s4/6LPpVG2+CRFsbAWUc+Xy+ESTsXRPiutMPvOQ26xfoKCF9YEQueX+gfBAt27xhgW4rJcztB6wiFHxVxukBaOFmjXKrNmiyw1Br366wx1Vmav8FxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc2A++/yIdKOoFtnTlOciV4dUuOwz3h03Ml3nb9hrAg=;
 b=A0E7dUuBZYG4mAPCVSrdcDMp1TlunkSwzicG7ZPprZlRoql4emvK7jBcLeG9V/vispSjLuZ+TuWaDeBg8OZRoc+lzHX8s0fzwdfAI09tnFIKdqZVkjy+GEv+phBh0+ukjtqeRdADOl0GnujOAuajrn8/qS6LLV8mU8Uf7AMl7dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 05:38:12 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 05:38:12 +0000
Message-ID: <cd465394-5a19-239e-7aad-caa6f19b0918@amd.com>
Date:   Tue, 13 Jun 2023 11:12:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 1/9] ASoC: amd: ps: create platform devices based on
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
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-2-Vijendar.Mukunda@amd.com>
 <5899c2b8-e984-fda9-5e12-190b0c9fd3b2@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <5899c2b8-e984-fda9-5e12-190b0c9fd3b2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 07adaf65-23f6-4da2-e429-08db6bd06083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1DTDyp56EuH+gIrh3vYU1vorUAj7mwC87T+zV4IBP3mgsKLu7acvF2y/HpYlBsKHNnjYQ1bqOWoOcqS/mHU7X5ifgBDteyf+eF9JvgmEEJhUA5F86g/ataco30cR3pojsLYT7bPb/KLszsL20GmUHnJ/BQxL/rdKoC/5MQohGSdF6FhYAozlYCq7XDj2Yv8wDZY5xnSVeZ1LjgQeE4kakUZVbovjq8vYyd7DCyKHbqP1cePqirCov2JlRF1kmw0NZBPAxybZzbvxu3AvjZEW9ge6wR1ZygzlFWk/dBK0pP2LoM/8XfvU6HflJADNUi3co+HsafHpBf3XW0DLMiQoFGNk2QZAdQciwU1RQoBUqzDDC1wkTa61TRbtmrpARA1Vl6ISdisdiu0P0+McsWbf0Ag6rrrm0f6tIyeTRM/n4ymqxuKY41amgWiYOv2PtWFQjoMizeTg8SPxrsV7Q1Zpl414eVEYGwocZ2KefDhZbQIVs5g28hS9dGqQa1nwyrIrRuz8XBRqkgk7YCDcxt9PIPsJnLEzwW7oyUaP2oHJM2VkK0Lr3KZQIseZ3NKoGBtqCBa9p+/fxy6FdgvMpElN1Ftr/nRPDnl9TWftzdccntfS6y9p+sQ17eOAFmvnZyyFtFGlnoA2Ku2Oqw1FC/9JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(31686004)(66556008)(66476007)(66946007)(6666004)(316002)(4326008)(54906003)(478600001)(31696002)(86362001)(36756003)(6512007)(6506007)(26005)(83380400001)(53546011)(186003)(5660300002)(8936002)(2906002)(8676002)(6486002)(41300700001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJVMkJtdHFTYWNGRFozVFp4MDJMRHA3eXVaYW5sR0VDQnFTSHF5VG9LZDZN?=
 =?utf-8?B?WktURXZienB2TkdvNHdyZkxlaU9ySTlpYm1wamhIQXhuTEVQWW5vaFR3SDFm?=
 =?utf-8?B?cDNGYjBhTCt4Yk1iQ0hacWJmZ3NNanJlU3V1czVMc0xCNUloYlFmWmdKUDdE?=
 =?utf-8?B?dW0vbEdZcHRxb2xZcEI3SjROOC9mQ3N1eERGK0dPck9jRnJvZFVDTTBVK0NS?=
 =?utf-8?B?cFFlc2JodGgzeDRoTU5tUW9IT2dDaWIvTmxFRU5LUDhFNllLN2xzZGVaU0lj?=
 =?utf-8?B?azlyWU1FQWNJNjFTRHdOWHRhbmhNRUhBZ3czUmZaZHliYkJwYTdoWmNoNHU5?=
 =?utf-8?B?M25EMXMyWHR6MXpmdHRxOW84N2tza2R2SjNSZTJqeVhYeDNKcm55cWF1b2N1?=
 =?utf-8?B?azY1L0hBcmlLNnFOWDhKeE5ZRm9DajFXM0V3Y0NURlZoQmZQSHdIR2tJTmtS?=
 =?utf-8?B?cTk1cXZXb3huV0RnV1BST2wwRWdCOFZmcnMvK1c4UWxNSHhlbmZvU3liTzhU?=
 =?utf-8?B?a2YwMTF1OGo2WmxRaU5RVDhISWZpdkJpYzgxK2N2ZG9zcVVwV1Nnd3YyVmdL?=
 =?utf-8?B?NFN1ZVoyQmFRd3ZHSXplaU14MFVDYXd1Z0o0bTZBYnBXdGNJS1hHYzNlZkhQ?=
 =?utf-8?B?Yjd4a3grdS9QYTl2dEUvUTZzRXFVWUdSR0phTHBiOVdsVTR1ZG1CeEk0djdZ?=
 =?utf-8?B?aGpmTDlwa2NqR2QwcFZJY2tZaExvVERyaS9pVVR1RlFXWTY2Z3pmWi9iQzVE?=
 =?utf-8?B?elM4ajBhbG9hMStIaGdlN2NTcWFMcVUzaTllVWhkaU84aUZxajMvRGVPcVVB?=
 =?utf-8?B?YURwNTZwSVA0K2VzaEErOCtoSVIzNVMxYXBQcFJqQjVEbGxnbHQxODJ4UFdZ?=
 =?utf-8?B?UnhCa2Z0YUJLUEdVOUV3NXI5T0w4djFualoyTFFOQnp6REpiQ3hIYlM1RVFH?=
 =?utf-8?B?OE8xYzhJV2drMWJWVUNLQ295TnRHR2d5dXF6RVp2WnhzNGF6ZHliY0pkNnRY?=
 =?utf-8?B?TWk5ZEY5K2FobjZ3bDhqRVp3Z2ZJWlJQeFZZU1VsbGRPKzN5L2VyWi9vb2R5?=
 =?utf-8?B?NUlBYWd1RHNwVVJCREZDMFd3dno5eER4UUtZL2N1Tmpta2FoT3R5Z1cyNUdX?=
 =?utf-8?B?SmE4OG1sR0N4YklHRTVLYmcxNkRnRnkrMWdvVGVPUVZlL2t4cktIUEhrY2VQ?=
 =?utf-8?B?QzJTcmpHNUs3TzdOaUlvN0dGSERBNWMxQnpNeDNkVFJ5eFRNTXN0MTE4aGd4?=
 =?utf-8?B?dkhNMWYxUlc1cUVhMHZjR3Nkb1M5S3RHa2RmdTlkN3MxbStRaG1RcmgrcC9r?=
 =?utf-8?B?NjRZd01CZ0xzMS81MldjSkliYzVhMEVMSUIvdFMzM3M2M0ZpTEZUdDBIZDV1?=
 =?utf-8?B?alpNditlWHBZSHR5aW9GMnBUSWVhSmw3MDY3YVJTeXJVOGdXM0JNTk9LOVU4?=
 =?utf-8?B?cVZEZU5ZdWZkRXozZTNmcWtESWMwZHN2QnhYdnI3Z3Fhck1meG9zUk94TnpP?=
 =?utf-8?B?ZXFVbERpYXQvZGUrUUFzZjVIbkhqTFNnM2NSOUpXY1lCSWJhYWd4QWFKaXJ3?=
 =?utf-8?B?eHdPUHhma0IvbXpmbU1qWXczSUNlNnZBcWZkeWZGTnN0SGdJWDk3M3MzeVRJ?=
 =?utf-8?B?TXAvU08yNUF4T3h2QjFReGVrZERPYTU2ZWxJcy9XbWtRK0sxMmJHNi9tb2Jh?=
 =?utf-8?B?NkNLR21vR1JZcktuczI5K3E2UnFpYUhGYzFRQ01Ua01HWkFPWTd4MFF3YUpS?=
 =?utf-8?B?a1hhZi9lNlphSXJzUDdISEg0b2JjOG42WFRraGI3UU1ZL3M4cnhoR0xCempO?=
 =?utf-8?B?R2xFaXlveFMzaDNYVVR5ZmtoY1JzQnhveVVFSVJJS0JydHRTUmZ4WkRncFJN?=
 =?utf-8?B?b3lqTUN0NUFFSW1EVE84RllRQlFkd0VQenk0Y3ZwY3NiazVIVEpobGVrWkZv?=
 =?utf-8?B?VVJIMm51aFQyOEl1TDJuV1VXTFpQUGhDeVh1OC9yOGRySHgzUUdUUmhaVDZy?=
 =?utf-8?B?alM5Nk9IUlUxQ0VVSjVsRmxnMyt1bC90M2E5VzExQVNNR3RySFZWVjlnSzNm?=
 =?utf-8?B?R3ZHbU9NV2I5bE9YQnFmNGVGb2NBTTFYcnNXSFZFNXZsdGpGYXVaM01vN1M3?=
 =?utf-8?Q?moLRM4Ui2v/pOWd7YtzeiHdWL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07adaf65-23f6-4da2-e429-08db6bd06083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:38:12.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92dirfgRufbzS0tpcozECo6ov6eRXclVBQBk5V0b4NYpjVJNMg1SKgQnjx3o3y3ABrjrzm6nboGz9/f3YDPaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

On 12/06/23 23:39, Pierre-Louis Bossart wrote:
> =
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
>> +	/*
>> +	 * Current implementation is based on MIPI DisCo 2.0 spec.
>> +	 * Found controller, find links supported.
>> +	 */
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
> nit-pick: the count is not enough, you should also check that only bits
> 0 and 1 are set in mipi-sdw-manager-list...
As per our design for PS platform,
we will go with two bit map values as 0x03 and 0x01.
1. As per ACP PIN CONFIG, we support Single SDW Manager instance
which refers to SW0 manager instance. For this, we need to use bitmap
value as 0x01.
2. Other bit map value - 0x03 will be used to populate two SoundWire
manager instances.
We have extra sub property "amd-sdw-enable" to invoke the init sequence
for SoundWire manager.

As we are supporting two bit map value combinations here, it's not required
to check bit set value. count value is enough to know manager instance count.
It doesn't break anything.

>> +
>> +	if (!count) {
>> +		dev_dbg(dev, "No SoundWire Managers detected\n");
>> +		return -EINVAL;
>> +	}
>> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
>> +	acp_data->sdw_manager_count = count;
>> +	for (index = 0; index < count; index++) {
>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
> ... otherwise this will be wrong.
>
>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +		if (!link) {
>> +			dev_err(dev, "Manager node %s not found\n", name);
>> +			return -EIO;
>> +		}
>> +
>> +		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
>> +		if (ret)
>> +			return ret;
>> +		/*
>> +		 * when SoundWire configuration is selected from acp pin config,
>> +		 * based on manager instances count, acp init/de-init sequence should be
>> +		 * executed as part of PM ops only when Bus reset is applied for the active
>> +		 * SoundWire manager instances.
>> +		 */
>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
>> +			acp_data->acp_reset = false;
>> +			return 0;
>> +		}
>> +	}
>> +	return 0;
>> +}


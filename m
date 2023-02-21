Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7D69E91C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBUUsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBUUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:47:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD6B744
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+qnsHBuTIu8bb+sTcgsSwFrMenTo6asof++Uew8T2w1vKDwq/5MysJ1b7WluPrEUcxb7+Rhu4kARP09XOYW2v2xGBcX81HOthPvVc6ByKS3H88WC0qpURlfH4soO04ab2TR9YbdnKeyHi1mkY2DngTc0DFi2yVw1tkgMqacdMuIWO08H+m+UmRFzhjk/8dBwojRwSn7fNvebnZUAkKywjBi4dVZJVEVhcufzLF2Wz2b+yqE092TkfiTVsHfliuz8icO9JpWcXP1S+fZ804pkr+UqMMlkGQOmIfeI8s9YH4GJJZNGBA+f7nFiLMlOTGR3pT9RWEZDBkjz5mBKmI4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALm2bP+8P5+QDf0wauYaXvE7fmf67hteSP+uGQBegj4=;
 b=Y8CbJ9MVcu0/1KrogI24ZbHub0pYkZEe7CsIUu0MO5ErHQUL20W5NPcBwlgBC5kZhEnp4mUsEzOgTbU6czqdistnPAZtuCFPBVKbpbqreGzsqZWAmTbQGBdxCEXXu8wk2kYlzH+uTbxxTw+HWQD0b365R0wiADE8GVcP8L1anorSiZINdBvdzKjxAH2Oq4gePoY5q+S7mqSPv40i/Irg0AE6o2Mnr6uE5g9QJvGri2FKj8E53w3+kqj1RpnKY28AwFXU3fsFeHDkCEaUy63l8Kx+KrgL+OMGUn5yNAvYfb4MB19wJwS1YwQ7g00RgzLF3ncEtZfS0hEvjcrSa8iZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALm2bP+8P5+QDf0wauYaXvE7fmf67hteSP+uGQBegj4=;
 b=lChIhNujM2dAk/pVL4QHR7SSLrRlPpYp+/Np9fhPO2kziKyt2SPma0cnTD5Z/uHlDQmVKsVlSlCzU7lo/XsdM/pP3/PNSX6az6Af6J0NXiCNXWIUfhIQYzziHmZYS6FEcI8Ea3/O4kJF7FHaaKbSweFGYSqGIqg70vG8/gPS3Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 20:47:55 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:47:55 +0000
Message-ID: <db9b7a9c-7067-a955-ce4c-52bbf374bb59@amd.com>
Date:   Wed, 22 Feb 2023 02:20:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 6/8] soundwire: amd: add runtime pm ops for AMD
 SoundWire manager driver
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
 <20230220100418.76754-7-Vijendar.Mukunda@amd.com>
 <72b601b9-93bf-b9f5-c898-c63ad46e5167@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <72b601b9-93bf-b9f5-c898-c63ad46e5167@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bbe9ad-14e5-4f5f-1bff-08db144ce81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIa3qBMA9k7O2ZmMG8ovOoVx5D32QM1MpSF0G+Oem64GMwvlT597nfRcMICxCnxnkujE8HO4kYf5ne6TnYolmeYs7B2wDY5TfZyDclrzU5okdOvk5sB+fuY6O6QCYDuirMIWLKZQhQXeJjiBfioyWQGCx5IxN9k0FnZ7EYH/QgCsWvSzkUG/Q4HXwDAce5oKPmVwlc4SlooRBVNOAXGUWBrF31TStfG5hM74XYQiXFf5uHPzYqKHUtODUkiT7Iza3bZ5f3bJYN2x+a102yHuH0809P4cXPcraQYBqzJMrw7d2NTdlpIwXGKUaRml/AGa9pQJRiYRmvsOjS9S4RMxK2MrbgSRjhPYU0wcfnqJaVIWsAELXJEiR1W09hgu6m9mdxOdsUejC9s9YMpSGUQUot3Z7ehb24PpTVvx5F5yR5r9IxJbhPe6zmSW6ZyK0BZ2Duk2y34AIH0h3QEh6FMIGhld6osMgDtXtxqxmd+cYVR1yjQuQi9CJNBWN1KsyNYyKQw/y4Csoid88AK1yE7IGEKgnpKcLb99+SDPhp010Y09oUdnpce/o12lP08Jx7fT6OBi+T/rdlIRLZeIq0E6Xv8svcu+D9NOHhu/8qRJm1uamjENZkFcBqHoujQWMsO1NxvZ2Pnq7MXiE9hBLby1wzmTsvADGK/ZmYTu3CdITJ6EfO/FEnbvwkLY+XTMfpYhmXhNiulwnhphfHvmpjC/FgVBy4nzlFSgURIcIEKjiXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199018)(4326008)(54906003)(316002)(6666004)(2616005)(38100700002)(2906002)(83380400001)(8676002)(53546011)(6512007)(478600001)(41300700001)(6506007)(26005)(66946007)(186003)(8936002)(36756003)(6486002)(86362001)(31696002)(66476007)(31686004)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hHK3hyb3lIZFQyOTdxTVZBTEtQVEpmejFyemo3ajJKbWFyTWZtbTNVc0tM?=
 =?utf-8?B?cEY2ZmVEaWJqNUtxbms2Tllhd1dRbWRQUU5UYVk2eEQ2enFpV2lORitrNDIv?=
 =?utf-8?B?V1MyVENtdmU0TVo3Q1pkYThqQlAraDhzUmxGaEYrR1BtbVNhSkZWc241Rk5N?=
 =?utf-8?B?KzE2VzlySHNOWmY3eDBNUnRVY0xxM3pIUnUzNWg2Wmc2RlR5cjR1TXRxQ1px?=
 =?utf-8?B?Yys2WW9PSk85Uk1XTElrM25JSnFYZlRKejgxaTFwZVpVaTVISENQazN6dUVC?=
 =?utf-8?B?VStENS80SHZtTDhlc2FPbEQxQnlmVzAxbzl5ZkFGMTlkUjB1dEtQWlQ2cnhx?=
 =?utf-8?B?ZExpTWI5M2NFdFJQb3M1a3hHUWhnYjQ4SmpQWVdDS2ZuN3JoNm9iZjd3Smgy?=
 =?utf-8?B?SlhQVHlHK0NIMlFUUmpjZ1ArT0JJNi9NVHVUTUNUbXBvRC9MTzV2aU1VcUtX?=
 =?utf-8?B?dHlCZnQ5bHJiNmx4WDBoS1QrdWF2N2NQQ08yaWJmL2RUcUp5cjRSY3pxWTVr?=
 =?utf-8?B?WnNadkNyZkxySVdad3FHTkgwdHdlSmZZOGVTaCt0d1o1aHVJcU5DVUJkVlZD?=
 =?utf-8?B?TFZtVGZ2ZEV3aGRJcDZKWmN5REdkTVhLV2ZMbmNuTzM5L3ZTUWdFcXlUT3M5?=
 =?utf-8?B?bUsrUEhpaEZjdHpHV1dlWkl0dEhqM2Y4RllPMGpINENBTjF3RWlObjkzWHd1?=
 =?utf-8?B?L2RGdnFuUkZiRCsvVGRUdXRnYjVnNk1MNDZYYVh6SFMvY0RUUlVVR3Zaa1JK?=
 =?utf-8?B?WGNRYWo1ejM1dXhqcUVGTWpPWlZHaFVVcnZkcXRFeHIrZlo1NWlyci9qaDdM?=
 =?utf-8?B?dFVhWFVwR0RVQ2FiRlgvanArY3JBem05dUlaaFJuV3JsOE4xbVdRSDd3NkFz?=
 =?utf-8?B?R1RNdG13UHJLOXVCeVUvR25qQjVxYTZoYW9ZQlJId0t1cUZzY1JhUGVnWVk4?=
 =?utf-8?B?NzllcnFucy9OUXl0bjJkVUtyckpBQk1nKzIzRHhZS1pwT2pvaUwyNE5jLy9m?=
 =?utf-8?B?SFFEakNwalhEU2ZrTktBajdtMnJYN3VsNGJVcnN2Z1JhbWpyZ3pXT1lZclBL?=
 =?utf-8?B?bERVbzczbStqcTcyT2hxc3paYUJteHphcmpFNi9XUHpWS2J4c1VyMnRzc0lW?=
 =?utf-8?B?NmY0SEhPSXNySDlTaXR1WTcxZk4yNzhVY0JpU1htNnJNWHp2NGJtZEg3Nzlw?=
 =?utf-8?B?ZFdUc0ZQdGhlR2kxNWp3dEZVRkhsL240UFBrWVZSZTdROFUySkVlZHBneFZZ?=
 =?utf-8?B?UVhLendaNlpiR1VhTWhjNVdFUHlGYmhMQ0dnNUdjc2F1WUpmajNpOEJ6bDJ3?=
 =?utf-8?B?N2Z4QnNoNmN2dU1jVEVQWUZqSnVYSERPbWRXK3FnRE9MbUhQbTg5SG9LVmoz?=
 =?utf-8?B?L2RSRmZIQjU5Y2tSdXl0QmVDVlRDa3NaU3JkS3pyUHI5SFZYb2FIRjVDM21p?=
 =?utf-8?B?NVkzMzRiZU1vWEpOQjRCbWVHWVU1TXc0SnZyZjNIdnlEaDg4WExLSTdZc25S?=
 =?utf-8?B?Z3E4QnhON203VFUwN1NQY2F4ZDZLUnZDMWlWemdWRzQyZGZxWVg0cmwxalh2?=
 =?utf-8?B?MVBrRU1RbEI4SE0wOStmK0VMM2IxQUpORGg4ZFRDNVNaWWFhNlk5bXdydlA1?=
 =?utf-8?B?OVJ6aEFJN1VNaUowRDB6MHZIY21MT2ZxdzFPeWdaVC91OXg4V1R4Um5nK0N6?=
 =?utf-8?B?TU1jd2NoV1c0ZDJmNGJiNHlCZXR4RXhrUlNMeFV0Qlg4SEw0aS8xaUViOGp1?=
 =?utf-8?B?Q244UmI3czFFNlVTdFFoSkNkTm55OHkvSHJiNzhXSW8wWVBSUGlWTkJZNThp?=
 =?utf-8?B?cE5SZ2JhaXVwL3RCZDJtd0x3UkVOY0NTSVVkRmVnK2ZtdytRekErMVlSd0hp?=
 =?utf-8?B?RUh0QXN2eTJRRndTeTkxYWZoaGZOR2NqcXkxRlJCL3BKRk1QMWJzNHAvSlFJ?=
 =?utf-8?B?eHIvQVVreURWRDk4Umh2aGRVKzNXQm9YMkVWNmtsMGxFOVF6dnJmT3NUcm5a?=
 =?utf-8?B?M3RlL1BHSDBSOElPbHIyZGdoMHkxV0Y4MFo4UDFsbk42VzgyNGF2MEREVVVx?=
 =?utf-8?B?VEE4R0tkL0RWYk1kdWhqdFpSUndUemhNME9EVWlBQnltakJlQW9MQStscUVI?=
 =?utf-8?Q?zFI03sp6Tos+xgr1hKLlRUrj1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bbe9ad-14e5-4f5f-1bff-08db144ce81d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 20:47:54.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJv8+S6KAhRl79YKNLGV3XastfyygjvBt4z/Mx3MSdLdlHcOmKqri5F9oFgVQbMyeQP+edLCFDR5lNrwbE2+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/23 21:40, Pierre-Louis Bossart wrote:
>> +static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	int ret;
>> +
>> +	amd_disable_sdw_interrupts(amd_manager);
>> +	ret = amd_disable_sdw_manager(amd_manager);
>> +	return ret;
> return amd_disable_sdw_manager(amd_manager); ?
will fix it.
>> +}
>> +static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +	u32 retry_count = 0;
>> +	int ret;
>> +
>> +	ret = sdw_bus_prep_clk_stop(&amd_manager->bus);
>> +	if (ret < 0 && ret != -ENODATA) {
>> +		dev_err(amd_manager->dev, "prepare clock stop failed %d", ret);
>> +		return 0;
>> +	}
>> +	ret = sdw_bus_clk_stop(&amd_manager->bus);
>> +	if (ret < 0 && ret != -ENODATA) {
>> +		dev_err(amd_manager->dev, "bus clock stop failed %d", ret);
>> +		return 0;
>> +	}
>> +
>> +	do {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> don't you need a minimal usleep_range to avoid re-reading the same
> register over and over?
>
> This is tied to the frame duration, isn't it? this is 20us typically.
I agree. will update the code with usleep_range(10,20)
>
>> +		if (val & AMD_SDW_CLK_STOP_DONE) {
>> +			amd_manager->clk_stopped = true;
>> +			break;
>> +		}
>> +	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
>> +
>> +	if (!amd_manager->clk_stopped) {
>> +		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
>> +		return 0;
>> +	}
>> +
>> +	if (amd_manager->wake_en_mask)
>> +		acp_reg_writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
>> +
>> +	dev_dbg(amd_manager->dev, "SDW%x clock stop successful\n", amd_manager->instance);
>> +	return 0;
>> +}
>> +
>> +static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
>> +{
>> +	int ret;
>> +	u32 val;
>> +	u32 retry_count = 0;
>> +
>> +	if (amd_manager->clk_stopped) {
>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +		val |= AMD_SDW_CLK_RESUME_REQ;
>> +		acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +		do {
>> +			val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +			if (val & AMD_SDW_CLK_RESUME_DONE)
>> +				break;
>> +			usleep_range(10, 100);
> that's 10x range for sleep, that sounds a vague and suspicious, no?
Agreed . usleep_range(10, 20) is enough in this case.
will fix it.
>
>> +		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
>> +		if (val & AMD_SDW_CLK_RESUME_DONE) {
>> +			acp_reg_writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);
>> +			if (ret < 0)
>> +				dev_err(amd_manager->dev, "bus failed to exit clock stop %d\n",
>> +					ret);
>> +			amd_manager->clk_stopped = false;
>> +		}
>> +	}
>> +	if (amd_manager->clk_stopped) {
>> +		dev_err(amd_manager->dev, "SDW%x clock stop exit failed\n", amd_manager->instance);
>> +		return 0;
>> +	}
>> +	dev_dbg(amd_manager->dev, "SDW%x clock stop exit successful\n", amd_manager->instance);
>> +	return 0;


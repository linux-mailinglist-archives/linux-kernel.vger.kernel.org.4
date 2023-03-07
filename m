Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9026AF696
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCGUV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCGUVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:21:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD113A3B4F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deRhVZxcBBOS2Qofg6sJNR1jTN5ir6GwMv5Gwjun9W7fGRz3BjycXi/JtNdJ/XdwtSgo3l3KD0LxYwhxPVAWjx38f1Nvf8wZDneB7zcJwUkKRMx0e3OlI1DTXRdYCQ6NtDHH9NL+BKNj0pSdvWywN1jupTD1Q4cpJF0cDnDa6fMyrptdzy4hDQgQ0D+OMNscwIzhlbq2n3y01IIunxd1tFPwObBJL7X/SIG0c6vB8JunQnd2UKBBsnMDm9vKcruq4X7dQv2QYNtSPJip8oaf9BayFkSuNKckBGulSzYiFT4rQJavNrTsAJByGwmKJgruiMlEprFXnVroZVYCU4bB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOStgiROp2/BDEWapku3PR2hSSAuBelsV2s6rafvnlY=;
 b=Fng4vt4BsvpAKwRDNL2U05HBBNfz1pS5+/8wUf5wfXTufwwy0o+w+V/HMzOfK5ycRwO625zdeed43Bdm7DC/ulf2tyrTUBt6yBrXJ5VvTiUi9yBPb3tnLqRLOaDIphQf39OShBVW2oqLjKyMXD2DEgwUTnfiXSXS1zrQsrLuI+vT3Bx1gxJXnoFfeFefzzkPqImhvX1GVWcOzrlUzZOpqsytyYrBE6rI46pFQTC1GBzQY9LpxCom3kfd3DCcuTcNc/9RvLVOYfY3r1ttrm2qm+r1JfGFgIg9XyZ/4TkVbuP/a3RziUR725vhaNrezB2/budHI+cg9nK9N/QsD+iKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOStgiROp2/BDEWapku3PR2hSSAuBelsV2s6rafvnlY=;
 b=XPcVK9gWMNCjzj3BBddGEumZzdTSarhZWasjUsdjRXpRhc1izYfC6nqMVo1KCInvH6Ohf5mtJPBReeKROIYXdjH2mTLOrgO723IOAJthZr7ocbTTWIDX3WKa1iuxNmbIkUGC0WKK7QSYAYFgmimnLsD04WDt4T5wrpv1lyKpEiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 20:21:47 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:21:46 +0000
Message-ID: <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
Date:   Wed, 8 Mar 2023 01:55:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 9693429b-2206-41fa-a0de-08db1f49931b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFRGN3kS8NM8JC8YGmJ/DaNMx4uw0Sb7YUT1WfZwlMLlDfqAqdS1piNY584pdo1zg1+QHtH4f1Ipbppx7k1E8FjimthBy0g27gKf63UxS/szFhDaAlmtKZ8yLbQMudySZxzBIe4qBQPLyfksc6eTwZZT6Q1BLl9OOh/0NB1UpxHTFkaGDc9YcIrg9Q/prYDnBDB3x4C8k4+9ENNktS57cwdX31seb0DIYl6W5j3Yl4FFr1X1BmVBqogTaJ29mJbptHiOPaF8jGh906aIgyQRdJYXaIq6Net0QwVq2164pIIfAo5iqIJODAbn100g3Zw7ZViOB2Sc8gIPxEZ+RuhtVLlhPLHVkVMS4QV/I6VsHLOnCCz0t7pp36egSMW5LFG+5ZPJEEHnJifUIQuDFVajRxjpZvtnHIBIxAKUgICsTBkoBFHcH3mann3XA1e0Vbf9SgJhLwSWgVq51i7sGfJwtte03UX4E1YUbEK/1hyVOhdJQS+KjxKqu85ELerTJrNugrDqcOntjbTnvzvqz114v843BfF+SKpmuL1Vd2WadFukWt/Fz8B55hvGU+8DQhNOoOqIshfRMMps+SwASdZq3d8PPYbjVEdP0joB5AMhpAhmPQROWsXkdDWBCYlG59ccVF3L+PUuJpegnBDG3wtLpClhPa1K9Up9qC9IOFndSMtCfYr8pcmt+f0T5tS05u9JIuYN8Fg1X1kNsgm9U8YJA0eRWTX4dszMCMHiKeBAcas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(5660300002)(478600001)(186003)(83380400001)(53546011)(6512007)(26005)(6666004)(2616005)(86362001)(31696002)(2906002)(6506007)(6486002)(966005)(36756003)(316002)(66556008)(66476007)(54906003)(38100700002)(4326008)(41300700001)(8676002)(31686004)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHY2cHRUYnlwbGZ0aEZRL1JGQjBYMWQ0TmF1LzNCQ01BY2V6b0ZPT0s1SEkx?=
 =?utf-8?B?SE1lR3g4eGRRTzI1K2w4ME56RGlXRWw5bjRuUmh4N29DOTkzWDJITDNQYnUv?=
 =?utf-8?B?cERDRjEvSnlRM1dHQUlPMzhkZnpQQlpJUDlnZGNIWjM3U1drRXJlc1VmSzR3?=
 =?utf-8?B?emlmTEE3UGIrVTlYRTRHTXRsd25CSXdzdk1vM2JHUkUvdHNUcnVCSURqejJS?=
 =?utf-8?B?MVZyQ2JvRW9MUjluWDY1elcyQ1l6M3ltWTY2M21HbEpTN0hRZzc4OXN5YU9l?=
 =?utf-8?B?b3BnSFhXQmJPV3ZBQTZSSExaclRVNGk0Rm14Y3hIUWhpYU85Mm5ISGJBVXdj?=
 =?utf-8?B?ejVGNytXTHpkbW5ORDJTUXo4a0xvVHB4a1BJREhSUU5TUldpQ21WSVhhR0JO?=
 =?utf-8?B?R1RqR2pYRnZZR2pEbTFNZktDTGFHb2FqNmdSOVJGc0s1Ny9QNHlrWHFNQW0z?=
 =?utf-8?B?eGRnZUtObWZ5M3ZZMFlkdjFsSjhwYklkdEtJVkJzMTlSNUQ5T1NTUFc3Y3JR?=
 =?utf-8?B?SldNNVJpSU5ZbU1sRVlCS0twV2w2ZHMvWEFZOHo1ZEIrbW9sQTRUTS9ubGdz?=
 =?utf-8?B?dG9xeDViN3JpMC9ZUnRvUVlBak90OUxCRGwya3dJTllUZG9SN1NTQ2xvRCtu?=
 =?utf-8?B?MWdSNVNDUUhUZU5pQlA5Y2JMRlgwYlpFd2VDNW44cHlrck5GZktjdW81Z3lj?=
 =?utf-8?B?eGlmOGt6ZDlkVjVOQm9nbkNyTWVBNHFwMWEvWVBIejhQMm5Rb0NIRUVpekpw?=
 =?utf-8?B?eUVkUTYzd3hZa1QzL3ZScjhvN3FrWW5XY3djR25vOSszZldmNjhiRVJWQmVx?=
 =?utf-8?B?T3RzV2s5UzBaY1VpSHkySXJjQUlMOGZETkY0NkNsM0RiOXpNS3VnYS93UlFS?=
 =?utf-8?B?cVAvZDliYWZwVWVEK3N0K0RxMDVtRmw4eUlXdis1WWNpazNuWU9kRjNPNWdT?=
 =?utf-8?B?MW9aZ0ZGZ1JFbmJIS3BacHpwMyt6QXU0M0ZMOVRPTVNtaERqNlgzZ2ZvQXFE?=
 =?utf-8?B?cTRjMWRTVkU0R0FxbmI2aGpCWHVXTVc0enlucUx3MkR2aVJsRnJoZ0ppQnF6?=
 =?utf-8?B?OUUremk3VmNKejVNZUk4eTBSanJqck5hdlZKYXZ2aUtudWJoOVNXZ1FCUzRn?=
 =?utf-8?B?ekcwZCszRXEwN2lNUjNnRXBWU1dVZlVOaGpIMFlvS1ZwNWxlalhNZzVIeGtB?=
 =?utf-8?B?Q2wvWm5kZkNSNDhuRlJkT0U5Z1Z4MEFDLzk4VkZhUUVZMGROc0QvV3A3K2dY?=
 =?utf-8?B?ZnVUbEtDR0pxYjJsMDlUYzI0eThyRDVkeTEwVDduQi9QVG1DMlpOY3J0SHFQ?=
 =?utf-8?B?MTZZLy9jMTdTcHF5S0pSa2N0MWVxWjk1Um54Sm85OFdBVnA4UlA0aWVpaUoy?=
 =?utf-8?B?SzhCT2RjU29raE00d2FBbTJDRXRTMUdleGFCQmhVa1ZzcWoxTVp4RTFiMjlW?=
 =?utf-8?B?RXVaRWhKNHkzZy9YZVpNc21RK2Z0M0psYVppSFFrZ0pWcFJ3K3dSMVZxc0lo?=
 =?utf-8?B?SS9vM0NlTjFNSzFXWnlndWhzdktGd1d5d3VnRnlIZENVcFRRRU5heDVqdmJq?=
 =?utf-8?B?RFJxTWY3TTJzVGgzQ0t0ZXY2OFR4eWhHWXo3RER3d0F5aXlmNXBjY3lmMW5k?=
 =?utf-8?B?Yy9HRUpPVVRQamFpQkpKUFdTK1FVdUFnYTlHbmgvclQ1OURnQ1VBYXgyeFZZ?=
 =?utf-8?B?Zld1bU9ZRzJXMGw2emhlS2pyWUdBdmxGaDM1VjZtWGZ3WGNXaWgwa2ZSTS9y?=
 =?utf-8?B?VUNJTWZ0U21NUVIxUGJMeXNrUUFISWJkV0loZWhDd043NW90bTFpeGxJVy9l?=
 =?utf-8?B?cUJTNnRBYXp3OEpBM2tSdC9PUjdDdTM3SVlBWjA0d05hV09XRHZ6NnFxSjlC?=
 =?utf-8?B?bm91Q1lFWENWeHJzckNSUXBSU1pGSnhUSzZOYzdDeFM4UVdWMFkxTTNra0tW?=
 =?utf-8?B?YUVmNnJUODM0L243ZUc0K1phUmVKWGVONUx6d1dCbG9hUlZXWE1VU0h5dktZ?=
 =?utf-8?B?ajBZaHM4RWozRmJUbWR3cDZ1bjFZS1I5OEUyMU0yeVJTOUlBRWt5c3hKcWdM?=
 =?utf-8?B?WWpoSEhQRkZJU1JxVEs3VFBBY2VReVZvWHdmNG9IV3hjMlZRWTJUZ2lhSFRm?=
 =?utf-8?Q?rzFObkxAdyyGf4miSELPh6TXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9693429b-2206-41fa-a0de-08db1f49931b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:21:46.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gybYq36Pdmmb5uGNtcoM0BNqRTLjcyuM7rC8Kz+rrS06pKM9yhdOCWEpZS6y7PPoc8AeG0VleqxRSvxq4ryGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/23 20:58, Pierre-Louis Bossart wrote:
>> +static int amd_resume_child_device(struct device *dev, void *data)
>> +{
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +	int ret;
>> +
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
>> +	ret = pm_request_resume(dev);
> I still don't get why the test above was needed. It's racy and brings
> limited benefits.
As explained below thread,

https://lore.kernel.org/lkml/acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com

Our scenario is multiple peripheral devices are connected
over the same link.

In our implementation, device_for_each_child() function invokes
amd_resume_child_device callback for each child.
When any one of the child device is active, It will break the
iteration, which results in failure resuming all child devices.

If we skip , pm_suspended check , it will not resume all
peripheral devices when any one of the peripheral device is active.
>
>> +	if (ret < 0)
>> +		dev_err(dev, "pm_request_resume failed: %d\n", ret);
>> +
>> +	return ret;
>> +}


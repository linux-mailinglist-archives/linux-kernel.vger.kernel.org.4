Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7069E903
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBUUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjBUUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:38:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F052D142
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:38:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR+hXd20xsyNeeCpEr9lBeAVM+ZAQRdkra5IpJwr/lthVwct3h25rtDGQ/SvCMdebhh1F0etxYNNEp7/3G5aaT9lOhP8S3WAi10sJFjIxignlSbhAfSyc4k9fZ/gf8IC3QyqyoqAMqe1m2D/Gv+ki8yQlJxG4eDs4e6bFij/aWQTI6UXF7onRednw7k28O7Kfo7YIAoLfOggsaU6mZbG1R1baTioKzwGIUaZvKMPMdpVHm7xqQZr9jk846xZa9BXP1UAtlOJUNYmcxrXe5hwhY6V4geRkPjhfMHVVTIJE8A8FWm8EK3O4J2V/4MivqJKKcF3Demt+2R7MVllRhR//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee86cR6rM/GHTuFXx5ZMrdsudfC2ag99l0h4YecFD+I=;
 b=MXhmnEBRsfr2q7TWsn6Y/GzNn5ZT17ve7e1FR03z4XeWFlYAa4v/NnPKMH9zzK9tEUIYH2JQYia+FGDN7nvKQXjNN8SXCigLpzIEq07n0qL87ipBmfDRd6MsZuqLC0cxk0uRF6yHdQruQQIiDk6d/DH6fsaC99GY5ggWIGnFAsQzwY7FVX62xTUJyngYCZ064uAil41ujczMflmy5KWiQM2Mpj26TC26CbLe6r9MjbX2Uc+zaAARxUWYwvNWULuJNNWlY2IAy0c20DnG9SY0Sf5R4Tb50JtTDl2GmCtNeLFNASb7sZQMDdOsEOKMhvm0xKfdMkCuz366rU5C/6D8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee86cR6rM/GHTuFXx5ZMrdsudfC2ag99l0h4YecFD+I=;
 b=JizyxtEycAhMe7uQw51OthtRyASpsFG+kB5r7n9ECRzrM/SwgyInSv6yHFNaQ/muwtR4u95a1zjrIfG/1bFfuX7VT4tIWjDu0FzKlLMS6CqSrZEB+RRzFFP+h0+zQeHzlXcUMLK9KnAA8dUQU81N0WRqHY+euJFszMGHRQ0dylI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:38:37 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:38:37 +0000
Message-ID: <0cbcee69-d0dc-1db9-bfa1-0ba2ec0812d6@amd.com>
Date:   Wed, 22 Feb 2023 02:10:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 7/8] soundwire: amd: handle SoundWire wake enable
 interrupt
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
 <20230220100418.76754-8-Vijendar.Mukunda@amd.com>
 <8a002459-37aa-47c2-4e7d-50adac6015f6@linux.intel.com>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <8a002459-37aa-47c2-4e7d-50adac6015f6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a9ed3-2e63-47ad-9e5a-08db144b9bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN5JLV6d7+GwlngcXWp4iqP2jGzL7FW3jxVa9DhsTJWZAQIm0QJp4UYIErirIA49y3iMCR68eVD2bmrz8NqpOlagVqWKJGnrHT1Vmq7w+1Ewhn6qGYH7jmugi8RJbV2crI15EvlMhMhm9Y5awmjH4/JgEr89Mo+E062WmJgG2bgB3hS9GUtb/YZBWRRjHF6X9ByfqMireUh+e08HW06IXZODyYQ5mAv5w+HV6q/x75PIKFVWeguBkWroSmn1g+EyLWwXDP3xvuIw6LgFl94pXviP99gadwUbBSUEDXczFSoRceSqT7sRkexaBVcJvi0X4ay8MaS9XHD+ZSXtBA/S9tCYHeHqeV2dkQdee0HVpG/POnXNz3lynDHPfA3o3MVjH1UONpx1evKCMN4RA+gDt2D4t1rNaXPsg0AnW8k7W0vmeSyGhf7RaGBz3sqMMdKcSim585+rpjPaH/7OZHPTEdrlKBYzWMZQUpKV6Oh/nuWDtMPYAi1j6REeKrD3tjb3H1XGyDz6p93GvmxlxnI+07YnWLQwZYoEaRgUY6Oht6YrxBVha4R80dWpeq1MolMPqgcWSLfN5vmPpwQtrtpdXYoyYmO3qPsTVaMiE/hAb5H04a7UcpyEesCeWGdel+N1L2Mf1+8uXLi+99QuFmAm9XLxcPDy90qc1+LQ5aebU+Nhcp4g8yvvjCiBjcgyOlQ0cwrjvuClFAGqwiRfYhERuRXERi0VEgH2isO2JI5+Hig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(8936002)(5660300002)(66476007)(66556008)(4326008)(66946007)(8676002)(31696002)(86362001)(36756003)(478600001)(316002)(54906003)(83380400001)(2616005)(41300700001)(6486002)(6506007)(6512007)(186003)(26005)(53546011)(31686004)(2906002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVEwWU9HSzZYaUxwa2d5eXBwNS9sN3NGb0ZoQ0IrRGdpTTIxVktzUXM0RXht?=
 =?utf-8?B?UGNVN3o2cFRoMC9uWFoxUTBaSjQ2VWtFUEFzdjNvNVlhQkd3bTBRUy9EWDlN?=
 =?utf-8?B?L3lCOUsrWFJUM0FsYm1hNCtlUUJXWlFYdklWNlNBdlVhM1ZaaUNpU3NZeXlJ?=
 =?utf-8?B?NVhMQWhmL0hja3dJYUVBU2FCeWZWZTFyc3FJU2hHTGlMYkFVdU1yRnVuR2hr?=
 =?utf-8?B?ek9YTU1Dd1MzZzFsWXc0d3dhWXp6Z2U3dDVBNFZ5V1ZjSVV3OURhdTJrbkVZ?=
 =?utf-8?B?V3liVjVBUzZXd1dqQXBWdU4ydC8wQnhsd2NmYkVTWVNnQm1iWGQvR3BZVHcr?=
 =?utf-8?B?TTFvbU9IeTNQdWlrOE5SRzNzZFdiOVRHdUVCMmcwNGt3RDh2YnFvQ0VjbTAz?=
 =?utf-8?B?b3lqT0YvNTZucVg1dUJuZVZGemgyTG5TSmhzV252R25BdC9FQjZLSElVakRz?=
 =?utf-8?B?S2RaNkFyaUxick1FZ2szT01oNjZmb21FelgvRHc4UWxuNDNPR0lBK1JIRVZs?=
 =?utf-8?B?TkVwS0RtS2ZpYzFmdTBBRDR1OUxDZGJVbnhaRTl1WWhzeVhTd0R5MGxQY1RC?=
 =?utf-8?B?V2pSWU9lNkw3Qy81YzBKRk5pSWZMcW5YOEUwYnozMFVhZWQ3SUFZc0hKQkhP?=
 =?utf-8?B?NGNWelllUjUwTlNpQ1d2WnBoQ09BbG9sM2kvOXJQSGlMU2FvYVg2MTVyckRC?=
 =?utf-8?B?MUsyM0ozdUZsQnR0Tld0QVJpejZqWGQ2SVYyY3hXTVdRTnYvMGtjNFRRY3pJ?=
 =?utf-8?B?UFJ2YktGNUN0ZFVWRGJWWUFHYUI1RXJvMXlmeWd2QzQ0MEFKOFhQMWk3ZjU0?=
 =?utf-8?B?Q2NST1gvRE5oSmc2WTNwQjBxckNtaVFxN3RkbjMwT1luOHE3Y2U4VHYwWVNY?=
 =?utf-8?B?TjhLTCswTTNYWWJtVW11V2hUcHN1TzRmOVlpUmliWjZ3Z1JsQmRUNlF2aUlw?=
 =?utf-8?B?Ri9DS0E3cW1jMURuWlZFWEp6REc2OVRReWpyZ3lESVRIcEhFNW5kV202RlBr?=
 =?utf-8?B?bjZSSUpYc2wrR2Jrb0FVWVc4SEtEVVZyUElGTExBa0J0ZWxubEF3MlkxeXhB?=
 =?utf-8?B?dGlKUU14eElpRDB1bTU3MWZGbDd5MS8zY244d3Bvdnp4aWYzUTg0dnkzUHYv?=
 =?utf-8?B?b1BRZGVmam50M1lEclNDQWszZzFjUk4xQ2NKcURjNXNpbVlBU2RjWlQ1dTA1?=
 =?utf-8?B?YTFjbXpuZDlmN0c5b1NNeVFGVEFkWlFTTTNXUDJOQURvMnlEYVV6TkpnVmF4?=
 =?utf-8?B?cmVna20vdFNYL1Q5WHEyZHN2WVl4M0IrVk1MR044K1k4OUt2TDRMdmNHc0VH?=
 =?utf-8?B?Q1EzeXZJaDJIc0V3Y2tSZng1RWZDL1BKMERoUVFsdndDeTRCVTBJRW8rd0Vj?=
 =?utf-8?B?dUx1Z1R4a2pYUlUvUzZsVUlCQzArZjkxc3hDcWtoeStXTitNV3czNGhaeUV2?=
 =?utf-8?B?cWRiZjhDemc1Q0ZtTzBGSnhITFhZWDh6N083RVd5clJaeXU4aXBScVBEdldV?=
 =?utf-8?B?RGI4S3U3OEsyVCtFQzFJRk50bFhlTlJzd0oxZ2xmcE5hVDVZVUJzWDgyQzdF?=
 =?utf-8?B?aDdFbUJHQ0JUREZpbEtkSWxPMWRHclhvOXo1U0JNK1BseW1pSjd4Wk1QMmhk?=
 =?utf-8?B?YzVPdTRTNjJET216czVCZjVnQmNJQmpMdWRZQnJBS2xvSHBpYkRrVThpd092?=
 =?utf-8?B?NFV0UllsRHY2ZCtMMVQrN1l0VVE2NXBwZXNpT0tkR05jV2pYMEpOUkZTbGhx?=
 =?utf-8?B?VEQ3R3lpQmdvVkhYMlh5WEtUc3pyTk1wWkdLcjNpRFIzSFkrMzhmaWpMVU9Z?=
 =?utf-8?B?RWxzb3RpV0JFekpaSTJTOUZrZDFsZ24zREY3UFR1SHRTNHVFM0Z6bm5QQVFx?=
 =?utf-8?B?YVVmSXF3cEFNSk8raFNxZ1NVcUIycEpVU2VnM1l6WHlFamNUL0xORk1DY1pV?=
 =?utf-8?B?bjdTZVZqTTBrVkp6VkNPWm1TTERzRE42Q1RhQnh3cGgrK1FYVXFZWXpPaThK?=
 =?utf-8?B?b1hZbysrNUJpb29FcjRRdzBRSXJKWnovZTJLNUhFZmZxeVE5YncyL2R4OXh6?=
 =?utf-8?B?L2pVdlc4UFluVnlHUXI3V2VmVS8xZTFsNW4xTStSVWVYYUQwQmFWUUVSQXhr?=
 =?utf-8?Q?Ajw6tsZmATqjx8qpkucGfVVah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a9ed3-2e63-47ad-9e5a-08db144b9bdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 20:38:37.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmpzSQN86sAlsnE0f5CNQ+Ile6lWVa80kkfDtNYseHQ4UE1chKepl09B2Jzgj6jE8dYggW+B/I+CniqfIh76xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/23 21:43, Pierre-Louis Bossart wrote:
>
> On 2/20/23 05:04, Vijendar Mukunda wrote:
>> Add wake enable interrupt support for both the SoundWire manager
>> instances.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c | 10 ++++++++++
>>  drivers/soundwire/amd_manager.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 3322adeca0d8..a7182aa78652 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -932,6 +932,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
>>  	}
>>  }
>>  
>> +static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
>> +{
>> +	pm_request_resume(amd_manager->dev);
> is this needed?
>
> In the Intel case, the wakes do not necessarily come as in-band wakes,
> but they can also be notified by the PCI subsystem, so we do have to use
> pm_request_resume.
>
> In the AMD case, what happens if you don't do this? Doesn't the
> interrupt trigger a pm_runtime_resume already?
ACP PCI driver receives soundwire interrupt and soundwire manager
interrupt work queue will be scheduled.
In this work queue, wake interrupt status bit is checked.
As still soundwire manager in D3 state, it required to invoke
pm_request_resume(). Without pm_request_resume() call, pm_runtime_resume
won't be triggered in this scenario.
>
>> +	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>> +}
> \


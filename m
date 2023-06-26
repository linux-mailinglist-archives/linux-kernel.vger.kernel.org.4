Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F773D8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjFZHys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:54:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA8196
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8ANmOaBWBHfRoYf4aFeE/I54xTyfhBta0gJkqQbE38BIQ0+jnjU+Qs7Fo/gPJi9XALhc17kEEXLbB6w1SmZ0HEXwAHnS/HFi8GmLmZJ6n2RI+tBCbLXH9QllC0BVPLW9mXbYPabLXlMZe2lbou/Smh0VVPsH3kna1leW9W/A0LU5VEihpY+ViRm3sFi8sVsCHq8yx5aGOb+6dH4B03oZuQ+th3KCVBFEGuCRAJCoocxtu2QE6J39eYK2qLubBtaO1BE+TyD2vJiLEYXauPccQbLaXruDvqajMGu1nJUdy2VNwhe4ohLfHrlh+MxCi10gc+3v6U7mIUBhJ4hzhQumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0EOgxJ4FroKoxK7tmDLfVftt5OxKkx97X0QBr7xE/o=;
 b=ZXZLjW0i/v9ig2QBumPIaRVVKCONPeC6UaMQHnXtPkum7T4w0KMueygUuGaA3ApQhDkGDIaSZujpoiGkpsrKgjHDYqao5Xiev8k2x16QbMHW+Ur4t0y52gh3kK1lpJux6p1u/gDFXVHjll3T7lYaiBQ7r+uWFETsvKWYVuJ+r2JxqgOhD9UlnNkcgN/uz0amO7uNinefONv3o05HRnrO8X3VmaMloVWVP6EqaJ03OwFrqYDpzKQ+LVvCc09U7x8Wlc+B3VuEJqXJQebK9TOzLpD165tTviwti8mT+WQCbv/jaMNaBlXUMKUh8FXliB61eQFgFPZ29E1Kk1lOQEYoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0EOgxJ4FroKoxK7tmDLfVftt5OxKkx97X0QBr7xE/o=;
 b=SxAbGNDqlsB4TGA57JVeIOljXhGK20adlaecPaelXbORHFFmucEzz48iE95181qdbG2TmUywNxBIZgjTXzKZZ1uPElcAfhOMIVruBeNcvmFWgaPIZA/ZJ16AMp+PnghMvObOYYkRYnQ4JWFuKU9z7wBl8rfaXuKa9o9QR2lUYNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 07:54:39 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 07:54:38 +0000
Message-ID: <d866dba9-3b0f-3573-9baf-0d02f4049fcb@amd.com>
Date:   Mon, 26 Jun 2023 13:23:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] cdx: add MSI support for CDX bus
Content-Language: en-US
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230518114418.18025-1-nipun.gupta@amd.com>
 <ffb49486-4e29-a44d-97f6-18fea5386ba1@amd.com>
In-Reply-To: <ffb49486-4e29-a44d-97f6-18fea5386ba1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: b2688783-61b0-47eb-3e16-08db761a9754
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jla56y7EHX+SlOw6qEQ3eHR9srYxKYEszP8FjzdsPfirzi9hXnhaKol0yIAcj5bvJxdBy0KSlo8iB3cROuP8RyPSskKp4jwMRi4OvQ87MX9+XGuhM0IRcvHqtXslMylFI0oeoVdfr9UiqcALhq/nYEFzO2w6L1hUTxJRB4hPdlv2Sh/+c/HzrK4r9qxCDgoM4rV7VheslNU92/wZSP/qwoI1wOjjrHJcOoek+w8HP5FeuyBzEszOB3zmiUKBLQ9FD50ICMRWd7nEt81oXVcoEVzi2gI+eOwALrJs8pBb91L4f1Q0SsscafQUbof3I083QgepnH3NJFQHx5YUfx/7QLDsMne77/bNa1xW3UOrn4N6WICHXvboyMgUahMbN8PfLYoDILlbTZaV2H8OdWymPnxnoAu5daLE7m8DycADCnB4lviEC8mJX//wFp9T32i591pocv27Azm6XmQhyiKwWQTCScnA2eEuH+r7f6EZ6xp63Dgn+EVnV8VuKISUzgGdoirEIPGQ7r8ImiL2/6/7bhaOVJa2OO4MlHCSpSvYu9jgvQfIHvDb1pynrGRyvuFmhyRVRuEKfiQG4sS+x6ag2BtqFvGHcEvtbZORzKTj4iWBsEGoGQWr9wyEbEOFFfKDon3gT4oDLuOF6IDyBTRhdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6666004)(6486002)(478600001)(53546011)(26005)(2906002)(6512007)(186003)(6506007)(66476007)(4326008)(66556008)(66946007)(316002)(44832011)(8676002)(41300700001)(5660300002)(8936002)(38100700002)(36756003)(86362001)(31696002)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFAwMDlYUzBneDMrNno0V1NtVnQ0Rkl6YVUyS2EzNmRuTmR2UmN2THZ4cmg3?=
 =?utf-8?B?SHorbWlhUXY3dmlGOCtGb3JQaHZQcUEwNkExQWdjNTViRmh1YzkvS1JMQmNw?=
 =?utf-8?B?YUJLeFBpSXhKcDV2V2R1WFhqQUh0S20vQVE0cHRPRVJqa0xUNDBRdGtZa0E5?=
 =?utf-8?B?YzdrZUowUi9wNmdaVTd1cjVlMnVtcjd0Vy9Hc09GTEcxUm4rR1ZXbmlXSTFR?=
 =?utf-8?B?a0orMGhBOUdia1o4L1hpOEowMjVQQlBlWjJuenF0S3EvZTZEMFlxUXZseTlr?=
 =?utf-8?B?bjlpdUFCV0VTSCtyMXVKNHlVSVRveVFma01oSVdoVzNHOVhqZHl0eWVJZHIx?=
 =?utf-8?B?SGNnZGxpcm1lMXlrK2FjVmhXUXlDNTlGTkR4MnZCaGVTYzh3Q0NpM2hXandZ?=
 =?utf-8?B?bGdNaW9FdDJObk5wZ2s0V253bzBIVG45SUgvVk4wRUk5K24wUDN5NmFQRHRU?=
 =?utf-8?B?ZmpPTWFyYk91WWZtWGhWOVJmVXJEemxXdlp5SHdLcGZiYkxGUVpRaEFFMVFR?=
 =?utf-8?B?aDBHNDl2eE1tb1Y1NVBpbjZUbTdlcVJLTFNEQVVSaC95WFBFZmlPSGN6aUlp?=
 =?utf-8?B?eFBZMDN2amZwcEhIbzZkOUJoYW5VbktuUzdnRzJPTFIwUnN3ZFI3alphbE84?=
 =?utf-8?B?ZUwzeGN1cHhTck5HNDBZNmRHNEVEVEs4Sk4wWVhVTlRDcWdZYm42Y21EWFRK?=
 =?utf-8?B?Nno0WjdveU1DajdOOHB6OG4zSnFyUFhLcnVIU0JzUUNGcVdMckR5S000MTJH?=
 =?utf-8?B?SFMwWW0zdUpSdStOdGFwRDluaTZycDljQk1CTTg5QWFKTGt1VGVCQ050TzRZ?=
 =?utf-8?B?aTNuNkdCbklqa0F6R0xpcDd4OU1uYXBRMm5YaW5ucm9aYVd0Ny9lMUI3Z0d4?=
 =?utf-8?B?RkdGeVJPT0tMcEg3L1p5QWJoWk5HdmR3OS9JV2s2elgyWDFMbktUdTRHRUhp?=
 =?utf-8?B?WGxicU91RCtPSTY5VlozQ1c0UlhMcXFVVk1mWlQwQ0xQRXlrcXFFRHlINkps?=
 =?utf-8?B?Q1k1K3BGKzhTcDhGTUEzbnFDME5Jd1RDd2UwcFR4b1BESUdzVWpsNmZMN2dO?=
 =?utf-8?B?NFBFRlFsSFF4dG50NDRobTVuN1lnRlZXYTZsMTY3b0RjL3poMUl3RUdCbmcr?=
 =?utf-8?B?NWpYcGRtcjBtbGZvK1VXU1dTWXE2RVI5a0tPVWRKRHRrSS9jQTEyM21YaVNo?=
 =?utf-8?B?bVZTMHhBSnNHUHpLNWJsT2c0UHVrVjRqVEl4c1ZDU3p4dnluLzRTdEhpOUhq?=
 =?utf-8?B?bnBoOG5MR2pGYXMzQVo3SHUvd3lCMEVxSmMzTXRYVGtlYlp4NHlNN01qVWNH?=
 =?utf-8?B?ZGFqUlR5OG5HWWJkT0taSXBBblo3TGpTN3hlb2NJdmdDYWRRaTJoeHBGcm5I?=
 =?utf-8?B?Y1lrRE1KS1NzWFpRMjVWYy9nZ291aVBLdFVJUEVPUHZnZ1dNWmZwWjQwanJn?=
 =?utf-8?B?c3Uzbzd6Rmh3cmdzNVRkamREdFEvKzRyRWk5bDVYTjI5MGlHQnhFSVFTeGtZ?=
 =?utf-8?B?YWVJamViakFXSE9tV1NuWmwraU9vVTZxOXI4eUdoL0U3ZG1KMVBjczQ2NTVK?=
 =?utf-8?B?TDFuSlFIQzl2U1cvYzdZSVB5UXJNY2pTYlZHODlnRWtKT09sZDg0MSt0ZkxR?=
 =?utf-8?B?S0NYVTNtWHo2VEpWYk05c0ZwS2VhbnZJck5VN29yOXVobU0zSyt0TEgzLzhu?=
 =?utf-8?B?R0FnWDdoZ3hLU2d4U2F4bk41cnNGbWU3ZmtVcWZ1SjdTaFV1Z3IrUldEQkE3?=
 =?utf-8?B?WklWWk4yNjFIYkxJRnJzOHp1OTlycWdJT1A5WEpXUjFkUTRnMnVtV3pKMDVq?=
 =?utf-8?B?b2V3OC9TaTZKNkFHTDlqT0hvNHlvenMwZlV6UFl6a3c2STJOZE5LY21uYlU1?=
 =?utf-8?B?L2JRalR4VlJid0Z2RU00VDVKY0o0MG1GbkZvY1JYL3NjZTBaSmVPT2x6RC9w?=
 =?utf-8?B?UjJYR1Vqb2QySU9NS0ZUNlRzaUNpMzVTSGlUdFNNSTR2SzlCNzJGVGlXdkcz?=
 =?utf-8?B?SHZPbWFyMEJXUTBqbGNFdjZkZDJzd3VjNHc1SlJ5TlZpRzVmdnhCcE9pUTZk?=
 =?utf-8?B?a25uS29iTVdnTjRlMGJGc0laajBoR3k4Vk5UVGI2V0d5QU9oMlhXWG1XVlV6?=
 =?utf-8?Q?MIrEeHrTTPoHFitOV7oDQmx0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2688783-61b0-47eb-3e16-08db761a9754
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:54:38.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV+217Lh+EpR/bOQpgbuEgqYS89eaI9g/57q1xbS9qC7YVEZg773Owk38Qa0t7wa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 4:32 PM, Nipun Gupta wrote:
> 
> 
> On 5/18/2023 5:14 PM, Nipun Gupta wrote:
>> Add CDX-MSI domain per CDX controller with gic-its domain as
>> a parent, to support MSI for CDX devices. CDX devices allocate
>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>> IRQs for CDX domain.
>>
>> In CDX subsystem firmware is a controller for all devices and
>> their configuration. CDX bus controller sends all the write_msi_msg
>> commands to firmware running on RPU and the firmware interfaces with
>> actual devices to pass this information to devices
>>
>> Since, CDX controller is the only way to communicate with the Firmware
>> for MSI write info, CDX domain per controller required in contrast to
>> having a CDX domain per device.
>>
>> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> ---
>>
>> Changes v1->v2:
>> - fixed scenario where msi write was called asyncronously in
>>    an atomic context, by using irq_chip_(un)lock, and using sync
>>    MCDI API for write MSI message.
>> - fixed broken Signed-off-by chain.
> 
> Hi Thomas,
> 
> Did you had a chance to look at patch v2. Please let me know in case 
> anything else is required to be updated.

Hi Thomas,

A gentle reminder, could you please have a look into this updated 
version of the patch?

Thanks,
Nipun

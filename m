Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD174EC16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGKK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:58:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38A10CA;
        Tue, 11 Jul 2023 03:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0zDAeX580YWc7385P5Y0DHH+skzKZmSBrSSe3ChhqjqYmChGcZkTRjI3Rn3R0P9ZfeZjEkUFxfEqgchDTKpjMR59dPyxTQiz1RF4+VH+J14TAEA7+qDl7125X+JJfloYke5OqmtfqFaoK7jENmiJ0mMvFVyiovHirEJByFZWWga1jw4ZNLPQmApfSwaIBNY/os3Tl6bS91KCSoaTb/T8RM0GWc4tv4pebTdiq99zdX7MDk4jUpE+X3lPB8WJkZ1GZV+Nf9KoRV+77GHbn5VK+K/wNiwsBVNLpnAwoFAw+Lf4aH0bHbz3if2IWEiQ0dJ0FjCviHxwbnSvM8bgEiQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scCu9jJvT4d8vsVjMCh12WVTjbJHRxEZnzL9ob2KaGY=;
 b=PX3Pr+iH7ZNvEEAjKIDFWC6nWCVOpXo11DyoP7QP/I1MD1cwcPM6F8DQDalTG/rPPoBZcq2xRKZ9CtrUKgzB7aLsGp4zPkuqSKAOW9Eh2mw2uK+Ywrm9+/xyise0oPwrxxWrqa+UwJTvcW35OjrjPQ0U1Ojw/ZUpxRvX4bXtDeGw6nlnpcUQBLcM5uG7S5x7G7mgLz46kgiBn3XJoATl4LYZ5zYt1028Jknz3kcAugDzw+wgzNoKkkFsgL68g1RAZ5FLHBRwBgVHOsDftemofrW6vsex/ZsE36tll5CBDzOsbppDQwAxwDvxSLP5sziUY3GFWJkEkFkie3dZzpE+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scCu9jJvT4d8vsVjMCh12WVTjbJHRxEZnzL9ob2KaGY=;
 b=BRIzSuxcJkD8TGmP0dX/VCS+vhQ/8viEXqOIYMREXL+6UIVieJG1MMs9SAds1Luu0GcE1W7P2Ea//H6P9EQQPSoBh7XRiCfaweLS8AV03HE+TS3Qpt8oWrJ/QNwKPeEkgzE7dyepkQRozQ4Mfopm5sGsnQyBmWwXyMmwYdPBk2WG8sgAf4Lc4uk/vtcFduXw8ecQsImFk9AUapOr7yG6doV8lQuALBOF2F8xj4b2Q7f0u/dJUAdtKZMTsOqUjJLbJ6jZgwLQhyuFmAhvaqp5oZIIkwuFZDBxp8hPPuv9LUXTUpoR4FV1AMqokbYfMpSJ16gWJi6n6XOK+fz7tcaOfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DBBPR04MB6105.eurprd04.prod.outlook.com (2603:10a6:10:d2::14)
 by DB8PR04MB6892.eurprd04.prod.outlook.com (2603:10a6:10:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 10:58:36 +0000
Received: from DBBPR04MB6105.eurprd04.prod.outlook.com
 ([fe80::153:4037:b3c1:50cd]) by DBBPR04MB6105.eurprd04.prod.outlook.com
 ([fe80::153:4037:b3c1:50cd%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 10:58:36 +0000
Message-ID: <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com>
Date:   Tue, 11 Jul 2023 13:58:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Stanimir Varbanov <svarbanov@suse.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230710082252.9702-1-svarbanov@suse.de> <ZKvgG4-IzqiYPSUT@orome>
From:   Stanimir Varbanov <stanimir.varbanov@suse.com>
In-Reply-To: <ZKvgG4-IzqiYPSUT@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To DBBPR04MB6105.eurprd04.prod.outlook.com
 (2603:10a6:10:d2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6105:EE_|DB8PR04MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0118f635-aab7-4940-d090-08db81fdc6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ag+a4/kAG4GYTQ9xLO9hiSfxiYt3K6npsPnuv5irp7Lb1L+We8PtkWvz1PtZLIpK3fbAMPue8R6ZQrFbLMGo0aQoV/7Uhs9823oHYdQZrXXS1mDhPS9KlNgK1EUzOpFRg9x+XaTmkBiFHyfJ/L397DOFw1e2kevVYmWgEZg+4Bn0LiIB66gt9R8ym4e8qlZvaN7TbuddENs6uovDSSD2V1oYWqO7+KWSVAHI/id6EKu3ILqpwAhuH0WdR2c0+dR3IUvHXz8gzPGI+cjyT8NVLwpd2A2z2qi9b1BeVnUMg1DMe5AYSHk92S0NIGD7PFyvngu+2Z3EIBMs0rt/ozp07imD30tl69DRkZy4AqcqPS2wlpFsDV22twWnm44CY0QrEA1kFUL8z51qz3P1iv1CoYMLFj81e8hwhbHwiRklXrl4hWFjR/b+aCbjqUgB/WHEw+QU8rehZvdMBnJz2FgVmlWP632mIt93FpVIxNpTaaVGUqQX/mS5Xhj4Rl44FlNYvAtINrNWVfZ7n3e6opU8NDSAh3kHvGNQ88pb3iafYyplzHwqT/fbFfWRNlqBRTWXNR04QOgtj7zLv7FPoidr14A4DaqCRPfEPjx4sQZC29OEXaQewkY8wAzgDEPEB+cAFCLPAvYPJork2UhxptW5Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6105.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(54906003)(6512007)(44832011)(6486002)(316002)(110136005)(38100700002)(478600001)(2906002)(36756003)(66946007)(66476007)(66556008)(4326008)(2616005)(83380400001)(186003)(8936002)(8676002)(5660300002)(31686004)(41300700001)(86362001)(7416002)(53546011)(31696002)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dzQTFGVUdpZzVtZnpNS3hZdGs3ZEs5T1pIVHp5Y2FHZzJIR01NL3ErUmds?=
 =?utf-8?B?YmZXbzI5L2ZYWE1DQUx2ZVpBUmlNdENDYmZjcWVocDlteGRIV1dRSFdQaCsz?=
 =?utf-8?B?ZnRNTllqSGVSWUdnZlNHZWpEd3k3ZE5mYVhRdW8zZXVCdGo4aXdNc0JidFR5?=
 =?utf-8?B?MEVvWWR1MW1qMnFSUkZpRFpzQXRsVzc2YW55dHRwR1VwQUk4U1VGTUZBcGxV?=
 =?utf-8?B?Z3B4bXM0RWp3em85ak9hb1cvOWRPRjErNld2RkNJdEhrVDAvWlEzbUV3eVEx?=
 =?utf-8?B?MzJ1WEdSOUZuZTMxMTdVazQ3NzdQdGhZNkpHNzNPS1Z2cUdyRTRVUDNpSWpQ?=
 =?utf-8?B?enFpZTNqWGt4TXNBOXovNWV5R1d3b25IdmdxRkpnS0kvSzlwdXA4Z3Q5ZFk3?=
 =?utf-8?B?c0pST3VPQVRVdGx5NzZ4KytpUHBDSFVBQ0tnTWhLTmwrT2JBVzNCNWFrRzRx?=
 =?utf-8?B?YVhFWFFCT2twU1RzOGdUMzZKT3A0TGZMSFQ1U0xKTDJUU3VVd1paendSSVhi?=
 =?utf-8?B?SkxvODcwWGVFVGJ1ZTNXOFpoNVVlRkQxeTI1NGFSdjBqdWZ4bGptZkRTTEFk?=
 =?utf-8?B?bjRBVlNOSTJxVHoveDZKVG5Ra3dod1VaSzI5b0owN3JMM1ZOSVZnN1ZsOGkr?=
 =?utf-8?B?OUVnSW9Ka1psNlhTTnBzc0tnRDRzMlhsODBwZEJNOW9HUmxCdm93NmloQXZO?=
 =?utf-8?B?dSsyMjJJY2M3Ry96ZDFvZGFjTVltTllnU1pSNFl3U05aWldTUzNEa3VGaXha?=
 =?utf-8?B?M0J5Wk0yYURxQ3Vib050Ym5RMUlhNDIxWEFkM20vM3BPTFRpdHBuZnVobmZZ?=
 =?utf-8?B?enQvYi9tUi9NM25zQ2RudkxJdzJUYldCaStiUW5Vd0t2RUtWMFZXVjhFV09H?=
 =?utf-8?B?UUtCMzFLWlo0ZTcwKzFZV0V3aFdBQjVaclJ0UkNnRzRzSnBQSTlNOGd5WlVQ?=
 =?utf-8?B?VCtrSzhnd2R4d1hKMzNNUXBwM2x3NVQrZzBhN0NVOHF0c3Nic0pZZHhxbW9J?=
 =?utf-8?B?SnBWNllGeXlHMmRhWEpTZEdRV3BUVnM2djNCeEtyV2lRVmlZNHdmSWV0Y09H?=
 =?utf-8?B?SkhqaVdQeC9BYWJmZ0p5cW5LYThSTVlNVGpMNmdLVTZaVUlJQU9oeUluRXhv?=
 =?utf-8?B?RlRMdi9WUERzWVA1UnF6VkVEeFFWR2NzaGNQenZXdjAxQWE5b1VXZm9lSGZi?=
 =?utf-8?B?eW4xcnpGZ0tDeDVoUThCb2ZNWDRmRUlYVzlwdENNcW8rYThhZ291dTBzZ0VQ?=
 =?utf-8?B?MmFMNHVRaU1lOUNDYjVNSzIvc2lGbGJKQnptRjlBQjl3ZUN1Z2twRU10WCt0?=
 =?utf-8?B?ay93anhUaVJIV2poOForM1JhM01vdmlvVFBTSjVpZmR3T2NHS3JGUWV0VE5q?=
 =?utf-8?B?aW15ZThDaGxZTkVvRmh2ZnF3bmY4cjg4RVV0d1Q5cUdWa2diZlFDeUJWdzlX?=
 =?utf-8?B?eUMyWVBaRVNkNmQweFh1ZDMzNUVNS0JFT1hnbHArb2RmSy9rYnZNTlJYRXpY?=
 =?utf-8?B?aUJYV2ZabUpsQWxDR2p2Vk1VbG1KY1JRN1pkZUc5SXZEUis1RmR4ZGJ0RDhj?=
 =?utf-8?B?SU1EV2gwamRYREJjOVpadGtmVGRiSnBIQ05VTE5vMTRQL3VIYWY3VmlPQmxi?=
 =?utf-8?B?NGMrcFdJc1VjZ2lvZnFWcG5uT1h5SDJGYnU1L1Fpb2RMa1NQYWN4QUJvc0tF?=
 =?utf-8?B?N2oxb2xYM3YwQzFPVUoyTGRiQlQxdWpzbmJ3SEwzbElsSnNUOGp2R0NoR3pT?=
 =?utf-8?B?UFNGU2ZhamNLdENmNmgrejlqQWxqVlJHYUhqdnJlVnNiSmxQU0ZCcldoam1r?=
 =?utf-8?B?WW80eThkdFhqYytQYUJQR3d4bDFFdjQ4ajJlbDl0NXBIQmhLKyt0dC9jR2Nz?=
 =?utf-8?B?enkvcWJic01YWlJteEpVWFFNR1hSQVpPTmV0QWc2K0tuWERpRWUrcVNwVkJE?=
 =?utf-8?B?c2JUcVlIcmxsZzdPVE5RWU9iM2k1d1h3aHE5L0lhSHVZZE1BZmwzWVgvS2Zu?=
 =?utf-8?B?RzdQYWFJS3BtZDUzVVhqTFk0MGlzYXBseXduUi9ZRTd3ZGhrd0c4RjRnbXcx?=
 =?utf-8?B?OWdpYi9EK3RVVzUrcGl6WXRWc0xBcFVFdDdsWGc1Z0lMcXN2ZFRQenVIV0tR?=
 =?utf-8?B?djhEL3FQcjE3YmZtenVVYnIyK2FNS01zSURmQml6UXVMMUZwRXZGSGp6WE96?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0118f635-aab7-4940-d090-08db81fdc6aa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6105.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 10:58:36.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b5BoYEi7rBuXMT39uTQ0SvXMLCVSNSoj1Ev0DKGwEs6HfcovLOylSRikVflTI2htrquxxPl7duJhCCsotJi9E6iwnagkYrCxNhv75g9yfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6892
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

Hi Thierry,

Thank you for the comments!

On 7/10/23 13:40, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
>> Add def_domain_type implementation op and override default IOMMU
>> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
>> could be enabled on some distros. The current quirk has been done
>> for Tegra234 machine, because I found the issue on it. The issue
>> itself appears on USB host controller which cannot be initialized
>> without IOMMU translation. Something more, we proved that IOMMU
>> translation is needed for display and GPU drivers as well.
>>
>> I evaluated few possible options to solve that:
>>
>>  a) select default IOMMU domain from .def_domain_type op
>>  b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=n
>>  c) add iommu.passthrough=0 on the kernel cmdline
>>  d) firmware - ACPI / DT
>>
>> a) This option is implemented in the proposed patch.
>>
>> b) Since that the community has agreed that pass-through is preferred
>> as a default IOMMU domain option because this will avoid performance
>> impacts on some of the platforms [1]. On the other side we have examples
>> where you cannot even install Linux distribution on a machine where the
>> storage media cannot be detected and the system just hangs.
> 
> That's not how I read that thread. It sounds more to me like Will and
> Robin had ideas on how to improve the performance and were planning to
> address these issues. It doesn't exactly sound to me like there was
> concensus to make passthrough the default.
> 
> Having said that, given that it's possible for distributions and users
> to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y, I think it would be useful in
> general to have a way of enforcing IOMMU translations if it's needed by
> the hardware.

Exactly, the problem is that some platforms prefer passthrough to avoid
performance impacts but others cannot even boot the kernel (and thus
installation failure). Passing iommu.passthrough=0 should be an
administrator decision, balancing between security and performance.

On the other hand the aforementioned mail thread gave some performance
numbers which might be are outdated having the improvements made in smmu
driver in mind. Unfortunately, I cannot confirm that the performance has
been improved during that time.

> 
> I'm not sure I fully understand the particular problems that you're
> seeing on Tegra234, though. I'm not aware of anything in the USB host
> controller driver (or hardware, for that matter) that would require the
> IOMMU to be enabled. The only peculiarity that I can think of is the
> firmware, which is typically loaded by an early bootloader and therefore
> might perhaps need the IOMMU to properly map this in the kernel.
> However, my understanding is that this firmware is loaded into special
> carveout regions which don't require remapping.

On Jetson Orin AGX (R35.2.1) I see these errors:

tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
EMEM address decode error (EMEM decode error)

tegra-xusb 3610000.usb: Error while assigning device slot ID
tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
usb usb2-port3: couldn't allocate usb_device
tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
EMEM address decode error (EMEM decode error)
tegra-xusb 3610000.usb: Error while assigning device slot ID
tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
usb usb1-port3: couldn't allocate usb_device

tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
EMEM address decode error (EMEM decode error)
tegra-xusb 3610000.usb: Error while assigning device slot ID
tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
usb usb1-port4: couldn't allocate usb_device

> 
> However, passthrough is admittedly not something that we've thoroughly
> tested, so it's possible you're running into a use-case that I'm not
> aware of. In that case, could you provide a few more specifics (such as
> the DTB and .config) of your build configuration so that I can try and
> reproduce?

To reproduce you have to add iommu.passthrough=1 on kernel cmdline. The
dtb is from Jetpack.

regards,
~Stan

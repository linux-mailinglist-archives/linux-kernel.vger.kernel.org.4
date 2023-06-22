Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27E73A34D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjFVOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjFVOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:42:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849EA3;
        Thu, 22 Jun 2023 07:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzPtpYbcaKT/XwMm7rK5vnKONyx0Mg7FoRhCtPrXBENav2uZcsiWgarfKr9N/F469MVCcI3CXiY4NFrHqDgRWQNejbltU++QyWOSk8HvINES01FDmVp4jZ0svkh3YACBZ6C2TtpsKrvcYVakOsYY80I1CCE7S/HC0eWHzl0XHh4SCUAZ/srr6Ji4/jqhBt4o7Q0va+S0Xuf2VoYxByn2u7yx18sblWZcgVYPvRCPwXsJZ7Br7b5+5qXe8T5KWe7XAOUp3vUMsFf1xOlxBz3OQ+DiOWlt8BDy/mRfG1G3LHIvCN3EdJBujhkeR/JMAnGJKRKKtBS/2PCp++XUgpUiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcTtuBTh/pPl5siVDG1Lt2UQEmgT2DAqFvTPi3YgdE0=;
 b=ZJm1deX42AcpfkSs1rlJ2lUe8YH3ocfKhFPdXTFGikoYnkdGb9jUb/vJ1/UCbhcD13wbzcw2G1d8PGhPr+fBuXZZkNMUC7IDmLdBH4z/UOLgcH9T28KKiu6mVUWJOk+wSrYs1+ThawgbNUVkzgl+ibFXezZXthZ4mSzz8G8AWQWREHD/zM2q0a2ljUHq+jneIyp+pcpvFRi8bjCrsCre1W1wf2BkgvnUN6kc4U/rxAjJbB8nHvRVbK86WjWSQoefycTBlwDt4974frkslDSgTnwEYM17f31kFucvyIUne/Kiy/txwmrscjrNJ8xGcVsw3kORXVW89YzwIsEtAk++Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcTtuBTh/pPl5siVDG1Lt2UQEmgT2DAqFvTPi3YgdE0=;
 b=Z9Numa7iSY+JiB+z+r7qc51H3VeyUtrE7rMUhlkJxSR45x4UO2I5SrKfudiAhcA2FbD+X2Ebp/pbXM1jzjZIw010CgPJ+8UtNJY5CBkKP0mxbhs3pXikl4eVQzIQHSQOnIRyMEvn/f3I7kkB8qksQPQ+d7vd7DzgENZ4tbEClcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:42:04 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38%6]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:42:04 +0000
Message-ID: <50db7ca9-6e5f-2f9a-61af-bb5b09898b72@amd.com>
Date:   Thu, 22 Jun 2023 09:42:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 23/27] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-24-terry.bowman@amd.com>
 <20230622141627.00000383@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230622141627.00000383@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::33) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:3b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8219e484-32ac-4c77-177d-08db732ed833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Hhy4scve5O+x/tq9Zx3fYiGQTRQQuqO5/bWbmsIr4wxQa79e28MveqkPmiXBIDN3dahMNlVRRXGdpE5k7UBMzIZM9Ys+S+xuW0ql3B29TL7lRqG+EQRcjCY7sGx2CGqjlPW4aTUllRXWx4j66ohwwlHb9G11PFsXm6ktjCjBcCt0xJpaGukKLRDcOqkS0aD6vIOraG8uGP0oBHdRAp86IdKRQ8y2kUx1a1+ik0hqZJWx6X1OxbNmWeuzxesCb5a+b2RRnhC819XJXRU+i6pJdvRUztQqzRO8e5oYzv00SNKpM9618tKhBkWCWexYuuA0TYhjtIR6NtbiooS4rm7aVez+GvFEn5Sl04T4KCEzJ/yrt10sx/2GFyyhYHu/8ZdCh05ocnIJyX2m8F6Z9UlrL9TYX0OjxRIhsobM7TuRS7prqFQp/HY4l2p8IdajF6WmXJjKr/Llnllt9/bj7IBp7ejEjM4dMcMDqqTuS5DFv5eBTkDI/bSbBr8GIcqCeI80myUwn+Fd2lGe/HNa9r/Noj/KNSKapZgz/AqmHyIktSgCR85DCxjBCiQa/2QejOk5k0mLfQ+wfbXrZyt0eis1QqJI9wwuN5eyoJ87hmxDAFruTsQ2B/eXQusEZ/BnxZLdclsWqEcoFMvbLWOaLNjXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(316002)(83380400001)(41300700001)(7416002)(4744005)(2906002)(5660300002)(8936002)(8676002)(36756003)(38100700002)(6506007)(53546011)(6512007)(6666004)(186003)(6486002)(31686004)(66476007)(6916009)(4326008)(66556008)(66946007)(478600001)(31696002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU16VDdRRzVZV21ZY29QOGZCMy8vR25IUFlabmVpSFdkNkhlcm0wUHZ0a1Ju?=
 =?utf-8?B?ZGdadTZZejhDYzdFcUxORU1kU3YwOGoyamFGbTBSMVJiekt1MHhYWk55bkEr?=
 =?utf-8?B?bjVzY0l6SVYrR3VINkxkWmJuOXVkYTlFcDB6SDBMYjFZOWNIbVFZb3JRbVFN?=
 =?utf-8?B?OWhBK09SZ0dxbXVnT05iK3I0M1JaRTJFbmtBOTA3OU5nTkF3Y1puQUdMU1NE?=
 =?utf-8?B?UnNJQ3NTRTlHWEp1clRoMGRCanFGUXhKMlR4YVdLUmlTcUNQNWcyWVBlY0ww?=
 =?utf-8?B?MlRMSVYrek0rZ2NQY3ZENFNBUXdnbWlGM3BDNjlXTlRHT2V3bW9KUXBTZm5M?=
 =?utf-8?B?ZlJCZmRwK2UwejN1TVBuRWI0aTFuMldwbCtINHZwMmpvMHFQZ1Q5cVdLWlht?=
 =?utf-8?B?bzZTOEtXRFJNeTl2QklYOEhwTG9LN1RhWlBjbU5NaFBYYThicVYyamJjRlFm?=
 =?utf-8?B?R05UZSs4cGEwNmoyS3M2L1NUYzFMdXFSUzZNaTU4V0tSVVhCWGtZQVd5V09q?=
 =?utf-8?B?amJoZDBUWU1PdVMyd1liWUYvSUJZQmJTcVhWTjEyd25aUlRBeWVXQTY0Rm00?=
 =?utf-8?B?dHYyeCtLZEJFSFZvY0hteFduVFNodm5nZ3hOSTZHZGUrTnVHRE9zZDRvYzhG?=
 =?utf-8?B?eUF5ZzYrMEVpWlh3WWZoTTgrbVNwVkExeXRqbWxwL3hiQnhocllHSW5uZk5S?=
 =?utf-8?B?b0lYMzR4MmdIQzdRMnBYY2laR3NYdEVGMVUyblF3dnZ4Sm1MU1ltdzZXc2t6?=
 =?utf-8?B?TElIZERJQWdaSC9pNFI2Y0VkVitKaG9QUlVIeUp2V1E3R2lKTkZHc3gxSEcy?=
 =?utf-8?B?VXNwWXJtaGxKcHJ5SDdsaDh0SXdXY2wrWXQyaFdHaFNzZ1M1ZDhzdW9mTHRo?=
 =?utf-8?B?Q05MWHVNa0RPbXpxZ1B2bFYyZTRybUlvWjZhRUJ3d3I3T2czMHFJbHhtamR3?=
 =?utf-8?B?dVQ5a09rNUR5OWllNW9QRnhxZWpINjYwdDc2ZU9EcFJOWVZJMS9sRjNPOW4w?=
 =?utf-8?B?bmFSU0ZIcWVWQlYwSndYUjg3SUllZ3VlRGpYRGpzYVBtdkZBS0xFSUpqZEdo?=
 =?utf-8?B?V3FodGt1cDJCRkg2RXEwRldJVy93dXpRdFNJcE5Xc3NTWGthdnUvZ3gxN1R0?=
 =?utf-8?B?N3ZiY2QvTldkcWU3V2tKVEMxZ05HdzVpYityUUc1T0txY0pwS1p5ajN0QzRJ?=
 =?utf-8?B?YnNxcTM1cncxNUJablZvN1FadDVNZWFzb3VHMW0ycE5zVmdiaHhDSWxYdjFh?=
 =?utf-8?B?VDAvcWozWGJ6QmRZY1JyQkdOTFdDczlLTGYraHpNWEk4YzhTWlZWYzFocmNm?=
 =?utf-8?B?c2NpaXlObGpjcnozaGpFQjhPYnZDSEZzUjZhN3lxKzI5YU9lSlVKR05wNlB3?=
 =?utf-8?B?WDV6WVl3SUFmOUk0MUJzRitXdzd5RTBwbWh4azBORGNVMUQ0K0grYVdjcFFE?=
 =?utf-8?B?Zm5BRWFPZkRYZGNRRU9WQWpJZnMrTVBsY3ZXem5VUUhrOThZWW1aRXAvM3Vv?=
 =?utf-8?B?TjZsK1VDd2NhTUZSa2l1TkZQUHpBalFkbmdqN0xEYlNiNlloTndwUFZrTXJ0?=
 =?utf-8?B?TGlzZmowck1ydzFnTFE2NVA4NVBXdDZsMVNMMVlwQThleG02TE5wbmJSam9I?=
 =?utf-8?B?NGQyRjJoYmgxaGpOM2c0U29LYkloREQ4ekx2Y0U0QWJyYngxVU9WUWpjSU45?=
 =?utf-8?B?TVJ4TEdrYW95dFBIaDZJVnRKczdJNWZnZnRnUzVJR1YwYkJlemJwWEhlazFt?=
 =?utf-8?B?L1RYQkMyN1RISVIzODRFeE1BSGNqZHI5R3ZDbnFEN3NycGZZRFF4bG42bzVm?=
 =?utf-8?B?cGx1bE1jV1NLSE5ScFZCMVErRXdtbHJsUVhsRzlHcUdVazA2bUl5K1o2VDBZ?=
 =?utf-8?B?RVhyalNRRXJtV2NTZ1l0UTlHd2EwZXhVRGY1bEp6WXhOV3gyNzd5Mi9lR0Iw?=
 =?utf-8?B?YytFcXhsRjJwNk9ZWU1ka3dqN1lBNFlnM2thQkRHZ1JzS2dEbHRvOFdoOFIv?=
 =?utf-8?B?WlVibC92VHp3cUVUeFVhWkdraG50VXNyZGhkdFFEd3QzT3NrbVFhaGpOWDl1?=
 =?utf-8?B?Lzh4MmVaREF2QU9zbVJwVVFtWUlXcGFENUd0OHdXVTBFeXB4MG1mQ3p4UWxz?=
 =?utf-8?B?em4rMzZSWXhYZEYwNjJ3SXUxR2ZFTDlTWWhEdWhnWEloYUFGYk9QbG4yMlZ3?=
 =?utf-8?Q?OdskoBkEw9mFDye2jJaHwhVmHtBiUeo5EpKbeJ1ubT0p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8219e484-32ac-4c77-177d-08db732ed833
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:42:04.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnulZgl8K7X6HePCJ9GZVsrjNxHGNOgXnvQuDAM5oU/FqaCNnWHtXNIlNepsZ6Q9wxc4qU676FLI504IwWXGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for the reviews.

On 6/22/23 08:16, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 22:51:22 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The restricted CXL host (RCH) error handler will log protocol errors
>> using AER and RAS status registers. The AER and RAS registers need
>> to be virtually memory mapped before enabling interrupts. Update
>> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
>>
>> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
>> the RCH downstream port's mapped registers.
> 
> Copy of the address at which they are mapped, not the registers.
> Probably worth tweaking description to make that clearer.
> 

Good point. I'll change to the following:

"Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers."

Regards,
Terry

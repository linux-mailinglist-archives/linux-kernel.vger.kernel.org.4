Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229966BD51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjAPLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjAPLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:54:52 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6021ABED;
        Mon, 16 Jan 2023 03:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYCWkio9PmaMAY7cORJDfDnyCrC0IHPnv4Pm4Qc60u3GoGry0GhSSjVp7L4HHHhUxQkcj0nmvidSitPfhiBxp/uGSorJZkTbZMUhVMJkDx+L3WhydUdDD8T7V2iJQcp40BdR06VuWsCgbS4YIUOhQ8veF+cLU73LVW5a7vWDvL7Tjd8iMKpkY5z/BZZcmJfPvqcD+437HuZCOD9ufo19+jMR3D0B9nnkwJE4lBSCQp3OxEO8T52c3HgUZ9F1q03PSQavBn4nlay53RiknYaPzyzM8+I8n5aQqQuc/IyR78p3+scNZA32KyWfaKudrNHqFYDnh2tH2NvszXSOXnLP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI5y2fKyeFHwDhDpYd2woiAw7pftg0YFrjur0YInKbA=;
 b=HojsFEZnC3LzTPvL2vGjB3YxFu0Gv7wlbOCUz06R/p6uM+mu9Hnv6r+7fIVMsU+XuoSSaWtNry4+3h//VKagtXl78K2eiltq6ZKSxTUwRtP1YFCNkph8fWbCGe7Ok+iCZvg5SNYC+VwEDDGrgh2tU1NrF+/dIWYaLgYAvveIdxmvh4jBvaUufyb8FOL2suOCElCvp9IuLuJbiKIGLmX9GreWFsJMf0fdMjdQOo7B/ijM4t1PgnkkMK4adp/HQ+EI/hotp9NzreLCM771BNMBUUth8akr96ZMnfBK3iF2zGD1E5hB4kywzV+1MJATvuCfjCq30CLOXdXTMvXAVFEQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI5y2fKyeFHwDhDpYd2woiAw7pftg0YFrjur0YInKbA=;
 b=h4CEevB9xuVzNowkrMym4RK79KjAzye1njYf34u4l7jGsQrLXbZpUOnch9lS1llwHlLBWmGs9uewtVrd+a+NrDmd2ZMdUIzI4Hvq8zlW4Rc4CpoHLOfOSRNcinW+pg6MytZbpk2IIu7yg4PZlhZxAOVU6LeLCvoGq+ISKGC84JqOSbqo+eosU+WcgYAdezgZAl9X2X00DQVdPvPu0mj6u4KHcookCfw0RUY95A2V5SII/w9oeYMSqgt2VROmGhEveA8S0WMsiuvq0R4NtqrE0ltunz8OvzpakmgwXwnFymtl5jN6HIBVhGSjmQe5M8AZ6+BBEmyVkI4OpX67m2BCwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 16 Jan 2023 11:54:47 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%7]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 11:54:47 +0000
Message-ID: <acf995cc-f3c2-c410-dc6b-b5d3b5cd0970@nvidia.com>
Date:   Mon, 16 Jan 2023 11:50:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221111101813.32482-1-jilin@nvidia.com>
 <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
 <Y7g9g0CbCc6b+3EN@kroah.com>
 <30fefd03-0ead-8980-ff5f-5e8a95e74c8a@linux.intel.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <30fefd03-0ead-8980-ff5f-5e8a95e74c8a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b6ddcc-bb9d-4bd7-4d71-08daf7b87767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JN38rNp6lm81wahA5Bo7PHvPYgqN/9yWrHSv6AZLd+jkIE+OnbC+ytlppPuRMle9ripboFIO789AL8ThtcKM6dnKmHr6lLJIfPKNMO8CRUANSm5WRKFcSp+Zy8w0FsqF+H9zjH53wp11cK/LRvkC0hShnaeTZamUWKXkGTzLQQKaURBPvX8uLLdUrn+HVqFRUHMbaz4UycoGgtZLD4jC/1bxqk6HbzuYOIGcdg5ATQYV7K1Th9O94pltwCQBXuoerM1MAhC7RLTm7UAULRhHsZZcG5RpObU69ZRj21nAkifvBOEtH0soTRovMLeiE2L1BNS56URjaYy1ID0VvmDKhZRjhCTDthSU0ErPokrygKihgNB9nM4a3S4873IyQKQprDPau8vGzUXuoP0UdnxMVMTgwXbtc/EHWXASzj3MdZgNYOHWjJf5ql2ZUZSgHCFaXHGAFAySyiQrYy0Jdnx4PUp6mxpfTV5Lax9k/9Qa8oJMOlI6tKBjXuJjt7cVF7j9AVeZDQNz98B2qJHyQGBun1b8hdLbV8oIEboxemXSQOJU4IY8ruRPFWY49dYCmRtIWPonXi+/17D0S+pLHO20HsXepL11QSVkeOKnsJKmQnQyBBAoJx+uAOE8F7pEVcl2fZbG5kgMcZTbyhvkRw/jJfMG3x+8u+/o7Jkfcia165JNZBs7+/+IVOaBDujDqDlwERvRp27/EctGib2e7TQAjtJrnzQES/R6o+8lilYyOE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(36756003)(31696002)(86362001)(83380400001)(53546011)(186003)(6512007)(26005)(4326008)(55236004)(8676002)(66556008)(66946007)(2616005)(66476007)(41300700001)(316002)(6506007)(6666004)(110136005)(6486002)(478600001)(38100700002)(2906002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhkZ1U4VGIrZjcvUm10RmtkMUdYR0hiRFBpbStmcTVGUW1xaW50NzZZcHRa?=
 =?utf-8?B?Qk9XSEU1aTJ3WWhLQndtRno4L0xiZ0dCTUpvQnRoUm1GZUZsQ084SnNTOHNw?=
 =?utf-8?B?TUR3dnE1TmFtWUE3dGI4d3g3T3drejFKdGZ4dTVXZTlXU3c1azRPeXM3dzVr?=
 =?utf-8?B?UFdXOElXK0swZTRTalVUK0ZISm4rZTFQdVF2QWdmQzF0MmRnMWRjQzViVVlE?=
 =?utf-8?B?Ykt5dnBiRCtTMjVUVU54U0lkelRlaC9iY0pyUTRWNkxxQmVCa0dlUFJWOWtt?=
 =?utf-8?B?cC9waEFNUndzZVk4T3BadldEYjUwRHBFbS8zbDFjc3BsRmMvU0VEOE9GSjR0?=
 =?utf-8?B?VTNzcmtNRTJzamw3S1ppTjRma0tuWi9UYitZSHNydGxHSTBYdC9pTWRrbUJR?=
 =?utf-8?B?amxoK0hvNTBBdVBodlRnWWR4Y0VJUkpOSlE0bytLS0o0MnpZM2RwQmw5Z2Nn?=
 =?utf-8?B?S0hnYjdCUjBDaVhiS2g2SVlIYWYzQUVWb09JWitwMUIyWUpjWVl5TmFvQ1FY?=
 =?utf-8?B?SjNzMnFVSWtXRExCbHl0WlhwemdobndEdXZuQTFrbEF3WmQ4YzhYQjVnYzl2?=
 =?utf-8?B?ZzB0MGJBV3ZmcmdodlIwWGVkemZ6ZTZ1VWNoUkUvelNVU05YYXRtMzMwZUlr?=
 =?utf-8?B?NFpNTDJIdlVEQUk2UURFRjVFMEc1K0JwUnYvZFp3U1pybDlZcmxiOWZPbURL?=
 =?utf-8?B?NGoyZmw2dGp3WTJJOStmaGtMeXpTaE5wamZ4N1lBZFB3WGh5eCt3SEdhTlRJ?=
 =?utf-8?B?RGxUeGVhcHI1alVtRDRrWmJPMVhnb05CQTl1L0c5YklTdDVUNWNKZ1NHcGhp?=
 =?utf-8?B?Vy9nbHdNOElxaU1vc0FnQTlrYXUvNGFlZXhUQkpTa3dnOEluN2h6T2doT05C?=
 =?utf-8?B?ZjgxQWszS1dzTUl6Nm0zY2hDN05pay9QUEtYU2FZUG5pZUpyS0t5eEhDUnNk?=
 =?utf-8?B?UW1xR2ZlYWxENTByLzBWMnNUaVFpUUdzU3FwejE2dHRjUGt6cEVvbXdxYjdE?=
 =?utf-8?B?dmEyMW5SUVJhOEd0bnpFOFhBd3k0REVXdGt5UW1mWG9abklrWnpqUFJKYU5o?=
 =?utf-8?B?VHFERDM4dk5WeGJ4Q1llU0NmeXFkNi9NUEZ1UGFNY1VZcnFxNUk3eUhoSG9i?=
 =?utf-8?B?WTNyVkhFSGFtRnh5Tm9oWldiR0RFQXgrRldsRTVrQTdhTTUrV2gyZFVBVFdt?=
 =?utf-8?B?WGdiOHZqOGFROEMxREJRV3ZoaU9DWHdsc3FVODJGVnZGSFZFc2ZUZHF1QTQy?=
 =?utf-8?B?UTNUaGlmYjRQTndrYVNkcmJMNjdFcUZrK3JNemJFOTZIVW5aclMxMXg5WVlK?=
 =?utf-8?B?MzlaaS9oOWErai9TUkVaVURkZ2hBdWl1Zis2NUtWM21ud2JFVEw4ZDJaN0lM?=
 =?utf-8?B?L3BHN2xIbjVaODl1TUNVQXVxRW5OaWFVM2s5WnFCd3Y2VGJENjh5YStCbFRy?=
 =?utf-8?B?cGVMeW1pTHJUd21Wem90aFFrZm5FVWFFam9tZUUvdytSLzBUY0N6QkF2OUcr?=
 =?utf-8?B?enc2YnZpUVl6R3k4b1BsTXcrRFFJKzJYSjJNU3pRVDlGVlNSY1dmcjlBNlFH?=
 =?utf-8?B?NXpFZnZqdE5WaFNQTjBwMjRiNHQyTDFZOXNGVjFKQ0ZOc3g1NG9qdnpWdTgw?=
 =?utf-8?B?UFhYK0wxWFBFdEhrZTdEaVRvMjhzcGxXelhRbDNIYUNxdW8rSnpqMDl4RjNq?=
 =?utf-8?B?blpDbmxJQi9IS0t4bW1YemNKK3NzSm4xNGNVWnlSVDB1Sk96ZjNCem9BV2k3?=
 =?utf-8?B?L3VpQlAxQ0t2bCtMV3hxSzMwNWdzVXNSbmE4c2RKU0dFTVQzMFl2MHV3czFM?=
 =?utf-8?B?bXFSLzYzUWxtdy9XRGFsK0x5RDkrdTFTbyswWHJRdDBqNGlmWlgwUFRPdWNY?=
 =?utf-8?B?VjVEdnlmSUpwOVhzaWJoUm1YcDJqWEtxTndDL2Zod1RFZkk1NjBvMG9pTExq?=
 =?utf-8?B?NWFwSFp6YUl5T2cyeU9oN3J0WkdMM0RQbGpwMEx0d1p2aWFrMnNydUNVcSt6?=
 =?utf-8?B?Yk8zQVJkNkZKM1ZjZENJUVA2REJ1QmpqSXFRS2NMTVZhUGQ4T1g0eDF4N2xH?=
 =?utf-8?B?SThFY21Qb2xIUzZFdjl5cityd29iNDNDVGxqU0hTY09WMThJQTNpR3J5SVJM?=
 =?utf-8?B?Ujc1cVZ0bmxXZ1dBbEUrRTUxSHZEZ09YS05zOEVsTXNzVm9uY1BSelVKcXVM?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6ddcc-bb9d-4bd7-4d71-08daf7b87767
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 11:54:47.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2LQjcN+U1TguarLAuSQUpqTrHWpNr0ujamFbQl0fehwjp1i1Q74UtSLUYhkvRVzf+v2uWDSWlIJlNrQKzF+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2023 08:28, Mathias Nyman wrote:
> On 6.1.2023 17.25, Greg KH wrote:
>> On Fri, Jan 06, 2023 at 02:56:51PM +0000, Jon Hunter wrote:
>>> Hi Greg,
>>>
>>> On 11/11/2022 10:18, Jim Lin wrote:
>>>> 1. Export symbol on xhci_hub_control
>>>> 2. Add hub_control to xhci_driver_overrides
>>>> 3. Program USB2 pad PD controls during port connect/disconnect, port
>>>> suspend/resume, and test mode, to reduce power consumption on
>>>> disconnect or suspend.
>>>>
>>>> Patch
>>>> xhci: tegra: USB2 pad power controls
>>>> depends on
>>>> xhci: hub: export symbol on xhci_hub_control
>>>> xhci: Add hub_control to xhci_driver_overrides
>>>>
>>>> Jim Lin (3):
>>>>     xhci: Add hub_control to xhci_driver_overrides
>>>>     xhci: hub: export symbol on xhci_hub_control
>>>>     xhci: tegra: USB2 pad power controls
>>>>
>>>>    drivers/usb/host/xhci-hub.c   |   1 +
>>>>    drivers/usb/host/xhci-tegra.c | 125 
>>>> ++++++++++++++++++++++++++++++++++
>>>>    drivers/usb/host/xhci.c       |   2 +
>>>>    drivers/usb/host/xhci.h       |   2 +
>>>>    4 files changed, 130 insertions(+)
>>>>
>>>
>>>
>>> I have verified that this still applies cleanly on top of -next. 
>>> Please let
>>> us know if this can be queued up for Linux v6.3?
>>
>> Normally for xhci stuff I want it to go through Mathias for things that
>> are outside of just xhci-tegra.c.
> 
> Looks good to me, can be picked up directly
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Or I can add this to the series going to usb-next if that is preferred.


I did not see this in -next yet.

Mathias, are you able to pick this up?

Thanks Jon

-- 
nvpublic

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA64863ED43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiLAKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLAKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:08:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78252178;
        Thu,  1 Dec 2022 02:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrDgPMrpzTDhsnUXjFNPFg9BYkZRvJDZ/ot7bwIkpcCVn96kE2LLcqbheOmj1fVxRBs1zLT06TtjY5x1kr8xBvAtxdfQCcKVwQDF62hYkG8TWO/pJnZTXpVuRsIT9f+nCdkSgDUmk4j8ugYESp5Fg+jCfd4XeNW08gcvJ0DdfTNh5EctK1wHyg04H9mCbQ82C2aFRWQF7nrH3WzzoT68po6kNCfg3dvNThWBio1otrOdmrIImgsZ9btGJB1OudYZv/j3uj+lG0u5Yu/6QZlb3i1QW03NT/5X2k7mCzilp10XD47JgNuko6dmUrtzr3UnPq77o+dlJa+f5pAq4gKBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJutWvxJfpgA5ZTa6bvfsMMJ44aWj4P5azOPbBFEin4=;
 b=j/mGl3uCW4HvxRUxbE2Ca0krFC2jB7Oh4sQAl7ISySSZb4PujVw2iaLf6WEvXfL6Ud45oZDoQyWvecaoZB/R0AMi0sPfb8afOd8KbonZLWOcVLvgNCKm60TlB1pcHxTRpZpeZOvb6B1cNr4k+kPwMvwXL6vmwS7JeQpskdcxJjERG3+8ZQldMlsAzbxxzR5OEhOqT7qjqtDihKhlitTeaAzCsxENmtNDlutQ/Xs1oQvH7VH9InA3x9L+Zx8lX0tMqXlpw0aZhdYrrMU6kxEtB59ViAiIG1j1nVb78j+rJWq1qlb/sMz70Cl4kYBsh3QIWsKBHaraU0Ovp6FHO3Wt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJutWvxJfpgA5ZTa6bvfsMMJ44aWj4P5azOPbBFEin4=;
 b=a5pyIEpWP8tc1znG5Z8a8lx4MP/qRYxQENHO9HzvFCy6h5xAOLw3GoIGlYTt0VKiF4yzDvZrHl8Ibeg98lw41KI4kksxiylvFKweSlkU2+ak4RGo5LgLCkxleYlgdz0RxJ5CINLdWB266fWYfsGdM3kDf4YdEdxm4tGuZrek0k0FJXvIWGXKsIL2DpHL6OD8aQfrEuncMS1HuLJZ3IOLh8lSdhHr6HxMXEQrt4UQ4iPDy7QYlRnIO9yJxoYgApZDiJybXyvte+rA7JR8RslE5jJxjz8PZW/2jM4zwnyc+Bh25BXPEwq9bAga2Ad1xbK4cpDhqOZWMvfLc5kCHPC/aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 1 Dec
 2022 10:08:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 10:08:43 +0000
Message-ID: <459f7d59-18dd-e611-e183-8ec03fbea910@nvidia.com>
Date:   Thu, 1 Dec 2022 10:08:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] HID-BPF: Kconfig fix
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: a34b7063-7458-4b50-c2e2-08dad3840701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3o3pAi8kfQhq6RzHELNWh33gn92wywgNgeuu33ask0q6JEdCPABH9mlH3VkWT+rFE7gtCt0z6TIDVDyX5ycJd53PeBVMGQPAunEtW2GxmKADyzvacH65kBIpFGyJDyQ2FD8FT8Cmb4CqQrU1ZBMN9wj2N1kdwwEFeoKTEYarBX/Yp0HshyfmJaWRseGEY8baKINB05AEqfY+dX6J5eNpwb6dpTZryvowaDI4N4wQN0CeawkDrydu7duacoCtEH9JbWd8CIYEmKm128c+zywXSWi3KW2Rk3voWZ7Je+fKGgSHEet1/JdUbGFyy70vTltsXl47KQBg8UsyZJZz5AzkuA6me36ZfK3cy8OHqhzExWoM2MFtqJu0pi59+1kChLGfbT56evulXD4GJtf4Co8mygEL6nkyPZfNnkh/l3fkrLzfwFcomXcF8IqpUMo/b+jPGlsYt5lXl7c+S+OOb3AYBT0GHN05OuPwJlEMi50Nnc/d6haEZ/Ze9TnagIfNtYKf+DH2r7cXLkqFSQYDJM2MiqLlkSkp2AHR+oQfVFi5oqpLZY512O6ciDWv+ghw9S0Vh53DcNelcFrLQINQ1bXw7x0UybTYOueuaZ3PW3uNIpXRJAs5VPEsTIb/TUMKbm5pFqFlEmEpqc0WnW0lL44sTQozJlfmwC+o1L9/tpCj86pTHfxXqPRoE7DCttrhxI+Dv7/89ysXtwh8OuDBDtyQ+K0c9zT+5mAzGgFwkTVPiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(6506007)(5660300002)(66476007)(31686004)(8676002)(4326008)(41300700001)(66946007)(66556008)(316002)(110136005)(38100700002)(2906002)(186003)(86362001)(6486002)(478600001)(55236004)(36756003)(31696002)(53546011)(6666004)(8936002)(6512007)(4744005)(2616005)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdRbXJwS2c5c01Obm5xb2ZFM2pLZWZqYklwOThUMGlCSU56b0dkaVZaZzZy?=
 =?utf-8?B?bkhQSGVmT2NESE8zWXJiNWNyOG5BL1ptblpOT2MyQjhXc3BEZFRoc1U5YjVk?=
 =?utf-8?B?OHUreHpHanorU2V3WDZWejVqYWhMNmdhZGhMUWVEWWF4Q1BCSFJScDIzTkE3?=
 =?utf-8?B?cmlINlA3dEpXUHBja0VhSTBjc0VUZjJJU0hPS2Nyek90VlRRTmViSUpzNENK?=
 =?utf-8?B?MjM4eGxoYXUvSmtLZzZnVnVSRi8xNGtCZUU3Um5zdlRwSm50V3krMVN2VlMz?=
 =?utf-8?B?dHhkd2RSejhRcHh6TG5UVGJETU9rVzM5Um43cnIwSTd0VEpJdmJMdEt0N3Fq?=
 =?utf-8?B?VFg5RmIvbjVHUk9aL0lKUUlzLzRaSk1tYU9ldDhMZm95TzM2cUF1RjFyOUN4?=
 =?utf-8?B?YzQveGpweE9lZVRoelNyeldid09FWE5sZnR3MUdQajBidVFkYVNtbFc3L3BY?=
 =?utf-8?B?NGY4MVE4ZXVEazJucDdDa285L3FET3M4dWJlcFQ2YUxiL0FiRkxjVDNhYXow?=
 =?utf-8?B?OTlqL3haSlVrNUpWOU83MDZSNlZPeFM5YnN1YUtndmJ3ZUVOVjNSRmtYOGpn?=
 =?utf-8?B?MVpiNDI2UW9heG9oOEhCcXVrN29SdGJqYXB5WE5KRUpNVzZPRm9DQlViYkQ1?=
 =?utf-8?B?ZUQvNUlmVjV0SUZ5ZG5tSWxNWFVSYzE1TG44UWJEVkIveDBTRTBaWEdoT0ZY?=
 =?utf-8?B?Zk55SG9YMFdyWlJtTk5IV1JQVkJ2bjI4b3VRNFhDTysrSnJqWTZxR015YTlJ?=
 =?utf-8?B?SDFzQ3hHUGpBdHhtSTdyeitSYmpzUTk3Y2o2ODBQY2NtaTQ2czUveUJxNHJs?=
 =?utf-8?B?ZzFydDM4S2RNQnFkdS9PaEJNZG90VWZncUllRG9FZzBzOVZDN0EreFFPeVE5?=
 =?utf-8?B?c0xOallyOThHRHNHMEJNM0YyUFlNcHEwa1FLYnRlc2NJR1lwY05rbnhrSm96?=
 =?utf-8?B?bVhzSDl2Zk1OL2dGNXA1eW5mUWxGc3Z3ZUh6WFlSQnB1c3JTcGtlaXBWVG9M?=
 =?utf-8?B?MVlDWGJ6VzZXT1cwVTdYRGkyVE1pak1FZTVGR0FRNmtuR3daSG9hQWJWT3hP?=
 =?utf-8?B?SHJvR2c4Yzh1Z091NE9GQWIzSkJBeC9IQy9DRHV4djdYMzJQbU5tYkptM0li?=
 =?utf-8?B?KzJRckV2MVQyMWxqRmk5akpocE1tRVZlMEJlWjdUT3hFc2NReW41L01PTWE4?=
 =?utf-8?B?ZGpmUk1HMno1YjFrR2dWRXQ1eVp4NWhrdUZZVXBnSk56eGVUUityT2pIQW1y?=
 =?utf-8?B?aHdOcStrdlV0a2U5VmdBUEJuMU1hUWZXbi8yQW5vSEV5S1dwRjdpSDBUSXpT?=
 =?utf-8?B?UUFGaVJsVWJPL1lnTlVXZTYrY1dQZjZVNUk2OWlOa3JhZWhiNWtXZlZBRVE0?=
 =?utf-8?B?QmdMU2RpY2RDWXArV2ZzbnBBcGdIWHhsSytsblZ0R2lUeW0vc0VPdnpLckY1?=
 =?utf-8?B?QjkyQ0dFTWtuNkV6dVhiTWZPamFjdmpUeCtxUXVIMWY0czNkRW1FSlRXZ1dR?=
 =?utf-8?B?NytGMjRZbUE2VlFHK21iOUcwcUdYcmFyRk5LazFvemVIVkFFczNtcjF4YmRp?=
 =?utf-8?B?TVNZV0w3TGZiQ3pzQU5FY1h0c2c5UldGSGFaZ2FmRmJadTRSSi91ZlZoQVU3?=
 =?utf-8?B?UEdERUs5eXMxVk9tOHZkK0w3bmlvQml2eW55TmVwT3hsQW5qS0dvQkQxaTBN?=
 =?utf-8?B?cjNIYmFVRy9QYWJVNjJ6eVo5cVY4aStVU0pZdWFBTitOWWtWRXBsQllLYzBq?=
 =?utf-8?B?ZERXVXA0OEN6d0U1c2FmaGdhSjZucDlNdlJxZ2RWcTZFLzR1Z2RPb3VTbkty?=
 =?utf-8?B?eTRhR3dIeThMbXl0ZHFBYnh0U0JQcTVtU0NTQ2pmaTF5VFZXZkdlaHBOeVI5?=
 =?utf-8?B?dCtTNytOVG5NbTlWOFNvd1krcEtHUmxIWmJKSkc2ZHZWZ202VUoza2REUUd4?=
 =?utf-8?B?TnUvaTZ3NDRnekFYTm9ibHNTbEQrdmloaDNjV1laMlc0dit3OHZEekwxVVp0?=
 =?utf-8?B?KzJjNGlqVlBXaTBITjBoWFQ4ZXhBeVBnMmNTb2I5bmdJS2Y4Zm5IeGlWTXNB?=
 =?utf-8?B?eHAxOXkrclJINEd4UjRtWlZSSzBCZkZjeW1rNFJWdCtJMWlMKzVNSmxJY1NH?=
 =?utf-8?Q?k388pzLnyjgQD6fv+8zSptj5b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34b7063-7458-4b50-c2e2-08dad3840701
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 10:08:43.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRLxzMB7nHLoJf4sOq94waBM6CHk35evnGO96CKPbOsn8p2AeCkyQtCDL0Bd+ahcU9vh0pxWfI/KA4SrdCDXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 30/11/2022 10:10, Benjamin Tissoires wrote:
> Hi,
> 
> As discussed in [1], we need to add some more dependencies to HID-BPF in
> the Kconfig. This way, when fmod_ret will be available on arm64, HID-BPF
> will get enabled automatically.
> 
> Jon, would you mind giving a shot at that patch on your test system and
> confirm the error disappeard?

Yes will test today. Thanks!

Jon
-- 
nvpublic

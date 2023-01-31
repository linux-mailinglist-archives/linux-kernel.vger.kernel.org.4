Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CC682D77
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAaNMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:12:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CD4F857;
        Tue, 31 Jan 2023 05:12:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOto/HA1Ril96+exzklGfx/ZDRvTttZttNBN+Xfut9Jrztj99AzG6FJ6QCtpkEqKGKXAgBsynT+S5UySmR2SIBMxWG297XQR78zmj1y0hd3I/36WIk+0lGV8Ib6uRIwnRNzr8pK4qv/nvlXHSCWVhShWZ8OV5lKapxH4GRIpvaQI4JbayizX6upnmfy9gx515dXkaWgLAkV9KrUY3hb/pYIJ7kP6LIiVXD5dMEO65deX1vTtzozXbbewyeAMb5shRtwLfC78XbJXdyYlyE9G3GDmxqHqfUOsTmNH2/89oY2LI/lUyim6AB9BzYy2yq0k2/XThcAZpA0QPqZm3Xmcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKykKRghwUAS68w3awqtk2Zld9/IzJaBWTw+CpFv7T8=;
 b=R77Rs8MkozCmnOIf9v266rNs0Gswht5oAnl7o6zhslNDHdMuXbi6T2hzJQhFtKD+niLpQIvSX2NqyqQ1w7yCXyc47qZMKJIChCyxbLRdF83Wa79NtTpLekTv/ErrhkxXS3urOvFTTjtdV8yWabGn3OQfnfIsA4kZfPD5p394A3ck/ssNdFDgl1XPbIV2ddgCr3Mj9PliUAL+np0O/69QoA0yUj3RCBZ1KH/f/2aetc0gQhXjdWQzh3D1GVJRRFv9VsnwemTecj1ugHObRu9AfZ++2QjFiBEcgokwMB3X/uygFDrvlfQmWvGVSUapWI7W5BiObsHbBtGQgNad7wzJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKykKRghwUAS68w3awqtk2Zld9/IzJaBWTw+CpFv7T8=;
 b=TXRIVVLu0dn9e7BaPqCCXQyQD3dw4bfglkZZ+nIZgt/VaH3DmAEPmtaCDXJHyuhOJGofYl1y4CUJUSYZ8nAa1hMlJCHQ1oJ/lOT/rvEfERQDA7Kcnoe1tQqIg5rzA0uxuoe9GoGxBhMHs61BZyO41EuUKXLcYVmG5ll/VJFWdMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:12:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 13:12:15 +0000
Message-ID: <e632c739-6bfa-9725-7e9f-980d433dde00@amd.com>
Date:   Tue, 31 Jan 2023 07:12:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-7-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230131052141.96475-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:8:55::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: e01d193b-fbfd-432b-2904-08db038cc5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uykWLym+0fQm0idERb9VYuoVxyokO47chdfwZT8PT+g3R4lAADkn3hH76xkJ/xclSiUnZaeR/LkQWR8u8HSBMmnLYyKy8mrzSad5VYbdeQb7VtzPqfFcm1vnJhposKvWPFvkzfNE56wt/AEw7v3kL6u5YUXsX76yV2gcrDjU4gHdxU+V7pkCr/QJJUZVhCMhb3rUUiv5Qiu2Y3FvNRppa1vvh1M/iy46FIGE8AIRnwYWvnwLp/gG7lkQqO5VDn7tmCdggc0VwigprfsTYZOg2LwYAxn5fDF2WxBJCvqC71uq0ZbprrYEgGrw/uFvwJMYBWEGztbBH5tz04oJkE+6f6AJCk1DFCLRmFasTtydIRXaoeyc8SenAJL7n5jsgEfZRS8q+A567dMkXCeTHy89Rl1pVuT/ycGpLsg/yS8G6jFVfo8ThQNJeIFFejYpnRV6MDpy94Kmb3LI4aSZqeyx/PrucpSDDwjOoVcfx+WKdJSvDbuZ+lNh57Y5NwpfQZ7QtKpgK+8LSk9RkiFllS+PxCbJKYOJQba+Dmr+L+F0Nlqy/Y42/i5vahV4gYQAnByZYMVoJwMxa4ZWLQ5CnbjWZJ4RBd7M27FVD3/XZbGmqujKTYdv0sHTviUKK1ObzhcrrsaxUY/Kz5MsMOYw6Tv1KHuZssdTME/DvQYcQRaWjdtEGzjT+u47oTfzMrSTliAIVMy6MoXw7sU/9eb9gr0ESdgYbptiuQKP13Kh6J3TeSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(31686004)(83380400001)(66946007)(66556008)(66476007)(8676002)(2616005)(38100700002)(41300700001)(6506007)(53546011)(6512007)(186003)(6666004)(8936002)(4326008)(86362001)(316002)(31696002)(6486002)(7416002)(36756003)(44832011)(15650500001)(110136005)(6636002)(2906002)(478600001)(54906003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdjY01jVk5xdnBSOWNjR0lDM3V0SEhkbVk0bXltVHNmbkI0K1Iwa1JlWVJj?=
 =?utf-8?B?L0g3L0xicjNHZllncTZ6OXZ5bFVaOTRvcVZjWjkwS0orTGdtalZVUjdYS3Nk?=
 =?utf-8?B?a1NpcDh2bFg0aVltVUlDaE5vbnhWRUQrelU2ZFBrbDNoRkl0VFhBOUxsT0dJ?=
 =?utf-8?B?MUNnWjljS2cxbEltYzloak5KQWRjM3pNZjRJYzdqZzBQbUNuMFg3T293djV5?=
 =?utf-8?B?emtxWGoxeHJzd3h5b0FzYlZsMTd6YVRvNllRU2F6bElxNGpZWkNYK2Nmc3JI?=
 =?utf-8?B?VVkzaFR0U2o3TS9PWFU0VnlzK2lhVDRCbVVkYTIybXhVN09nMmtxRDFKdEU2?=
 =?utf-8?B?dFdJWWxzcExPL0d2eGJiR1hpckdVUzcwTjJ4RDR2dGlFUUZWMzNIamw0Z0h6?=
 =?utf-8?B?aytVZGFxSExyRzFhR0RlcjhFM2J4N05xNWxYV0RoK2lPT1pQbG4yYkhlRDAw?=
 =?utf-8?B?OThoS0JDaWg4ZWxUWEEyMVFSNk5mVDNtSnJtSjZkcTU2Y1NBdklsMDFZTjM4?=
 =?utf-8?B?NVJtbUR6ZzNHUHlzMkRuSW03ci9rNGIzSGtFUXRLSEk2R0cvUmFpSWl2ZmVE?=
 =?utf-8?B?K2ZKaFQ2V2c1dEp0S0FzSkJHUU8rZTR3ZGVSZk5nNWg4TjREU0M1bGtIVVox?=
 =?utf-8?B?cjZsa1ZPeDVoTHJIK09vc0pHUjRod0N1WlNZY1QyV0M5NUk3Y3dYZ21sbDZm?=
 =?utf-8?B?NXk5Ym9xNEFYWitBd1N0U0JIZjFMeHduVGJoOWFRTi80Qk9qRzJjb1Jad1Rx?=
 =?utf-8?B?dGNHbGUvREVVTU41NUpvcldiRUFyTGMzamZ6N3pWdExaWWRsM2xVV0NNNk55?=
 =?utf-8?B?Y1I0cEc3K1k1bTBIREVkdk9mRDlvQVFTQ2piYUNNR0p6SEFMaS81QkNjblNo?=
 =?utf-8?B?K1lrdEFjbm95L0s4VXFTd25RNjMvRjMxYXRBWlQ0b0RaY204aStHZTJnbEVz?=
 =?utf-8?B?M0lPODhNc280aUIySDg3bURwT0I0V2VUMUlVcUxHTEdRaDVibWhOZC9OV3FQ?=
 =?utf-8?B?ZzBmTlN3Um9pM1dMV3M0d05LcURqWFo3Q255WlRHWTkxNjVyN0kyZmFmTkFH?=
 =?utf-8?B?TGJqcmNsbW9SSzByL2pXN1U1dEVLVFAzeWE4dU5CRVFBU1NBaTZGWlkvUHQ5?=
 =?utf-8?B?OTdpNXhLc1lWNk9YL3FvYW9jQzVmQVUrRExJMzg4cUpvWGpVZGtlak83N0R2?=
 =?utf-8?B?UmM2d2V4R290VXB4M3NjN2RDUUpKUnpmN0V2RUo5a2F2b1Btai9jMVdSd01S?=
 =?utf-8?B?eGFpZ3R0U1dWUWovOUFKOG8ra3ZwS29hV0NnU1FMT25UcHpvKzROTUozQ05l?=
 =?utf-8?B?T0lBZ2p3dmQvM1VaTHJ5WUdXOTJyMHBWaEgwQmtCOWxQSk4zL0xJSEIvUC9E?=
 =?utf-8?B?Wmd1ek1yOXE5NUhubjYzRnBQR2cyRWxpSDViZ09qc0NmWTVjV3dsc2JkSzF0?=
 =?utf-8?B?Ky9zZmhpMmZjN05DTS9DNFNGWVdZazhMcUFnNlZuVXEwWmdlcnB6TVQ0UUo3?=
 =?utf-8?B?ajE4UEZyMUI1bVloWUVFN0F2Y0pWcW9PemphUEV1S1VpWld2STVzd2xRQVYx?=
 =?utf-8?B?K1lDQjRpME1lNlpGRFRPZ25NNDdXTDh0WC80QTRqNS9iOGdjd052Y3hLSGpC?=
 =?utf-8?B?YU1WVC9xVkh4Q0kxK1Z3TzZldSt2d2tjL1dRQVpxOWhsQ1drQkkyNEp2bURV?=
 =?utf-8?B?eWU5am5UM2N3VUxJLy9CVGpLWE5YQTRjYVg5b0VUT3MwVEQrSytFZDJIYjZq?=
 =?utf-8?B?bGJiVWx5NnBFRU1qNzRhSUxObUQwZ2t4Z2U5TFoxR0tzck5scnZqamN0ZjJG?=
 =?utf-8?B?UnQ5blBzMlFMZmtFbmFoeHd5aDJkdnQ2czVXNWhpclQxTWg3NGZoS3ExYWJ6?=
 =?utf-8?B?WExrQWhOblNlamFQYkJTRndkQ2Q2N29zbW1IV0tQengzYi8rbDBWOFZFSHhH?=
 =?utf-8?B?ZTdmdjAzVjlHcld4Sm5pdzE0SHZYODRTc2tNN2tLbiszTndRZjdvazJCNnBY?=
 =?utf-8?B?bXNnRTl4aGFJSndBaTlIU0ZjNHhGQnB4OUdZVVBaaDlNYUZoV0JCSHdIaDNS?=
 =?utf-8?B?MjRSL1lLMGV0eGxkUEVnZklqT29wVTBQMThhL0V4YzJ1eHJhT2Yyc3dSblpP?=
 =?utf-8?B?dlFMczNDQnhidGgyWSs2MkMrNy9NMDRTWE94OW9lMUJEdjR2QTZ4MzVyRnVN?=
 =?utf-8?Q?SHUz49+oPN67j5BO4RyT5xSQ1dorbrlpPKzHpyjKqEwg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01d193b-fbfd-432b-2904-08db038cc5a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:12:15.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc25ih5q6JGPL4MYzYeW+zRFc4XtpktSlhYmKTTdRS14Vf59Sx5Fz65LMkGrhD4pDuu5+GWWCjbC6rpfESQB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 23:21, Wyes Karny wrote:
> Update amd_pstate status sysfs for guided mode.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 5304adf2fc2f..56a3d11f51a5 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
>   AMD Pstate Driver Operation Modes
>   =================================
>   
> -``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> -CPPC non-autonomous(passive) mode.
> -active mode and passive mode can be chosen by different kernel parameters.
> -When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> -Target register and takes into account only the values set to the Minimum requested
> -performance, Maximum requested performance, and Energy Performance Preference
> -registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
> +non-autonomous (passive) mode and guided autonomous (guided) mode.
> +Active/passive/guided mode can be chosen by different kernel parameters.
> +
> +- In autonomous mode, platform ignores the desired performance level request
> +  and takes into account only the values set to the minimum, maximum and energy
> +  performance preference registers.
> +- In non-autonomous mode, platform gets desired performance level
> +  from OS directly through Desired Performance Register.
> +- In guided-autonomous mode, platform sets operating performance level
> +  autonomously according to the current workload and within the limits set by
> +  OS through min and max performance registers.
>   
>   Active Mode
>   ------------
> @@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
>   processor must provide at least nominal performance requested and go higher if current
>   operating conditions allow.
>   
> +Guided Mode
> +-----------
> +
> +``amd_pstate=guided``
> +
> +If ``amd_pstate=guided`` is passed to kernel command line option then this mode
> +is activated.  In this mode, driver requests minimum and maximum performance
> +level and the platform autonomously selects a performance level in this range
> +and appropriate to the current workload.
>   
>   User Space Interface in ``sysfs``
>   =================================
> @@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
>   	"passive"
>   		The driver is functional and in the ``passive mode``
>   
> +        "guided"
> +                The driver is functional and in the ``guided mode``
> +
>   	"disable"
>   		The driver is unregistered and not functional now.
>   

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

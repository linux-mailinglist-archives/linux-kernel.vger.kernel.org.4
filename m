Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9268E8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjBHHQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBHHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:16:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC524CBA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz26Kfa4zeAR6u+EJiOGBqAeKblEg/LPdBTPELFJkOXIa84p2esGLUDkyXf5oGcfjlig/iFoRxjbtWIsQAvxuOINQKpsem1U8nRIbx+dEf2bEHuKrwzTg+R3i2lt1bVNeL9Rg8Sr3zjHqH9F4DV8U/x4XArMc50cEunDBcSo+eQvH/2pIzRvTl+qHbgRMWWYnj6hrdR6nw+88TRzwtyvRYqWh5Ycpz5Vujq28BpMsC7+ZJihu/o/UwPySZg7QElROP2rnzcHrlrr67qAq1ZGMvJIdpvdd5p1BdnAqZoOk99IHvriHXOI+sUlWEMdHLMxr65dbkyB7qYFQ7T16zR5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxOkRKMNkXWngKAtReZpwVJvH3E/fir7ln6ffaavgKc=;
 b=LCo5Zv5otIkhKNGKjsoKmmk4souN6YRn1cv9g54FOuubDBmcrgQ/A0bdscn/XcQOJZaSXBdFGgt6LO3W+e7X4/JAUPSDNyIaF2G7c2egAniNo4eO8WPxJLT7SyJWToT9s6/NpReHkb8BECikEB7aUApQs3oQJ+vi6n4zFWVw0c3tCP3LkXLK9PVP0D+e74d0ZSeLgbrD1T9bA62MbiFmOOiDbfLPdlnsGNnADxQXCzLymOxqoxezU+MRW4T7mU4XXUDXtIziUN0p6OC5Cq+XBrQGndR62oiiJy9ydesH9hiKNNmEPI0S4RxuOsDp6wYqKmORmBeShj7bY6GnbvA0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxOkRKMNkXWngKAtReZpwVJvH3E/fir7ln6ffaavgKc=;
 b=3mWG91kJ+HIEeWau1XddeINejxXDS0WtcqIhCA/xzcJhKWEMhdPCP3pgbel0MbX1cIaCVHJSVlrapChD4N13vC9+H0UmesrX6RBdpR9EweAL40CAOMsr2VtrA6X0ngrrstw5gLle5PcVqyvHX5W64ax3uIrYbNJQbZd9Si05KPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Wed, 8 Feb
 2023 07:16:31 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 07:16:30 +0000
Message-ID: <f1d1268d-6232-0428-4aef-a002eab6e16d@amd.com>
Date:   Wed, 8 Feb 2023 12:49:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] soundwire: export sdw_compute_slave_ports() function
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Basavaraj.Hiregoudar@amd.com, Sunilkumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
 <Y+NCL1MdgwcuLTLk@infradead.org>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Y+NCL1MdgwcuLTLk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8caacb-1871-4036-e1c0-08db09a466a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFVmX9vBspkDTVcObS1+zrRruzM8zKjF7DDCfaWmaG9UnURYYWry6iaRw0/r2Uw+nMROT9C6N5ZG7/OAeFjvW6+lkGjOD/cR8ZeuYxaxg9AILr3eSep6UTL/EbcTKAq3DpyHACojOTMXMFPpNhA+YKZV2WAjsuHIyHGvhhU9Vy4t6otviiwY8oI9NHWtgjac3/4jzVvA9lDfwoCRZ4lQeLnwGKmq5b87pA9mMlmrqKp1/aW+uQ1rjjOTYjGNDiZBQPTtGRFOgEDnW4HxiKtNC1jgqPOngd3Rh+KhLdXYe17QZVGSE4Ust3UUiU1yQtfNj3+uS+i9B392GOJGBAKJjq9Y4O1naeI6m4ViX8EwjwoOdYdLpoDMz6kVDXXXoh8P/mFULly9B4OKObXNnRSvUAA721Kwg16iDwSvCEakl0tiYbolxzK85OoFCVzp/Z09P+u86AvglGuAYvq4Bm19PK8uH+dyNxOH5vLuehPVzfclrMRgwFRQHepZGmyFKIEcu+2bZpmInWO0h9BzGsmQ9kD1TjH9wm8Lnt+r+D0V1JwweErQ/uL8soLJH7a3oycEKQKJvP11nrF5HCzdUMdqfH/Oc1OjKdOIuyEJWYj0DHOr5PjdgLN/jAj8kqxvAjAj0BYxDH4ezuDvlWzACFZOQUg6Hq10Z5yDl5Z4dQBMfGyA/sdHb8tC5+91VEwH2cphRJi+RbEuE4kIWaxjEF9r5M2q5HlSaR6cX5/LuLtxUYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(5660300002)(6506007)(86362001)(53546011)(4744005)(26005)(6512007)(31686004)(186003)(8936002)(2906002)(8676002)(66946007)(66556008)(66476007)(6916009)(4326008)(38100700002)(41300700001)(316002)(2616005)(31696002)(478600001)(6486002)(54906003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejl3dU1vTGZOQnZzV3RSL3hsR25mOTJ3Q3ptMWQ0U1hYZlBIWm0rUG9lU1l1?=
 =?utf-8?B?WGJuT2EwSmIzN3BBb0FPVTBsR05CYzlnenpicVVKNjNuYXQ1L1VSL3dLdGYv?=
 =?utf-8?B?R3luNDF3d0VNY2tTdGhNamlzUksvUmlEUFQ5MnRqcVRia1Z2RkpuVmh1eFVZ?=
 =?utf-8?B?aGpjZCtsWFJNLzlCYWU2Qlh3dEhtUTRZS25lZGRGSnlodU80RE94RHZaZ3Rs?=
 =?utf-8?B?U01FYmVtR29IWjVtTkZ6aTFYanNJSlNidnBGWHRPckF4WlBRTWlMVUUzNXls?=
 =?utf-8?B?RElDSlRrK0dYMlZhdkdwcW9jK3R2dVRWQ1F5Um9UdGtNSDFXdkpDR0pIbHFJ?=
 =?utf-8?B?VEo0UGduK01NMEUzclczUk9WViszNW80WG1WWnVUNkRGckRJQUVQcUJ1bWJy?=
 =?utf-8?B?UnZxQWN6NllUMDNjZnYyaTN2T2FTMmdIaGdrdGV6RW1sN0ZzRmNhV0IxWmJE?=
 =?utf-8?B?akd4UVVCV0tkbzIveFd5d1V0OUMwOEp1bGFzOHk2bjBhRFN0WXdVb0YvRVFz?=
 =?utf-8?B?OUdlZkIxWWtGS2libjBnWmlTRnB2K01DZ2Y2bElIbkR6MUlpa3dWSFRVcjRz?=
 =?utf-8?B?MngrTWdlbWozOFprclN3L1FxL1QzVWlXaUVWY0p2WGttVXZ0Um5QOFRUR1Nl?=
 =?utf-8?B?aDZhbm1PcnZ3WkVPbzA1OGRGUnJNdXZlbFdraFYwQmx1SlEvYTZGR2VUdFRi?=
 =?utf-8?B?a3RsNHc2OGFtK0tqd2NjcjV5S0RPQ0NGeDBYaXY0OC93N2xLcXlrMWZuZ2VT?=
 =?utf-8?B?UmFCRnpjMG5lV081ekVmQ0NCaHdNSDBzMUhxTkVUanJpSjYvNHJjaFRLbUhT?=
 =?utf-8?B?Nm4rRFJpc3dycVc3WERXUmY1cnR5VjU5dzh2M2twTmFPRkhLRGoreW5aZEZS?=
 =?utf-8?B?c1c0MDAvR1BRb1pjeEd6SmRBRUtMNk9vcmxEdU05OU1qZkpFMk9oQ1lsT2t0?=
 =?utf-8?B?WmgzVDJpdFJ5Z0tTZ3VFUjRLTHdVanM4U1NxaWJNY0o1Mk5DRWV0bGlmQWJm?=
 =?utf-8?B?b0pGakFPNG5EelAzbURwTUh4NGtOc2M0a3hNcnU2c0dqMC9BQlBNSTRzY1ha?=
 =?utf-8?B?aXdmcjZId3czdGIwdWpOTXRuV0grdjVoV2tLbFJjQzNIeGN1bEdYVEM1UWFI?=
 =?utf-8?B?YzdYSXkycXFpNllwMGJZSGhCOXo5K3g5R2lQRzIxak1zY2cwcjVoenJUZWNZ?=
 =?utf-8?B?TUc1Vksycm55ZDFldWp4TXRtUmFzTjI4UTRsdXg0QTFHQXVzUUROTWJLWGxM?=
 =?utf-8?B?Z0JscmZiMTN3Z2lSMUptb1NuU0FCc3BBWGxJQXdER2p6ZFRtWXdEcW1Jb0Rr?=
 =?utf-8?B?cHd1NE5RU1B3SG9rdElLQk9YMDg5Q1hpdkpMeXVjQVJvdUpGOHh6Z1FyQU9w?=
 =?utf-8?B?QU1QYTVjSFBFY0JocG92V05LbXZpNXlyNUw2N2N3UkxRblJyRWRyM3ZIQXZL?=
 =?utf-8?B?RDhEMmZWa3BmYXlrR3VoUTBPbGVHVkdJclF4YndGdVQrTy9hc0dhMFlkdzJM?=
 =?utf-8?B?eEJ4bDRPbE9SQmI2S0VpeDlhSkpDb0JYZDkyaFk5RWZFMDMvTjdkeC91ekJI?=
 =?utf-8?B?b21obzFOOVlzMVI5b1AwRXZMK1lUa01aWEE0ZzhZRnQ2RG1tdjBSVERjVExm?=
 =?utf-8?B?R3diT1hSNGQ3Vm5MekV0dmZIUHhHU0JlNTUrMFU0V2t0VElwK1BKdUcwQ0hK?=
 =?utf-8?B?V082MU9xVHFVc1F5NXdwZTZQSG9zZHphR3FWWnZldEdadjVDQWpxNUhXbnM1?=
 =?utf-8?B?ejdYNWx3THdVY1FXcDNjVUoyUG9GOXZ5VS9hQXcwamREbG9oZU9jdFpmR3o0?=
 =?utf-8?B?c3J1ZkdCQ28ybUxCS0VHMW56dElGbWpIOGcvL2U2TEgvTHBaM1FydkNyZXNK?=
 =?utf-8?B?Um1pVDQyaHVVcm9HWjFnWnZOTjFZRnJUUmhDWHRUbXdORWZTMExoU1d5R0p3?=
 =?utf-8?B?TUd1SXV5NmZ1eGFzcGdHK1hORVVmdFFiOFp3ZTZ3c3dyS21sbU16L09aeDNn?=
 =?utf-8?B?TmgybGwwQnBoWExid3pPY2RmZWFYV3lLWEFwQ0pkRDBjQWgrSEFmcm82TFBY?=
 =?utf-8?B?aXZad0MvQ2Vja2JGMk0zUVRLeWR5dUlzOTZ1TUVMYWxJZnRxNkxVRkc5cFdj?=
 =?utf-8?Q?Ki25NEQY2Dd8shXfcFGRtb8Ix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8caacb-1871-4036-e1c0-08db09a466a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:16:30.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVkgOR7gOb3sn9Lf4GCl7rML15iYUQPzZ2pgfJQv38UXoJ/sFsCQsE6phbiKm4hYsFHLMR/F/8E61V/cL6pdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/23 12:03, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 10:29:44PM +0530, Vijendar Mukunda wrote:
>> Export sdw_compute_slave_ports() function to use it in another
>> soundwire manager module.
>> Move sdw_transport_data structure to bus header file to export
>> sdw_compute_slave_ports() function.
> You might want to send this along with the actual user.
This is a dependent patch for our soundwire manager driver
patch series. Yesterday we have pushed this patch based on soundwire
git tree. If the patch is not picked, then we will resend this patch
as part of our patch series.

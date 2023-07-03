Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB27455BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGCHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:07:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633ECC;
        Mon,  3 Jul 2023 00:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ/NNG3ZY1pBvRzn3KzF2h60dohaCFNy2poptrfFfSZOK5R5Mv5EJn6oWm5lCkSrFlKUVkikX6hXPUkoV0qJztLsU3KPxVKAnVb8qyptFpn/KCz07bjdvpCgIvlkMSlbbSKWKM+P/TEKn2mXtS5Dt2ag6HVJh5A7ishr7egWH1WAzrpRhIRvnjpet03bjxxaYtpC3CYejxNnEj55QQRivmrIVup5BDgYl3QcbeRCl2iUUfEly7Zj2cpHGzrrKLqUsMqbP4/+8O0/lkUEYDU3VLvVBtgcRAoPoHucQsjI5XXfj0C7TdsHRoIswrm/zU1LrOD8zcHv4fvi1sF5ttIupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm7RNQgRQZwLlXTT4Ru8B4MQc5Xw5tfDsVtN6SgQaYA=;
 b=OjNQ1xhEPTjCxtZPbX3TQ8mZ5lFZzt0N9f7SvgXs/mGFFJZzh7nL3ZQon8UvHR9Brctb4TGwi46RkE0WpqlXhrgoKNvYj3loyKYSvBlw4Niho7mAAIyLGgzeDHyQRNhrjU4vlBhJJegTa9yvB4pVFroBayqpaN25Z8j5sWywmdqQ/tz2mp7+ihL5yXW00/Ahy188duGsVn0rIQisKUFXfVviE5UtQ9jEdqfkn145CqljOveIYuEX/H16Pi02YxeL21nSrMVOtxONnKDzkCEgamql7vBSuigkcDwJwNemDZjLul4UZjS1zRRUV/9jxfbCgum4Y8gPu5sqMDTJvopffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm7RNQgRQZwLlXTT4Ru8B4MQc5Xw5tfDsVtN6SgQaYA=;
 b=S4en/C3mJhXyHUB/h+JtQkqI6IuOEMiA5uutB172BoejU5bn8FlqA0SL9Wx8AyOJIogTizyVqIa7fQwagp/kt9q3i3BVyryOA1svro/0y+8fs1Sy+jlNR8aqv6TUyP0L5z6fp+5d43CyOuKpsfzNDOZ0rVCto8ZfXqucd5zhRkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:06:59 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::762c:9254:a5df:5d5d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::762c:9254:a5df:5d5d%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:06:59 +0000
Date:   Mon, 3 Jul 2023 15:06:37 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Add sysfs file for base frequency
Message-ID: <ZKJzfbbMFRQO7xov@amd.com>
References: <20230629135454.177421-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629135454.177421-1-mario.limonciello@amd.com>
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 791a028f-9ccd-44f0-898e-08db7b941817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXlOGQlo22eMtZB8QQqSM6nVYlo9d43vYIFRc2QluU0JEHjjybIjZs4mxEcOMMHqwoOymWhPkInmZob6F4B1FedW2gRdButvrIxaPlSu9HFf3DCPMM9lBx1rEB/N4JAKf8f7H2V+F/o28Nrd2VEvXxJVyzp4Xw0sMhlPR/zsFklyJlR43da19ETAWALfiPuZsbdKhOR2dh/u9MdC55jmQtlps4dj4FiBuRneQ3tl7O9xS9pzM4GuZIrsNMkVnqVbo2fW75er926tHTzUjakN+XNeAbB41iMP597Qz/dSe0UOb60mBpBCu35eQ+KurID2Aym27I8QDy/vcgLA48/3hUfUO/lR1WSxCq9IINgi2SfQKPSsKiTO0u3hYJST4lM+hw5NdFuMCQq8l0sC5MZMy5041/fJRGX9vFlSE1L+hVZP4JxOFaT4zqdG/L+l2iGWLZSMv/bFCiKJidjGWUqRSKjAnpz/f2OA/ZE35xqgiX2CmFG1G6V0ukPLzJJFXXQT9yOKatvF51CFAFk5abOYj2v1W/vCB4wpX72kFXJBbeMJi1biW9vyJXGvMwnXupbd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(41300700001)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6506007)(26005)(186003)(6512007)(37006003)(54906003)(86362001)(478600001)(316002)(2906002)(36756003)(66476007)(4326008)(66946007)(66556008)(6636002)(8936002)(8676002)(6862004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRaIl0wtc2n5sI8VQBTvMdI1bFPdAVmddg3jtmDhG6ioZU036VsjM5m5OGO+?=
 =?us-ascii?Q?0xwOth8W/dYW8rtDKV1yDNyUcKBspCHsY62gF47vos4gwapBgUhQfeCvxPXZ?=
 =?us-ascii?Q?5CTXYzaAlFDoHgrBsqoEvP1UVoqfVOvCtAhU/dK0GhBMJ0FxOxXmUKzkJNAK?=
 =?us-ascii?Q?6n1Zn0I0ajLLtCFO5n/E+eGckhlfdI7bFpPuT1nISgD30qpWWtiZ00MRPclx?=
 =?us-ascii?Q?ukdx1oVuikTk6neVfsKVZxoxBMaYPHpQz8NA5VzJEOETHA2J2DUpUuCWcN10?=
 =?us-ascii?Q?bET/EjLQqSOBWD8+JoIWjIYzbQOhvsidrh/9+CqhAxFkXOn5F1NFAg9dqpdI?=
 =?us-ascii?Q?62avbs8+wRLB4l4+8LLp8oeCe6Ky1kY6vpasom1SbahG0jmYeZmmQNPmGyZv?=
 =?us-ascii?Q?MPjdGnkMkLrCRkMXmOoX6PpMuelr8uVXcW50nxr5ctJDBQR46+CLawAvAwqY?=
 =?us-ascii?Q?hzyf1u6b2eyLuP06lg0rYGe69wC3gihE3jWcgCYtSOpDF2dDw5xaqGzL0Qi7?=
 =?us-ascii?Q?iLjlYZYkLo719NeV56lV9GQTNdVORyc1jRwjk8pHtBBr0FrcSXOQj/t5hH7n?=
 =?us-ascii?Q?ko6+HgijnDhzL9lDEFi981J7F1QiwetGJxac0izXchW5Sdp5LZxFqWkTHwzD?=
 =?us-ascii?Q?ApLvWmaQHcVteF1VXTsCwObNclBPZpoDdmdUkFWma9/B8WgCQ+grbzE8csG2?=
 =?us-ascii?Q?NnIRDkbtYqfKaKyuP58ADTXmFFfl5sTG95DuZDD//qpN7LdnEF1Ov1RxfkIx?=
 =?us-ascii?Q?l7dHvDJfx6Tcax50rASf0m5ysbbzMwtF0Jq50Z8R9W8nuhNkWylLagtAJGSa?=
 =?us-ascii?Q?7tN5vKwaT4VbWIlrx5D+0npjZ12of1TaezcITRpyBaMP7uchmc74e/Y1jN42?=
 =?us-ascii?Q?9eT8FDjiPhk9XyNYEuz9MguPPfVNJ97i/W4dYe9HeSe9XHY04s+T7deSra7x?=
 =?us-ascii?Q?vg6wPqF9fFAtK0lUfmAWvXH3Afw8hi88UsjxWezBfdq5bVxh60+ZFPu23x+S?=
 =?us-ascii?Q?ErJIqJh8p6FJqDP2BjNg+hqmgY2yAYnyCMolTAdS1lEyIihcVHl+Kaw/u24/?=
 =?us-ascii?Q?BrbzugoXS2VJaqLydLfCwz/lcYpCNwMm00xrHQGfq6HwV5sYWT7SUQcimYlQ?=
 =?us-ascii?Q?7FqgwBh5A1XHlyg/2kSDIKTHi5oGyPofxUl8mYmx7TBYf4B6Bc83Ipy7dEAA?=
 =?us-ascii?Q?secjZxXPsSYxZVOJMi2onUHQbCcvHnbT6Z1GgWle+r4I9iUDSZ6xqpGYBVgN?=
 =?us-ascii?Q?OknYzDHxN+ckLPbn8wn8C6gCCxewkQw8+ahmXDHZHLglJLf7pjuESsFU87Zy?=
 =?us-ascii?Q?FhIID+D3QPIqxT4aHx240GgAlrYuDAklpUKHHsL5T4Qic9ooJ8RzKosczmYh?=
 =?us-ascii?Q?Fb+4EYsSVKjU/3iY5gpa1rIucYE5Iu1DnRn64khQxt7tfQDxS3dfaewsTKRA?=
 =?us-ascii?Q?tZSptUYPjPdIMo4ViDDYMaHVPEJnxxYoc7Btsu6Z5TZVE31OeM8/TWsI819s?=
 =?us-ascii?Q?NthO7ECaO1a8h/wXXDITRJRfXjAlSRGz+YP+MCCqjuIbQCdtqQpFtrj4xPHs?=
 =?us-ascii?Q?HypmsZutjpFPSL3jT9IEvbKHq/li9IFEZ3d9Lzbp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791a028f-9ccd-44f0-898e-08db7b941817
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:06:59.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq+q6YRt+mqVcq9R5HmyD5XEyWjIur8h86iaOC+NTjCRsrQzWJh4RagU7NL9aZ/pC52v+i6y+ceKZ51bUp1Vdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:54:54PM +0800, Limonciello, Mario wrote:
> Some applications may want to query the base frequency to tell when
> a processor is operating in boost.
> 
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Co-developed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  4 ++++
>  drivers/cpufreq/amd-pstate.c                | 15 +++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278cd..e68267857e859 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -281,6 +281,10 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>  firmware, if EPP feature is disabled, driver will ignore the written value
>  This attribute is read-write.
>  
> +``base_frequency``
> +	Shows the base frequency of the CPU. Frequencies above this will be in the
> +  ``boost`` range. This attribute is read-only.
> +
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 81fba0dcbee99..0fec66b3f7241 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1037,6 +1037,19 @@ static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u32 nominal_freq;
> +
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	if (nominal_freq < 0)
> +		return nominal_freq;
> +
> +	return sysfs_emit(buf, "%d\n", nominal_freq);
> +}

User can get it from nominal_freq at drivers/acpi/cppc_acpi.c:

show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);

Thanks,
Ray

> +
> +cpufreq_freq_attr_ro(base_frequency);
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1049,6 +1062,7 @@ static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
>  	&amd_pstate_lowest_nonlinear_freq,
>  	&amd_pstate_highest_perf,
> +	&base_frequency,
>  	NULL,
>  };
>  
> @@ -1058,6 +1072,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  	&amd_pstate_highest_perf,
>  	&energy_performance_preference,
>  	&energy_performance_available_preferences,
> +	&base_frequency,
>  	NULL,
>  };
>  
> -- 
> 2.34.1
> 

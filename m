Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C266DCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAQLp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjAQLp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:45:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF59012;
        Tue, 17 Jan 2023 03:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXPL75JGCFDFehzfsovrw3Gfj6RE9SMejVaq/C5PjoIP73Ce06iVvcmHPQzrv1XdTNXyitCF1WTyRT7ezotjY6I8yAWB1Y3da6ga/lsrNuWIPjZkRV/hyXF4OX/HsBN2PXZVhYh6gOAn73/HfEwi+Tx6+P5fKYeaism/G4dsTtTvlWbVf2+20XgYir5QmhBkk+8AsZ+7N0Tub3RnjUk60J9xiV+JR09EZRs+TJI4RvJiebbg+lXzhWEaceURFlCq5DgTxvwH88hv2+K4LXfjVeRepYBhEW2HkEPeSH1XcOT/voDE18n5bp82hOZFoJuJwA3J5rFXxovXW6A96PeVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG6XbRyUT6NSTXVXXKDRnNhPDqDxmA5NDQ9AWLJWbfw=;
 b=jClSOlTtWNJZJZGvA/mMxtiRzGgm0NYwsUAagM1E4o70hZ8oB5be1c6Zk6SAXkdQBCjKn/Tu2pASbm1OMGGaz+QayQi9BRa+P/bgiDDThZFz8uxxynm8kcvaMkG5n1yFQX/C3O5nDpjYhlYRx8T8004SGV1avQSZzl7xFPW4/bxEHyY5PjKeKKhOL5/Tp08FaatJkt31dkSYImxNI4QrXK6Ubo9Tpssgxt+L2b5IfWAaOY1r2rwdkcejyrwru6EnCXEKSYtDv0iHeCtFLr/ipIXyFwSisZr9wKS7DyaBaLhwU9ES61slZN1rI5mmGh4V6cfPhxrFqTNTtIYaY1k8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG6XbRyUT6NSTXVXXKDRnNhPDqDxmA5NDQ9AWLJWbfw=;
 b=KhcnEm47sFf0gD9d3l4o49cjNHUKIWPDmv3Ok2zqnLntZVPq7OOHRvvxgPRYXlWzZT1yKFjjogrtkWy3yxwcsYgdFX+AyjddLChtwQqy8cyi5kZp1uscSlVJnGgDI6L8iMXAN91mUDtpx7ozEx9A27418AFSi+Tc4QL6mT5Wuaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 11:45:53 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 11:45:53 +0000
Date:   Tue, 17 Jan 2023 19:45:30 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 02/12] Documentation: amd-pstate: add EPP profiles
 introduction
Message-ID: <Y8aKWon0+gTm8kHO@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-3-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-3-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 20229ec9-5fcb-47b6-ba16-08daf880635e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBkWEppWX/cch7XpU2kpD0pNo+NBq4h47HNTPnEXcbU2IRUlQ5f2Jtkgh+fOyiJy0K1KS/blsyNYpIGaHl3La2DAWF2R/hgbt6BItkbq5HoyVHA/TEeIOtKMzvku1iCkSBQhhr2pjjeKrVlm8OBnmHKeLlRoSqwVwvTCOYCQ2tvkPW0Bx81dliXtvSX20gC2WgDr+Hu7JTkETYTJies24AWPr/BDLH2SdacXeIjR7d20pY+q+TB/ql4kunKOqiYN+Wf/9dyZCzI5ig07s+HXP0evCYJ22zBSOk4Wl012sEMkJcvpFa5O8cTFuVIDGXOANs56PEYXCaDd3nGn19x9Yq/EjbokMde91D94ZVwECFiGO1/gMmwD490dmw7ky7rM/9WNR1syzI/SefVdWD0Dtw2hEatoAqliaClBczpvS9o4Uu8w/4cWFLcMF3f3gMu2TLW9Mp17CPXgt9Cnp2X20YVQQEYdF98elBSUKLxe58rj0M8WbnLOFZA45zoECiQZzWerV6yQgHvivVahYAUFGbtNDF25ePXQhexa3D0VAcXF5+BfG1oH6rXyIhlugMMaY1hJsDrCMHGM8lpZ6S/O9ZDGaSrE9NWFAxVR7D/IkAGFuOeN+TVJ6INf+K17hlQU57HWkfwekpqka0Grpz191gZqQQ4BLxLsHu8uxWti0jeyWurJKI2pOeiZHXNQX+hY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(36756003)(86362001)(83380400001)(186003)(26005)(4326008)(41300700001)(8676002)(66946007)(66556008)(66476007)(2616005)(6512007)(316002)(6666004)(6636002)(54906003)(6486002)(478600001)(2906002)(37006003)(6506007)(38100700002)(5660300002)(6862004)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCKFP7bET/+cYslVA4dd+lg44wq5cxIE+QeujrOHnnOv5xXN5nWoXgQU08Lp?=
 =?us-ascii?Q?ZSBHV/2qUx9dOIIFXq4A1cqna5YoRCKG2A6qByT6fUf0ORUvuaH0MyongwRd?=
 =?us-ascii?Q?Tfly4pjkHag2R5lFwjipLIGw01pF7sqBc0xgkZaqvbSVwXvtyxxRtTmOrmLe?=
 =?us-ascii?Q?fi5wiTv2MW/xNGE7JfuH5GW39syCn6RuTIdl0GoqaiTW8mj6vkw3immJyl0T?=
 =?us-ascii?Q?1+4viObRiSXbRmzjJ3bTl31Zl9gSmRWCs/lh6VoDh7bkG9ExV+6JGXWD2BYi?=
 =?us-ascii?Q?Y6pePmAeKFI0fzl3tv3w/02+89GvcxDPx3IfcuQ/VqxMsPGuWfn6a37sD+74?=
 =?us-ascii?Q?ASk7M1wfjDRWmUkhRP/Ny7gRbE0uwyNyT6WpptpyE7pHa208dH4KCvXH9mJ6?=
 =?us-ascii?Q?wF+VoSfY/IuT5XliscXSQqbpa+ZVXpho6qe5TD241MS/+SfrNgenH4A+ekge?=
 =?us-ascii?Q?IrDDEJZG3d12Xa61DhwWMWu8J5Nzg6SkqLZ5l4PVhfUvbJ1IFTqKYRobTd6k?=
 =?us-ascii?Q?9S+pE41/X2Q/fka1VtO/ZO2ub3C9HEwUOnYJxs7wMNBDW/djck+HTkuq8eb2?=
 =?us-ascii?Q?XvBWyXp0xp/wXANtNqCholqg3UPgs777kq1hVNWg/RloyjgKe4E4z+mFqyOt?=
 =?us-ascii?Q?wX8geViZzG3Fqv3dZ9E38Cw778nw3txx2GrSEPkPL16aJaWyq7S91yhjL7SO?=
 =?us-ascii?Q?4Xyo6u2es1UVCCiIDlBpC8jQPIksGvkDC/BGx7hC/sv+Ma3Wwrku4ZRFHqYX?=
 =?us-ascii?Q?X/ddk8mRfTOVZxfl8b4AI9MmIajwWKVrIXVxDwR+2bRsX/fk1/1XPdOUzlIy?=
 =?us-ascii?Q?PXrmwmvbU5YHirp28m8Oxg00gYUN5BYQBC7V2eKoHcG+grU1QCfJFoORl8Ve?=
 =?us-ascii?Q?2BQCM6kUCLvKEGXFdMNbT+bpRyd+flATxT5aMD5ES62d/xEhK3wAdmXWS7P+?=
 =?us-ascii?Q?kKuUC0L7YLr8jlWmQcldycHmsjrTu/kMUqXApS28DNxGcJ9coxu/J0msx/j3?=
 =?us-ascii?Q?iFwDKI5vZdAD0GqwGP2G+pmjMuIX3M8aP12QinNNdfa5cw9qvgiYobxw1tZH?=
 =?us-ascii?Q?waASbKA7rIwVHB7d9XoSwFh0S+QD7JdRWmjl+0Yvj07gN+Ft9ltH5ANsdtM4?=
 =?us-ascii?Q?qNsQnetFwVGz+8PGvzhRLjpN3B/xk3shxk8IUB8hG0/85b4VIAeWB/AxJxOk?=
 =?us-ascii?Q?Ba/iNVzWYkJgNpJhU/GclQuWbEJyt6oehtQtjW171qO2ABGHgzvUCxYuTaaQ?=
 =?us-ascii?Q?A+x//wPMD4EdUYb++cj2L06rEKnok3CHB6ZCW5FfMuLCWD1OpIW2y8W43PEN?=
 =?us-ascii?Q?7ecy4By2+gimawS0vN/lEtwrGwOxZmrVbJhhCInij73L5+6r3hD6XzpyI92O?=
 =?us-ascii?Q?jn3x1fxXbCCCCyhuW8rZbXWjBg8T+2o14iuajTI0QInfzyDRZvkZbSP7AGJK?=
 =?us-ascii?Q?XaD8fNGrXcAI2DUtsID2RWvlyCrTAhouuUHrD1Nh6lcNRsQp1nTsGRVgQEQ1?=
 =?us-ascii?Q?UUlw0IifrD8/iAfkMYiVZrgtKgtpJGlHkF9BaFvpaJshxvJ8+zAxhrKbfuyK?=
 =?us-ascii?Q?1i/l8wsANR0FO6YwPDJ3ac3h0tVVagFX+PKMhH38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20229ec9-5fcb-47b6-ba16-08daf880635e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:45:53.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbJbK5C5TKqb8yVXTIuuu1Ws0K1QQ56oPDBRb8wRwJEGbk0PCxEH7vwTAlcX9slv+EBWJ1l/4wtA7A5Q9vMPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:10PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The amd-pstate driver supports a feature called energy performance
> preference (EPP). Add information to the documentation to explain
> how users can interact with the sysfs files for this feature.
> 
> 1) See all EPP profiles
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> 2) Check current EPP profile
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
> performance
> 
> 3) Set new EPP profile
> $ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 06e23538f79c..33ab8ec8fc2f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>  <perf_cap_>`_.)
>  This attribute is read-only.
>  
> +``energy_performance_available_preferences``
> +
> +A list of all the supported EPP preferences that could be used for
> +``energy_performance_preference`` on this system.
> +These profiles represent different hints that are provided
> +to the low-level firmware about the user's desired energy vs efficiency
> +tradeoff.  ``default`` represents the epp value is set by platform
> +firmware. This attribute is read-only.
> +
> +``energy_performance_preference``
> +
> +The current energy performance preference can be read from this attribute.
> +and user can change current preference according to energy or performance needs
> +Please get all support profiles list from
> +``energy_performance_available_preferences`` attribute, all the profiles are
> +integer values defined between 0 to 255 when EPP feature is enabled by platform
> +firmware, if EPP feature is disabled, driver will ignore the written value
> +This attribute is read-write.
> +
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> -- 
> 2.34.1
> 

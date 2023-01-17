Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3533666E00A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjAQOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAQOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:11:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E4303C5;
        Tue, 17 Jan 2023 06:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdeAq2v5ufw/JCkpyvewvZ/DCiEy4JVziYzRMEn4WjPUMZGQNpYaQ3lsNAI+tXvS8USrQbACUP0teYec4aX3lmQ1fIwEKUGlmdLiH65HEjsOZn5BjVru4rRCjQlQz6CKPMB0ztmrD3zlug0quXSpBQ1nkZxTNulQ6H2FQcptnFf3eijFtoRyqb7ThywSFakELi0KBdz2KB2oWo959mfyrfidIueN4ErQRey+uSHPJLpT9bSHH8UO4QYhsNIOkHNdgyWIArfU3lNNQNaNu29kb7QN5RcGnF1mx95OnGxlLg4UncpnjCFIg0ggS+1obKILl7DaiRG6mZHnbv66BiAkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjAj8Q3EASeThQ6TlFmpsEMRJGZAVMGiPmj8QaF3xFw=;
 b=casMm+SEuUE4KXsmXPRLGI+TSEbIYBLcZ1S8bPXaNr2sqLVG7NtHAEQNl51YwrG6xHVWrwSA6P8giiMNehACyr9mPosSD1LuWPODIdO98xiFj8Lq3HouChaBS3qQH9h1uE2IpAjFFajMPjfqWRMQLZT9j5Ik3OGDX+dAtgDZf0+tqkGPfy4LQadbdwRcsRpIj6IRE98URhjqc1Km3LB4zMplO/SZeMOke8l9a8J3Nhi4XQIGeA9pwTDC1pY6BimilamFoW99hiYpt5nQpWCBtpketl2IoJKO90Uv7y9P5V78nRkwrRRBL/PY23uQzMvkftb+pVnZ3JeaJh9K/fxHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjAj8Q3EASeThQ6TlFmpsEMRJGZAVMGiPmj8QaF3xFw=;
 b=bbHc3a6O3v7CrT+tjduhos2uick0rElCG/W+XxI+OdTaEnkHsr+TTVwJcozKTLoL2tbS4XevMbW+IowCKIacETyRqwXXL/fVqgImvHAlxkHEV9vszuBqizqDHd+9T+3+gADEsjSu6wTewkxT6SYF71hBS73Kkp4Ef/66hZeXXuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:11:26 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 14:11:26 +0000
Date:   Tue, 17 Jan 2023 22:11:00 +0800
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
Subject: Re: [PATCH v10 12/12] Documentation: amd-pstate: introduce new
 global sysfs attributes
Message-ID: <Y8asdDS6EZl+dwvi@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-13-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-13-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb83c11-6522-47e3-1a4d-08daf894b85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjfG6CXeiv8LBHnx8O7xDF0fKMDTkVIsJmH50rDptuzi3+T/oei1InbB5NDB8vNiYQAtfpWtp3gjGlDaoDxCrdyG+jjwSp2ypEHSrThuCQuBFSMNowx5ikBBF1G71+sj1KP9QzY8Yv8nkj1OXdUIC/xtQCSNNkTpXMWHAVujmEJAyFoq4HMvUiVsjK3mDuOLoVtPKhGAXMOC4E17A16hl56bC2PoCQMD48kxT7gxoMmF9GFCkBh8d8zi+KU/g9sICfjR00l9jbcUD1KTewjWUscMrGvy8/I+klFVKYWxgbDDZTocZnMRHHdEaBlXMpRGjoIPj58s7Q2windZpga95NDB4alGkmwks1iSQoGBKHj3IUd5LGdBxQH7KVW8jg+Fqa558LHW6nBROq6yGI75xmBlV6x+H15vJNva4N1JgrE9R51exB+mRzlFI8/fc3/2IKbcXcO/jGt2BvXQ/JG5xDSIHckvDzQFG4KhhXw8CPApiTyP/tn9Qb4jDRYOG6VR6ZRgkPXJvtL4Mc91AwwI7jn+2IIK0mQZ6Q+kNnSNBQsOoKabGXPff78UaDSVqtAzpvNTKyX7YAQ90p0hlX6hViAN/YR2YX8WqYvaNZ/NUJMpODDO5f2M6tE++HrhAclVh6UsG49jnlbmBoYjH/Rwq9o9ylKTBal2ClpH5kMIApGnGUe/eKTL8GWr3lJGrSLP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(6636002)(54906003)(2616005)(186003)(26005)(4326008)(8676002)(66556008)(66476007)(6512007)(66946007)(478600001)(6862004)(41300700001)(8936002)(83380400001)(6666004)(2906002)(5660300002)(316002)(6506007)(38100700002)(6486002)(37006003)(86362001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBK24+QxddoBWPt8MI3/HFgQOHQmYryUXKXtPMT2sNm28JySaodU6GU2qHOq?=
 =?us-ascii?Q?kOrYF2veaaGIVjbWzJTDADZ3wptqBfGrUedOdzljUsiVI8QEgnBkyewKhexK?=
 =?us-ascii?Q?Ozaj4I6NG6K3J8OSatrxW8k5LkSkoU0NDjYuFrPNJ4wE60AAreMaDw6yfgqV?=
 =?us-ascii?Q?oU5crTQ6xV3Ud46CUVapz8n1pg0WU4tTuGa5mh16Yd9NHmTJlq0MW2+vTimI?=
 =?us-ascii?Q?EWWL32RVtEOEfsED9JRPsToo/Kd0+aNk18JkJ3cMUhfCUZ/gLaEDextIPIu0?=
 =?us-ascii?Q?9QvGsJEJe15BS5zdPMuTRbHF7YNdXOfBrOIobgU5jItVQiHK93kOydKps6Oy?=
 =?us-ascii?Q?kzPdIwmWnXH86TqN/fEW1SzWLanIH4WctaJS3bO6pD/zcF6KrdMmBdIJ8qPD?=
 =?us-ascii?Q?D4mRDDGk2GMoUKUub5+chC9py2256pviwAh7/XZTLytcu8ZQuXcJWQG9NxBu?=
 =?us-ascii?Q?kNg+en6Nbq0CGFhscTcn4d4IM8ZFhADd6pydIzWZQ2LJA0DFWhe3Mvo8uN6E?=
 =?us-ascii?Q?a/oVGuznhMrMtXsPvNxQgKtfWnC6SS3jwsT0VqXPCyLQMbnhRMngJJSM60G0?=
 =?us-ascii?Q?pk8pPhXxsG8zIHj/wxKz7cbW3gHfHy8OsvinMP1ZJFmmnebdNFd4MJ5zB300?=
 =?us-ascii?Q?QTMZUo3ZZpIi+Z45rk/LUG7J93qHUV3Z3LjzPAWQo6J4QGaZhhkB7iz38f80?=
 =?us-ascii?Q?kJSVC2BhhDoH8kQyGoybBxPDtRVYvG0GHltmpjdur/DBTXYfR6w7MJKmER96?=
 =?us-ascii?Q?mz7YiZZ7NrMaHN2QFsSftjnF9QNl23yVBpdQVB4bjLqoggolmAvwT4yIibdM?=
 =?us-ascii?Q?DotPtYOjNsPmzQlEQNOB1eam1AJ0SkyMZ4wensZPm0YGenoTHoTpt5b0k2Fy?=
 =?us-ascii?Q?7VN69HU1KjWjYUmLAgXILaKjHLGg73TiClvgutU+CnDkmXr8Nou05NyBe6Hd?=
 =?us-ascii?Q?pPVZKLb5NwVENz8nNoSFi3/vOkD7mxHldkOXSGTElHROSH6Wuvi1YYYn8Pis?=
 =?us-ascii?Q?cxFsEQ79lpcac82QyK3wyF8tn+n/LT1dF4m65Jdz7zknSp2qlL2thY9hRjRX?=
 =?us-ascii?Q?32/MToNfUhL9U/nCU4uaJB/6q39hXVnprpcY+wheiXjN/XokNp+e8V3Nlwuc?=
 =?us-ascii?Q?Hug7J643b1fgJg6nfSU1vjKmPKAN93HFqKPdcidyZXkKDvfSp9sIXSBVQ4Lj?=
 =?us-ascii?Q?HX7P7PSC8mhe95u1SGEjpz9mvj37w77KuqgWxcIO56p3uOVFuSEjCDmk6Xcc?=
 =?us-ascii?Q?pzlpmgV9c9tKvMKMRZyrJIkukJcdw659VcmA9F0XQNn20lP1hFcjN8TT5gUV?=
 =?us-ascii?Q?74sHW2sCcGl3H0AWcT+kXYFlg82duQyWDfW/QzBbQ5KTnDrxIJkZq04zoLG7?=
 =?us-ascii?Q?1VFloaYo1q+MlPQyoUEnci4vBRMfXwd3qSKx9n+awKxKyb7fnU7qG8FCqxTy?=
 =?us-ascii?Q?I+ArxvOPuMPpc5hY/s0ijMKtOdIAnnI7gQnws7neL0bXr+2z/rNx5SZMlUwH?=
 =?us-ascii?Q?L/ZFOaWOQmCe1yVxLEXCBwTrVZnlHNSiVj4R5Cllh1CzVg+zF/BoXCV2RIY3?=
 =?us-ascii?Q?8VqR37wb47FQiG9SXnBfoXQzKjXA9IEbcIAluVWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb83c11-6522-47e3-1a4d-08daf894b85b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 14:11:25.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqv9yJWIZiQxeOJ7LGFnrU08jpDNDzNm+mxwy1S73/OWFIRUUnTCI4NhJ2jHiYEp/ymkWCriijTSOZ2Vq2UJYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:20PM +0800, Yuan, Perry wrote:
> The amd-pstate driver supports switching working modes at runtime.
> Users can view and change modes by interacting with the "status" sysfs
> attribute.
> 
> 1) check driver mode:
> $ cat /sys/devices/system/cpu/amd-pstate/status
> 
> 2) switch mode:
> `# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> or
> `# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Patch 9, 10, and 12 are Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 62744dae3c5f..df0637a49f47 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -339,6 +339,35 @@ processor must provide at least nominal performance requested and go higher if c
>  operating conditions allow.
>  
>  
> +User Space Interface in ``sysfs``
> +=================================
> +
> +Global Attributes
> +-----------------
> +
> +``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
> +control its functionality at the system level.  They are located in the
> +``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
> +
> +``status``
> +	Operation mode of the driver: "active", "passive" or "disable".
> +
> +	"active"
> +		The driver is functional and in the ``active mode``
> +
> +	"passive"
> +		The driver is functional and in the ``passive mode``
> +
> +	"disable"
> +		The driver is unregistered and not functional now.
> +
> +        This attribute can be written to in order to change the driver's
> +        operation mode or to unregister it.  The string written to it must be
> +        one of the possible values of it and, if successful, writing one of
> +        these values to the sysfs file will cause the driver to switch over
> +        to the operation mode represented by that string - or to be
> +        unregistered in the "disable" case.
> +
>  ``cpupower`` tool support for ``amd-pstate``
>  ===============================================
>  
> -- 
> 2.34.1
> 

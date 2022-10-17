Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8A600B86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiJQJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:48:05 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D2E558D7;
        Mon, 17 Oct 2022 02:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhSkOdzmh51tnhbelTtyMFe+xD618IX4cBONkACpgyI2z0FboYYvnEZuqQxpGDBI/giSKt7fR/qzf69tg8sbK2T+resOLoV+sJak9+fHVyOzgWmNTLLy9kXP2xlqoj9N/7nE6vnP0CiEXnDSUYnzT2Ce4TDsb86+jaWo/Ig+mBSo1MVDhqfwSnc5mLMAm+LNNf4JZy8pwCYUC8ItFYNrxow0r1U8oiPolC+/v42AjBHlY+1UXLVo72zpBxbnq0cNxvt2OJBnGol9BA9Y2yyuaQwCl5phl+ncj9nHhBZF5YvoH2dHSLxgGrhCW9/QblIBo24pU/Ec1oTHOrln/1zibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TqAOmrBTCzTHNY0yZIbZsz/DI+vbEk3Ntjk41/lF0o=;
 b=MSSPq+4xbv5eaRJWUHe64uB0i8FVIoKLlLFHLwpui4YWZalY+jBolLMtEJ1MGh1ssDNreYGIw6Hx4ZDVrg/WGTrpv+qr796vwbYGAifcg/CFWpZCoT1TmpRuDKeV5pfLljdL+Xj0y422+zhqFOlAs2bYfb5eQKuocv+Kft35ZCrRwGKlCXPCzj6Oo6HTqY44YWxQrwknt/aLa0lUPPxatUDf4Z5vT27zkPLTwaWu9WITLUeNhIaqFxfQ5uVbD10uAY/fOW4TrGWpcbgqfFOtPh3s48+Y3KVpVOywkjvg0qAs2k8Tly1V2xfY2ZJJqy4uadxHLRIw7lO96qU/GX+BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TqAOmrBTCzTHNY0yZIbZsz/DI+vbEk3Ntjk41/lF0o=;
 b=QuB+vPK4wPSzNxHQXJOgQaOO6jjiYbPnLLBng9AIP9jSKwJ0l+bqn5M0A4BBGiG2mFHcl0AVnu4h4CC7tFoyJ2AvaLfLXojHktbGlmcYE6PUTCV2KLiewCpNIM90EfwzqNlrZJRcQMKOZgnyFeoDzh5lhtUSxSFgo2jNTSJHlVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 09:47:34 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 09:47:33 +0000
Date:   Mon, 17 Oct 2022 17:47:13 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 2/9] cpufreq: amd_pstate: add module parameter
 to load amd pstate EPP driver
Message-ID: <Y00koVkHD3ECCY7H@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-3-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-3-Perry.Yuan@amd.com>
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 8beb4608-be3d-4130-5be8-08dab0249d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WWLJGzzlHX8k0+S0g1fghHmnSKZD5mC6ZkiRLNwsZFYyjvtrsWtUYB4JM6XC4XvUmt18fH4XVJFLX2ubA/T0U2AV1W6+fB0UanrlV/tKB7yiTOkXla++H6RnIWl4AD1XU1sAXZ+pLsuBCroldDJln6/EzGX08E/FFYdMyyT1SepsMHCOEFGI/P1b+rAce0UfH5ZHE0Snb32hHpgSTt301Wyny7TnZmuBMrvLwDUYM2qOmfSHEMumpSnxusNM5FSXTfQeKQZhwYS3pEDsG8EibhSuU8b7jbUBpNK4A5EUo1BnAJG7L29IZxVwWEzSEu7v6l6vjJwSkW9EwkZJHXXygafMifPdhckGYULz+Fn+Ty9uSD7dtMo1tV9oLFeO7BEhpiTTFz7x+S39KtqXKjVTL1Z+vXBEePxesA/Z67z2Sh2w23jzIU1IdxDlEsigycIGR+RKnK70gNGCLPPM307lTISOjfIQiOFr+RxRSwMpsWyV9LnXp0wvzeRsdMHUwTJaE2CyOfY8ask3Rg7i6Y5bPNfucnJ724yCLJmPIyFVPmhIYPIyo/OKVWjEu5DfAchhm+hfF2Qp3pLO3Y4dfKY5QTVMOpZDy/QgQKOzFePn5CjxKGNkT5f1/Ce4qKCO6j7l8MLXluWiPjfcIiP+7h1goDxNruE2/WKpyLlq9Go02IcoV1nuJ+w0BXlqZi2Fn6dpNhcJFRb8LSRnN4V2rX9SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(6486002)(54906003)(2616005)(186003)(83380400001)(86362001)(38100700002)(37006003)(5660300002)(2906002)(41300700001)(4326008)(6862004)(8936002)(6666004)(8676002)(478600001)(6512007)(6506007)(26005)(316002)(66476007)(66556008)(66946007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aiz30Xdy2f5oCRbk7Hdpt9bXj8qJtaghsJje48sTYJWHp64hc0R41XIunatO?=
 =?us-ascii?Q?0U7Cbr/Blw3CIfXzd3cDCON2Va4njLt9sP3c/jtccfXXZ/Xu6nmbsHtuOADW?=
 =?us-ascii?Q?A4vGqfUhAWi0RYTWfi+ITqhYXKl0zZztj40kGbxVjB2i/DnE9tthax2147hC?=
 =?us-ascii?Q?QeN2CtPHqJRIHh7TKvWAQPxa0JzoSgrN6NX0ymrEfn0qP+Hw/ZYaHDXspgRm?=
 =?us-ascii?Q?Oekab0oc1Z6YEXjaN8HIjASRDpzyz72r8l89OvLaB3wxEUQRRaEWOiD+Zy50?=
 =?us-ascii?Q?Ir08eGNkEgbwTimX2C+U6VoZbG+5L2QcWVi1U2dqdUL1lExDF4ek+e6uR7M6?=
 =?us-ascii?Q?Vwptm++dgp/OgHhV8YsOSnssYzncsvOMLP6gWL/7rX9Ik60Tsod306fuNZJy?=
 =?us-ascii?Q?hFczZDVHMwoekAL/Ya20vJywCw5SqfYj8o8JesvQMuy57BNejZXiu482fMSZ?=
 =?us-ascii?Q?gtMy4hxNFikXn1QN1frSExSGw7bAlExLuobOSYMMH2mkxkedW9althVA0CnK?=
 =?us-ascii?Q?RAgwGqI4KuFgKekfzWLOfHV1NDdIIYCQ+e9YU2eIer9+LgIr8iWyj/laOFNs?=
 =?us-ascii?Q?yRuPNInWHf3lwLUUvxFIIL/Qsoiu1sQ7g4/JdNXaFjrpsPbaSyRh0wFaXCSc?=
 =?us-ascii?Q?zrfNR0GW5iC+VMeXuvJdbO5DEnDU9JVhefUUIOzukMYDG62UD2trnWveAvUt?=
 =?us-ascii?Q?5hxEkQFJn4/gRDyCZ5OxVTxaKw9ACMoLm9Ha9TaUxqJc28MamAAGxXR7iFpb?=
 =?us-ascii?Q?2YEy4eLU/9IegCEMPrMg2s3EdhFLWBt6Es7itYJAvBoTzk/XMpvEjNfEQows?=
 =?us-ascii?Q?sQsyOugvu0oALw3kEUm/z3rPunHETXhGqPJuPAcZh5dHp+w7TZEkW2qnXobH?=
 =?us-ascii?Q?S4KyWp2O/fsi+UpELmpcHjmAsHpM1jpj2JBJb5iu9DJWMM0X4wJMnD1sinx4?=
 =?us-ascii?Q?xq8xCD400gEJXvXgN9qooCGE1mH7+T9vNUc8D8itwvtWBSTgnYVmLsp5s/QT?=
 =?us-ascii?Q?AxsVfORM2nd62FfFQQEIUNSi2K78BPHOj6a7ZuMBNfZFImDb+nxT8foGDdk+?=
 =?us-ascii?Q?+qy2ncvYJ+Lv/eDaXCDdap0XhwpaBaHUdQTZGvIRYwfO2eEoj56l4mqZ/HVB?=
 =?us-ascii?Q?orCBauMstfy32RLasryE/ygOqeQ15O2JAZzWznVMWd5/q5REsN44rF2n4bFP?=
 =?us-ascii?Q?Rqo6M7Luvf7QaTgm4Pf/QS29rvrcon2Lz3W3XPYr4kQab0hyiVsNTaMHX89r?=
 =?us-ascii?Q?7tSmMc/UXCsE4CQf7KK0qIy6F189dGjCfD23hCYsvKyxNw9F+m/kNzg1ETTp?=
 =?us-ascii?Q?V78r7qiFNwskCNLw/byt3Bnk0yJ6S0JsauujeAksSvy7WIptWRbMVpGY20k/?=
 =?us-ascii?Q?wI6zJAwdBYgTE6lp0X/A190srsrDX39X3LQzYE4Pivs+0XsaoOdp6HmAHS9I?=
 =?us-ascii?Q?bHDMBCK24ultPEFjGLbfC2CraFx6tGf7/IPVxpmX/dVvjlqUMUUGQWENeyTz?=
 =?us-ascii?Q?jnHlnLv1pKki2lBSuzec7P8mv0Tbk1ksGr+cbWRvSUuoiz1QuONTxsvx4caR?=
 =?us-ascii?Q?kiJ1Mf0Ny9ty79+hJNj+MqPYeM+HNxwdiZacW5HF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb4608-be3d-4130-5be8-08dab0249d9f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 09:47:33.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm0AsyzMLuAXX+BqXtyWZehbJ6qFqEfD/9GKUW/YQbd//iTaxT7x1V6azwbIcNM+5oA9NJdchdLbLt+CavSh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:41AM +0800, Yuan, Perry wrote:
> The amd_pstate mode parameter will allow user to select which amd pstate
> working mode as booting mode, amd_pstate instance or amd_pstate_epp instance.
> 
> 1) amd_pstate instance is depending on the target operation mode.
> 2) amd_pstate_epp instance is depending on the set_policy operation mode.It
>    is also called active mode that AMD SMU has EPP algorithm to control the
>    CPU runtime frequency according to the EPP set value and workload.
> 

There is one concern here: how can the user know which kind of processor
supports the EPP function in hardware?

Thanks,
Ray

> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f52b8f2fe529..2d28f458589c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,10 @@ module_param(shared_mem, bool, 0444);
>  MODULE_PARM_DESC(shared_mem,
>  		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
>  
> +static bool epp = false;
> +module_param(epp, bool, 0444);
> +MODULE_PARM_DESC(epp, "Enable energy performance preference (EPP) control");
> +
>  static struct cpufreq_driver amd_pstate_driver;
>  
>  /**
> -- 
> 2.34.1
> 

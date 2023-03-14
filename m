Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F636B8AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCNGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:04:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217468DCEB;
        Mon, 13 Mar 2023 23:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYSVeeTGbGiwsUcOHq3mD8zcuxR4nA+QZFOZkrGRfyySpRBw2NRia+kHjzUZSyq7XPorEhG1YU1prbne93BKa9aUIlpkT0O2r/FiqWcAn5JF162Q+5reXze/+l5UieyT1lPN1hJnQhq50q4Hspzt2LHDmFI0RhPn6byPYkWxWYE3ZtR+nTc5JNTRQXU13vEuIw2lvjDFmc0QjPMK4ayqx9Qe4Vot2jzb3Dhn+bN5iw8sKWhcP7jeouKTNlkERULNqfrm+LmduETNZf/rFu/rsoazoDwW6AXdONvkUE51Q15Ze0SNA7Yb2kyTWSZNjBg4aGAL5xIZRHcBluzdFj8Ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MKS/x/ZkNq0w/IDifqPp6HEarJBQu5bif5Gd6bucT4=;
 b=CqEjeJ4h0QUD82fWp91Lm+TVzg/Xcf28rVBX80Kk4Fo9LqIv7q0gtJWI5Vc3uAgIzywNLfUWiSqQk58njVX09hOWApvlVAzl/OywsOsP6XKw96+R/6teWpfsYYSB6Dy+lVYLVL7DhtR3yAJQuXW6TAMR9KJpOIjozNwlfUIJsYt47LBg6kfUP1CKSrdYmSSjfiWNjhpDHmjmZ0xCJjEKhQg222dEREvxdwcTRISUL7jD8CJbDhakO++sVmeUIYoBQoJ1tTbznMmhl/Eldsm02ad7Ye+x0uKYzB40UVuV9fk6KreLcMCMFNhqEmryuI8hAYYOUeoIA1WTz39LFqkWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MKS/x/ZkNq0w/IDifqPp6HEarJBQu5bif5Gd6bucT4=;
 b=Wh8IFrEn7UHL3RGYWa16yzbgRr62KnvGv/QRm/xjgT79xRQtuypWGig6NKc0RG5TCZU+rbNoyXXJ5CREYutrkrogBG7hRzzoQWLw/4hYJUUuYhkxOnqLYbBY7cXT1/abBgQx57D2VENrEUqTZjImUxNFVI7nY3zyKgfE0EBLYoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 06:04:33 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::4f9:60f8:cb12:d022]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::4f9:60f8:cb12:d022%3]) with mapi id 15.20.6178.022; Tue, 14 Mar 2023
 06:04:33 +0000
Date:   Tue, 14 Mar 2023 14:04:10 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 20/36] cpufreq: amd-pstate: move to use bus_get_dev_root()
Message-ID: <ZBAOWpJQeoeyMTaD@amd.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-20-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-20-gregkh@linuxfoundation.org>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a713f7-daa6-4053-f448-08db2451fb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dP0mdOOWmQu+O+LjM+fYX9aVMkRWPOpcuGBWk20Q4rnsTHVQSh/o8qVjC3yGQUytY+pNyKmALEQ5ViY0l/0Mda7wNyM1ytokZzq+tpIoBV3v4sKs/wKwwOtNdd7NvfNRJeSCB46bke8mLTLY4oeHNLvvPKBr62RUKQwp1ofsnDWGMIewbRqA0+04E4f3FUuGBgizr7iU2aD+Re9ocArEG0PcOfHqDNMoO0wNS1erSQqQtiMPUqTcEtjkV9dQ5lNvRfOIm49gwV8FQHQAf2hx843XN+c1f6gEgSaX1PFsSpM4/32poNQwXPab1eM1Kh4YLz6eGC79h0Q5iP36PSSl04fKcrQ+6ElpERxezSI9wfZwiEq5sg71Dq4TVvlN9aLds9VoRKFu9mDBKCA5bqps0riw1x77Ph829G7ArFQA+JjhY22RgY6Y6r21iIwQBSmd1oe2cEqS/lESL/b0yw59bZOrahqWyOtCK1UioSRtOIkPPVP5HUuEM7TQ6eK7z5pGlvZJ50ZCrQMPPzha1hkoJHjRo8Ce8TbvFlEzEQ5DzsE64ncrU2eT9Mbc7VMyv2p/3e1AY3JFrdlrM8JKrajUng+v9AnMFUz+xht8VYetWrpm5HiZMs51e3Xtgm4c+GOLaCFPeYfQD2Y06UusSmf71w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(5660300002)(36756003)(83380400001)(478600001)(26005)(6512007)(6666004)(6506007)(6486002)(2616005)(66556008)(8676002)(4326008)(66946007)(8936002)(66476007)(6916009)(186003)(86362001)(54906003)(38100700002)(316002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3roSCLt/iVRdkw+UCTNJZe7lluuE6B8+K9E6Nc6oDr4z9xeknRLpFr5ZwWTG?=
 =?us-ascii?Q?TFsxNgohTCGThd3sW88vR/sEYtN9DRThCqNToFhuxjCLmuNoQft06hXvxDRq?=
 =?us-ascii?Q?JFZYy1W1wh6kt8taOqLCSgbVthGchHS1fqXMS9Fbs+Zwrb4sS2asJfdjqTZM?=
 =?us-ascii?Q?lisADRQD2E+5h+L4SBwcaOFBmEswX5MIlyK8cDqLoUp79Qfxd65jvwGFESeh?=
 =?us-ascii?Q?I0dMNIfHgWGu7GZl2XKr9uLDNTn58T64c49OtaAZ/8TENZzNr9mfv7UbUuvA?=
 =?us-ascii?Q?f4p3fY/kU+z4Aa72sOuugfa9JIeD40ztddGSZETp7/eBVFfGxaJWmFx01a1G?=
 =?us-ascii?Q?jvFDj4h4eHeZVxa6YdhayB416BPDqmDI10/sKySyKZor6+IRhb+0iHQRlRuZ?=
 =?us-ascii?Q?nMr7WPmgdLqJ8hIJYYWkbwO+jEx8Ha4B/Foknyp9D5Edk4zoZA1aXanZHPq6?=
 =?us-ascii?Q?nYaAigU8XsZ90EjEMqlut+amG8oaLNkXuuHYTUrDgpyom+nT9VGAmQofbj1w?=
 =?us-ascii?Q?vrLWJ6xsFqP+WMXYIhpXvwu9goZIPoPDMKQzQRiMYtIZPRuyuhZGWFjtmabz?=
 =?us-ascii?Q?9XyqQ/YKLoqyUZD6H+aynnFvAREPaIZhHfWeM9nZfQHT0+zpwQXO0Mu+9I8b?=
 =?us-ascii?Q?j2mlyYDqYG5RkB0yXuyG9UMHoSfE8BpOHxk5VP+8mFaSncYltsFcUQfgU55D?=
 =?us-ascii?Q?xXCpudHaYW6EIQX1tbCuWQ4aeSwujOEaBrxQ9BxjEKGOtJDwtWLxQrYl5pX+?=
 =?us-ascii?Q?ltD9+6Pu6/bpuFBWv6Rw3FVaPPJnHq6/zt2i1XOmJ9NoiWzfau4TKAxVrM8A?=
 =?us-ascii?Q?bLgSDdgQVc3AILYX6eCNsT+DspWDGvXgoFJGmYCCWephVRlcM0Ulwi2RGhnl?=
 =?us-ascii?Q?OUo1WS2uUcU/fMClENJ6fIA3T+P7bEz0WaNXVO2Q7gvQdaqbBC8m7ymt5Qh8?=
 =?us-ascii?Q?AGznKP2OkDhvi8vvbBl+eAi0hyr5Nq+9p0wekAJphq3+MMofME3h0obRqj4y?=
 =?us-ascii?Q?BFwBAGYkOqhNjw+wnPdcXqpSWscio6W9v+uG9kAIj86TrQwyxadSoMQ7Xgp+?=
 =?us-ascii?Q?Iq5nbsJWRlF5EDjjOyyM8RcOMUf1UCYUqRnnraOtuuEfAAbJyIYy1hn6yaO/?=
 =?us-ascii?Q?cWMBH/ItuBMU+91+Uh3IJRlObXu+MQxbTTq8+YAVnnxMG2WBqEcg89TWRW2z?=
 =?us-ascii?Q?LJF1RZS/n/TGm9cLWpgNb+EQIdCmxgiNg/2TxwcNb7Bov9j23Ni+dEdRMYDd?=
 =?us-ascii?Q?PsjYfrE5/VeZE39CS47CLdRRB+I5f3Z6G4YLi7M/psk2mRpL+JYbF2uGihcs?=
 =?us-ascii?Q?ABtthlDoe1RR9GYjX9mvrCVRdviy/rC480ZZXluitw4wwCBUdmfVKc51vToi?=
 =?us-ascii?Q?kxQEjkkUK2zZUq2ubIfgA384yA2cf/jIh8f2/wwIhTrBRP/4q9zSfemnr059?=
 =?us-ascii?Q?AX8/Oygl1CjD0CFBMO/m4VKGUnENziLBK/S8ZqhE+HG5G+HKa3KZ3maz87bF?=
 =?us-ascii?Q?I4jC8OkPwG+XT1ONxYfbOGzw+Aehxiyi0MsI78plBxM3tBAuGUccR2c8kmUx?=
 =?us-ascii?Q?a4bbvtT2NbKMO19N7RkdH3tC+jwurqvzbPoI6sGC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a713f7-daa6-4053-f448-08db2451fb1a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 06:04:32.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG+hf4Je412OPFlOzUajYh83dy5/FPBrLqVB6bv5snczx7xQ+4e0tIgdVcD19CnX2mEd631uv8/ffjHjDB8aOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:29:02AM +0800, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> In doing so, remove the unneded kobject structure that was only being
> created to cause a subdirectory for the attributes.  The name of the
> attribute group is the correct way to do this, saving code and
> complexity as well as allowing the attributes to properly show up to
> userspace tools (the raw kobject would not allow that.)
> 
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

Thanks Greg.

Acked-by: Huang Rui <ray.huang@.amd.com>

> 
>  drivers/cpufreq/amd-pstate.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 73c7643b2697..b92454c50118 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,7 +63,6 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
> -struct kobject *amd_pstate_kobj;
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -932,6 +931,7 @@ static struct attribute *pstate_global_attributes[] = {
>  };
>  
>  static const struct attribute_group amd_pstate_global_attr_group = {
> +	.name = "amd_pstate",
>  	.attrs = pstate_global_attributes,
>  };
>  
> @@ -1253,6 +1253,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  
>  static int __init amd_pstate_init(void)
>  {
> +	struct device *dev_root;
>  	int ret;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -1299,24 +1300,19 @@ static int __init amd_pstate_init(void)
>  	if (ret)
>  		pr_err("failed to register with return %d\n", ret);
>  
> -	amd_pstate_kobj = kobject_create_and_add("amd_pstate", &cpu_subsys.dev_root->kobj);
> -	if (!amd_pstate_kobj) {
> -		ret = -EINVAL;
> -		pr_err("global sysfs registration failed.\n");
> -		goto kobject_free;
> -	}
> -
> -	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> -	if (ret) {
> -		pr_err("sysfs attribute export failed with error %d.\n", ret);
> -		goto global_attr_free;
> +	dev_root = bus_get_dev_root(&cpu_subsys);
> +	if (dev_root) {
> +		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
> +		put_device(dev_root);
> +		if (ret) {
> +			pr_err("sysfs attribute export failed with error %d.\n", ret);
> +			goto global_attr_free;
> +		}
>  	}
>  
>  	return ret;
>  
>  global_attr_free:
> -	kobject_put(amd_pstate_kobj);
> -kobject_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
>  	return ret;
>  }
> -- 
> 2.39.2
> 

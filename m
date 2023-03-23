Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772676C7328
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCWWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjCWWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:34:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB57EC2;
        Thu, 23 Mar 2023 15:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/TQrlUNAViAjBrMrCvARq3clrHVMw8dNiF4cORL1UJZHAciilDR1i/R2P1XjU3Nk1+QGZcORKf9OmqYItzj7vnzaNAqmYwnPJ6gVUjf0RIn5/stMeB6qQmovtYwG7OS+f3fuDYfmZKRLVaD1zUZH8T5ctZSz9033begdm3ONJ/xX2PqbxGKaM+XivK/L32QUnIAhG4wiFWm3xfYZ0IVvt4Nw9X13FmK1YALMhR4pXlrkDw++JEKk93NBXUe2oB8uCfE1Ug2O4iqB3FJe5TZnvWbsjY998aC0JQESFD+WNaFjwcNVNR0uoXdD9QeyMIpfgpklcZzEiZSH8kGAFC1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXqexM+tafJGlPbqYLkmvxpxjnvAbBLKhNMzoLBa8S4=;
 b=Nsgwth5Mi6StX8wDIEXUlp3nvXf+QEIo5HH9k9txUfsTNgcRp+lrXIBjXA1dBUHh5GZoImek7+ZNsYDFGE8rWwpoFthQ5DPOd27p48J/b22nbv/LGG60f00EWCsFv362gIY/5frMEjhODGF25iQxNep5zGTnWlWL2mmzkm1IUqSLizK8fLUUcMW3V5KSPMQyLrgHnHSEEcerBHH5BSM5Dj8jLpgBXxssDGBoRXeuUGBeKKdtXSuACA/3ihJ2lDQcpu896R1zr2DSpdL0+KHAr1Q1OrV42Yes9wJiMVMefVLJqu6ZeP7kffuvDxk/TlcEbx34fb8IGO5ZgPMC7ZgpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXqexM+tafJGlPbqYLkmvxpxjnvAbBLKhNMzoLBa8S4=;
 b=qXE6Oim9MBLfLnhcms0Gs3uI0SZgWJ57IY4FH5UGPT5w0TI061nnx7znTnhBts9tzF3VbGeW4bLQBbHdsNMGY/SVsTY383kzLfbpTyTUeJr1SulIAn8kRJdVabRgYYsxuDvXWqYR/lyg7TdmXRk4Wl+hfANXG196OgFV9cVlGeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB5258.prod.exchangelabs.com (2603:10b6:5:6d::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 22:34:05 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 22:34:04 +0000
Date:   Thu, 23 Mar 2023 15:33:26 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: Re: [RESEND PATCH] driver/perf: arm-cmn: support ACPI probe
In-Reply-To: <1679587838-80000-1-git-send-email-renyu.zj@linux.alibaba.com>
Message-ID: <557691c9-2176-7e9b-1130-8091507dfdd4@os.amperecomputing.com>
References: <1679587838-80000-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM6PR01MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: c43bf53d-db28-48b4-033c-08db2beeb4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMLFAaG95fdRFCwD2xOlgvlUkdflYKe0ce9jF3Fh+q8As0UaltQ6sOD9/L5dGyrlOBKAt9O9WNQtM5zXHzlA7QSslkcNyxAw6fbSDUrwe16d1WfAgevV2K993lBun3xGojuFBmjv9Xo0VgGvb6muSp/SGotybrWMAx3b4Ufd/0NJMTS4v1zLg75TXu27AI7C7c2ATg5KtVYFkwuotYKaFMPio2Ub5izTjW2FEIXJRHTyPFqhWSmgW2c2eeJN0dlQOcdHjJnYGPr6syMI2oaxNOC1rCTTMpnjRHhhklNOdGRhb1MxlBPC3QYS2z2GWiMT/RtbmXal0A9BWgCkRGNbjVE1MVBy3ZLkDhgmXjskDjxO5V8+4uCZ1KnAN6/opnYuXZ5BX0dyk5eza7UAwB35qDjCMB5vBX2dkAsZXAnTpILqbe/vRfm602Ny5USlDKRarB5EJhBvU1iftUu3F1vdIwyecLc2OQMYBrZkfswa+V4fXs/rw+7nLAp8WTFa9X3mUbsbaXDkcSE00LlgwelCVLfE3Rc/fSnbRWsZz3daSARL3ThCeieWxx1zqNfZcgnofkJkVRs96B6ZluLs876xf8v7WlW23/3c3ymwYi60I2jy+J/yB9lskorBa6HKQUeFA9FrNB29eN3saRjDkGtCnxLZ4hPAs57VOCKvtV5Dxxb8avgxXkiJrxvZHEH2ovL2xQs38r82HxgBgaOO/FJP0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39850400004)(366004)(136003)(376002)(396003)(451199018)(66476007)(66556008)(4326008)(6916009)(8676002)(66946007)(6666004)(316002)(54906003)(41300700001)(5660300002)(26005)(8936002)(6512007)(6506007)(52116002)(2616005)(186003)(478600001)(83380400001)(6486002)(86362001)(31696002)(38100700002)(38350700002)(2906002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fJ+0KAa0fWM4YPEcfg9xHLEuSd4vKIvK70ove8CS16WOn+ruS++6kp98SJlU?=
 =?us-ascii?Q?Tz2g6Y90Az6mm4vbbCQmZ4pcmpq4w4xckJ9db5oPkCmk3h1aFLG8DztrmOnb?=
 =?us-ascii?Q?QiXkG4XgE9mE5Tn2BK47PSGQ84ggOO+C+DMtuh0c3lfUqWnQI4ZVNy+wWMAL?=
 =?us-ascii?Q?jd/U01IW3egrQL6z7AyM5jgX8f4vJyHTIOU6eLf6k5n4JxZ1CaMehrUCTb8L?=
 =?us-ascii?Q?2siRMrafZPYqdz11ogrEE8jSeyNixeB9eIltx2KPHKg4slnRy09PlPeJ3YCn?=
 =?us-ascii?Q?s1oehlJ/6U3vf+W1bH8SX8xqkRMOm+XOn31FAbJx9970vW/s+rMt8jAGcX1w?=
 =?us-ascii?Q?plX9CXfQqiwKPP0nONxAGLqqKCdl7syKtM3iLcSymsSt9hYmZZXfTpXlSc9t?=
 =?us-ascii?Q?26tQ5ZONN30PnvzUysg+dRru3hhv/4d4UBHEw/dKYh1zdCTexS4/eWrXjlRR?=
 =?us-ascii?Q?j1OrdqQY7+skCRgYIGNjmOMWKR2ycaI5rM7jejbHLFnpYoOhe74j/zJjwJgW?=
 =?us-ascii?Q?UJHVh5LaNeAjCb456iWjS0SibXY1cMB97D7u38m+ndasDasXIX9glmIWw7Dd?=
 =?us-ascii?Q?73O/Eh54lgrdyX8P1TsBkBU3gU/q6CqNI4ZFPdRQr6EdAoeig6MV9fyj5Zyp?=
 =?us-ascii?Q?6umPfQbGWZbMQURN5HLQlH5fQCq/4fxdFTq1doa6DAxohBDYWqgkEIhQYq9R?=
 =?us-ascii?Q?NnRopeHJNgoGzaNkQeF/sjfQwlkbcEqvOgWU2K8jLkE1PSn8G6YgPINyiyXw?=
 =?us-ascii?Q?RbNxgjWE39lfXFS7Q2Hc7guhDFp1JoO5dDP27sBip+mds/6pxiq1DP7jATuo?=
 =?us-ascii?Q?TBQ+MnYy/2OoiI8wIpETEf08fJ4HY0nt+cbtTmnVk61Qu+PEvVRBEeHIwcHg?=
 =?us-ascii?Q?5dEmLcCwRwo8CXR0w17vMPY2KykxH3KObGAjbCKBL64WCunWdnlL3N8X+XOP?=
 =?us-ascii?Q?SwRJSTF08D1a5vy6ViMzI9fZsZk2uJFYF4bwchZISgtiK+1EfbVrIBEDMIJi?=
 =?us-ascii?Q?bVAYuPgBsOkrS3K9qQfcYrPx6eB/AGHzYQFB75q2IWi4U3oeFFQ7PDGD8dDX?=
 =?us-ascii?Q?y2rq80s+M02r7cq++KxSYLfkb3eKKPIY3OEC8jd/yXMoVlExvPCSmqp5BXDl?=
 =?us-ascii?Q?BV0vsjG1gZbbKm5ijJ1FLpN5vYhKx3pjb4HjkWziaZDlgFTWzdremYy8sVYp?=
 =?us-ascii?Q?XvEN56sGFEn5Xnk4EoU6Ltp+tIwdFXdX+PZY6EaruzcztT1n8uY8UlJVUBA6?=
 =?us-ascii?Q?vA8uo1ggFsEBNyYRKOSgNxER4oD36UqJIl41hVt/PUBn3rAo29C9lq4T80Tq?=
 =?us-ascii?Q?wHY+0+b7HA+w4VlH7e+m6qVwuex9ENMHvDdo61J46i34AfiA6YZNp71TuJSA?=
 =?us-ascii?Q?heezEKe8iJoRkLFtoOHf9qpANRgJ5KnYR1ho/0ak766AszCdILZHW8kHrC45?=
 =?us-ascii?Q?wIF2eo7ypd2rCpqF68NJjKD3BIiuXCZ64FkniQuASPZPzOrFCC3wXsBWoOdU?=
 =?us-ascii?Q?Y5HeWcdq0HfIGEKSowb814wBwxVuY75PyjiX+arQzAS8xzquyhmtfMphDN3+?=
 =?us-ascii?Q?fB8mRDhMhH8wGHlaNTpyq50erGPy8C3TYQS0lvnnM9KBJ3uI8lyBUpwIzjht?=
 =?us-ascii?Q?SkkN/UX8gVtO/UVeYE9seGk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bf53d-db28-48b4-033c-08db2beeb4fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 22:34:04.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGD3hpcHJrsRmw842Hr65KRf16cdXuwsR6qb7gQKBGfxhlfAEj0ecR8P4C455nYjxgE9Z+5ZX229odKHLmppm+gKI66gyuT2xBQ3ZOPX6r2/mbu9iiPsBRIKXZfNSyht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5258
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jing,

On Thu, 23 Mar 2023, Jing Zhang wrote:
> ACPI companion devices call insert_resource() in platform_device_add()
> to claim the device resources. If the resources are claimed again before
> ioremap(), and the addresses of multiple resources overlap, it will
> return -BUSY, causing the driver to fail to load.
>
> For example, the CMN700 on my machine is set with two resources similar
> to CMN600, and the overlap of resource addresses makes the CMN driver
> unable to match my CMN700. The error log:

I thought that the two address ranges were only needed for CMN-600?
I guess, the specification doesn't explicitly forbid giving two ranges for 
CMN700 although the example shows just one.

>
> [  12.016837] arm-cmn ARMHC700:00: can't request region for resource [mem 0x40000000-0x4fffffff]
> [  12.028230] arm-cmn: probe of ARMHC700:00 failed with error -16
> [  12.036832] arm-cmn ARMHC700:01: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> [  12.051289] arm-cmn: probe of ARMHC700:01 failed with error -16
>
> So let ACPI companion devices call arm_cmn_acpi_probe() and not claim
> resource again. In addition, the arm_cmn_acpi_probe() and
> arm_cmn_of_probe() functions are refactored to make them compatible
> with both CMN600 and CMN-ANY.
>
> Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
> drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
> 1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 1deb61b..beb3b37 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	return 0;
> }
>
> -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
> +static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
> {
> 	struct resource *cfg, *root;
>
> @@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
> 	if (!cfg)
> 		return -EINVAL;
>
> -	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!root)
> -		return -EINVAL;
> +	/* If ACPI defines more than one resource, such as cmn-600, then there may be
> +	 * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
> +	 * be obtained from the second resource. Otherwise, it can be considered that
> +	 * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
> +	 */
> +	if (pdev->num_resources > 1) {
> +		root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!root)
> +			return -EINVAL;
>
> -	if (!resource_contains(cfg, root))
> -		swap(cfg, root);
> +		if (!resource_contains(cfg, root))
> +			swap(cfg, root);
> +	} else {
> +		root = cfg;
> +	}
> 	/*
> 	 * Note that devm_ioremap_resource() is dumb and won't let the platform
> 	 * device claim cfg when the ACPI companion device has already claimed
> @@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
> 	 * appropriate name, we don't really need to do it again here anyway.
> 	 */
> 	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
> -	if (!cmn->base)
> -		return -ENOMEM;
> +	if (IS_ERR(cmn->base))
> +		return PTR_ERR(cmn->base);

I believe, devm_ioremap() returns NULL in case of error

Cheers, Ilkka


>
> 	return root->start - cfg->start;
> }
>
> -static int arm_cmn600_of_probe(struct device_node *np)
> +static int arm_cmn_of_probe(struct platform_device *pdev, struct arm_cmn *cmn)
> {
> 	u32 rootnode;
> +	int ret;
> +
> +	cmn->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cmn->base))
> +		return PTR_ERR(cmn->base);
>
> -	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
> +	/* If of_property_read_u32() return -EINVAL, it means that device tree has
> +	 * not define root-node, and root-node will return 0, which is compatible
> +	 * with cmn-600 and cmn-any.
> +	 */
> +	ret = of_property_read_u32(pdev->dev.of_node, "arm,root-node", &rootnode);
> +	if (ret == -EINVAL)
> +		return 0;
> +
> +	return rootnode;
> }
>
> static int arm_cmn_probe(struct platform_device *pdev)
> @@ -2255,16 +2277,11 @@ static int arm_cmn_probe(struct platform_device *pdev)
> 	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
> 	platform_set_drvdata(pdev, cmn);
>
> -	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
> -		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
> -	} else {
> -		rootnode = 0;
> -		cmn->base = devm_platform_ioremap_resource(pdev, 0);
> -		if (IS_ERR(cmn->base))
> -			return PTR_ERR(cmn->base);
> -		if (cmn->model == CMN600)
> -			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
> -	}
> +	if (has_acpi_companion(cmn->dev))
> +		rootnode = arm_cmn_acpi_probe(pdev, cmn);
> +	else
> +		rootnode = arm_cmn_of_probe(pdev, cmn);
> +
> 	if (rootnode < 0)
> 		return rootnode;
>
> -- 
> 1.8.3.1
>
>

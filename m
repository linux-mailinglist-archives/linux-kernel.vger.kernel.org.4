Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33595E6672
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIVPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiIVPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:06:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7556E119A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJEKZ9eI/wrnLAoJsR8wOlfFtYwW6hWEq0ndLj/Ze9iGDfKtTZ/KLAwGDiHuGFkTfCiQIoXY3aendff1tFnZKDokqOr6THAZpJzGVcz9MCAe/9Z0jdN1ICvTeMWaAmq3b/sh7qSDxuxqDpbIHSEt0OArXQq+W0l4N3E1IPCKmKHPRfYRtV3I0/aQVB0Yto+5n1LtfjijWICQdPSfiFPLAmHTvgMZeNCfpjcWc3W0+vtO0tOPpCNcd5Ly+Gjm+mPxFGwwX4t8x95xSoH6QVY/a68qri2pymB/YzTnbT9gtMxDZhBSJVSYF1pSgUDZhilEEJd2WpWNssoc3WBTew/lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWmqRfEnr4gzs5yD4Rb+bu5exfv+115r5BwzDV6CEZs=;
 b=BVpO+hffxYCTxJAgR0xTaiJwQ/jTFlcrmOeL0jR1k0s2l48Re6+TFzeTRVLPuwLqaMrNS7IzcFlIV0qZIX0lFe7XeXslhta36NFEZa9yz/FuzDLxIpBnLaMFIPmEayabb8EtgtOtPOLQbux3e500wZ77ixY7QY+NK3egHIU3CIdK+xIjUTa3AAcVLaO5Z48GiX2Mh8QuUUr8o++yRLSbS6kk2cSfYIRMd362cpAug+PFfOM/6UVpfVnLwS3eX9dhoVqJ024h40crCbOR8ZRUCoJgsdxsfWxiT8mJO9S3RbhaVdwaS+l9UvSztUMpiFEOJWt9ooljty4I27mE18qAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWmqRfEnr4gzs5yD4Rb+bu5exfv+115r5BwzDV6CEZs=;
 b=xjREro2/W8MeyL5odDVIgCsbPJ4gCof7NX/Wqwt6oG5inyPC747ogQZNaNo4drZ0Lk9t2C2nDBDpeHnE+FWSUJt6rMf6rnV5uCMjabETRtQwo7elVWKkeFMao//sHl4wA6YFs4sTvzRXXerl63I7ItgIlZMgLqOChYkP2cMWD7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CO1PR10MB4674.namprd10.prod.outlook.com
 (2603:10b6:303:9c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 15:06:08 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b417:2ac7:1925:8f69]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b417:2ac7:1925:8f69%4]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:06:08 +0000
Date:   Thu, 22 Sep 2022 08:06:05 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: [PATCH -next] mfd: ocelot-spi: Add missing MODULE_DEVICE_TABLE
Message-ID: <Yyx53bfj9pIBGKOK@euler>
References: <20220922103703.1731266-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922103703.1731266-1-yangyingliang@huawei.com>
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: df5c8f89-5eee-4bf0-afc4-08da9cabfa5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzU8x1Yy9DpuL8Ct1qFVfKfKUwvc2YYdvi47d2CFokmirXxS85EShAYrMFYxZh/adAkKv9Ni22bm0iMoOJsMFyUJvIwdhIPY8YEZ4mS+uv5f/cekPqpGuwEZPrhBU7/3yLMyfkN6OaeCgh++Fit+aXc132VIwu63fF2x2BYErsrV4pLHZ8TuRlAtAbgoK2YSQEMi1av5fOuwF+D0sNS8QAquq8pCGGY5QCYjEVZATVTprFemIzk40AfnV2SB/lUR80bNGW/msyJcIv+uDMkbvueco3RfhWIAO8yee2JCEKV8OE+BhZSOGK1YRRsmJs1m4Zzk4CcmTyI6G7I4n1iyALr2rVb/+0f7PWbuqk2j6vZZ1ySBbtdcueSrTD/aBIJyX+kNn8sfdA0ICVdESYoYnL6AD92F3oVndvFc34uo+R6zPdaOwhd/w783ma/zHOU5ccC/rlAQeBrPbyfg9OKV755qoKmXM6wA9hCBrjfwsm0BX49yv01OTpv1AmvA8lsXWm1of/+FCOpUjVkT78zROX/s8IPpfKFRlMkst1ebqbBgYkRcNzkEn8YXKaBvhnuDQWVfAQWzS7CCygUD8B1LbX/Sq3J942y/I66GHPg8jlcTuf2RZ2QR8Z02y3VotsObTg5EL1TFgLhCt1vSI5ObPfbhCHlnU7gaJbUXnsQc/hcHJXhuL33u1n84Cas+w9k5coj3fvol4gs0jNxzjoCIlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(396003)(39840400004)(136003)(366004)(451199015)(316002)(6512007)(66946007)(26005)(8936002)(9686003)(478600001)(6666004)(6506007)(6486002)(38100700002)(6916009)(186003)(86362001)(33716001)(44832011)(2906002)(4326008)(41300700001)(66556008)(66476007)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQAYeawHXW1xBjP2sD6Ae6CtyixVsQciycnuuBhqZeGGQXE4LUVqF7y0hgyF?=
 =?us-ascii?Q?dbmZItwKFB/THlT27tyHuufYmfqb30pd+JE5sPCxVbV6kYJkanGb7lPvIFzo?=
 =?us-ascii?Q?bELhKkJksyNrxPRRvZPFCS8JsDbMaoFYVQPBZ2vrHyr3EN8s14FsNK1E8eYu?=
 =?us-ascii?Q?/EpkDuUJ7IyY1mHAwuTtXeHI2qCBy0fi+EekLYLJ8HquKO1yERmipeJxkTcb?=
 =?us-ascii?Q?tlMDulqK71AzokdO6V/Vn3/RaSt+cY0F46TAQM1bvMc9s+o7r64VqIF8XzWR?=
 =?us-ascii?Q?J05mOtAWn7mSf2aCnb3Y0VQ5fQhRmLO/bjtjWxj6OTycVdYsyoWMAci2IaZJ?=
 =?us-ascii?Q?ivE+M+EVNVGsUyoU94BPILqP8Qg6fOZQkfQLguM0CHmw1GDDbBP3dKsgMzC3?=
 =?us-ascii?Q?k92afu/LtV4XRPc9SineU3Jykj2UjmHZU76AlJjs694d9P80cA/OR5iZldU/?=
 =?us-ascii?Q?1v8DAkoX/toayM+wHx7Fa68IXJk1ltlFI+2JiRtJButgfUzpe8XzuixjNcrU?=
 =?us-ascii?Q?60l/bwGdOkijRE4q+CjSkiVHOY4Na2uaPcUGZXbEFCyyc+uYpQipd49Iu0rc?=
 =?us-ascii?Q?kD99Pw01cdxDBfDe7pykKxNGLiD3ctfVn1UI49sLacGuqpnz89XRadC3uqtp?=
 =?us-ascii?Q?QuqlT8IsIjp2RHlxoRs5n9Ge/Bl4/9yUEYJ+a6pUOdLlkkaQD8WpYIizbgBk?=
 =?us-ascii?Q?uEqvT4i7806HFFRXz84EV2IDVkzCTmfiZSVf6LCZdWAqSxCTuc8gbkbOdjoH?=
 =?us-ascii?Q?oMJriv0IrwvvF5ZEgUxXyxAfSW3uzjbRkc05hEO7LAIscLFSSorw961nzN2D?=
 =?us-ascii?Q?SUWQ8Ihqa188KpKWKkXlqDcP84HYy35+fhV+ZpbUJ2HnF1l8rIgjslgiE10z?=
 =?us-ascii?Q?v87Cnqq1s+3ONsNUvWkuY3vBkgklPK+SCIxmlTJeytWdNh83Ccd1JnMHYEs4?=
 =?us-ascii?Q?8NEYLJOM3MwmpEDwmDp0igegYnjoubdd1r+yLNDUpAOcvJaRaTcHOLgoq0Es?=
 =?us-ascii?Q?WZH6RazBtB7+YrATASXCIadrUmjgXcNYd/SGrxN38Xc1h9NnP5A2SHCq1lvj?=
 =?us-ascii?Q?Zth+SCf+w6ysPtpL9nykIZWFASj5556NSakfAqk1Yn3JKS70ZFOuuC1EyxWf?=
 =?us-ascii?Q?pEuC4HMl6HTFCLFCKOkDmNm8WFYGxSqAWlETmiI00goUFEEpDWwRSu4zSeIQ?=
 =?us-ascii?Q?aE1Q/esjKZJTbW/J7YK17CcdU1kZV3VnGlOmUZI66jJ7WajovFaXH/klBY4W?=
 =?us-ascii?Q?5wBQGpAtMYANij5jCuGZXwM0pna6zxdbUfV4uTkUTIIGhbUkiJj7Z0WuH4SY?=
 =?us-ascii?Q?8WcRPAF+uyhanTXbncqdbnQACOusS9tEZ3rpxvxdzF7Dx72jpckFhMNw43Oz?=
 =?us-ascii?Q?I3Z8C+OkSMXYLaxJSGlj9SJCkmzg5bZlwfaTrR0zpBFtClKySXR5PmwpcK+K?=
 =?us-ascii?Q?kVFxJH1P5wpMi+yBjIpm47XdAAGNYLEIOcU3T9wbLwmYgNLmn33JyF9pWHuo?=
 =?us-ascii?Q?1Bum4plWSKabJD5BbemeCIWBKtVJ8I0lqtfAS5N3+7nvOtgjgGeDXKX3ub5f?=
 =?us-ascii?Q?DhpMXx931AW5bB+f0FQvI3OMdjwxcGTOTzrl6rYrEz57huPsmaIoqDWJ9axj?=
 =?us-ascii?Q?bTuS3GX/ZtWGq5voZmo4eMo=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5c8f89-5eee-4bf0-afc4-08da9cabfa5c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:06:08.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stTmTPc3YgRD+NovKACfPbQEoKYwA+DvrFZSpRu/lnqM6II0zkBblUaD8YAmK1HZabjxC0KN0bNBFdysL4b5B5gBDbcNGw78ORhKDiYLR/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Thu, Sep 22, 2022 at 06:37:03PM +0800, Yang Yingliang wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Fixes: f3e893626abe ("mfd: ocelot: Add support for the vsc7512 chip via spi")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mfd/ocelot-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
> index 0f097f4829d1..2ecd271de2fb 100644
> --- a/drivers/mfd/ocelot-spi.c
> +++ b/drivers/mfd/ocelot-spi.c
> @@ -276,6 +276,7 @@ static const struct spi_device_id ocelot_spi_ids[] = {
>  	{ "vsc7512", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(spi, ocelot_spi_ids);
>  
>  static const struct of_device_id ocelot_spi_of_match[] = {
>  	{ .compatible = "mscc,vsc7512" },
> -- 
> 2.25.1
> 

Good catch. I just tested running ocelot-soc as a module and it worked
without your patch. Do you know how I can test the case where it fails?

Thanks

Colin Foster

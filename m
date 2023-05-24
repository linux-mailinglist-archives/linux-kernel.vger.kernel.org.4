Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BA70F40A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjEXKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEXKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:23:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2091.outbound.protection.outlook.com [40.107.220.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B48F;
        Wed, 24 May 2023 03:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb+Fvhh3Eki9It1NIW9HBxFbispq/O3XBBfTFIqWftOH0VlZ7+pjc8eYv7VsPmbzeJzcyqIpyKB7fH0CVRYm97bmVlj/y69U/hlOwklyTpb1+vmVAOuD+zjMajjsoSUvw3vmbU47RW0AiBgcCb+P2NjxciXkaR4muZprjJlOadVTlIiqhMTiLxWenShP6OF/QYYCiKrGRrrovHZZeAmthNVvzkj7hf/O8/AuHK1lJLwr+bODrIgodrSlNsilpVaZwZjm6q24ckYf8yLKLPRkVOdIRyAxjrS6zM16dc0q8gmcmlOoRiHBjVWZK50mUJriooD+wqu5yWTODEDwfVMvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+urhLekVdlW+2KNDcUNdiuXnITAHUtBkEuqWHya6Yk=;
 b=K/J+RBVoQU7nbD2YmBUxVaAbw5C2yAgr6wSaPRNbMPTMaC1oGOBVJSDscXam3v3wH7nmLWSQdC5+ue7oKgnCiVaaWH3+tGczGI30GYUe/xogaf8IIY67SbAhmB5W8v/Rnir1D6F4z+xqltxaTVXFH9S6BXXkAsYlVwEPXaZBrEzErH34EFmOpth7GEAtiUhSTs18hs7ua51WH9P7V3M9OUoYjzTlCxu3p+TrjFEe0Uc5rDR74g6ZYo2XkGo9++EM/vN5eU1YT9MbrhsLMFxkBJNbgtvHl1/J4hwOJ8USs5faobusRbiIoda1+O5eg4oNMoyE8tzB1dzkFJuWWO/2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+urhLekVdlW+2KNDcUNdiuXnITAHUtBkEuqWHya6Yk=;
 b=isL377UqfjxHGJhOqZje4u6+LNJjTbWeSFjihq0zhP6oIIivwIt9xUhs7/VbrzyP99zDo5V1TX30pSBIaPiNAxmqS7hwt9LyOc599eE1BN4onKE6dn3jgDq3Ylg0uXH6BPGF1cM+ZQ3UtVhwMhBffz6h1/nEb2VgTt4fIAIwl/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3795.namprd13.prod.outlook.com (2603:10b6:a03:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 10:22:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 10:22:58 +0000
Date:   Wed, 24 May 2023 12:22:52 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] ray_cs: Fix an error handling path in
 ray_probe()
Message-ID: <ZG3lfOt6lMjxr+Na@corigine.com>
References: <8c544d18084f8b37dd108e844f7e79e85ff708ff.1684570373.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c544d18084f8b37dd108e844f7e79e85ff708ff.1684570373.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: AM0PR02CA0158.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3795:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c56073-3175-42aa-ace4-08db5c40d850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJMKf8G1W7G/DbZMRteR7M1MEJr/rS2vBGSoYfiG1mLvxb0fq52eijknyTNUf4uprosLDQS365G7N+yLvc+vmofIX1rtvM/wsgJWuGmPMViYZ8alyGK8tn6RY1dFtlPly2ym5TZedzLMZ0Eb20UI9R+inederMMdp8GWYGaSJpHSFdy+jskrJ2ozAUOY0X34Uj8m/g/5NsQsjnYGCQ3Va/d/pOcqFt0w5YDCTEGDqvUNdXnqyHQND+gQM1MoFcCdypZCmamMGRVnXWmzS2tFkr/sA/uxkoSbq5Gh+lkpswVa/CKtvO4c3hBQ6cN0bWpiWdeEdk4U9CiLYyCBBuSuwKm4+LozFnyZtCEys1TEEjvIwl7IO+A+vnbU69YqeSCdmkC8btK9lXcjd3bcZ67dWHkcFdOb5FhASQK5Gxv5RcCvOcaXFa0NjyHwezgRxQhA4pM71w8aohQy+O933xsWKMcGbCJTQAM62gTeqpsqlFjggUJw1PoYnYelFvKvxLqrF6Mk7W3ZH4izBEuf85w/3Eed2HWrr2MBqbvV05AKXbWvXrgSo+yfAhg+cqWQM47QnDdbl3LlRDqXdViZdeFkb3c5qIwGnPbyYiE1tMPxQqiTa/hhehzKstl3VORs0FUzXQKB9W1DO1G5cGwPq8Hx2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(376002)(366004)(346002)(136003)(396003)(451199021)(66476007)(66556008)(54906003)(66946007)(6666004)(6512007)(6506007)(316002)(6916009)(4326008)(6486002)(41300700001)(478600001)(8936002)(8676002)(5660300002)(2616005)(86362001)(36756003)(2906002)(4744005)(44832011)(38100700002)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87fKeutVfr3lWdDB00g+mwhfdA1DRLagWia28yQFAb2KZZZWOZqwbmLcwwi4?=
 =?us-ascii?Q?bFlivopI9dwBQ+vxgo7T/MDmAZRAciQawBRzhhRVvB+zzNAjzUZ55sd+vhTW?=
 =?us-ascii?Q?Lh9HimIpv+nKdV9Z4PQwEMoDaZQF2KGiHHmnw3qMUv6txRk6/39qsGo4999a?=
 =?us-ascii?Q?TYHYMiilImPGi9GLtcgkFs6BGIRYGceNJTgJhzdsMXL0QWA19DQ35V4Lxg80?=
 =?us-ascii?Q?ht1kq8Tq0/leDHnPQxYAzxDTQQ93LfOu7WpH2DEc7FiYQNzVR7WFLkWxnP4C?=
 =?us-ascii?Q?4V8iKsbS1zleck0I7XH4AoEStpVScuGxPoojI8EqpwSFVjodNe3Fedn9ytEQ?=
 =?us-ascii?Q?LIP9qJlG5BlBrU8Ink3KHtyJ63jJ2viAU2GSmEjO5Acs29BXF2ZhAWH8tbtg?=
 =?us-ascii?Q?FtfHe35AIPNoNk76OBUxDss/ZLucRZZiu3bND5Af4GHXZl/9V8EQuyhm+8NX?=
 =?us-ascii?Q?5r8lMgcA/JjrxPmDKXjFy7D/7LsFx5eaovlwSdvZ4FY4jJ/brpAwbKTeLH0p?=
 =?us-ascii?Q?xJZZzm+ANHNTqEubC5B1nG+QODQYe/XvAlOcSjkNPU+NfObx2uErQT0zNQMm?=
 =?us-ascii?Q?XYcVGkyVK+DS5h9+Nfh6j56KIV4OLHLKP/6spAxhhr54ATMCEtPSyKqPdfnf?=
 =?us-ascii?Q?zirMV/ZavLyboB17/vQDicMawTdZNPhv3DZa4UHrvTtwc7/Gzr3rRx1L3yAj?=
 =?us-ascii?Q?Lawi7gMGVqnT5MMFjUXnJcawJ7htg338gl5JI3A6qGMK6dGHXN3iGyEmD41e?=
 =?us-ascii?Q?7rifqb+SRH6j11vhVUUN4M9oys0MLmOFAT2Fmw7oaniBQ7zKB4yKQKssDeA4?=
 =?us-ascii?Q?AkvxYXa+gWiSCByYwqnubYSS1dEPbLCFLReYtSQMYQP224f+tCLfbAuZrEGP?=
 =?us-ascii?Q?HHHXZmsicNV8t/C+2Hm+TPr8Xwu4oHZthEmH1vbQz/I6f2FhrDST8PXRARUg?=
 =?us-ascii?Q?9NNLam8uG2APMiFY+2OGsKdAlqMcMuZwDMpwR2CudRKmheIphQ6U9QJ3jsEw?=
 =?us-ascii?Q?2Z9b1s5O0ZSxNqlsILQe4/KwYK0bAWJUxP7ij6vKNntmX33ncEi504rqxHam?=
 =?us-ascii?Q?/CjfWEIDp/qYP1XGmTy9Uq/YzCFhc7Cii+cHjUXMUoWmtg9P3hY8EymEGDTc?=
 =?us-ascii?Q?MPwFlKNP4dfSjw0hWDncHmBC4q2qsICjsnTPS/RYm5YEfCcw2/xOzmMcFBtT?=
 =?us-ascii?Q?fgRmo4FnsrfXglX45mWP8sPm9r1muPXmEHFddAPaUR1IyiCl5AgHUD8CCoMe?=
 =?us-ascii?Q?AjQcr70f0J4CL3GCgJxg5BNjPppZ9zugM73H7+/2xIvWlvLrM6O4MhYZVhgV?=
 =?us-ascii?Q?ANcncP/74ohYUx/AzZH/9uIDNw00kPs/BnUYwY/gJ3kb1gqKNAeYFDeCnQK4?=
 =?us-ascii?Q?AnTpfpgi8kflQCKjyHiPMPlMsSd8GHdP9aqU6mxeU2GsWkuG/6CMGC/vweh9?=
 =?us-ascii?Q?i0iEDNs2xSYeeo+HK2XLb3jAwOrQXgwXwk11HBKTMRrtrqNUQMvb4XHYqP4i?=
 =?us-ascii?Q?E9pJT8CoTJJtuZKCCb5FLdqqIGe736ImuP2tO7RTow8F+amHIfMz/bEVSqxp?=
 =?us-ascii?Q?LNubEx5uyJPm0AKdX4jplUe+hCTUvHByX9yU9LzA+dgoPCbY138X1G2koX2F?=
 =?us-ascii?Q?Fkwu9bQ22an2KievaIICg7oBUNbXNGzEUk0BpsfdaUaIKG3d/09t48PdSC3x?=
 =?us-ascii?Q?I0QZYw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c56073-3175-42aa-ace4-08db5c40d850
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:22:58.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6XuptNzF3az6+jQL+HHcGqnERqrzC8lMthI8ApdUChFDMRDhs4d9BLMZkhhM6P4L35kRnyY++ta6JFTpSdCWV/QSyZiMPMyO8Ip7quhNRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:13:22AM +0200, Christophe JAILLET wrote:
> Should ray_config() fail, some resources need to be released as already
> done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> ray_probe(), not ray_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


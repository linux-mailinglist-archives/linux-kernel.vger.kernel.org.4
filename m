Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFB6116C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ1QDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJ1QDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:03:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9791222F2E;
        Fri, 28 Oct 2022 09:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwVg+BT5qC2LphguzVFmN0pl2+e3viL23x2dFok2BZN1yxoVOt3+CLEbFpbqsYtm0RLp9WEZKN7AMMHEZlPW85NB5KOOCwOF/ica9jXRdjV64UxYxjzSXBiC6uNUbxJEJItFmREoyx9cgQZDAc4/VU5inxMXF7KgKc3xSr2MuV7qG2SpDYY1HkQFT0R3CfERg78G6UbaxRKK4hgfxmLQzdbxfmhl/ltAVU9qzcd+di1HcMTKF7MG8l68laCNFFgC5Z0Rv5IMUbSzifbca/t21SIJzLoQin/5OU9K5oYzgkroobI5Z6nND1awGtwb2IuN79iSun9sKcCP3l4fq5cMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwopFWDBVKBFsUAGS71eFZHvhc7hTfONqGeHtPnir2I=;
 b=Z2r17wualSx/23pNyfgrDH8N0VtWRYTqMwrNdv3tRsRJ0KCjwpe8X2/B+HXdjZOMmN5l1oGlqeGP6QmW+HlzyTt+D65sWIMCNN6X6MS6ejGFHwYH1ujGIjsRMQG7F12fhiLRp3O91JuDU2S6LUseYCA1vmA+1QOiXMQCSXo4/vJtLQ1BipRQlXTyVruy4b6FMeTkbMn2FP64K7hOcvptAbm1Sx3dc0frKlqE61593mX9LrpK8DlzUaJZJjQpYMRBDQkZgsAbL7D7qkcmjxjfqFYVQxd9rUdMkpYxSaCcVzHjAliDtHY/qPhv57WX0guVl4pntkZljWilw2Fh2Xrm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwopFWDBVKBFsUAGS71eFZHvhc7hTfONqGeHtPnir2I=;
 b=ufLAd+Izn3LW9+dJo7p7zjGDBuVXRLN4Lhp407+GRrWt6a1xV05DgBv0aT9goMXTq8ALej8e31GS+8WdPkT8aAe50XMyWEGAvBWJUAa6Ntz+AZ4mPuuOsgYLTAXH3dupNj+FEImpT7auRVElvt+1SxxAp9MNQn1rPO4OcRpAwvoxtLHklBifzYRxwPHFpoZYYmIsEl0RQJz7kVJSdW8SYoPQV3J42+dWxBp9D4EaO/CnF2KV959scPnqeBd4Y/KUmo/xe2qX6h49Nx2eqmip/Uz9PYqVkJzuIHIXLG/JFsNOpIWsrqTgMYTo+4rR66MDZAToY7uOuIESWCgJS4K16A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:00:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:00:44 +0000
Date:   Fri, 28 Oct 2022 13:00:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rdma-fixes tree
Message-ID: <Y1v8qhfir/wP/0v/@nvidia.com>
References: <20221028071943.30659de2@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028071943.30659de2@canb.auug.org.au>
X-ClientProxiedBy: BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a27e565-0042-4903-cc4d-08dab8fd918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDOB+sCkZPixcHnSEcpFe7jLRzleftW/Qap/aigLpLqAgWWbnMkSqsoKFXv7sfif8MrOjyDzBM/rI/fZ9uVNXQmiP2tNbmYZPu61/3TY6V2HZxCiKkcoIiGGq9prrAoOb3zpykfaBGkMluLlG9L1cUyeEyPmhXCxfuvU3TJjstUpaQ7t18i+kEyOqXDGPUcHr8G6YM20cMYBBzdEMwDqvyZjudfj+Kfz5dNwg9cgwYH/CTFIlFBER/K8gI09LWj13LGXUSiEiBgAAqsTmAQJ0eZtrPcurqSoqaPe/hogxcyqDrU46FcJUEUWF/c08clQQY/kAznezyw8gLFIFa+K0b1S7A1EPgqM2STke2K4Poy8oqDtblLUJVFg1FSUBgaAGCm5HANFEyxaChO84sjYq5TorrrtnXdgYVPlSFwltUKOJHh5f0rhI52LhE6m+CmTz03xxJtQSqxxHOg4/gvv3vCNlkQyeYym2gv6nkDWuB9yqpk/sVuVGK2LCTxRaNmYMubrBSmnapaOxxSmQ2sDnvPV8Yba5zXBcA0h+y79VLVA3CppqnUP98qxkvCp4gySjHn/2ytF0BSQuVr9StVQjyR21og4LLlsXWK8EWQ0BwpW1MSErxWMxiPKJzQ9vDagXb1acOtf8FLB6wQcUaoLYM/9A8hrNdfUkqhl7Dc/9Hi8JlgrUm8LtMY2oWWZCQw+WWwgFqnMlPsCQp56SUyFwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(6486002)(478600001)(38100700002)(5660300002)(4744005)(66556008)(66476007)(66946007)(8676002)(4326008)(8936002)(54906003)(83380400001)(6916009)(86362001)(2906002)(186003)(2616005)(6506007)(6512007)(41300700001)(316002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PD6KOClEmpEYXsxsAGpJnB0aj3qceF+qTEURTqJQriK9C7kHPPAQNJ0CJNF?=
 =?us-ascii?Q?rB4Cxo3u0+xQTuzC795zEMTaXBVg/u6n4TnjTZjCOSWbJwiyAedqVQ485fhd?=
 =?us-ascii?Q?n7iLOLrXtjitvVFlMOLH5TsOkB1cQAs4JytsrAdNG0teHnTDkXBtr8yUqUAg?=
 =?us-ascii?Q?ktz/trRJOgg9CbNxvZvc+k1bd/1e2DaM5ywerQ3Xl8tM6sG4Lu6T7hBEjc9Q?=
 =?us-ascii?Q?8ZoWEO1lHeh8/NEdSh7T4tWNp920PWJoXfdUvWIkOfh2W1GvAGovTWNgRxH/?=
 =?us-ascii?Q?k6QD09j/dQE4LY2QjQ0qYJOfbSHbUlLBedJKzwc+ANaDKEDEVSPyoaUn7eiU?=
 =?us-ascii?Q?ZLp9btL5Ly5iI3E/jCVT4RdDiLfmnGx4cmMY1Z4g8MrI0ll6G99skxAd0mCr?=
 =?us-ascii?Q?d+QeIb4fVuJRI/Rah17GuO9mFxw5zvXSI3aTBpj1h377AHdBSLWGaYuswPvy?=
 =?us-ascii?Q?uTtvvHmBM4PIcIhIkU7rmfLjO4oko/TDN0Ze733sH58JGM/34Ol/jq9Cwi9y?=
 =?us-ascii?Q?ZL3alPLo7CKglsA0jSczjUHiQPwvNO8yE1/Bbc6QZahih9NknSbvK0DkBuep?=
 =?us-ascii?Q?+aiQL9vWC9rkhc03vkqc2yIPBaN+AaX4i/JYvF+4Kf9m7yUHwsk7fdrrFWNY?=
 =?us-ascii?Q?FMsRCn7W8bPUU6nhgilZhFIrHFJmcdxULygBVtN8ny5EgmbCto3kb2zPHZSy?=
 =?us-ascii?Q?Vnhz+Z1ZbZOWwrlDWFUKF8CTAU4CxmBpfIHhvf9ixHfWCA4wvOUTAQqDPx7n?=
 =?us-ascii?Q?jBghSp7lDZkQ9Mvb45Bz7CAZa7/UGyGIDPGjoVctoLWgb57+YwTCoQgaRujT?=
 =?us-ascii?Q?yuRRDj0v06Ji0p+K5QFXan7ZnTvc8UWUs+uKSoZYBQmdfKgIWnvNL6gBs77m?=
 =?us-ascii?Q?64T/EDaQGWbm096nZ2SWuf9D4Gzj1jP5tLXna81PaXjhZDYbxAohO+acINoj?=
 =?us-ascii?Q?6jvTHTi48hhz5y1DEg9DKopkDUuNU/rs84Ofg6nWexVyZYoHceO8Ra8eoS1U?=
 =?us-ascii?Q?lkT0Vb/hcUdtnvdbca33IVfICAL3XR311Wl2HHfXrHTfF0AKL8XzYpzwr3a/?=
 =?us-ascii?Q?l+Gf0Uh1r0OsM7Cu6KLdL9cPjLmlxhqX/K8ijjwLysRpFIxx3tmG/Gupjtz2?=
 =?us-ascii?Q?BMjXI/LWSo28G1FNS2oc2zz5KMyrUeTc/I0sCMSCnGgVvSoUofdeR8A5UDHP?=
 =?us-ascii?Q?knILnydtzMX5ejOf7p0waEdoENJ/ZS2dqGUo6gJUdXsLFFWuOlGWkddIkATL?=
 =?us-ascii?Q?ZNVYDK84ZsVwYdgOVY+uG/vkoJyV/ga5afVhph3nDF+nkEZxWE6r9K+Zxrsm?=
 =?us-ascii?Q?kJXI9Jwb4pm6kDZW4VRhxgWUbKR7S05dgtZf+eMwkgoFFndLSVeSeFMeamZT?=
 =?us-ascii?Q?tvkWG0BXslD/TLLBDRwu28DJqD2ONcjqe4S1j9+lXGMNpj87wen+CrMdF/jL?=
 =?us-ascii?Q?7I1aAuW/mkGtGsnyvjG61N2owW8lJDvO2MoveQ62kVGgvbAUb9SQ0Ej0auWQ?=
 =?us-ascii?Q?RZ+7K9+TIZQXFYFMP/icHxP4pU4BD6dWNPywPc8Ty3G8S65Stl4ClEOaGOMU?=
 =?us-ascii?Q?td6Hny6MT5uiZPc0gK8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a27e565-0042-4903-cc4d-08dab8fd918f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:00:43.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtOTdPNsovX1fGUnOafn83sVtDU3VEJK4gdGn80gYvWXDVwASjGMSIvULFhb9v3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:19:43AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rdma-fixes tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> 
> Introduced by commit
> 
>   ad9394a3da33 ("RDMA/core: Fix null-ptr-deref in ib_core_cleanup()")
> 

Fixed up thanks

Jason

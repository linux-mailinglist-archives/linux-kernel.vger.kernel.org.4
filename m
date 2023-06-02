Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2971F870
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFBCcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFBCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:32:37 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172E184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:32:36 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3521bcCH023829;
        Fri, 2 Jun 2023 02:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : in-reply-to : message-id : references : content-type :
 mime-version; s=pps0720; bh=ZC9/juM1wDX1hn0fo96GSeFfHZ3o7mJXmb41ClhQYqA=;
 b=giH2hQzzeuC+E/mj3AM23m4n2ipX90gwOJPcWsapGeKkhNqPzl4NNAX4Gh1Be3ihgzSx
 JkEw7xoJF4x/dztG/8CH67NIwsKtBSTBTvMmKO52qe2rdQGoL2H5di82PUlOpu+pk4P3
 igYAiKQ9ClL/dk5EHca4hs6SxnMetggfH0JTjKpHqoNtGNOFLt4rgO4yGTi2BfXxaShL
 lKyQUTJutRxxILNnGlEfj7EsAI8VhXAIEatGmMRO/qrVlCF0F0+khuY6N+ScBIA7xUvJ
 1+GWdJ4RmAUuTMNAmEXqmPKXmTeCFQvFylAQ6vrWya+vXSVLct2KaWF1ri3od7lMmL/4 gw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qy6x7gew0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 02:32:15 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9A23C12EAC;
        Fri,  2 Jun 2023 02:32:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 14:31:59 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 14:31:59 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 1 Jun 2023 14:31:59 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 14:31:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aopmoFBbQD35rY/AegaVC+BaYIUKnfNMAisgSrdRhzhqgC+FLyK8NCrt3jQw+vhVLWNhqq5w0an06DV//IPlnQ4rQZd4hj0Qsv/zwbjfgPTJ8j0BJ6M3pPFTAutnHnGECVjP36W+eP8dZw5j8Gn0IMPb8quA91W5rsDMsXKknj/Fky5HqBSvezWepIHa+a0RSPLsBVxPDf6MZVkhewex5Va7qayb393FR5qZrGwMBzCguVhX+Gomv52pVywExeaOhALhwWPN3d9ihS07aiaTgwbs2lofwl47FZh54jn9l30lb4bRL3aAeVJGJbPan4xd4nXBA2JcXdrjHCCDyAgolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9/juM1wDX1hn0fo96GSeFfHZ3o7mJXmb41ClhQYqA=;
 b=LuK0aXFzmOC/c0owTN2xdbZP8Uq3QLqD4R8OX9IrR2d9iDbQL9/aGASK4iRgGVzhC+hucPK3raw3RYpbcwyfPoQsFlwou2aVS7WcQj1kJFiva+l7nwBPyxQNEvXkAA+xa+EAfi3+XQfc+LgG9unrMLPYgGEPe0FvavaTv9axz5LYIl2by9zUmoHVU/2ArmGZzb2IxiluSc7WnIzq+274N97a74k9htN5tl6IgyeK3qw2Z6OOmqsMufyvy07iMKuTy0y/RqkwvX596TtPNnLxflHfFpSrcxVX3mBbfjLBrKQ89Bs20WH0PLES8SW4YywParkBtGkNo3ruRq3kNJc9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::6)
 by MW5PR84MB1403.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 02:31:57 +0000
Received: from SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::904c:d935:b75f:db3f]) by SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::904c:d935:b75f:db3f%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 02:31:57 +0000
Date:   Thu, 1 Jun 2023 19:31:53 -0700 (PDT)
From:   Paul Cassella <cassella@hpe.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <akpm@linux-foundation.org>,
        <joao.m.martins@oracle.com>, <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
In-Reply-To: <Y4u2TK4yPU9dfiDr@iweiny-mobl>
Message-ID: <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com> <Y4u2TK4yPU9dfiDr@iweiny-mobl>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:a03:432::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR84MB1388:EE_|MW5PR84MB1403:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c504a4-73e4-48aa-2c9a-08db63118902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en66TFZX2K9VmH2wSiIiqlyrx3VMFLrJ6qsxCZ8dZt2WP/8t46ELlRerLy4PP9c8qdNAiozCo4lPx6VhHjy866MLVgg9A+9OWzeeKP1oSQaUbWTgXw+He4/4/Sa8nGaBJQYxQirrcYIMHy//objVqqR6QI6DxuhD9BG5oBHtyl7d611+aoBl66Nh+kkvZ18O9JJjLVgXPvvD+OI7DIB0nkL+7yFLNhnqxrjXsCYFRHwESj6sHYemFeEnfJyOKc2DpXQCPnadyhpNPiXeyK4zwo9bbIUyoQLByEYkeaijE775WEJUIeaIbisQpVI5feEoKCPrWYv8wbUCEL9dwjcuq8Sbt1GQpdhKluZNQVMUew5HOU4PrPwJmna6ikbtXDN902WPahM3ZydM59iTWZ4bs2eAHvN5+Kg9TWOZT+eSq+POLMoKTBrZO3/1B3C6pVRmWaJ5Quf4iltAOwwwaseSyZI2nl0yyTi/YDiS7Gy91IkbqSUu4QnjZdDgjZG5ZzK2F+NWqmK0XEjWZLJjA499jZcPgnSF+RSnTXE3jojb7T0HA2/ycPa/7cKIoX00R3pS0B4rMuUVomR9zWfTn4spHKMZ41GX7n3QE6vNHpwk1o97bgxqwoLRDzXCq0llsQ0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(83380400001)(316002)(66476007)(66946007)(36756003)(5660300002)(6666004)(6916009)(7416002)(66556008)(4326008)(41300700001)(8676002)(6486002)(38100700002)(31696002)(8936002)(82960400001)(2906002)(2616005)(6512007)(478600001)(6506007)(186003)(31686004)(26005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wxvu/NLgw78/LG0CjInG1HCsdWFvp4BKPL6pia8xAF2nkm0xg2k7kyQB1MMH?=
 =?us-ascii?Q?uW05HAqXOAwnof9aA3fGKsGCMoMz0mZSWY1P2DpImH5141InTP+NJsqqQRHz?=
 =?us-ascii?Q?u/j+KWlZRh4jkH16WhbjNwTO0/4yLFhgXfSvSDMd8hOOh+rYwIdLsYBz5Tig?=
 =?us-ascii?Q?NHVqrIVfvC3A0m9IykK1tnKhpY3YfZKIhVGjp4z/url+MkkdUnvf2rhiOL65?=
 =?us-ascii?Q?hQSAnrMD54O7JgmbmY/lln+NcMweunMHOp1K8KCxkIdGgeSK/i8ubg9/DQXA?=
 =?us-ascii?Q?4lHN90vXzVeQhMBDrjI71dcqEurD5NQbREVsabSTvp8bK/9qlZicA6E8Gepd?=
 =?us-ascii?Q?rPEPDrBjqeV/opT+2jKiaFZfGWVERXx7/Iykr9C5QPCDfPyFdZP1u6QOXe3W?=
 =?us-ascii?Q?i6LjervaxutYQIs8XzpPPmWRjQ3DTuifr6QSk8XC3703S9p4o6yb3IXNOvC/?=
 =?us-ascii?Q?AvqPO7XI0NEZKuDnh1CxknZyvOcaOO7BnV0xZhbCCDLhn6hGPOI+/r0CXmIp?=
 =?us-ascii?Q?5+XwADWsKAQ5jzOc5oM++THjI7BuHJZsJQc6dJESi7ScCd8Gb6inbryyvXLW?=
 =?us-ascii?Q?dD8smqz0X6Zw3J8M0foZUiudROEY1z9L3W8oDOn54Zdo5mpywYpwVwDvlfwG?=
 =?us-ascii?Q?qQQfAPBcBHduDxpz6zGxOO+KHy21TzORm7fPQPwnxDobfpiX2vUXgqIzQ2SU?=
 =?us-ascii?Q?XZ06y9OoD6PLBCvZjiuX8i3A9hfExsxHMWI6sGHnG+t3cJx8bIwXp8rqOFaI?=
 =?us-ascii?Q?Gd+vyobu1vvUOcHsNzOnM8kqkMag8SmQBvzA6HIF/1q9Geb57640xbOT+UjW?=
 =?us-ascii?Q?obAIqqoQtBK4U491HX/K10k/NOb8iA/V1keBKjEVkTLj+4838PjyCb1eS1Yv?=
 =?us-ascii?Q?wh30iHF94oYlTsAuPVEzhit7S4gAqtjeruRrlz0hmS8bh8L1g4zTZ/dTNIgK?=
 =?us-ascii?Q?dAYQ+gnYUr+LWXf3WhKqp1bo9yP/+q0wGksF+NeOZsgrq6DjpGPScdy/DF9T?=
 =?us-ascii?Q?KRV9E8lLfdX9474v5uhbMU6mgeXY2yccSUcWdBACjMSAQEIAnswRawDDJ5te?=
 =?us-ascii?Q?Ng1pF8uh7CERC5HGADMHQHmRV0qoHIqvrLp3Lorj4w0c2AG4bhRMC6JGmInk?=
 =?us-ascii?Q?sERMAepJzdef593yGPg5NcSAoNDDAwG5iljEs/+otH1QvVRfliF/Ol/yUgD8?=
 =?us-ascii?Q?8pJ0P4wcvBApQ0+BuAKm07ux+OZzLnkxYKHAZ+nTn67vwSBLmlOTIwDnRY1D?=
 =?us-ascii?Q?fOSSSgubPEvXKNW5U44uIN+EXgzH2W+AwKracxBruZR9p++/AYw9I99Yrx74?=
 =?us-ascii?Q?x6kp1BD+uT7Vw4khW9Lzr3FYRhJQyyxvi6/cMkQLOqe9wfSuP95SPpJ6Q+0F?=
 =?us-ascii?Q?80PerwMl23br5QB/r7Yi0/NspvsMnvkvuKlibfrTgS7kb2dSJEO/mXXu4kkF?=
 =?us-ascii?Q?IWybx7vlrLi0qciTOVF1QSQoHN1rmrwurW2PXzSCTpT2Fy1rupzyFujiLoWi?=
 =?us-ascii?Q?hH1iH0Gmr8b1UQmTUd8OkGri1103Ll6JtiuLUnESVGeT4nhmRKuR5oPU3mX/?=
 =?us-ascii?Q?R0KBSrbnCVlALCtAq5Am3lPBaTjvsCAIOtz+cfEz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c504a4-73e4-48aa-2c9a-08db63118902
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 02:31:57.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBULQspKojDp/7fTqb+39lVv81u1tJxh1/H0vkqCMbtdFpUK66F9qaLIvVz6ABOwTnqh5BRCQPmTVRbdl2ZLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1403
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: L2tejDAuaRhYferSObTG0EXM4hO6N8ce
X-Proofpoint-GUID: L2tejDAuaRhYferSObTG0EXM4hO6N8ce
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020018
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2022, Ira Weiny wrote:
> On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:

> > We should always call dax_region_put() whenever devm_create_dev_dax()
> > succeed or fail to avoid refcount leak of dax_region. Move the return
> > value check after dax_region_put().

> I think dax_region_put is called from dax_region_unregister() automatically on
> tear down.

Hi Ira,

Note the reference dax_region_unregister() will be putting is the one 
devm_create_dev_dax() takes by kref_get(&dax_region->kref). I think 
dax_hmem_probe() needs to put its reference in the error case, as in the 
successful case.

Consider, devm_create_dev_dax() has error paths that return without 
involving dax_region_unregister(), prior to kref_get() and device_add().  
dax_hmem_probe() is clearly responsible for freeing the region in those 
cases.


dax_hmem_probe() drops its own reference in the successful case because 
(per the comment) "child dev_dax instances now own the lifetime of the 
dax_region".  That ownership is the reference that the error-case 
dax_region_unregister() is dropping.  dax_hmem_probe()'s initial reference 
also needs to be dropped in the error case, as in the successful case.


> > Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
> 
> I'm also not sure how this patch is related to this fix.
> 
> Ira
> 
> > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > ---
> >  drivers/dax/hmem/hmem.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> > index 1bf040dbc834..09f5cd7b6c8e 100644
> > --- a/drivers/dax/hmem/hmem.c
> > +++ b/drivers/dax/hmem/hmem.c
> > @@ -36,12 +36,11 @@ static int dax_hmem_probe(struct platform_device *pdev)
> >  		.size = region_idle ? 0 : resource_size(res),
> >  	};
> >  	dev_dax = devm_create_dev_dax(&data);
> > -	if (IS_ERR(dev_dax))
> > -		return PTR_ERR(dev_dax);
> >  
> >  	/* child dev_dax instances now own the lifetime of the dax_region */

This comment should probably be updated now.  :)


-- 
Paul Cassella


> >  	dax_region_put(dax_region);
> > -	return 0;
> > +
> > +	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
> >  }
> >  
> >  static int dax_hmem_remove(struct platform_device *pdev)
> > -- 
> > 2.25.1
> > 
> > 
> 

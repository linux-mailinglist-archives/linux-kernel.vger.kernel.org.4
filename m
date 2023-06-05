Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D21722F99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjFETR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjFETQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC419C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:16:30 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355H8jkZ021562
        for <linux-kernel@vger.kernel.org>; Mon, 5 Jun 2023 12:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=yocraCnbh36EfLmD2NJKygkFfvy64Er/24Gsbr33G7g=;
 b=MwZKDBPulER74+1RxVrffo2NIoP2E9H66MuXgfHIT58yOEJ52e0l54/aSaLPfu2ByoiJ
 pvT7csNGFNEwE34WHsbkBu9mdpMkRE14GbMj1GdQ7ZTjx9uZM1sj01XoetWkPJpXYk+T
 XJCNutCw+2xlPlbuoL5fKgjoBiOVJwAjievgNhX9dB37TriCSLt2gF+FGLfL2hdtZ3+A
 wPVTkOE3b2odHXnKxvSYA3GNiLEVYttCPdNLzCycPcfF6NMyAqkck6QBesvy6/Z6m743
 xONzxJ3bOSU/EBs4T3dB60uQk+0KZWrVqU1yEkyXG1hEs+c68oZYRZvHHhAJJasBbbac VQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r1fxyjxc7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAvEOg/3U6/srbzAx7VNI0bjbM5fiisactvPEiTiNjx+QLH+TBHjmEbHxGZBEwPIbBGoaVHrzTdBifXJ+bfriqNQ1AtI44dWg6xT053e0Zf6fcRt+Buvcz/4BSKR+j+e5oL0BJGMlVf0j8eYIfhm0SsbQ2o7zmLJpboCsKdchdHcrnnh1zPnZOqRoVqgMbRwMIQYK4UvmxWpqoQRBbJIU5uKIxpJS+ovc+gQrumJkA2zHfW4CruFNgl0oUrEMc29HFqTHPEmaT0X3Au1GLUCuCgLyeDXDpdpMrRej6bjAGgIkBrXrCCEMuRp3NYGbKXN13vCRImfy9VAMBzdAD44iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yocraCnbh36EfLmD2NJKygkFfvy64Er/24Gsbr33G7g=;
 b=S8CY3X7uM6eMbdyfmCIzNC86aDtyhz8fnp2erAoTWbv/QFtMmVDwDWI+hH5NwUuhH4LE0SEYzW7192RXYUvNfcOS1uOoJ0TqBaUxAwD2HPs5yCLMwSVTrkVqZVm3eA9dGa5MpAewiVxDcnxAWeTWu7Ww8D7q45dohavD7+UHS7+U622x1VWQc/UsLwx7ELR5ZmmKXtYH7p1TeiE3N25IaKpjPUNFfv19EZiSunOc0xi6qpCudb6RK7CY8eLLMlP4cRM+6MdoB7UG8xVaz0OSd2lXuxp1off+WPUXinwJIuhUTViWZYSnLJ1sErNViqvOH9fJzPT+3m4B4+zU8UOjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5191.namprd15.prod.outlook.com (2603:10b6:510:14c::12)
 by DM6PR15MB4023.namprd15.prod.outlook.com (2603:10b6:5:294::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 19:16:26 +0000
Received: from PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::6fb6:80d8:62ab:9789]) by PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::6fb6:80d8:62ab:9789%6]) with mapi id 15.20.6455.020; Mon, 5 Jun 2023
 19:16:26 +0000
From:   Tomislav Novak <tnovak@meta.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Topic: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Index: AQHYz4xNSRmGp4l1PUKwAHNo0kfo465AaXSAgBQ5MQCAAxHJAIEmcOYA
Date:   Mon, 5 Jun 2023 19:16:26 +0000
Message-ID: <ZH40hgYbWc0x+1c3@tnovak-mbp.dhcp.thefacebook.com>
References: <20220923203644.2731604-1-tnovak@fb.com>
 <Y3OrsU9M+X2UUcRG@arm.com> <Y4SiohG4P7nX0GWb@tnovak-mbp.dhcp.thefacebook.com>
 <Y4c1zOZYi3sCxzo9@arm.com>
In-Reply-To: <Y4c1zOZYi3sCxzo9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5191:EE_|DM6PR15MB4023:EE_
x-ms-office365-filtering-correlation-id: 178ddf96-d602-454f-c13b-08db65f95bea
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHnFBez31bUgwpOm5lx3DYXdId6WNu+ZTDaocVR4zkI9Ifg6ySyMGcV/DjKPdNjGmN8VcpkyAn9V1AFCT4w66RzXKh1oYfzg6F6F0C1sNRsgbDrhL6EUrfu5plVEmab6leCNdqlW+0s59Whw+3CnpFYmE02wvM+BlTiNTDGRuOFHJ8m22/j7TJOZZeuP2iacL8kvBpe4B+u1pzBPBUXJfpUgpbbEHTg3VNcJBC5gQ6cJyA44ueWnk0Mcx5WCFOcKHJN611i93JelGD4hz6ECCoX+tn2ZGEnnpZ0RftO9z45T2u+rgdpv90/Vyf2ODYN5AHFcDs/uKvGzboJkuTXjnU2dBsLhMN/uJjaP4eZHUm5Vp18m9PZg12h34K0NoDFXRNn3YXZSeBUeGcsRwi6KubTL49EGSb9WdCJecDP8Gp4zIjy7QudrbzQch5xoeG+XHzkUNpclpv2BBdsLRFrU6VQGqT2zYpbNnWfkRfIFA/IE9Y22jti7eal+Ucus4L4/fyyfFSu/b5QcnXZ5/MG3m5bjU7FuZVoD+K161HCuE3jIZutzeaczx6CcB2beY1TiNFHFzFarpsD+PftSLnM9KHM2s0kr+4y2DjWQdtIyYUOA2buPDPOGGf1/sJ0P3eWe0KZpVNrgqMyqgpg00/Ysqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5191.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(54906003)(478600001)(8676002)(8936002)(66556008)(4326008)(76116006)(66446008)(6916009)(122000001)(316002)(38100700002)(66476007)(64756008)(66946007)(41300700001)(186003)(83380400001)(71200400001)(6486002)(9686003)(26005)(6506007)(6512007)(86362001)(5660300002)(2906002)(38070700005)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uf7j0S9TANmZKPuhvQwqYKYK2ZSa/mjfpzcdr71BxdVNqaoKzIp42ncRIZw3?=
 =?us-ascii?Q?5lP25g/gcalEKRaUr8nFON32lrDfbWOsP5W77yRP7R2MDZlPpZJddK+aVJkN?=
 =?us-ascii?Q?wAcCWnjyyZwrCsfsCCGk0nlgNp/UeDbwL/b2yfF6rmvjDAtcVrUmGpZs9ktP?=
 =?us-ascii?Q?o4Y99FHyKAjygQy7id1qUp2OKGmDPE6g0eNm5lznoTn+83flK6ObAZUBR7Kd?=
 =?us-ascii?Q?ILe9JaOnjqpC7e1Cuhozk+YuzpKR9sn1ipnvWz/udEY8h9MIdShxDXrlXfrF?=
 =?us-ascii?Q?ZSTsVOEt+3hu5MbPEN79kO9BXw08WfhirtHtNr8tVizNwMEpRbbFNpNNr53w?=
 =?us-ascii?Q?YrBJ04MnWcZ6LnE9Zsd/mBLJrDqmSjAL0cUL1Q4oI2SJ3DXBCZmCFX+FkB2f?=
 =?us-ascii?Q?touXQg/QAERCGPD5Le3z2TsS0wWHHJ3fXgw0+89D66LSnWXotrcOdKFYLoFj?=
 =?us-ascii?Q?0M4B8sBr1cMQEQadGS98QHJcfDKiQKUb4gzEWfFqu7CNzmz1QaLqSnt5g6M7?=
 =?us-ascii?Q?poFbZ6mLiicaP1E23Vvw8vO5X8516nhXnePJk6dx5Wb0S97uysBGnyaxn2+R?=
 =?us-ascii?Q?lCnE0gNYotGA13FT4+BS12w+wfKSYEiseHrS1OcHU8UxpyDKMktbejj1IQpR?=
 =?us-ascii?Q?fp9gzF2Mo8/qT17twa11af2nxm5x3Ni6rsUeO7GyXxRn/RcGcbjq64uoSSK+?=
 =?us-ascii?Q?/XCCzBmrCBoSSKciwBcZ9RuQit5h1jadtY7FDC2jO4pna7f/mTXQ0Wy0DsKX?=
 =?us-ascii?Q?V9hXzam6L+oWPg1hbfAXn6IbZZwa0+/lG2jACR/7/yDyzMXuJHclA0ZISs0u?=
 =?us-ascii?Q?68Fh8LzPKSPwVLJ+oZVgyWsPPNuz0i5g8wT8Z7JTqz1gx4SDgT5fCZ2m+gf3?=
 =?us-ascii?Q?1vnHFloJPNDgHM6ZLAUFWdbKgwVJEC++G3yb0AO+/Yiww30FCVxWO0C2XQ5l?=
 =?us-ascii?Q?8cFFCBiqalUbTGnc3aFaUNY5S2kNkjuRHZIYgqltaNxprUpEXScOhYW0L3ji?=
 =?us-ascii?Q?GkwXcs2fBewEJ6x0c4PKtzinpcYW7HufFyfgwCX7a4183qmqn/JfsQzEoHV8?=
 =?us-ascii?Q?IwAtm38BQx79mV5NhqehJ3EmoUTOxQ+sna1hVwya67MA1bu5PVcH9AKp0mIB?=
 =?us-ascii?Q?TzInaLoDXKwTaWX3JK98ii/cSJkq6lLPbt0aLgQMwq2VCj+P0x9ely9h9pUN?=
 =?us-ascii?Q?D+wKNy6brrw5lzsHSbgcNK/ECzC+lTNo9mabvhRlXiHygCrujK1EQJ6z1ZqF?=
 =?us-ascii?Q?pBbiCDn2gNxWbpo+pMwWGhF0wP4PoF60kDfoHJcv2+phfW2L7lELRLIaKktR?=
 =?us-ascii?Q?u6Q1CsQPlMB5W6h9z5NHtl0hLCA3r5NIakHVFbk/cf/+Ca9AJTrXiy0JDrd0?=
 =?us-ascii?Q?5i61GxiNH7oCVKaQ08s4MwQzimCDPfs224Vi6CpcV/ebc+5MZFo79Pu+CNJH?=
 =?us-ascii?Q?3Ay2m54lpp3chQYLOO/IpP+xZR5hr0K2ledXygLVdvmcu00wqHxCBf93wnBS?=
 =?us-ascii?Q?Y2dibuBg+oVEw5rSselPeFWyYkv5tzW03zNETahDWUg1MRPV+6/HBpLHfI+8?=
 =?us-ascii?Q?D4F5/QqmxOoAxt96x4ZgV88GhFfiRMz9z+lScmeL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14E4CC09C062D04FAC28254F331E9398@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5191.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ddf96-d602-454f-c13b-08db65f95bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 19:16:26.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ojz4KqLjvnpUTjXgLYKZT9X7T4BjhrPMacdeTydeFdz8vDFJozq6i7sQQ2mzWpQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4023
X-Proofpoint-GUID: 0asDUUdsAriQB_tD-hVUbe3sWX5DHE6d
X-Proofpoint-ORIG-GUID: 0asDUUdsAriQB_tD-hVUbe3sWX5DHE6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:51:56AM +0000, Catalin Marinas wrote:
> On Mon, Nov 28, 2022 at 11:59:37AM +0000, Tomislav Novak wrote:
> > Thanks for reviewing!
> > 
> > Given the changes in the arch-independent perf_event.h, I think merging it
> > as a single commit may be easiest (assuming rmk acks it).
> > 
> > Alternatively I could move arm changes into a separate patch, keeping arm64
> > and perf_event.h in this one (possibly splitting out the latter into its own
> > commit). One that's merged, the arm patch could be submitted to linux-arm.
> > What would you prefer?
> 
> Actually, arch/arm*/kernel/hw_breakpoint.c come under the ARM PMU
> profiling, so no need to split the patch. It may need an ack from the
> generic perf maintainers for include/linux/perf.h.
> 
> FWIW,
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Sorry for the delay! I had forgotten about this patch until I stumbled
upon the same issue again recently with bpftrace.

I'll send a new version of the patch (with updated tags and retested on
on top of v6.4-rc5) in a bit. Think it could be merged via the arm64 tree
or would you recommend I submit it to rmk's patch tracker?

Thanks!
-- 
T.

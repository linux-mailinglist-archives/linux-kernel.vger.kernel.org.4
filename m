Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6830E710B61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjEYLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEYLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:48:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D6AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:48:15 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P9RUax009311;
        Thu, 25 May 2023 13:48:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=KOhnX9Xg0CbaM2dTEn41G9572wGJqXhqEXDto3zLWOM=;
 b=s8Nfmjw4FJqQj70TWtU6ynpybziiRDILLz2ctxVEh2Y9zK5AXxGQkyOOgRph9KzAwd9R
 lTBBgH1e5dckIAGYX3e3F2Z+phJrCsBSJwtZx5/kH4o7YVSLez5yGzh2rdpnJY0I7j4r
 CXrJD2uuc65twMoI2zE4a8NypkBlZkR6Sv2Fs3aSK7G0b/54hZWAx9bygMQUJWA2YBRh
 UifOy4Qzrr24J4we2oYPU7H+Tj53IGhE9h/TWQm8BN6vb7yt5/T2ABPWfndMvaN2Uv2m
 9qyjRQIw6Df2zcacNslxa9S+wMfjFDPQd4CShnXv2pUdH2FgYkB4aM5QyAKQUHMXroqZ IA== 
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qru86q562-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 13:48:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIQzpgtbjmOifthb7b3T/CrfKzOWLcuNFtxnyeYEsZNIB/DHfVEOLm0BRg9E1ki41ajsM12qk2AFVu/16g6JP1uchEdpLtdoyY3Ka/aAzlawU8+5w3FCJY8sK5GyaGLnGKZffKILlf54uzMZysKC3KMs0WYcsNl4WnaHW5yL/IbSYrLXpyRDJ1+HjUj0RjhDzbaH17TMX6422g+OJjmLJy6w1UEAeCA/ya+1SaBnFZlczSBuDd+m490cF4y3Cbj2vgsIRDBCtnFWAZsKLOhV3EPGqzCgAOpcpF9wCmgp6xUQegdbdGPaEstxchfVnmYoLsqWiLMXDt5+XFRys+XDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOhnX9Xg0CbaM2dTEn41G9572wGJqXhqEXDto3zLWOM=;
 b=k4RxI0NrUc1evqrofuPiFZ+3tFqiqG+9/JHFMHuuB9vQFYeacmhQhiLL2ucH/8p1B8Y+0dCTqg90JM+pgZknx2LwE+nqyljBYIIIN+BOL2ERuaD1DEjHam5fDpTtl7wV7wr0nWjSyo8qqf1Xdj6DPar3Hxv8mChrpSbTNw12C926ISb4j3qKHXi1QYvWmNNCq6/ZUYRRH3GqDjkIgSfsnDVKaNjsvRIH1CgQlTApQF0Li4wSouU2XHhObZwtTnlJHUEsuNULNwaJYZ5cyP2o6EuSCi+eCG3q7ZO6mCFWzjO7PtSr9rfDXBQBQ2wNRFfmrJ2C/ekJtRa4DTJ5yRR/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 11:48:00 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9f5:ed2:136d:e80d]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9f5:ed2:136d:e80d%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 11:48:00 +0000
From:   Etienne CARRIERE <etienne.carriere@st.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: RE: [PATCH v9 3/4] tee: optee: support tracking system threads
Thread-Topic: [PATCH v9 3/4] tee: optee: support tracking system threads
Thread-Index: AQHZjUXixbe5W5+830uXcQHXDNiQ/q9pCREAgAHWVN8=
Date:   Thu, 25 May 2023 11:48:00 +0000
Message-ID: <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
In-Reply-To: <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=True;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-05-25T11:47:59.801Z;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=ST
 Restricted;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|PAWPR10MB7126:EE_
x-ms-office365-filtering-correlation-id: 49b5528c-a1b3-472a-3c90-08db5d15e3d1
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPaIF2y/0MYQyWlESUfxM1R3PHMZyidthQza2ADluAXCyXT7r0xmFDn9LpolhLm0ZAuqxDMIREOyt0cp5/LiZ+E6EM1bHq010C1ySGJVQ4JaawxMBAUZLQHbqf1ma6FwLi0cNVs919oEbe28jWxrV4j54xt4jPhNppqqqKEGVkyVg4sODYbSehTXlLv4XOrgHpZiQV4TU1toVKQFcXFBl6XQafA4mAO6T15X3TAItTIZj1STuQ5DVTErUSb73lY/+0Irz3TRG3ciJ7fdUqueEV3uDing7tcexkN52SeP1ev1yv69vneGC8E1kiBWORoLyLEq0hLgMcWbwf/wyqnXIvc4bRh1vhbV8SFx4bh4/XzSLELj4V7f1bo2cBGVbi3mZIF7P5CrjR2OcPXbyDtxP4DS4HIVO3j0z5OD+87OcFI3iLOIGjaoW464C1oXezyK0JfOWdwm+0O3+tN7uVhjA7Leqt+52IbaTgnf8jIeTrOzmn9vCAk2xTr8nPB+ru6E2lmGW6zeMfK01hQMofOdZJSI/pVLE1fBTTpib+BDTC+m4hhxSXDBgbpJguKUjjbmV3vjodeXgZGhs8AJEqjWVHxExv2TUVVhRs+HJWqgbylt6PgPJTH/L8s/DbqhbT/t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(66946007)(2906002)(66899021)(76116006)(52536014)(83380400001)(54906003)(8936002)(66556008)(5660300002)(33656002)(71200400001)(8676002)(66476007)(4326008)(66446008)(41300700001)(64756008)(7696005)(55016003)(6916009)(478600001)(316002)(26005)(86362001)(6506007)(9686003)(38070700005)(122000001)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gbZngV6u2jCkoy+rS3QlzGH135vwx/X6L1ujs/ShnuGFUmqcphMpzabKR/?=
 =?iso-8859-1?Q?caw8kHBPQcS3en9A6QBfErXaZU6OQa9Jn1i6S5DoUm5N/m24HAbo6Yrxyp?=
 =?iso-8859-1?Q?CSfBwqnw2GIb0bCJpIetqQf1pi88Qy3bukv35rJl1/+2RVeCWdUnaXbDBz?=
 =?iso-8859-1?Q?7YHDJA64VSa64xqbboohlCxXxrDzzkOE+ZX0ngLNKU/sjgFBF9FHQAZXFu?=
 =?iso-8859-1?Q?YEAfnmmbySIclBtqopZ4ia0fOsqjYYfEYIMf0EllBMXSryn9OsKCf9eHg1?=
 =?iso-8859-1?Q?hh1zX9VWAqyeV0D1pVF9pTHcf6abEs8nxwdClBeEEv3CubN7/VwrkyPJ4k?=
 =?iso-8859-1?Q?vaap26L7m5jESEaPtu8xfgpbqOshDL3k60M+/6sBV8r2OnUBrxTKH03hcM?=
 =?iso-8859-1?Q?aQI0Tfrx1deVNGAMl6/frmgoRWU9+djQVUb1VR/z1170umix0siQ2v2SOx?=
 =?iso-8859-1?Q?RbCWZzjKTU3i8yA2mGZdT29AceDQ/MEjZYlgEbeZ8mIpsbE4qL9dRngWYg?=
 =?iso-8859-1?Q?LUOU375erOA64zftZoi2asFINAfFYq7nrUellG2MPpF411z0HLnMYLeorx?=
 =?iso-8859-1?Q?5LFyZs+jeJW3np/IGnB4MZzseB8xmJ0ovUVwETyp3CxfYhCssqjbEHgc9N?=
 =?iso-8859-1?Q?CIQK7C1Sh7bunrhlHxYcxKRLDsQxJ+YoVnycaXlEJgtmyzzG8395AZ035K?=
 =?iso-8859-1?Q?ZyEKdoQAwl3sue3np4FhpF2Zn8aY9QxlPJxTzWG0nKYNyRoFmx6pD+TgCf?=
 =?iso-8859-1?Q?fF7D1OmULMTb5c9qp5JgEscru4djmSRICChNGSzI1+AaljUt0QESgwPI4R?=
 =?iso-8859-1?Q?xubZMuuNG45AEHRuLrhz/QsPlB1E/M/mqomdEgreMZUV4L/hJujFa17vRz?=
 =?iso-8859-1?Q?HX9mZlHvM96GW32snKSxlkMidqw7gWIH/4SrUwOSNQylLW4/UYHLDzXUpm?=
 =?iso-8859-1?Q?juQGa5m3Ob6tTmdEsGonwgacP0646IJA7KaPoRq8AWHS1qTa0DgKe2GD+O?=
 =?iso-8859-1?Q?Q2i8CiE8cZ71S0HPfSm4EWwjusBh6ENwps1F0Qlk1Ar56Ck33Nhbk8o55E?=
 =?iso-8859-1?Q?a0oEHuNcUDJuJN28AkW1Mnj6nRk+4ohbSWqqByZRn1ldDRRf5pZmgO/HHU?=
 =?iso-8859-1?Q?rMgbYf2hbLA8FQDIWFXM4U2iXDWxNpvgm6tUsn9mx1desmodX2W4UvfIlU?=
 =?iso-8859-1?Q?vlbhPKIbJaXtfrZbrFh51/ydGRiUpMjyxCcz6ToW2PUEqEZY1CCt68eoe8?=
 =?iso-8859-1?Q?UvuXFOSnxPlEBA8wagS1W+gKB3+DxgeUj6d2WmVf5gulRln8Qy0K/iM2Z4?=
 =?iso-8859-1?Q?pxRwTsaISchNjOpjmLSXxsOuXW6aoJ/hc1yCGh8i58yEDP8Wkaj1QUZlz0?=
 =?iso-8859-1?Q?+XQ+AZ0B6l+i7QUmwjnMGJ89gTA9b32km3IZV2/sbptatN98DK5jk2YPhK?=
 =?iso-8859-1?Q?ffsb97U3fZqeLI8A06PZ85QFbz4xKZ0pcC+Vr2c7KRAADUcuMkHXaE5B70?=
 =?iso-8859-1?Q?xBZAYci8uqM66rN9nzXJtsEVSwn8SwZD1k1a28Lowg2KHrafvnH2VP1+Qd?=
 =?iso-8859-1?Q?StWMZC9DhD+6/nFKwcY2rCN8Sj9oaX1S9YQHUtJWbBUTqi5DEpGlPpTlJ0?=
 =?iso-8859-1?Q?zNsklmMsov9yUzzs2aXcmkfgHFCLNaFOox?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b5528c-a1b3-472a-3c90-08db5d15e3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 11:48:00.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4HNHGo4EBch8CpwFOzA+7i+WnfGAcsAAbm2XMkQcKowKCm0Xw++AwVLW2+cVW4AfS2DVQpA5mf56oQx/6s8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7126
X-Proofpoint-ORIG-GUID: jFtAZRPgaRrYwxEPu_UHFj4f4I_4GitU
X-Proofpoint-GUID: jFtAZRPgaRrYwxEPu_UHFj4f4I_4GitU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> De : Sumit Garg <sumit.garg@linaro.org>
> Envoy=E9 : mercredi 24 mai 2023 09:31
> > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> > Hello Sumit,
> >
> >
> > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > >
> > > Adds support in the OP-TEE driver to keep track of reserved system
> > > threads. The optee_cq_*() functions are updated to handle this if
> > > enabled. The SMC ABI part of the driver enables this tracking, but th=
e
> > > FF-A ABI part does not.
> > >
> > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE syste=
m
> > > sessions. For sake of simplicity, initialization of call queue
> > > management is factorized into new helper function optee_cq_init().
> > >
> > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Disclaimer: Compile tested only
> > >
> > > Hi Etienne,
> > >
> > > Overall the idea we agreed upon was okay but the implementation looke=
d
> > > complex to me. So I thought it would be harder to explain that via
> > > review and I decided myself to give a try at simplification. I would
> > > like you to test it if this still addresses the SCMI deadlock problem=
 or
> > > not. Also, feel free to include this in your patchset if all goes fin=
e
> > > wrt testing.
> >
> > With these changes, there is no more a specific waiting list for TEE
> > system threads hence when a waiting queue can complete, we'll pick any
> > TEE thread, not a TEE system thread first..
>
> I had thought about this but I can't see any value in having a
> separate wait queue for system threads. Here we only need to provide
> an extra privileged thread for system sessions (kernel clients) such
> that user-space doesn't contend for that thread. This prevents kernel
> client's starvation or deadlock like in the SCMI case.
>
> > Also, as stated in a below answer, these change unconditionally
> > reserve a TEE thread for TEE system calls even if no TEE client
> > reserved such.
>
> I don't think we should make thread reservations based on the presence
> of TEE clients. You never know how much user-space or kernel TEE
> clients you are dealing with. And reserving a single privileged thread
> unconditionally for system sessions shouldn't be much of a burden for
> memory constrained devices too.
>
> Also, this way we would enable every kernel TEE client to leverage
> system sessions as it's very likely they wouldn't like to compete with
> user-space for thread availability. Two other kernel TEE clients that
> are on top of my head are HWRNG and Trusted Keys which can benefit
> from this feature.

Trusted Keys is an interesting use case. When OP-TEE accesses Trusted Keys,=
 it may need to access the eMMC/RPMB using the Linux OS tee-supplicant whic=
hj may repuire an eMMC clock or voltage regulator to be enabled. If that cl=
ock or regulator is under an SCMI control, then we need 2 reserved TEE thre=
ad: one for invoking the Trusted Key TA and another for the SCMI request to=
 reach the TEE will the Trusted Key TA invocation still consumes a thread.

BR,
Etienne

>
> > >
> > > Changes since v8:
> > > - Simplified system threads tracking implementation.
> > >
> > >  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++++=
--
> > >  drivers/tee/optee/ffa_abi.c       |  3 +-
> > >  drivers/tee/optee/optee_private.h | 16 +++++++
> > >  drivers/tee/optee/smc_abi.c       | 16 ++++++-
> > >  4 files changed, 99 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index 42e478ac6ce1..09e824e4dcaf 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
> > >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> > >  };
> > >
> > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > > +{
> > > +       mutex_init(&cq->mutex);
> > > +       INIT_LIST_HEAD(&cq->waiters);
> > > +       /*
> > > +        * If cq->total_thread_count is 0 then we're not trying to ke=
ep
> > > +        * track of how many free threads we have, instead we're rely=
ing on
> > > +        * the secure world to tell us when we're out of thread and h=
ave to
> > > +        * wait for another thread to become available.
> > > +        */
> > > +       cq->total_thread_count =3D thread_count;
> > > +       cq->free_thread_count =3D thread_count;
> > > +}
> > > +
> > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > >                         struct optee_call_waiter *w, bool sys_thread)
> > >  {
> > > +       bool need_wait =3D false;
> > > +
> > > +       memset(w, 0, sizeof(*w));
> > > +
> > >         /*
> > >          * We're preparing to make a call to secure world. In case we=
 can't
> > >          * allocate a thread in secure world we'll end up waiting in
> > > @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue *=
cq,
> > >         mutex_lock(&cq->mutex);
> > >
> > >         /*
> > > -        * We add ourselves to the queue, but we don't wait. This
> > > -        * guarantees that we don't lose a completion if secure world
> > > -        * returns busy and another thread just exited and try to com=
plete
> > > -        * someone.
> > > +        * We add ourselves to a queue, but we don't wait. This guara=
ntees
> > > +        * that we don't lose a completion if secure world returns bu=
sy and
> > > +        * another thread just exited and try to complete someone.
> > >          */
> > >         init_completion(&w->c);
> > >         list_add_tail(&w->list_node, &cq->waiters);
> > >
> > > +       if (cq->total_thread_count && sys_thread) {
> > > +               if (cq->free_thread_count > 0)
> > > +                       cq->free_thread_count--;
> > > +               else
> > > +                       need_wait =3D true;
> > > +       } else if (cq->total_thread_count) {
> > > +               if (cq->free_thread_count > 1)
> >
> > This unconditionally reserves a TEE thread for TEE system calls, even
> > if no client has claimed such system thread reservation.
>
> See my response above.
>
> >
> >
> > > +                       cq->free_thread_count--;
> > > +               else
> > > +                       need_wait =3D true;
> > > +       }
> > > +
> > >         mutex_unlock(&cq->mutex);
> > > +
> > > +       while (need_wait) {
> > > +               optee_cq_wait_for_completion(cq, w);
> > > +               mutex_lock(&cq->mutex);
> > > +               if (sys_thread) {
> > > +                       if (cq->free_thread_count > 0) {
> > > +                               cq->free_thread_count--;
> > > +                               need_wait =3D false;
> > > +                       }
> > > +               } else {
> > > +                       if (cq->free_thread_count > 1) {
> > > +                               cq->free_thread_count--;
> > > +                               need_wait =3D false;
> > > +                       }
> > > +               }
> > > +               mutex_unlock(&cq->mutex);
> > > +       }
> > >  }
> > >
> > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queue =
*cq,
> > >         /* Get out of the list */
> > >         list_del(&w->list_node);
> > >
> > > +       cq->free_thread_count++;
> > > +
> > >         /* Wake up one eventual waiting task */
> > >         optee_cq_complete_one(cq);
> > >
> > > @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx,
> > >         return rc;
> > >  }
> > >
> > > +int optee_system_session(struct tee_context *ctx, u32 session)
> > > +{
> > > +       struct optee_context_data *ctxdata =3D ctx->data;
> > > +       struct optee_session *sess;
> > > +
> > > +       mutex_lock(&ctxdata->mutex);
> > > +
> > > +       sess =3D find_session(ctxdata, session);
> > > +       if (sess && !sess->use_sys_thread)
> > > +               sess->use_sys_thread =3D true;
> > > +
> > > +       mutex_unlock(&ctxdata->mutex);
> > > +
> > > +       return 0;
> >
> > Nitpicking: should rather return 0 only upon session is valid
> > (sess!=3DNULL here)  and system thread reservation is supported
> > (total_thread_count > 0).
> > But that's not a big deal I guess, can be addressed.
>
> Thanks for pointing it out. If this approach works for you then it can
> be addressed while integrating in your patch-set.
>
> -Sumit
>
> > (snip)

ST Restricted

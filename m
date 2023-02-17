Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62369B502
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBQVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:45:15 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50413E0B0;
        Fri, 17 Feb 2023 13:45:14 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLUHui003437;
        Fri, 17 Feb 2023 21:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=aJwhjUx/XET0FhNRIJkwSG+7d+MJCuReE7ALeft4rjg=;
 b=Ywzqo2MwMqGPIdHhS9uIT956rk+UxBq67TgYlA7E8DKNfB7IDve2pZXkRXYQecOHSnFQ
 VI3iOZqoBQEcnjIHxXqOpZeBdfBGo3HJwsbKF86rEcmeMxmIaQeC1jhwSLB7wZIIhypE
 cDjnm5kmLSyZhiE59JSnvT7o6og1iwmkM4X4PjTsasXElMENgDgOqfGUtNvICZ9P9FUZ
 mcvkHVv/84qLpbTjR9U0ziQf2woeP7Sq9bQG0qMmz3A5Y+vtnFIO/ljYS/FRQfFm+2/E
 hhbJ7CszeSy8DHl0Sm/unmBvU380s2MqYFwlwb7uRBXcrqlXCavrBGmkmEDvGyuwb8Nq JA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ntbehuyb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 21:44:58 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 782828005C1;
        Fri, 17 Feb 2023 21:44:56 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 17 Feb 2023 09:44:43 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 17 Feb 2023 09:44:43 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Fri, 17 Feb 2023 09:44:43 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 17 Feb 2023 09:44:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3nx7Yvjq99jNmWkZ8AWz4MiyQeQr0qD3yeDWv6ldvvDOyPzDFQhNAPTL8tQW3kxl3SoDJCBzD9HVKoWJ5T0XCPK0MYjA3GxYVjVL2rQwo44TwVBxUunqIPhUZhsCxNq1msVx3TTnUqDCB9zMhhqOmC4rbSy6Qn0Do4jmWXFPPMNRdDX05AzmAZGYAbCsQvP87NB7yzWViHAh80zTYIVsSPHOJh42Lz56rS9HXDaf8yLH2uAP5hRMQTQOh7y2vPDZEktwMLVXp9XN6/q9WuuARGTk50YHAFMLWCszZ4ePP9McUtJFhBeK70mpknMwzmI8+kXWlGZKNPFrv6ku2JGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJwhjUx/XET0FhNRIJkwSG+7d+MJCuReE7ALeft4rjg=;
 b=iw5uXQawSR6hsylHZAxGBV59ExXVoAzqIoljaEw92LEICZqv0ssvieRHajEq07Pz+XY5EICyPiwSQGklexCbFHFCC0MXruzOTLvbK5HYyaa0EPQNSLwFZZcoORtOQcGCwT5WF8+shmqfH1K93XKU6xDgCm79wjipsVKvPQkHC4kpOaPcsrDvbdovPVIBWUJlh9NbOVnQndYiifcARC6JEM7yYFVOXasRtaTYxAew86jEgyuOF0BsW8loc4q+b+zroRD0Cc0312i1YsgjQ3TiOGGLh9KHt3e5son8q7f0yaT12LFyE9RQX13QFlNqRZCe5pcP0ZjeDminVG/7P/VUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1431.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 21:44:38 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::322d:93aa:45df:f72e]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::322d:93aa:45df:f72e%6]) with mapi id 15.20.6111.012; Fri, 17 Feb 2023
 21:44:37 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Danny Tsen <dtsen@linux.ibm.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "leitao@debian.org" <leitao@debian.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "appro@cryptogams.org" <appro@cryptogams.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ltcgcw@linux.vnet.ibm.com" <ltcgcw@linux.vnet.ibm.com>,
        "dtsen@us.ibm.com" <dtsen@us.ibm.com>
Subject: RE: [PATCH v3 1/6] Update Kconfig and Makefile.
Thread-Topic: [PATCH v3 1/6] Update Kconfig and Makefile.
Thread-Index: AQHZQuuGDnnRnVY7A0GShYfN/q6Vy67TobxQ
Date:   Fri, 17 Feb 2023 21:44:37 +0000
Message-ID: <MW5PR84MB1842DB9DF917B9B3B83A005BABA19@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230217161805.236319-1-dtsen@linux.ibm.com>
 <20230217161805.236319-2-dtsen@linux.ibm.com>
In-Reply-To: <20230217161805.236319-2-dtsen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1431:EE_
x-ms-office365-filtering-correlation-id: a4de8a0b-d227-47bb-a330-08db11302af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcnF3FvgZJ+wfMJ5xXDIBjKPOo+4seEji3wOMgLVJX4ZUz8dBYlTma/ZQWHD814XjxvPJfxn3vICkRAN4jMpXV4EMSowGU1H8nttEPgIUVzYzucb1hYBLb6a4Ptv+tmGuWYDVW8IwosJbAIHY5o+0a7spa4KjJVKtLQP+qbIiGhA2zU2FCOZM1aeEWfR5ixVv7E70pleSHjtiy3/iAt0dEbW1L+wxdJsLdg16/1t74i+FZPfwgDqmKWTbnr9S0DBEMnBrdKf/1+scjRN6eM4F5q3Acajoaw/XtinU/oPj4rdhtikCUaIOVgZ5t489yqGtu8cEtkXqIhh6mMZpUIUwFWq6B88+bWcqQvmsis89CAsNBzpxBH/klA9vf30f8nbMYYXQUTlto5DHana6cgy2OlAWRtRwdRgVJJ4zcjcwyM4Tdq85BzeglbQ0heoxhSBqqvhkVKU1d94fLeyrPGw3vPOkZMrDBmkXGnO/4DVipt3lCTUa+jSGtipy/8Rk/PlrZxVUX0czLT2hy/cdEJKmBLK6fdUlwsSiXrBidAVd9PaRsuJYQdcQGy/GAE2KzrFMp3ACnMizavLzkT05zIIqKenxirK/zIbB9kmjfKNvg5Xi9K4kR5WfFwqalMsYFlkUZMYLJNT/KARowc/MmoWX8Sz/0ApDQJx78evnzFsSTm5tLHuchoIGyTmZtJKn5FKfKTk89CfVFpyHQsg/1vNkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(316002)(33656002)(54906003)(55016003)(110136005)(83380400001)(9686003)(6506007)(186003)(26005)(38100700002)(8936002)(5660300002)(52536014)(7696005)(478600001)(2906002)(71200400001)(41300700001)(76116006)(66446008)(122000001)(38070700005)(66476007)(4326008)(82960400001)(66556008)(8676002)(64756008)(86362001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?urmgQHfFpv7ITom0Yw3HMX6cKdr25nzoQY1lHNDk8LKghbqNNNLgLRXELtPX?=
 =?us-ascii?Q?TWDyt0Oagiy2ww8go0ZfetN+B/MJp00SNW4IpyZMBnQPYyBsZBtBrRgU2GuK?=
 =?us-ascii?Q?+Eriis7A8Wo88qNQfBe6CicqLEhIxL4pdL6zrleNHfcdVvA2egTCit2/nM6C?=
 =?us-ascii?Q?d523ps+6Qe+mm1BAD0VbAKYbeMn+kfsWQ6/GbzH9KPeuH2mL/ABBRHItlVtX?=
 =?us-ascii?Q?g3BWHDm3k+QW/zEVbViubaB2+DV7ecZFiNH7C1LyaluVJ+KF8RtrB/3zBtE8?=
 =?us-ascii?Q?ILGX2yKxBUFk1O+ipxfz0WGDxDvC9IaKkY28fqItsoQ0CIRm1WP9NAHhJsrX?=
 =?us-ascii?Q?+FujFt3pPem2fwv2VKndbzNauO9rSYBSvZBSdbnEcuAx7z5yN28pgi3w9dau?=
 =?us-ascii?Q?1a+pLpyHRlBmASW4/IEVpQgthms88HiV7w6Euuh4Df8KXue7xPoahkuhb+rv?=
 =?us-ascii?Q?JTPosl5pLGLppcpLiGE8i1sbm8zKKx4AgUcnFo2le98QkOhRNyuukgZtTYwL?=
 =?us-ascii?Q?xUv1wTNGs4BND/mkzazZtzc/GBuFbPNahI+yCn4oHVoYnTsC14gJ/f/PxWS3?=
 =?us-ascii?Q?ihdbUuJbY4jiEsSha0wQkpB7RC9zW51wa7rVt+kX+zeD8KwYhK2aA0njyd79?=
 =?us-ascii?Q?HgqebqLbnIUTmZsTD525ARKnTIQsBdUUUwPxNDf3h3SeebGH5p7zul9uQkMM?=
 =?us-ascii?Q?JuEkNZca97dnsWpuN2B6SEu6fh0Mf6WOpSzXL8TNPdqgaZSuw377w0ZflP/T?=
 =?us-ascii?Q?+7CZAzr7va0n6M+4ktPZn85D8UD+YcLebB6CLxfdiF6TolIsM7PYNQtlotq2?=
 =?us-ascii?Q?H46IRqZYEmTVymdeEOK190m8wZN2UmknX+K9AJDrQoV+JGZoeO3UYMZDtD7p?=
 =?us-ascii?Q?ifVKi8mztgWNQjuO5VPPs5m6OO2o4zUm3AGbeHDyc3cXG3ys6ya6vpaH0vdk?=
 =?us-ascii?Q?8Dmontb5lFom6xfPt/xsMLV0rC5r+X4GR2Ss8SnfENLHbfpCEvbXZauH81VW?=
 =?us-ascii?Q?Y9Y/LVlb4EeCoFo65hpxv16t9x7g9f1vDkXwCzCZYwrL9YD/tstBcMPtzilf?=
 =?us-ascii?Q?OVeu+M0zkNjSpRBkNoLXYHXmlnmqoVxCWLWHK52uLGXDWb9BP5l2H7NoYtkj?=
 =?us-ascii?Q?PSTud7bM2ADT4MvXEilp2tLb4+I22RP2kt+SHiz7RMDHx7HF8MZXbUPKoT4/?=
 =?us-ascii?Q?RtLiE5MJYrQ6WyyFZnVJhcyoZvLqgyZmSAUI9sVHytnGjVX74YRX4togpOUq?=
 =?us-ascii?Q?LF6FuWoaCQpVCIxno8Asl3ZstPz6EBqEtKdoi0QhtJCUcWk3g6E78wyuPGMB?=
 =?us-ascii?Q?ncDsTifwRTh3wga4+YLlpg48Y2sx+oPmYA/NcdKko/1eheHqonMsZ2La6sIu?=
 =?us-ascii?Q?oCX+u1ZEOivlI3afKH2u8xRJ0kpjoDw7sDAficHPUBumOGyfvKY4igleCXQc?=
 =?us-ascii?Q?tvtm6pM7jlAsre+pAWDp1Llqw7Uye7fMNjSkah20sYG35A3WLutsLu1wBMVZ?=
 =?us-ascii?Q?Q+TIBLZb1QshEACmxRjiDav4S6LqySkQ/XMpQmRF0U9wMEahlmETuaKUS2ol?=
 =?us-ascii?Q?Uu5q9u7jbirYDjAFJkk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de8a0b-d227-47bb-a330-08db11302af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 21:44:37.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0BeupBwrbKgvj/UEVY2QMvSSenh6oL4NOwDCXYE13IrwDZ34TMYbI0f1HH0O+5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1431
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 1OpJb4UPyBMehuBmrcspCq7OikZZ2A1x
X-Proofpoint-ORIG-GUID: 1OpJb4UPyBMehuBmrcspCq7OikZZ2A1x
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=940 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170190
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config CRYPTO_P10_AES_GCM
> +	tristate "Stitched AES/GCM acceleration support on P10+ CPU (PPC)"
> +	depends on PPC64 && POWER10_CPU && CPU_LITTLE_ENDIAN
> +	select CRYPTO_LIB_AES
> +	select CRYPTO_ALGAPI
> +	select CRYPTO_AEAD
> +	default m
> +	help
> +	  Support for cryptographic acceleration instructions on Power10+ CPU.
> +	    This module supports stitched acceleration for AES/GCM in
> hardware.

Is "Power10+" a specific architecture or does that mean "Power10 or later"?

Please follow the newer wording conventions for the menu item and
help text, more like:

config CRYPTO_AES_GCM_PPC_P10
        tristate "AEAD cipher: AES in GCM mode (Power10)"

        help
          AEAD cipher: AES cipher algorithms (FIPS-197) with
	   GCM (Galois/Counter Mode) authenticated encryption mode (NIST SP800-38D=
)

          Architecture: powerpc64 using:
          - little-endian
          - Power10 features=20

          [some description here]

Also, all the other powerpc cra_driver_names follow=20
	alg-arch
not
	arch-alg

so=20
	.base.cra_driver_name	=3D "p10_aes_gcm",
might be better as
	.base.cra_driver_name	=3D "aes-gcm-p10",

Patch 4 seems to have code for lots of other modes like CBC and XTS.
Does the perl script strip out all of that?




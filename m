Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59960C166
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJYBuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiJYBuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:50:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51731372BA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crU395b4E9aLHKhoG5fD+LVcxzer8gMRWafduvbB2XfRKS3wYaLb4bI+MMLS4s+OWNAEdr5zVC1sv97K7qRUJvBoW2a52lAeYWIoRVkDDqCfY+ct8A+VXRHAHB6DiVMlNHcy19d977DSQAsJ8se6tDumeVRC7uoOdEE7o2sMdf921elxeaF5VTtZp4hm3GUavMue5CJZQsQJSGMTHIc0foD6qIv+HLG9G2Vdh5FyhA/gkdp23DDMiKih3p3v4Cuiba/agu8tdO9K8DRTGOG0w87PI5aJLOyYSvUJwx+fmNDvZHrZ0Be+3BkhaiSDIwBgeaT9gkdoQb4taVwWmDSGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG4T3DJJr/eG5bTs9YDAwGXrStNCvUKCRGYS1gq9lYU=;
 b=ENmtPMSpxWoHE0f6nuuTNWdTvqLSW5wC1UswGRF9E0A2HMMixxsaa/RR9cdrsw9HE2vq673KB38v1eTwVH2ozcgFg+CXPGYL6/jWIffifWGEWtc/gQccYDQSQouGRXV8ffS9kaDrSGd+2teXToajxH87zyecMGihGvmOsZenpA6vZYgCu7XS+Arzt78YRFcW3Ee8hgxgVzHYdnMKzrM/UEm3nBz5Pygq4fJOQoML5p39N2ePKsOimNxxC1sRZ17TNZLhAecb/5mWbKSHJScWBRWMkLRI8P4qWj34whWXctub2KSr2S7g3BBC+5xt4Zs9rbKqqdP9trctwDYjS4RPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nathanm.com; dmarc=pass action=none header.from=nathanm.com;
 dkim=pass header.d=nathanm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanm.onmicrosoft.com; s=selector2-nathanm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG4T3DJJr/eG5bTs9YDAwGXrStNCvUKCRGYS1gq9lYU=;
 b=EcTmZndMC3nmnlIL109yCQE43bXI0ql/LR5kDjcDQQh6edw2uUFImuLaJgRiXwJxf3SuYzrT4jDBw4a79Ny8XJgtS2cHtOQ4vnTICmppwlN9MZqS4hrBYh9/l0eMALWtjJaN2ZxsvNTZOrEMVQKH6VTvfRYyRUzu/Oo46V6Tp9k=
Received: from BYAPR06MB5573.namprd06.prod.outlook.com (2603:10b6:a03:a8::18)
 by MWHPR06MB2336.namprd06.prod.outlook.com (2603:10b6:300:65::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 01:46:32 +0000
Received: from BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497]) by BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:46:32 +0000
From:   Nathan Moinvaziri <nathan@nathanm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Thread-Topic: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Thread-Index: AdjoEtBynXV7SUtxSVy5+tznV2O0qA==
Date:   Tue, 25 Oct 2022 01:46:32 +0000
Message-ID: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nathanm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB5573:EE_|MWHPR06MB2336:EE_
x-ms-office365-filtering-correlation-id: c9923f8f-0dea-44b6-9a7d-08dab62abe4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em191S5BSzv/eUJSVV3W3WiqVmDEW/5YG48nW1UFoS8lcJ9v5ucnMgLG7JKgDKipqB0FDv0AOnYUNPTkU6mwmX1U/7KV577yuYRyPxlbEL7Ry62aMvEaN5W4h9ykq72KkBqk27sQh4EhONCziiQDme4dogMis2/PlW3wiNO1a3Zm9JBi73bp4Q9LpYJFpT4Q8J6xjQe+ki3plqziBa4qRJGo+yHVOG37Yf3458Z6u964Xb4IXwjtDhkEJQmApZgImbu1dx+4uzAObH47ZAgKBnyrDimWjdIMbMg9T5rynQJUtDGiV9tEjlis1r1FIIvz/sI52Zrwx5Z7b5rd3LYBWcycuqYOmoC0tQEwNI6UqoUyzEBUT7Q5jwfaIZJk9yFsbBTYg5XLH0uB3iPxgjxquhxKMfsyuoVXVtIVcpbhdBMSb893oIvoj8GJUVsKsh6Sc2aggu1c/oOMaFGMiWnQrmkIN1o4XlUl4oJQHNawm3RI5b0F40gpT9eCPGLDGjRoTs14LfFDysrA0QDIKxS/YBKMCFubrETlJ3H8TI5I7Lk+FawFFeRBHTV5qVMAu65ICBWTirxU6PKLX06QX8CsID2oG2zsUGKhOcw5InPEIDlrDr43QIlThUeYT7Nu4MURQvs17eFNuWPTQ/pzufSsCdDmeGB+P1q+8g74uE9Djn2IbIOOVUUEGy1HtxlQukRWGqNPTilgvIIWW9qRS1Pb+gctdb29YoSHOum32qMR73wvaWnUoJqF3Y2etwWLfaj2p8DZi4LHvntJIfR0kMdvXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5573.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39830400003)(376002)(451199015)(83380400001)(38070700005)(186003)(2906002)(122000001)(38100700002)(9686003)(5660300002)(41300700001)(8936002)(55016003)(52536014)(478600001)(6506007)(26005)(76116006)(64756008)(53546011)(66556008)(7696005)(66446008)(66946007)(66476007)(8676002)(110136005)(71200400001)(86362001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BjwmGzvsYUt9zU0zaT45vFdQgDaDCY8DkeIZo6p2ZUwp8OAQKiXYtNcDTDrj?=
 =?us-ascii?Q?168RZViv9RDXjVkXBhyV3Ns3qme/CCFBStmLQdOdJQgcjiQQRY43O3Ejq7UK?=
 =?us-ascii?Q?pxgtP5+daednCqV5TIK9+HXQbC57IyO2VAkDXAL5/X7sQxi1KZezltpdkJBi?=
 =?us-ascii?Q?xzYfRTxo/x3hW1VOm9/Lgs9dST9iyMQFzM6WikIhiTRoGE1SqiNu2DyCRLd5?=
 =?us-ascii?Q?hjLybGBZ0llkrD5d7iApLUku1c2TRGLKZHMnMCs9Q/Zb3cSBfLZsbUV0Yb7y?=
 =?us-ascii?Q?rZ98m/CHMyyN9r8JM3W0IWQd0fQhHnMRTM4Z8IBcjeUYURro/wwRjXFZ9lEP?=
 =?us-ascii?Q?kBflpls1ifp18DkPjALA69mooHnbToem3jx8KSEj4j4uBSNCBH/TVdgljOQm?=
 =?us-ascii?Q?5+oFAM7BHH4f7NQjcMPuFZFKS7YKU00CwI/i9yJ/prkuFI6ll8JrJzj6wmZa?=
 =?us-ascii?Q?88VRcMMe8i0ldHicHhqC9BWmi8/juGVR83KI9T1msFdBmCKwDrQMKaNm5w7g?=
 =?us-ascii?Q?Dggp/qktp3qRbv81U+m/+lQQ3t7Mu7ljKrfqB03ue2B7GLepsjq4ju58cAIb?=
 =?us-ascii?Q?q/CwOEdzv/rusHdh7Kx11hEKsaLRDfaT1vZ3DcUxxs08L0SukKWr2IvbmEKa?=
 =?us-ascii?Q?fVywdaiiG09GqsD5N+1a2ZETAMtMxQ6Pp6134eBbtKbHi27jRRo53+n0PDtQ?=
 =?us-ascii?Q?bep4ICKJG4pWOS8vO/codOggZZuqWtMOB+RzHq4rUmpZEwlcpzlDhCozCy6w?=
 =?us-ascii?Q?kwL9I6QNZlCU3VHJmXJyBynA87CMS8uqfRELQxffyovzE/QdnrwbKxRvgdWh?=
 =?us-ascii?Q?ecxwfYXMSd9funk7/IkSFOyohvFmrtgzkheCcP1wZ1RarbTEpOK+9r7Sn3fO?=
 =?us-ascii?Q?Gq3605syDlo9NKAjfsgyuSwxyIwWEzt5sLOfT5oziWH4bigXsKo9RsMxPWEM?=
 =?us-ascii?Q?b2EXZm05KTkDKSuhGBj+zwooQuYIX7vKx1o005K4zTVGiZAhs0OHeM7/tuQH?=
 =?us-ascii?Q?w7IgXnYXRNYlBq7iUFVxVDFeSIY5tG4G/2STngYTd4YgHSiDHKHq+HhZ8CTB?=
 =?us-ascii?Q?jT+GhFnszMECtSgxaiW/hKFlO+Jowkw0GCcn9td16byxE5cVMtQ13sPEjlF0?=
 =?us-ascii?Q?ZK8fMEe5I3eTHFubWPaPDo/JkT1QbExgqGnRWrg6esL5NUXaLcXLTu7PYDK+?=
 =?us-ascii?Q?0eHeVYwbOKlHBuEKEDl2vFElguozGjAP21jR54Ima7Q6PX2QXJXZh3ADYP7c?=
 =?us-ascii?Q?txP1eFNaylPmGHnglSHFSmQiyTas2nwyNlpZWAj8r/RNUlMrTUldzRH1YYtQ?=
 =?us-ascii?Q?NZ94a6vxfHDHFyzMFDiRbiouy+qrr7Yj2WtkITsl2fIE1YuI4uWU3i4V0zrW?=
 =?us-ascii?Q?vyZVcKnOhvPDir+fs5xHxkngCd2SSFoqLZTK+UPBOA9GJNyAyrQQ2bv3Q1nX?=
 =?us-ascii?Q?MebTvSl/sRB3qtSTuBZ6UbuCL/ccSB3rt5WJJQlJLpIjoruhngJ9P9c4pmck?=
 =?us-ascii?Q?Fuk5feIWJJCZmKfD581jQQYw5hodAlDrpSpUGe6JjZpJCJnkPDSaOevCmMJI?=
 =?us-ascii?Q?TYn+7CAoys8UeH5V4gPKcCH/Y/lYbYjM6tUGAeJM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nathanm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB5573.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9923f8f-0dea-44b6-9a7d-08dab62abe4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:46:32.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e74266a-92ff-414a-9879-2149aecc5932
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3bvU4kS1im+b2/+jsjPKulK8okiBCjuW3U0RHu5wNYyVOY6oneHIJ+PFfd2C9hzcPVnr2T+63AxMXlxNq53gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB2336
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From fcb0159ee74908f92adc34143657d8ca56e9a811 Mon Sep 17 00:00:00 2001
From: Nathan Moinvaziri <nathan@nathanm.com>
Date: Mon, 24 Oct 2022 16:37:59 -0700
Subject: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match.

With strings where many characters match exactly each character is needless=
ly
converted to lowercase before comparing. This patch improves the comparison
by only converting to lowercase after checking that the characters don't ma=
tch.

The more characters that match exactly the better performance we expect ver=
sus
the old function.

When running tests using Quick Benchmark with two matching 256 character
strings these changes result in anywhere between ~6-9x speed improvement.

* We use unsigned char instead of int similar to strncasecmp.
* We only subtract c1 - c2 when they are not equal.

Reviewed-by: Sergey Markelov <sergio_nsk@yahoo.de>
Reviewed-by: Steve Tucker <steven.r.tucker@gmail.com>
---
 lib/string.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 3371d26a0e39..51ad56db1b5d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -64,13 +64,20 @@ EXPORT_SYMBOL(strncasecmp);
 #ifndef __HAVE_ARCH_STRCASECMP
 int strcasecmp(const char *s1, const char *s2)
 {
-	int c1, c2;
+	/* Yes, Virginia, it had better be unsigned */
+	unsigned char c1, c2;
=20
 	do {
-		c1 =3D tolower(*s1++);
-		c2 =3D tolower(*s2++);
-	} while (c1 =3D=3D c2 && c1 !=3D 0);
-	return c1 - c2;
+		c1 =3D *s1++;
+		c2 =3D *s2++;
+		if (c1 !=3D c2) {
+			c1 =3D tolower(c1);
+			c2 =3D tolower(c2);
+			if (c1 !=3D c2)
+				return (int)c1 - (int)c2;
+		}
+	} while (c1 !=3D 0);
+	return 0;
 }
 EXPORT_SYMBOL(strcasecmp);
 #endif
--=20
2.37.2.windows.2


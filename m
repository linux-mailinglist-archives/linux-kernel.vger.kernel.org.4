Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49B620104
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiKGVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKGVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:22:45 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C382610;
        Mon,  7 Nov 2022 13:22:36 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221107212232usoutp0230a4c1ecdcc8d724e5ac70ca4593cd72~lalWYYFLo1004310043usoutp02I;
        Mon,  7 Nov 2022 21:22:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221107212232usoutp0230a4c1ecdcc8d724e5ac70ca4593cd72~lalWYYFLo1004310043usoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667856152;
        bh=9EeahBanuO7auZquaY2S5pI/4JEI5KFyntys4he8T7M=;
        h=From:To:CC:Subject:Date:References:From;
        b=Lf8geb5QVoOsTsmja69wOdKjLpKdpUl5QJfXt9Tr16MylzXvbJeFQ1ge0czIkZ2cJ
         kBiJ7xFE5FjXA57/DKKm2d9yJlW4pwjMt83CLc302pALLRgQIbBTV92hxz2MfRYENd
         d/P90jBvThclZOvCsSVEHJW4CiGpIOrPxCSGBchU=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221107212232uscas1p2aa035c51136c44599d44a9c53a9930a3~lalWLIWw-2792327923uscas1p2E;
        Mon,  7 Nov 2022 21:22:32 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id B4.75.35398.81779636; Mon, 
        7 Nov 2022 16:22:32 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221107212232uscas1p20a000834b76db7a7e459708b06638120~lalVwk97R2792327923uscas1p2D;
        Mon,  7 Nov 2022 21:22:32 +0000 (GMT)
X-AuditID: cbfec370-817ff70000028a46-88-6369771836bd
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 16.C5.32876.71779636; Mon, 
        7 Nov 2022 16:22:32 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 7 Nov 2022 13:22:31 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        7 Nov 2022 13:22:31 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] cxl/region: Fix memdev reuse check
Thread-Topic: [PATCH] cxl/region: Fix memdev reuse check
Thread-Index: AQHY8u8LeWViEa6a3k+/w2cfyy70nQ==
Date:   Mon, 7 Nov 2022 21:22:31 +0000
Message-ID: <20221107212153.745993-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djX87oS5ZnJBmu+KFrcfXyBzaJ58mJG
        i9f/prNYTJ96gdFi9c01jBb7nz5nsVi18BqbxflZp1gsLu+aw2Zxa8IxJgcuj5Yjb1k9Fu95
        yeSxaVUnm8fHp7dYPKbOrvf4vEkugC2KyyYlNSezLLVI3y6BK6Np0lrGgm1sFbe2fGBuYNzE
        2sXIySEhYCLRdfICexcjF4eQwEpGiQmTnjJCOK1MEhv+bWCEqep89gesQ0hgLaPEgiYVCPsj
        o8SbtwIQ9lJGiY2P7EFsNgFFiX1d29lABokINDNLvN05GWwqs8AnRolnnZuYQKqEBYwlrly7
        BjZVRMBC4vSRx0AdHEC2nsSltjyQMIuAisSZzuksIDYvUMmkUyfBbEYBMYnvp9aAjWEWEJe4
        9WQ+E8ShghKLZu9hhrDFJP7tesgGYStK3P/+kh2iXk/ixtQpbBC2tsSyha+ZIeYLSpyc+YQF
        ol5S4uCKGywgN0sInOGQWHx5KtRQF4nLt09BQ0VaYvqay1AN1RJnes4xQTS0MEpcatwM1WAt
        8a/zGtRmPom/vx4xgjwpIcAr0dEmNIFRaRaSH2YhuW8WkvtmIblvASPLKkbx0uLi3PTUYuO8
        1HK94sTc4tK8dL3k/NxNjMBkdfrf4YIdjLdufdQ7xMjEwXiIUYKDWUmE94ZbWrIQb0piZVVq
        UX58UWlOavEhRmkOFiVx3qgZWslCAumJJanZqakFqUUwWSYOTqkGppCyjGNNgot3uZ+vOa+x
        X9J7ebitpc4fY5VGhe+vTmeufdIsOIF5Mfdyy2/zpDoiZl+O/Kf4pfwtl9AaLQV+9YwFGkL/
        xectMdssGXv0r0Pol9vTLJMf7b07IXIe+7vuW5kS9UzLpddnXGoweHjaUEj3dY544+ZW2RPW
        evsueOTxrvCqEupcvWzjyfKfSg2WE8sjWTX0Lj2Y1G61PHp9Adt8mW/VnZ5uT9kNDvL/WP/x
        RJjkk7ehnDeb6x5vKH75aud2/n2Lrt463/eohfN/pYDkcbmimek3hbLuzWOVuvOZqe5N+H2P
        u7y2fyvX1389stfqp2+LY8i1HIuV8cv3CpTIbXwU/FWvnWOpVrUQnxJLcUaioRZzUXEiAIKi
        UQTFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cA0SVeiPDPZYNcEVou7jy+wWTRPXsxo
        8frfdBaL6VMvMFqsvrmG0WL/0+csFqsWXmOzOD/rFIvF5V1z2CxuTTjG5MDl0XLkLavH4j0v
        mTw2repk8/j49BaLx9TZ9R6fN8kFsEVx2aSk5mSWpRbp2yVwZTRNWstYsI2t4taWD8wNjJtY
        uxg5OSQETCQ6n/0Bsrk4hARWM0pMePkYyvnIKPHjyCVGCGcpo0THjP3MIC1sAooS+7q2s4Ek
        RASamSXe7pwMVsUs8IlR4lnnJiaQKmEBY4kr166BLRERsJA4feQxUAcHkK0ncaktDyTMIqAi
        caZzOguIzQtUMunUSTCbUUBM4vupNWBjmAXEJW49mc8EcauAxJI955khbFGJl4//Qf2gKHH/
        +0t2iHo9iRtTp7BB2NoSyxa+ZoaYLyhxcuYTFoh6SYmDK26wTGAUnYVkxSwk7bOQtM9C0r6A
        kWUVo3hpcXFuekWxcV5quV5xYm5xaV66XnJ+7iZGYJSe/nc4ZgfjvVsf9Q4xMnEwHmKU4GBW
        EuG94ZaWLMSbklhZlVqUH19UmpNafIhRmoNFSZzXI3ZivJBAemJJanZqakFqEUyWiYNTqoEp
        5xfbw1WfAnZeZLp/dR0f26xCk6B6jRs/5z+o2XrXt1OH46Xmx9v79vzu+Dcv9cqnqA8//ydw
        ZZ0WO6NbqT2TJ96KL0jhKvsat9NzXylYebvuS92iurwr/POP59fT3m6yP1T1k7lE3PqA04xI
        zfQDXOYXbtgZ3dqx/Ij2L5EcPd1/0gHiBuU2609eV2VhuNu/Yo3PtMsVj/gPi/H/2sv1re6D
        +65vvYtnBXc/2lYqZm+fVhS8dFu3ZM4cplOrdPTCrO+tWlGtvfCctOLvmcZx0wWYeb0f/n6r
        ynZ0BpNnQR9fSl/hI+na9LvPP128L3nwXypn8IffS6v/2cmVrOuYsdEjfOIXu/kPVrYu+ubF
        qsRSnJFoqMVcVJwIAMlK5HVBAwAA
X-CMS-MailID: 20221107212232uscas1p20a000834b76db7a7e459708b06638120
CMS-TYPE: 301P
X-CMS-RootMailID: 20221107212232uscas1p20a000834b76db7a7e459708b06638120
References: <CGME20221107212232uscas1p20a000834b76db7a7e459708b06638120@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memdev reuse in a region currently does not iterate over all of the
interleave targets. Fix this by using existing iterator for memdev reuse
check.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f9ae5ad284ff..c7152b4bd9eb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1226,7 +1226,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled_target;
 		struct cxl_memdev *cxlmd_target;
=20
-		cxled_target =3D p->targets[pos];
+		cxled_target =3D p->targets[i];
 		if (!cxled_target)
 			continue;
=20
--=20
2.25.1

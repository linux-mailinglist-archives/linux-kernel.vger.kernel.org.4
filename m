Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8464DF62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiLORKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLORKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:10:00 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE245646C;
        Thu, 15 Dec 2022 09:09:19 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221215170916usoutp0263dccaab00684a7722a3f74269686e2c~xBpDqaU6X0458404584usoutp02R;
        Thu, 15 Dec 2022 17:09:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221215170916usoutp0263dccaab00684a7722a3f74269686e2c~xBpDqaU6X0458404584usoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671124156;
        bh=1CPzB2AnkGJmXFPeKz23Hypwvq07se7M+6QmDyIqBKo=;
        h=From:To:CC:Subject:Date:References:From;
        b=WartrFhiLHwPQXrYZePou+Z7Y5Sht9x5I95+WwEbC7TUxsI2vqm0bVZkbmu99s2jK
         4WWAKSXGcNEWKUmlkrMteWDnZlmZIdVW+XuwsgkZNGZLlkeAz5bwthfw8SIB3dN+QW
         H4FtRfRvLrDb7VDdVDssGXS2O60zRjx+w8stTBgw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221215170915uscas1p230d68b1bfaee439fc5be80ca2147bcba~xBpDO8lFe0844108441uscas1p2n;
        Thu, 15 Dec 2022 17:09:15 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 0D.9C.09670.BB45B936; Thu,
        15 Dec 2022 12:09:15 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06~xBpC5NJXN3167731677uscas1p2-;
        Thu, 15 Dec 2022 17:09:15 +0000 (GMT)
X-AuditID: cbfec36f-5b1ff700000025c6-48-639b54bbb8bc
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id BF.95.09588.AB45B936; Thu,
        15 Dec 2022 12:09:15 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 15 Dec 2022 09:09:14 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        15 Dec 2022 09:09:14 -0800
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
Subject: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Thread-Topic: [PATCH] cxl/region: Fix null pointer dereference for resetting
        decoder
Thread-Index: AQHZEKf1Iv1EVp5Dik+XycKcRUXbBg==
Date:   Thu, 15 Dec 2022 17:09:14 +0000
Message-ID: <20221215170909.2650271-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djXc7q7Q2YnGzS0qlvcfXyBzaJ58mJG
        i9f/prNYTJ96gdFi9c01jBb7nz5nsVi18BqbxflZp1gsLu+aw2Zxa8IxJgcuj5Yjb1k9Fu95
        yeSxaVUnm8fHp7dYPKbOrvf4vEkugC2KyyYlNSezLLVI3y6BK2NNQwdzwVmhipuHDrE3MH7m
        62Lk5JAQMJE4NqmJvYuRi0NIYCWjxIJtW9kgnFYmiYb5k1hhql5sOwFVtZZRYk/7H0YI5xOj
        xNGvx6FaljFKfGj9xQ7SwiagKLGvaztYQkSgmVni7c7JYC3MIC3POjcxgVQJCwRKfPm9Hcjm
        AKoKk7g0xQvC1JN4cUcVpIJFQFXiyMMHYGfwClhKPO3aAmYzCohJfD+1BmwKs4C4xK0n85kg
        ThWUWDR7DzOELSbxb9dDNghbUeL+95fsEPV6EjemTmGDsLUlli18zQwxX1Di5MwnLBD1khIH
        V9xgATlZQuACh8Sr0+fZQG6TEHCRWD7ZBKJGWuLq9alQu3wkemYvYIewMyTe3+2BittLzHrz
        igViF5/E31+PGCHG8Ep0tAlNYFSaheSDWUium4XkullIrlvAyLKKUby0uDg3PbXYKC+1XK84
        Mbe4NC9dLzk/dxMjMFmd/nc4fwfj9Vsf9Q4xMnEwHmKU4GBWEuENeDorWYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvmikdyUIC6YklqdmpqQWpRTBZJg5OqQam0h0vuJP/zs/o0T6/55Oe5lpj
        2QgzXnZDva6Tsnu1Aw8tcQw1XnAj6sTShzqZx4TuN1fUqljy2RecWHfTKXnlbuXHgWY/hFPu
        NbW4v7Vk0zZp7qhwfXA+7+EnduHfuz9zq5WvKvN//P2nyjm7axXHn3p/E2s2qatYd9WBQyrS
        8ei3+hNP6lbfqdhenHBqdYNo/9XTR9alnPerCFg/bevzFesd3ruV3Ck7ktFft3cu3xG/rRIS
        PRcD5Ltlfdc/93mQ7rXuwbLZs69wtnof1F1o/aNtRunE46Z28p/+fGE9wf5UzVhv5XOVlS+P
        KhxwfKnP/uZQANPLtCdBBwstTy+yMdn3u2bWpOoIA6OAC1sslViKMxINtZiLihMBhhxmPMUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cA0UXd3yOxkgy9z+C3uPr7AZtE8eTGj
        xet/01kspk+9wGix+uYaRov9T5+zWKxaeI3N4vysUywWl3fNYbO4NeEYkwOXR8uRt6wei/e8
        ZPLYtKqTzePj01ssHlNn13t83iQXwBbFZZOSmpNZllqkb5fAlbGmoYO54KxQxc1Dh9gbGD/z
        dTFyckgImEi82HaCvYuRi0NIYDWjRO+lqywQzidGiTldNxkhnGWMEvP/fWcEaWETUJTY17Wd
        DSQhItDMLPF252SwKmaQlmedm5hAqoQFAiW+/N4OZosIhEns//cFaC4HkK0n8eKOKkiYRUBV
        4sjDB6wgNq+ApcTTri1gNqOAmMT3U2vAWpkFxCVuPZnPBHGrgMSSPeeZIWxRiZeP/7FC2IoS
        97+/ZIeo15O4MXUKG4StLbFs4WtmiPmCEidnPmGBqJeUOLjiBssERtFZSFbMQtI+C0n7LCTt
        CxhZVjGKlxYX56ZXFBvmpZbrFSfmFpfmpesl5+duYgRG6el/hyN3MB699VHvECMTB+MhRgkO
        ZiUR3oCns5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8wq5TowXEkhPLEnNTk0tSC2CyTJxcEo1
        MK21dy8unnVxK4tyW4LL+scn7u26E33d4K2B89ezGhM9sk7n+0Xmmep94Yu8WPfuPe+mVcor
        FY+q9n47frL6ZuxhO7/LF7onav/gqXogtvnR91VTngczf5w5UXLT56/r/ylzXpgtVe8y3znl
        jNrEPufPlumHNuwI50tkSj0vLfIgR6n8x4RU1+Taeq6iTrlFyxbvDjOwM9v46X7PDkGmjplS
        IQ+3bF/y/ndRt4Nz7N4mi/ZlD6RE+o+aCRmsmOEinNw46+7J2h0OXju9TOal5nXwb8xfJd11
        IaaNW6W48YP4O6tTW9fmBTTXuG9tknk9+UrvkhdbAhvqjjgFXrPcNX9B0H8+g+ZbHG1T4w+7
        cSmxFGckGmoxFxUnAgClbyL3QQMAAA==
X-CMS-MailID: 20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06
CMS-TYPE: 301P
X-CMS-RootMailID: 20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all decoders have a reset callback.

The CXL specification allows a host bridge with a single root port to
have no explicit HDM decoders. Currently the region driver assumes there
are none.  As such the CXL core creates a special pass through decoder
instance without a commit/reset callback.

Prior to this patch, the ->reset() callback was called unconditionally when
calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
1 Root Port, and one directly attached CXL type 3 device or multiple CXL
type 3 devices attached to downstream ports of a switch can cause a null
pointer dereference.

Before the fix, a kernel crash was observed when we destroy the region, and
a pass through decoder is reset.

The issue can be reproduced as below,
    1) create a region with a CXL setup which includes a HB with a
    single root port under which a memdev is attached directly.
    2) destroy the region with cxl destroy-region regionX -f.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/region.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f9ae5ad284ff..3931793a13ac 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -131,7 +131,7 @@ static int cxl_region_decode_reset(struct cxl_region *c=
xlr, int count)
 		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
 		struct cxl_port *iter =3D cxled_to_port(cxled);
 		struct cxl_ep *ep;
-		int rc;
+		int rc =3D 0;
=20
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter =3D to_cxl_port(iter->dev.parent);
@@ -143,7 +143,8 @@ static int cxl_region_decode_reset(struct cxl_region *c=
xlr, int count)
=20
 			cxl_rr =3D cxl_rr_load(iter, cxlr);
 			cxld =3D cxl_rr->decoder;
-			rc =3D cxld->reset(cxld);
+			if (cxld->reset)
+				rc =3D cxld->reset(cxld);
 			if (rc)
 				return rc;
 		}
@@ -186,7 +187,8 @@ static int cxl_region_decode_commit(struct cxl_region *=
cxlr)
 			     iter =3D ep->next, ep =3D cxl_ep_load(iter, cxlmd)) {
 				cxl_rr =3D cxl_rr_load(iter, cxlr);
 				cxld =3D cxl_rr->decoder;
-				cxld->reset(cxld);
+				if (cxld->reset)
+					cxld->reset(cxld);
 			}
=20
 			cxled->cxld.reset(&cxled->cxld);
--=20
2.25.1

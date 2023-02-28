Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA56A62AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB1Wl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB1WlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:41:24 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8D3754D;
        Tue, 28 Feb 2023 14:40:47 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228224029usoutp01baecc932e091dc6fe5e6d2efaeffe310~IHiqkmhC23146031460usoutp01F;
        Tue, 28 Feb 2023 22:40:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228224029usoutp01baecc932e091dc6fe5e6d2efaeffe310~IHiqkmhC23146031460usoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677624029;
        bh=OZb09o/TekRRAlSOZno2pYSLsUkKlMFtRRfVE2PHgvA=;
        h=From:To:CC:Subject:Date:References:From;
        b=U6i1f0T+uLjjZNjUWoYL7CYZlGLo+HP9F6uxjcz4P1wtvYEwPq/cMmuMi5h7CEySx
         TOV461IkaOhBSg2oDtcp8opjokHYMFa6I/m3Sw2xS5R0rTeYpS6+cgxVXcUbzZ5LO5
         DL8/YkbfbiQYPPq+opgk+7txZ95tpzihVECAGjZo=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228224029uscas1p17c6cc91a0272593beac21b786c354633~IHiqY97Ou2950229502uscas1p1-;
        Tue, 28 Feb 2023 22:40:29 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id EE.78.12196.DD28EF36; Tue,
        28 Feb 2023 17:40:29 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785~IHiqIpKXF1367513675uscas1p1x;
        Tue, 28 Feb 2023 22:40:29 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-7e-63fe82ddde09
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B0.A8.17110.CD28EF36; Tue,
        28 Feb 2023 17:40:29 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 28 Feb 2023 14:40:28 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        28 Feb 2023 14:40:28 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field check
Thread-Topic: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
        check
Thread-Index: AQHZS8WnqoF9q+YY/UCqLavADTGrLQ==
Date:   Tue, 28 Feb 2023 22:40:28 +0000
Message-ID: <20230228224014.1402545-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djX87p3m/4lG5zokra4+/gCm0Xz5MWM
        FtOnXmC0WH1zDaPF/qfPWSxWLbzGZnF+1ikWi8u75rBZ3JpwjMmB06PlyFtWj8V7XjJ5bFrV
        yeYxdXa9x+dNcgGsUVw2Kak5mWWpRfp2CVwZM/7+Yy3olanYv/UZawPjWvEuRk4OCQETid5T
        G1m6GLk4hARWMkr8nPSIGcJpZZK429XEAlO16NwZVojEWkaJL/ueM0I4nxgllp54zAhSJSSw
        jFHi330vEJtNQFFiX9d2NpAiEYFTTBL/p8wCa2cG6XjWuYkJpEpYwFvi6+rvYDtEBIIkdp26
        C2XrSRzcuwiogYODRUBVov1nAEiYV8BSYvKBpewgNqOAmMT3U2vAxjALiEvcejKfCeJUQYlF
        s/cwQ9hiEv92PWSDsBUl7n9/yQ5RrydxY+oUNghbW2LZwtfMEPMFJU7OfAL1sqTEwRU3wAEj
        IXCAQ+Lit81QCReJB38/Qg2Vlvh7dxkTyJ0SAskSqz5yQYRzJOYv2QJVbi2x8M96qDv5JP7+
        esQIUc4r0dEmNIFRaRaSD2YhuW4WkutmIbluASPLKkbx0uLi3PTUYuO81HK94sTc4tK8dL3k
        /NxNjMDEdPrf4YIdjLdufdQ7xMjEwXiIUYKDWUmEd+HtP8lCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeQ1tTyYLCaQnlqRmp6YWpBbBZJk4OKUamHzVVexzZv/dEvtgqTHr2YIZbEH3AsuPPU5N
        k40SLl//YrvYI+msSrHr2gzvH3UZ9x2tE2/7scdDKu3TD+dTvZc07rSYnb7JFWraxfEs3em3
        iurtsMUl3988uswgds/onKHcBfE1Bw6wrHFS0Hnbxv5SqvnflfhZbxJOHer0TpZMuLhKv7pA
        qlBS8uU0xvNnbHf5O889OePBn3mJ65MnCxeIe65KMLOaova+wbX/Wf6sF8q61R3Xv+cotD9T
        +VVfKsu06ZPa4R6pkyG/3qbO4NvqoxMdp3/dVmpBYN/2Yp/i+OxrOU52B9/MXFy9bevZyFm7
        assVI7XtxV9kCgUFPLqwx9OZ+Wjp5T/M/3a8V2Ipzkg01GIuKk4EAJ6AXsy7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWS2cA0Ufdu079kgymP2CzuPr7AZtE8eTGj
        xfSpFxgtVt9cw2ix/+lzFotVC6+xWZyfdYrF4vKuOWwWtyYcY3Lg9Gg58pbVY/Gel0wem1Z1
        snlMnV3v8XmTXABrFJdNSmpOZllqkb5dAlfGjL//WAt6ZSr2b33G2sC4VryLkZNDQsBEYtG5
        M6xdjFwcQgKrGSXWT21hg3A+MUq8uPiKGcJZxijRdf0iI0gLm4CixL6u7WBVIgKnmCT+T5kF
        1s8M0vKscxMTSJWwgLfE19XfWUBsEYEgibuvFrNB2HoSB/cuAmrg4GARUJVo/xkAEuYVsJSY
        fGApO4jNKCAm8f3UGrAxzALiEreezGeCuFVAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSdyY
        OoUNwtaWWLbwNTPEfEGJkzOfsEDUS0ocXHGDZQKj6CwkK2YhaZ+FpH0WkvYFjCyrGMVLi4tz
        0yuKjfJSy/WKE3OLS/PS9ZLzczcxAiPy9L/D0TsYb9/6qHeIkYmD8RCjBAezkgjvwtt/koV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzvoyaGC8kkJ5YkpqdmlqQWgSTZeLglGpgkoma+zHGbrLR
        xkSvqj1aN1je+7QGBWVMOZEsnboss59F0LdZwSFvaVf+1vQJkx8dfD1rr+zPKwE8lz8ZMLCZ
        5TwQnPzT79GZd99YvdTPJ4omCXCZ1vmd7YhiCL36r9fr3NpfDg25Z8ur5zZsuO+5VrR5rZT3
        zjTTN+8j/Sw5ug7+NrOqMD/3cvPz95XifydoPHrqLf9Q94jXDT+OPyejnpoX//7B9jLvfWxA
        H+PfigN/ppnt2BA+zf2L+ezdhi7nv6xdxtssq+nSJFl4cYfPiw2rVq++IXype675N4/2dfr8
        ++5V5J8J/RppVhMvvPXN3Yb3L+4qzPe5YmW4JfLguk8lCxpFZD9LToyPTj2fp8RSnJFoqMVc
        VJwIAO+Xhec3AwAA
X-CMS-MailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMMIT field check aside with existing COMMITTED field check during
hdm decoder initialization to avoid a system crash during module removal
after destroying a region which leaves the COMMIT field being reset while
the COMMITTED field still being set.

In current kernel implementation, when destroying a region (cxl
destroy-region),the decoders associated to the region will be reset
as that in cxl_decoder_reset, where the COMMIT field will be reset.
However, resetting COMMIT field will not automatically reset the
COMMITTED field, causing a situation where COMMIT is reset (0) while
COMMITTED is set (1) after the region is destroyed. Later, when
init_hdm_decoder is called (during modprobe), current code only check
the COMMITTED to decide whether the decoder is enabled or not. Since
the COMMITTED will be 1 and the code treats the decoder as enabled,
which will cause unexpected behaviour.

Before the fix, a system crash was observed when performing following
steps:
1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
3. cxl destroy-region region0 -f
4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
"no CXL window for range 0x0:0xffffffffffffffff" error message)
6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
crash at cxl_dpa_release due to dpa_res has been freed when destroying
the region).

The patch fixed the above issue, and is tested based on follow patch series=
:

[PATCH 00/18] CXL RAM and the 'Soft Reserved' =3D> 'System RAM' default
Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf=
.intel.com

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/hdm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 80eccae6ba9e..6cf854c949f0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, stru=
ct cxl_decoder *cxld,
 	struct cxl_endpoint_decoder *cxled =3D NULL;
 	u64 size, base, skip, dpa_size;
 	bool committed;
+	bool should_commit;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
@@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port, st=
ruct cxl_decoder *cxld,
 	base =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	committed =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	should_commit =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
 	cxld->commit =3D cxl_decoder_commit;
 	cxld->reset =3D cxl_decoder_reset;
=20
-	if (!committed)
+	if (!should_commit || !committed)
 		size =3D 0;
 	if (base =3D=3D U64_MAX || size =3D=3D U64_MAX) {
 		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
@@ -727,7 +729,7 @@ static int init_hdm_decoder(struct cxl_port *port, stru=
ct cxl_decoder *cxld,
 	};
=20
 	/* decoders are enabled if committed */
-	if (committed) {
+	if (should_commit && committed) {
 		cxld->flags |=3D CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |=3D CXL_DECODER_F_LOCK;
@@ -772,7 +774,7 @@ static int init_hdm_decoder(struct cxl_port *port, stru=
ct cxl_decoder *cxld,
 		return 0;
 	}
=20
-	if (!committed)
+	if (!should_commit || !committed)
 		return 0;
=20
 	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainder);
--=20
2.25.1

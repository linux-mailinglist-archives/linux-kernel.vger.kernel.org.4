Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355F16C5112
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCVQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCVQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:45:50 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE462FED;
        Wed, 22 Mar 2023 09:45:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230322164517usoutp021e2b135b49c0ad5e5e28b6e29caa15c8~Oy40HHsrh2885628856usoutp02S;
        Wed, 22 Mar 2023 16:45:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230322164517usoutp021e2b135b49c0ad5e5e28b6e29caa15c8~Oy40HHsrh2885628856usoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679503517;
        bh=dcCFXX+y9c6xdP2tRoqypsJLB05ol1Tin32yYibOl9g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cGaO5ncEaQe8CfF6xDjRJUyk5/eZsbcioEtnV/1GJDb4qOqgu0W6kmB+HHErXwfVf
         K8VCMt8LGw3tpHSh7aXvLnN1MwO3WTZHXDCmOIvc//xzxEsG1YbQUZtqWbdZ+yBMJ7
         aeNC8ABRSSXU0x8AXkpb9hVWUzDmEcGt4iCI7aMw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230322164517uscas1p1182b3e6fde0efeabdd4afc8bcced8bae~Oy4z0ByDf2457824578uscas1p1C;
        Wed, 22 Mar 2023 16:45:17 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 06.9C.09547.D903B146; Wed,
        22 Mar 2023 12:45:17 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322164516uscas1p29b2bde0a1be33d3d6de0aea49a3e2d68~Oy4zhW-Va2946329463uscas1p2d;
        Wed, 22 Mar 2023 16:45:16 +0000 (GMT)
X-AuditID: cbfec370-a01fe7000000254b-a1-641b309d104c
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 5F.68.09579.C903B146; Wed,
        22 Mar 2023 12:45:16 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 22 Mar 2023 09:45:15 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        22 Mar 2023 09:45:15 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Thread-Topic: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
        check
Thread-Index: AQHZS8WnqoF9q+YY/UCqLavADTGrLa7qFEkAgAAP1ICAAAuggIAdaWIA
Date:   Wed, 22 Mar 2023 16:45:15 +0000
Message-ID: <20230322164505.GA1641600@bgt-140510-bm03>
In-Reply-To: <640276695c8e8_5b27929473@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F1143051CDEA048AF91AD1197433780@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djXc7pzDaRTDBrm81vcfXyBzaJ58mJG
        i+lTLzBarL65htFi/9PnLBarFl5jszg/6xSLxeVdc9gsbk04xuTA6dFy5C2rx+I9L5k8Nq3q
        ZPOYOrve4/MmuQDWKC6blNSczLLUIn27BK6Mmy/eMxds46tYeeEhUwPjbe4uRk4OCQETidPX
        DjB1MXJxCAmsZJRo6fvGAuG0Mkm0T7vGBlN1YtU+NojEWkaJy/8uQbV8YpSYcPUXO4SzjFFi
        c9cEZpAWNgFFiX1d28HaRQS0JSbOOcgMUsQs8IRZ4vbuO0BLODiEBQIlXp6ugagJkth16i5Y
        WETATeLJnBSQMIuAqsTLZS9YQGxeATOJHc0dYDangKfEpO6VTCA2o4CYxPdTa8BsZgFxiVtP
        5jNBXC0osWj2HmYIW0zi366HUN8oStz//pIdol5HYsHuT2wQtp3E6X9zoeLaEssWvmaG2Cso
        cXLmExaIXkmJgytuQNlvOCS+7bOCsF0k7k2dAzVfWuLv3WVMIK9ICCRLrPrIBRHOkZi/ZAtU
        q7XEwj/rmSYwqsxCcvUsJBfNQnLRLCQXzUJy0QJG1lWM4qXFxbnpqcXGeanlesWJucWleel6
        yfm5mxiB6er0v8MFOxhv3fqod4iRiYPxEKMEB7OSCK8bs0SKEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV5D25PJQgLpiSWp2ampBalFMFkmDk6pBiblow+nVggasEsyWUfY2nDvjozVOdHxaPqF
        3LS5zFz/D7a5yUec1XcU+mOY8/f0f4ED5/+c9z2ZUiiW7Gcy3zkj30VHuypLfXnYkfZlBVLv
        K1adXPrtcFjT8ecMJWvdtQWvyZn/2L/2gK5Xzsr/9h9/fy6uC+g4tvHTfYPL2apvL929v+jq
        ssw3rNnJzw3L6iblmu+4mfR/wfqaHZpndt0JWuyqcvTHpufKWofXTNXemifp61tS8qtXJtiF
        q2D+qShmTg32TMbIh2vWXlxyT1nsTPTh+zIxVYfY50et/1r8WPT45vcbvl2tnHV32Yfz09Kv
        fmGpXSSRk39ZflGeStj5a7cvvzhtq2l7c+rdlX4FSizFGYmGWsxFxYkAikJdtcYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWS2cA0UXeOgXSKwbw3xhZ3H19gs2ievJjR
        YvrUC4wWq2+uYbTY//Q5i8WqhdfYLM7POsVicXnXHDaLWxOOMTlwerQcecvqsXjPSyaPTas6
        2Tymzq73+LxJLoA1issmJTUnsyy1SN8ugSvj5ov3zAXb+CpWXnjI1MB4m7uLkZNDQsBE4sSq
        fWxdjFwcQgKrGSUmzP/DCuF8YpRY8v0vVGYZo8TJjmUsIC1sAooS+7q2s4HYIgLaEhPnHGQG
        KWIWeMIscXv3HaAiDg5hgUCJl6drIGqCJO6+WswGEhYRcJN4MicFJMwioCrxctkLsJG8AmYS
        O5o7WCB27WCSeHv+KTtIglPAU2JS90omEJtRQEzi+6k1YDazgLjErSfzmSBeEJBYsuc8M4Qt
        KvHy8T9WCFtR4v73l+wQ9ToSC3Z/YoOw7SRO/5sLFdeWWLbwNTPEEYISJ2c+YYHolZQ4uOIG
        ywRGiVlI1s1CMmoWklGzkIyahWTUAkbWVYzipcXFuekVxUZ5qeV6xYm5xaV56XrJ+bmbGIHx
        fvrf4egdjLdvfdQ7xMjEwXiIUYKDWUmE141ZIkWINyWxsiq1KD++qDQntfgQozQHi5I478uo
        ifFCAumJJanZqakFqUUwWSYOTqkGJuesHxpzcryuHb6W8m2hX8hFdpnXt+493e9xJ/ibaekO
        /r2FWhMblIReHWrxuKIVd58/t1VS2M7/nc2CJI36900GPk8uBxxLnbHSe8nWVddU3wvPjqwT
        mPnS5eohO3XL440/l8Qt2fs2wDHOoOvpmpdbGfiD/ctf9Idd/98jdaPqZMmDuwqtVSZZt3g/
        3Wnzf6xeFvd2rdCcnNdzfl+/dvWnrbHJp57FPq9UGrfrySU2xFv+2nQ6qayYqaRl+4LaGhWP
        rXvmnwrmri7I+BzjM+OHXY/uvJT0Gf039jCfS/A811/sejWmIOTrxys9fPMnn0/ekNN66gbb
        BM6HV3SuXVi19b1us8ohsz1Cnopn7yqxFGckGmoxFxUnAgCQYBpsZgMAAA==
X-CMS-MailID: 20230322164516uscas1p29b2bde0a1be33d3d6de0aea49a3e2d68
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <64025f6219d2d_71138294e5@dwillia2-xfh.jf.intel.com.notmuch>
        <20230303215446.GA1479551@bgt-140510-bm03>
        <640276695c8e8_5b27929473@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 02:36:25PM -0800, Dan Williams wrote:
> Fan Ni wrote:
> [..]
> > > I think a separate fix for that crash is needed, can you send the
> > > backtrace? I.e. I worry that crash can be triggered by other means.
> > Hi Dan,
> > See backtrace below.
>=20
> Thanks, I'll take a look.=20
>=20
> [..]
> > > > @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *=
port, struct cxl_decoder *cxld,
> > > >  	base =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(wh=
ich));
> > > >  	size =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(wh=
ich));
> > > >  	committed =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > > > +	should_commit =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
> > >=20
> > > This change looks like a good idea in general given the ambiguity of
> > > 'committed'. However just combine the two checks into the @committed
> > > variable with something like this:
> > >=20
> > > commit_mask =3D CXL_HDM_DECODER0_CTRL_COMMITTED|CXL_HDM_DECODER0_CTRL=
_COMMIT;
> > > committed =3D (ctrl & commit_mask) =3D=3D commit_mask;
>=20
> Did you also notice this ^^^ request for a fixed up version of the
> current patch?

Hi Dan,
Jonathan sent out a qemu patch to fix the committed field
reset as below, and the patch fixed the system crash discussed here.
https://lore.kernel.org/linux-cxl/20230322102731.4219-1-Jonathan.Cameron@hu=
awei.com/T/#me5283349b37d53abc93904a2428910a2f6a354f6

Do you think we need a separate fix at kernel side to fix the
possible system crash when cxl_dpa_release is called and dpa_res is
null? I have noticed at some location, dpa_res is checked before
calling cxl_dpa_release for example in function cxl_dpa_free, but no guard
from other callers. If it is needed, I have a simple fix and ready
to send out.

Fan=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AD65BB33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjACH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjACH2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:28:39 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A93BB7D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:28:38 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103072836epoutp023de2a3258492e9c3b7b38c6a05c62718~2u_fi7_Gf0550105501epoutp02U
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:28:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103072836epoutp023de2a3258492e9c3b7b38c6a05c62718~2u_fi7_Gf0550105501epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672730916;
        bh=eGleB0WkzSKoVjSc8z+2+zO9HAuRkuvhJZWvCINDNyQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iMOzyZt+bc0wWzJYExfeW6xsGthQYeUkxzRQQJYRLCV+eOficIKqrBYa5bUGtOQTj
         nKSa4+7BFmynQNyy0tyla5QiBG2w2XXuePGAeqGoc8OwekvT1ODnKc/EaoF5LdpEj6
         aX7b+0tH9kh1T++qR5URe1auiblDrEQ6OWng1Xls=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230103072835epcas1p4ed9ed9da2abbbb4b8def9320aa88d555~2u_epiPyW0485904859epcas1p4W;
        Tue,  3 Jan 2023 07:28:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NmPVC1FVbz4x9QD; Tue,  3 Jan
        2023 07:28:35 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.6A.19973.329D3B36; Tue,  3 Jan 2023 16:28:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e~2u_eVYf7n3260832608epcas1p37;
        Tue,  3 Jan 2023 07:28:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230103072834epsmtrp269cd492211b8bf6d96c6ed818ec8bea8~2u_eUhUhJ3213832138epsmtrp2W;
        Tue,  3 Jan 2023 07:28:34 +0000 (GMT)
X-AuditID: b6c32a35-f09ff70000014e05-16-63b3d923ad9c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.F5.10542.229D3B36; Tue,  3 Jan 2023 16:28:34 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230103072834epsmtip169b02d5592f8a4c123b73b41a729f122~2u_eIA3g80565105651epsmtip1i;
        Tue,  3 Jan 2023 07:28:34 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     riel@redhat.com, redkoi@virtuozzo.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] page_alloc: avoid the negative free for meminfo available
Date:   Tue,  3 Jan 2023 16:28:07 +0900
Message-Id: <20230103072807.19578-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmvq7yzc3JBmf/sVvMWb+GzWL1Jl+L
        7s0zGS16379isri8aw6bxb01/1ktXn9bxmzxu/kyi8XfK+tZHDg9Dr95z+yxc9Zddo9NqzrZ
        PDZ9msTucWLGbxaP9/uusnn0bVnF6PF5k5zH6/2HGAM4o7JtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ9zefY6t4BRrxfmlJ9kbGPexdDFy
        ckgImEhMuDqTuYuRi0NIYAejxLKZM9kgnE+MEru2PITKfGaUON+yhBmmZc/TlVBVuxglXiw8
        xwrh/GCU2HDvHyNIFZuAtsT7BZNYQWwRgVyJloVHmEBsZoFSibdvToBNEhbwkjjxsJEdxGYR
        UJWYsnYNG4jNK2Arcf3iTVaIbfISqzccgNp8i13iwCd2CNtF4vStv4wQtrDEq+NboOJSEp/f
        7WWDsLMlnp48AtTLAWTnSDRskIUw7SXeX7IAMZkFNCXW79KHKFaU2Pl7LiPEkXwS7772sEJU
        80p0tAlBlKhJtDz7CnWXjMTff8+gbA+JyeengANUSCBWYtqHiUwTGGVnISxYwMi4ilEstaA4
        Nz212LDAEB5Fyfm5mxjBiU7LdAfjxLcf9A4xMnEwHmKU4GBWEuGd9GJTshBvSmJlVWpRfnxR
        aU5q8SFGU2BgTWSWEk3OB6bavJJ4QxNLAxMzIxMLY0tjMyVxXpuIdclCAumJJanZqakFqUUw
        fUwcnFINTFP8psduffDnZMtEs9vyebOnT65Jer1xk+wpzbhvj9K4Jkf47f9guPBF5waHCQs3
        7soxOWbMFm+XKMDEk/mGudY7/PLkkKlexsuLDJzSXwd2Mn513jcj5oIFz/TC+TM2HPP6p912
        iX3XZJ6G/Jq1iy9N21sgoq2wpqNK+/b7hZYHn6tWWMWa/J2SsOPrR5dn+aYfnD5k56sYX11d
        tEnQ/N+SuDb+2WViZ6J2vD2bn7z2mlZIU7LpvBVZ/zq3Kn4WXhJ6kCWr9pauHKfES5lWZZ95
        rXlrK358/7+5pE0qQ/WyU03ugprMGsak1qa5SUxyV5/r5Dyetrp5zafbz9+ffiPDmTr/kKN2
        ajqP48u2W0osxRmJhlrMRcWJAJxZSe79AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnK7Szc3JBh8+GVvMWb+GzWL1Jl+L
        7s0zGS16379isri8aw6bxb01/1ktXn9bxmzxu/kyi8XfK+tZHDg9Dr95z+yxc9Zddo9NqzrZ
        PDZ9msTucWLGbxaP9/uusnn0bVnF6PF5k5zH6/2HGAM4o7hsUlJzMstSi/TtErgybu8+x1Zw
        irXi/NKT7A2M+1i6GDk5JARMJPY8XcnWxcjFISSwg1Fi4dkONoiEjMSb80+BijiAbGGJw4eL
        IWq+MUo0fTwEVsMmoC3xfsEkVhBbRKBY4vWHLmYQm1mgUuLf7VtgcWEBL4kTDxvZQWwWAVWJ
        KWvXgPXyCthKXL94kxVil7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcflpaOxj3rPqgd4iRiYPxEKMEB7OSCO+kF5uShXhTEiurUovy44tKc1KLDzFKc7Ao
        ifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBynb/q/Q72Cbv1D73c+i6j5Pi0e8aH958RCItK
        tVnFxTnJKYDn8gV36VdShvpvG/oqHh4Xsa0tPJXz9LbW9TrWIz0y9juNJ61LlLmZwrdgZjtD
        hfuOrNJPQrqsW/Ysm9gleGGq75/VGTOckhL1O43dhLv7bpW++vbtPcvMDSY75M71ZRf8UFrc
        Jnu0I+m0e1moeaAjr+6N7RNFHY7OXan0e03X/VmfmMp8z7Gk7PB+Knhb/ERd2HfWr/fP8Gub
        BKxf88+7t5z5drbjZCH1t+y/vyjq3Um9LVKpufXl7BmVj7mUX4WJLuPsrzmexFis/m3SryMf
        ne6UMkT/yxeNdC1522sjtuXMl/6+3eKr/7kpsRRnJBpqMRcVJwIAzUxQ7q4CAAA=
X-CMS-MailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
References: <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The totalreserve_pages could be higher than the free because of
watermark high or watermark boost. Handle this situation and fix it to 0
free size.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 218b28ee49ed..e510ae83d5f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5948,6 +5948,8 @@ long si_mem_available(void)
 	 * without causing swapping or OOM.
 	 */
 	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
+	if (available < 0)
+		available = 0;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
-- 
2.17.1


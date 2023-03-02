Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FD6A7D39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCBJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCBJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:06 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDD3B216
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:01:53 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302090151epoutp036beec7685f29046b780036f6ab9c0670~IjqeQZupy1438014380epoutp03O
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:01:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302090151epoutp036beec7685f29046b780036f6ab9c0670~IjqeQZupy1438014380epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677747711;
        bh=b0eBmLCnU5Wywu16Z/+5AO1xr9GLviTEe2c5K5ZdnZ4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MdH0f57d5e5Tdihxv3PbGD+YoQbz3+vfA/FQbadnXIfV8MgetCwG84UIOnuWcqlJ0
         rOH2qpKBE2rwAijXZ50fpEAnmW516fsI2sVcxq2mxKPnzRCpAquFO9cIsOwfq6Z3Cs
         U4vU7rqwo3YGCHWE/WhDYjkhoVBLSIf7jUSGv+oU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230302090151epcas1p3c0d8eb47301ef3bc120b419449235c56~Ijqd67-BB0388603886epcas1p3s;
        Thu,  2 Mar 2023 09:01:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PS4q22GXdz4x9QF; Thu,  2 Mar
        2023 09:01:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.10.52037.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epcas1p18924c1d17c91f6ecad2049e46b0b1e33~IjqcXAWfu0635206352epcas1p1S;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230302090149epsmtrp21bcc9e83d90c36ae2cba3331534b5c66~IjqcWT2Co3164931649epsmtrp2b;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-1e-640065fdb441
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.2E.31821.DF560046; Thu,  2 Mar 2023 18:01:49 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302090149epsmtip2e0787feedbafd0e4387a3c0d0f3bb444~IjqcIioa70659906599epsmtip2m;
        Thu,  2 Mar 2023 09:01:49 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v4 0/4]  Simplify extcon_dev_register function.
Date:   Thu,  2 Mar 2023 18:01:39 +0900
Message-Id: <20230302090143.46678-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmge7fVIYUg/lPtC1OrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR0H9rMV9LBWzP6xn7mBcTpLFyMnh4SAicT/dXMZ
        uxi5OIQEdjBKbLvQwQbhfGKUmHJhC1iVkMBnRonjM1NhOiaufcoEUbSLUeLw92+sEM4vRon1
        vfMZQarYBDQk9lxsABrFwSEiUChxuD8bJMwsoCbxYNVGdhBbWMBe4u3hi2wgNouAqsTP4//B
        lvEKWEm0f/vDCLFMXqL73x+ouKDEyZlPWCDmyEs0b53NDFGziF2iY2oBhO0i8ebLfnYIW1ji
        1fEtULaUxOd3e9kg7HSJlVfuQMVzJF7fb4faZSzx7u1aZpCTmQU0Jdbv0ocIK0rs/D2XEWIt
        n8S7rz2sICUSArwSHW1CECXKEt0PXjBB2JISi5/egZroITFp83x2SBDGSqzYt5p9AqP8LCTP
        zELyzCyExQsYmVcxiqUWFOempxYbFhjDozQ5P3cTIzilaZnvYJz29oPeIUYmDsZDjBIczEoi
        vAtv/0kW4k1JrKxKLcqPLyrNSS0+xGgKDN6JzFKiyfnApJpXEm9oYmlgYmZkYmFsaWymJM4r
        bnsyWUggPbEkNTs1tSC1CKaPiYNTqoHpfiPD/s9XW//Fequ9+Tzf3zvTsHB2944TXFLHivYl
        +V3UMFg5RSeo8fsG5qbgzTKBRUuDqnuXffbnOPp9SYEO594LnfK3501RWRj0w/m5QEj3Ab/u
        5owt944VPvE1eromLb7jdlTykZd8uq/PHblVssSYKzb5/rUL9vPv7J+r+bag2ErK1uazZ074
        bTGLgJ8Bfhf5fruXtO3cHfna4K/NZBHLK4WTj+llLGM5FGnWxrhgwT93iQ8aW7ZvPXTr5XEr
        lT8PLv6tyLsWbbTwyU/p162lu/78S3u0I/9f086Dyve0/8zqOCF/Pa+CK9BSy8dNd2vwnz3c
        06wnntn/QsJh6rrLYjGr4u7H9uTNcpv1S4mlOCPRUIu5qDgRAE9GWm/yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXvdvKkOKwbs2MYsTaxYxWVz/8pzV
        4vKuOWwWtxtXsDmwePRtWcXo8XmTXABTFJdNSmpOZllqkb5dAldGx4H9bAU9rBWzf+xnbmCc
        ztLFyMkhIWAiMXHtUyYQW0hgB6PEupYkiLikxNnlj9i7GDmAbGGJw4eLuxi5gEp+MErsWzWJ
        GaSGTUBDYs/FBjYQW0SgWOLCgcVgM5kF1CQerNrIDmILC9hLvD18EayGRUBV4ufx/2A1vAJW
        Eu3f/jBC7JKX6P73ByouKHFy5hOoOfISzVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKj
        vNRyveLE3OLSvHS95PzcTYzgMNPS2sG4Z9UHvUOMTByMhxglOJiVRHgX3v6TLMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTP/+Bpbf6BJQsXlvsPWN6
        c/vJzdb3p8TpcBXNeeHluGvVFVXn/c2xMVo/k8su+V2Q/Z/BJ5VtntDU3dK8wqqy5rDaEd6L
        9StTuydd2SQ+52D6qT+tpxarpu4XdujXtdRtY3mVszFbK8d7g6Xmrmtf9vZF3Fj07sSP70fD
        JicdK3swqzrW2q9L8Lb0rq+fml7m5MnErEm2kw9sqy+WO5l85/DzL8rcR6+yuT8zzQ2+/lf/
        1oMpTbo/k9UOm90scxXzWWfw1+Dr/k/7eJ6qTljLVXRc7+ean05S26JTJ53U+ZF4yYdx+mTG
        P3fWbHh+/uvjH8sv8bmqlxlrm96tC9/zJledPyf6d5Lq7bNM0tv/KrEUZyQaajEXFScCAEDH
        9MSiAgAA
X-CMS-MailID: 20230302090149epcas1p18924c1d17c91f6ecad2049e46b0b1e33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p18924c1d17c91f6ecad2049e46b0b1e33
References: <CGME20230302090149epcas1p18924c1d17c91f6ecad2049e46b0b1e33@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was modified to increase readability.

Chages from v3:
removed possibility of kfree(NULL).

Chages from v2:
resolved possible memory leak of dev->cables.

Changes from v1:
added return value handling.

Bumwoo Lee (4):
  extcon: Removed redundant null checking for class
  extcon: Added extcon_alloc_cables to simplify extcon register function
  extcon: Added extcon_alloc_muex to simplify extcon register function
  extcon: Added extcon_alloc_groups to simplify extcon register function

 drivers/extcon/extcon.c | 293 +++++++++++++++++++++++-----------------
 1 file changed, 166 insertions(+), 127 deletions(-)

-- 
2.35.1


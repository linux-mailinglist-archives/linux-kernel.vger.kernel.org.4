Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693C6C0948
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCTDUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCTDT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:57 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD625168B6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:19:51 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230320031949epoutp02df8e3417edc247cc7ef0100092221f11~OAm_YKaeY0411304113epoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230320031949epoutp02df8e3417edc247cc7ef0100092221f11~OAm_YKaeY0411304113epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679282389;
        bh=z1VxWYOcpABzVi/P1qAfbN1MmbZ4qGWpz6oYLAr6rOY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IHlrShQ3byfWXYX+2Nrz6+Oq6xgjZUbYlWEQWYgbqCviNLrEnoyEtPo1zLHrRQpjj
         fD5fErGrjpGkgftbYqODm+rKjEwFxTUZFvDvsDxlBN+IEF0OFEMOhz5xuR0Adcfkjy
         5r8sZEL4483egf7j6CYxEtguNxLzc6IL8kx9xu1w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230320031948epcas1p38233d8083ec98d8472bd5858608ee916~OAm_AZwt-0095800958epcas1p3f;
        Mon, 20 Mar 2023 03:19:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pg0N40F5wz4x9Pw; Mon, 20 Mar
        2023 03:19:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.1B.52037.3D0D7146; Mon, 20 Mar 2023 12:19:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epcas1p1aa5b69c95a6f00400ca6cc78a5ddd17b~OAm84-lZF2336523365epcas1p1g;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230320031947epsmtrp2293be9aa9a6dd3512c2b25fec51615bb~OAm84Sfk_1098210982epsmtrp2L;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-c4-6417d0d339f0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.58.18071.3D0D7146; Mon, 20 Mar 2023 12:19:47 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031947epsmtip1b33f03b4ae384138ffffb5fcecd4c774~OAm8tkAL_1354313543epsmtip1a;
        Mon, 20 Mar 2023 03:19:47 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v5 0/3] Simplify extcon_dev_register function.
Date:   Mon, 20 Mar 2023 12:19:36 +0900
Message-Id: <20230320031939.28862-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmru7lC+IpBgtm2VicWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM2Y3NDAWTGGtaL/u3MA4i6WLkZNDQsBEomFjLzOI
        LSSwg1Fi1ZHgLkYuIPsTo0TnuuuMEM43RokL0+YywnSs2zsTKrGXUeJK2y8WCOcXo8SzM5vA
        qtgENCT2XGxg62Lk4BARKJQ43J8NEmYWUJN4sGojO4gtLGAnsXTbEzYQm0VAVeLTtb1MIDav
        gJXE5sXP2SCWyUt0//vDAhEXlDg58wkLxBx5ieats5lB9koILGKXWHH0INQ/LhLdjxcxQ9jC
        Eq+Ob2GHsKUkPr/bCzU0XWLllTtQ8RyJ1/fboT4zlnj3di0zyM3MApoS63fpQ4QVJXb+hnie
        WYBP4t3XHlaQEgkBXomONiGIEmWJ7gcvmCBsSYnFT+9ATfSQ2PrmHRskdGMlrv9/zzyBUX4W
        km9mIflmFsLiBYzMqxjFUguKc9NTiw0LjOFRmpyfu4kRnNK0zHcwTnv7Qe8QIxMH4yFGCQ5m
        JRFevwWiKUK8KYmVValF+fFFpTmpxYcYTYHhO5FZSjQ5H5hU80riDU0sDUzMjEwsjC2NzZTE
        ecVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MGXEnzSOXGqdZC0x9+JGL89/MY9d3yz2zdB45K9a
        6T1v5qeLe2zmynPWyjp6yvNcXR/F83BNXdXv8xb3z887LOnzPd7opfF2ljvPNfM+Zjx7try8
        P3iP/WPhE5eVj992dF+xZM+1SXVeBbOjHsi/+/hrUr35hG/aCWnVUuunTU3tvuZS/Xrvkdof
        nE0qSpG9xxinN+2Zs/gf59pE14RzzWH5f5ILTj3auMNgoeOacyu2Hfvwo1VvTdqKB2WVvc/f
        Se+6xNVysSGj0nThsW79j7N4dva5H1wsrqkhpG3zhp2d27VwQ+kGYV+75z3Kz7R7lr2ccNNu
        j0WQ4gMDYz/Wy55ac+ZmexpaxG7OWXSkZb8SS3FGoqEWc1FxIgCis7w78gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTvfyBfEUg8892hYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6M2Q0NjAVTWCvarzs3MM5i
        6WLk5JAQMJFYt3cmYxcjF4eQwG5GiRczO9khEpISZ5c/ArI5gGxhicOHiyFqfjBK/L6/GayZ
        TUBDYs/FBjYQW0SgWOLCgcVgcWYBNYkHqzaCzREWsJNYuu0JWA2LgKrEp2t7mUBsXgEric2L
        n7NB7JKX6P73hwUiLihxcuYTqDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zU
        cr3ixNzi0rx0veT83E2M4DDT0tzBuH3VB71DjEwcjIcYJTiYlUR4/RaIpgjxpiRWVqUW5ccX
        leakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAdO163tQuM8WTci2Bki+n56R9
        3KKqZ/V11wKGq9LbI9JXHz7CVfap7ITK6wmeRxJ2ph+TELcr7o+P2Di9JXPCqzfym+ysOpUz
        nXgvLXGX1Y5TWLJu8bNby4sCJYU5Wt4kL/3l9FiBefnt4KZZD/2m7jyjuXTR7itpCqYTPIXU
        Hzb/fq6g1D5Lx9LcuF7hz3mF5Mrv7jwmk47It4rFvv2g9/HT1sv2GQyvzvrlvZRgXeZs/0H/
        yicpi8Xn7X6xz3x9fPNTzcUdVSvuHrm5pcOsQOFfpYLQ8QOm14tY33zfPn9L4O4THJ6NH4Nn
        sp+cn7i+8vE1sbJrf+Y3vtok13sx+kxmMMfLddt/rm7Y1fkshVWJpTgj0VCLuag4EQDpI8G9
        ogIAAA==
X-CMS-MailID: 20230320031947epcas1p1aa5b69c95a6f00400ca6cc78a5ddd17b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230320031947epcas1p1aa5b69c95a6f00400ca6cc78a5ddd17b
References: <CGME20230320031947epcas1p1aa5b69c95a6f00400ca6cc78a5ddd17b@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was modified to increase readability.

Changes from v4:
added null checking of edev on each function.

Chages from v3:
removed possibility of kfree(NULL).

Chages from v2:
resolved possible memory leak of dev->cables.

Changes from v1:
added return value handling.

Bumwoo Lee (3):
  extcon: Add extcon_alloc_cables to simplify extcon register function
  extcon: Add extcon_alloc_muex to simplify extcon register function
  extcon: Add extcon_alloc_groups to simplify extcon register function

 drivers/extcon/extcon.c | 281 +++++++++++++++++++++++-----------------
 1 file changed, 165 insertions(+), 116 deletions(-)

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFB69C50E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBTFp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBTFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:45:51 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F02C147
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:45:49 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230220054547epoutp04f67112825dae3c4639c5283e585ce348~FcibexY110305303053epoutp04e
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230220054547epoutp04f67112825dae3c4639c5283e585ce348~FcibexY110305303053epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676871947;
        bh=kMO4/j3TuBLxMQ3PH9c33KhJRhhyCZtYJwHZRxCJouI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aLOK9naNFtVv4CseUvr5RFVHCiOpJ7b0JYRMLZXVq8lnmdk4OHgG3gzHNbldfpRuv
         APBOwQ2HlJAVjLliNa3M+vhcJXC7sUkpKBhujGWrcaBsQrxGUjM7BesV8gPXalZD69
         OwkfNUvCKDbs2NkAD3xgO6cwIKiAYeVm+Ehkgm4A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230220054547epcas1p1e9f6024b4078cc9b5ac1ca38edc8d9b7~FcibH8BWk1974419744epcas1p1R;
        Mon, 20 Feb 2023 05:45:47 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.224]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKrxQ1jc8z4x9Q7; Mon, 20 Feb
        2023 05:45:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.F9.12562.A0903F36; Mon, 20 Feb 2023 14:45:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epcas1p4a2e170c1c67a675c6a54496417171d51~FciZvi_6P2418624186epcas1p4g;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220054545epsmtrp10a428392b400027fe6401ffa9590d63e~FciZu2mlJ1501015010epsmtrp1i;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-7d-63f3090ae91e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.5A.05839.90903F36; Mon, 20 Feb 2023 14:45:45 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220054545epsmtip1d0df9efce8b2e5cc8aee90cd435e6c72~FciZiQDL22531625316epsmtip1V;
        Mon, 20 Feb 2023 05:45:45 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 0/4] Simplify extcon_dev_register function.
Date:   Mon, 20 Feb 2023 14:45:09 +0900
Message-Id: <20230220054513.27385-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmgS4X5+dkg4unuSxOrFnEZHH9y3NW
        i8u75rBZ3G5cwebA4tG3ZRWjx+dNcgFMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        ZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGSuaTzAWTGKpODupk7mBcStzFyMnh4SAicS0TT1A
        NheHkMAORomPG2cxQTifGCW6Vl5hg3C+MUrMf3QKruXzz6WMILaQwF5GiS8fUyCKfjFKTNq/
        HayITUBDYs/FBqBuDg4RgUKJw/3ZIGFmATWJB6s2soPYwgJ2EmvebWEBsVkEVCXOHp/AAlLO
        K2Al0X1UDGKVvET3vz9gJbwCghInZz5hgRgjL9G8dTbY1RICi9glfnQ8YoRocJG4fq0DyhaW
        eHV8CzuELSXxsr8Nyk6XWHnlDpSdI/H6fjtUvbHEu7drmUFuYBbQlFi/Sx8irCix8/dcRoi9
        fBLvvvawgpRICPBKdLQJQZQoS3Q/eMEEYUtKLH56B2qih8TKeQeZISEVK9G7dxLrBEb5WUi+
        mYXkm1kIixcwMq9iFEstKM5NTy02LDCCR2lyfu4mRnBK0zLbwTjp7Qe9Q4xMHIyHGCU4mJVE
        eKUPfUgW4k1JrKxKLcqPLyrNSS0+xGgKDN6JzFKiyfnApJpXEm9oYmlgYmZkYmFsaWymJM4r
        bnsyWUggPbEkNTs1tSC1CKaPiYNTqoFpvr7UKU5z560FeS9WfOsNnWqU/jfg7PWAgOqURPtH
        HpcnhoW81c/xltc47Cxk/87/4uLARLetSj5Sf5h//5OPXLC/02RX8iWpvcIPOV2DfqqdXzRp
        3qE5nMJNNi3mCl4WNYazLn1grw08InNqRtnhsITtSzS//7nkt7L/pPlchy3vTq0uYt9idLZE
        eOZqBu+mfw/WmnWsFr200DDCUWPS+g2ql3bVMSU9l9z03OBZYmL8naQU71Ztn8cfXnLEOl3k
        YV/1zW3R1WmZ/+acuib8fYZKi4OyE/tCO41bvd9fz1J/csj1pdx7L/Zjhmu4GyfVfs++0bI0
        vf65Ntub73dvmr/mvcp4oPf965X7swJOKLEUZyQaajEXFScCAMt+g7/yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTpeT83OywfNrShYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6MFc0nGAsmsVScndTJ3MC4
        lbmLkZNDQsBE4vPPpYxdjFwcQgK7GSUOvt/GCpGQlDi7/BF7FyMHkC0scfhwMUTND0aJ47dn
        gjWzCWhI7LnYwAZiiwgUS1w4sJgFxGYWUJN4sGojO4gtLGAnsebdFrA4i4CqxNnjE1hAZvIK
        WEl0HxWDWCUv0f3vD1gJr4CgxMmZT6DGyEs0b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc4sN
        CwzzUsv1ihNzi0vz0vWS83M3MYLDTEtzB+P2VR/0DjEycTAeYpTgYFYS4ZU+9CFZiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZFCxdZK33y0XgmIJgS
        dut34TaR/X016tu2FF92jXFr+eIpsKKHi938uNWqrvQJx4v1D7e869aRd3N7r/hxRfj2xtaG
        GK+dpg2B0cIZW2t/dKXvsw1f/dI1kiXa8CTvm3vLpptwdrp4KBlqtmxNfGnREhxwald+w6eY
        9zU3biswXolZ17LR61/M9knPTVUkZNe12wWvtF3NqW6iXlepKxx6+E6pYWKk77U3e5QXcwWs
        cX4QcNAo57qKzM5LM5VM7nWtny/Lv9fA8af6bv/Z353S39dwhpqeYVVcb2t3YO9zsdkLHgvH
        Jqs8cqwp3ZE6I1tL47rg4pWHn/1+sVJdaG2UAfdO9vXpW90dZKdHKLEUZyQaajEXFScCAMEQ
        nxOiAgAA
X-CMS-MailID: 20230220054545epcas1p4a2e170c1c67a675c6a54496417171d51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p4a2e170c1c67a675c6a54496417171d51
References: <CGME20230220054545epcas1p4a2e170c1c67a675c6a54496417171d51@epcas1p4.samsung.com>
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

Changes from v1:
added return value handling.

Bumwoo Lee (4):
  extcon: Removed redundant null checking for class
  extcon: Added extcon_alloc_cables to simplify extcon register function
  extcon: Added extcon_alloc_muex to simplify extcon register function
  extcon: Added extcon_alloc_groups to simplify extcon register function

 drivers/extcon/extcon.c | 289 ++++++++++++++++++++++------------------
 1 file changed, 163 insertions(+), 126 deletions(-)

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7372F3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFNElb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjFNElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:41:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538321BE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:41:21 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230614044117epoutp01364c01c66ddff7b3d494f02700fd72d5~obMqelD-x2654226542epoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:41:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230614044117epoutp01364c01c66ddff7b3d494f02700fd72d5~obMqelD-x2654226542epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686717677;
        bh=UTp2spf180fapim/QCGBMuGvcRmlmKbbwTJawClBTJo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VJC3EuJjQcjy53i317PUpkpAY1MwggC7HDemD9pE26ieyukonBFv5/T880+0M6+wZ
         qp7cOSuyofo8NIrxb6hLQ+dXi0IGHaQZhmsk7xlWvGbThlVjcRGBrvcXZBeqXorvx/
         AhX1GWCjmcwbTcGMQLfZpr+nqBqDoFqr3RYd0SxA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230614044117epcas2p30a32e7bdaf1e216b7d2fc05297d37c21~obMqCF2n82216722167epcas2p3p;
        Wed, 14 Jun 2023 04:41:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Qgt6N6fZMz4x9Q5; Wed, 14 Jun
        2023 04:41:16 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.19.07392.CE449846; Wed, 14 Jun 2023 13:41:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230614044116epcas2p4174f088a892ca2d2d156944449f6823f~obMo6xLoD2937929379epcas2p4o;
        Wed, 14 Jun 2023 04:41:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230614044116epsmtrp1930bd94b1ac3c8e43235cf98bb532903~obMo5Y_K13155031550epsmtrp17;
        Wed, 14 Jun 2023 04:41:16 +0000 (GMT)
X-AuditID: b6c32a47-157fd70000001ce0-0b-648944ecd760
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.D0.27706.CE449846; Wed, 14 Jun 2023 13:41:16 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230614044116epsmtip18a4e154b4e06e21e36d5302f731c43dd~obMorEBwJ1168811688epsmtip1b;
        Wed, 14 Jun 2023 04:41:16 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3 0/2] change UIC command handling
Date:   Wed, 14 Jun 2023 13:31:54 +0900
Message-Id: <cover.1686716811.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUxbZRTOe+/lUha63BQY7+pYmhLDh4G1lJa7uTKSwdZkkxD3Q90g3R29
        AtKv9BaFTRMUHLRTKVOKLDhkjUIQ01BLhbYIazEdJOIc4grqwuZYAoowKsMujFl6Uf+dc57n
        nOc573s4KM+E8zlVWiNt0FJqIb4Lc/kzZFl/FJpUouVgFjlxvx8n56+6cHIxPIOT1++aMNK6
        GkbJL2zzGHkt6EJI95MGhBwMDmPkrPNbjJx2d+LkpdtDONkT2EJI869BQH62tYyRX916hBUQ
        iukfTyhs3kVEYbk2BhQb9mZc8XBhDlN84OwDipBjv6Jp7BJSwjldfbiSplS0QUBry3WqKm2F
        XHjilPKoUioTibPEB8k8oUBLaWi5sPBkSdaxKnVkA6HgdUpdEymVUAwjPJB/2KCrMdKCSh1j
        lAtpvUqtz9NnM5SGqdFWZGtp4yGxSJQjjRDPVld6/PO43orWBuy3Y+qBDzEDDgcSuXB08oIZ
        7OLwiCEALSsejE3WALQtbKBs8gjA3xvtsWYQF+2Y6vkIsMAIgH0PP49lk78BXPbfB9ssnMiA
        C7NtyDaQSKwi8GmPKwqgRBp0W24g23ECIYF/ekejMUY8C7uCG1EJLkHCy9P9KCu3H85OmaI+
        IPEuB65M9AMWKIStvfM4GyfApYBzxx8fLrZcjGW3q4be7j1suRbarMsYG0vglQdNYJuCRoza
        3QdYdiocn8NYl7ths//JzhAubL7IYxtT4ePLH+7o74Uds7/saCrgXx0LUS88ogyOvN8FLCDl
        yv/zPwWgD+yh9YymgmZy9JL//qhcp3GA6E1mHh8CHy+vZvsAwgE+ADmoMJG7kN6k4nFVVN15
        2qBTGmrUNOMD0shrtaL8pHJd5Ki1RqU496AoVyYT5+VIRXnCZO4z8olyHlFBGelqmtbThn/7
        EE4cvx4p/aEutX5leHJrM79n6l5vWcDZ3s07/V6rs+tFviYcSDn7khcMxr2SVETvS4t/69xv
        zcUyzT5/hu/UbjG3pdqSXFogGUxKeM3zOCPnKlK05rozKh3gdWSOLcVI7egb2eFvks/Hc2/c
        Gbhwz4ql5/dJAmlH1q3eMtumo1Hc+DKFj6yvKUsRgeeo6a67eOP6J4uhN6fNxZlYaO+rbb3t
        w/4vEzW6deOZ7psNI8dUUyffNuW3l3Y+qLXeGtcVfSc5k16HNm2eM3o9My5rqGAp3RU8/nQ4
        /ifmhZvmQ1+DlHpqPFxrsj7naOucOxLT0iDXTM4MuEWhdxw/d8+ov3c8TwgxppISZ6IGhvoH
        N/qBKxwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO4bl84Ug61TuC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI4oLpuU1JzMstQifbsErozdhx+wFUxjrji+/jprA+Mhpi5GTg4JAROJc8un
        MHYxcnEICexmlOiet4gRIiEpcWLncyhbWOJ+yxFWiKJvjBIff11hBkmwCWhKPL05lQkkISLQ
        xCxxafZ0FpAEs4C6xK4JJ8BWCAsYS7zbsx/MZhFQlZh/4zs7iM0rYCEx6fIaZogNchI3z3Uy
        T2DkWcDIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzh8tTR3MG5f9UHvECMTB+Mh
        RgkOZiUR3qca7SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJx
        cEo1MLUt2v8scKPbjh83nljv4PZhu7m95eHMCz6rGlkM23rFbZ4mfl44qULuqPQH3h/8E3XS
        ptsptf+7fXjl1qLT9i9EVF79EI3+oRWRyingWGzI9iT8MYNH97K1fw7+OnK017v+zOev055U
        fldL+XL57t+1947ujE555LSy/MnvgsnqnFUTHGxMgnnfVfhzabqWMwteLFUpc7lY1txw+8Xt
        xZOyJL5zG7nuDNv9w6ArQqU8aurc+f12ixVTkm66F3jLLL52x+1qddF3P5eIzFmrLq12fOzs
        dd9C1q2SVWkDc/wRD5WbdUWfzrqqfZdIsDMxjvFbKd/wZt+KNdevb/U0s006bCXhoRSY++bH
        A+a2i0osxRmJhlrMRcWJAJg/w+POAgAA
X-CMS-MailID: 20230614044116epcas2p4174f088a892ca2d2d156944449f6823f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614044116epcas2p4174f088a892ca2d2d156944449f6823f
References: <CGME20230614044116epcas2p4174f088a892ca2d2d156944449f6823f@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3: rule out the change of polling w/ pmc from this thread.
(I'll post the change later)
v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd

Kiwoong Kim (2):
  ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
  ufs: poll HCS.UCRDY before issuing a UIC command

 drivers/ufs/core/ufshcd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.4


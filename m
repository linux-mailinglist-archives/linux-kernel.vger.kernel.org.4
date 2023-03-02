Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35EC6A7A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCBDhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCBDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:37:08 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F11515DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:36:54 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230302033652epoutp025bced4ae994f5c24716326ba89c53546~IfOt9dzRh0948809488epoutp02c
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230302033652epoutp025bced4ae994f5c24716326ba89c53546~IfOt9dzRh0948809488epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677728212;
        bh=yij6bhWT9LdqglB8x8d0sKUGLx0JKno/SBsW6tnVBnk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=M6Rwks1zOf/rp0Agq7vuiDZKWP6RYTB8QWJnGkpjj2FSTBgWANyJ2+6CfjL05goHc
         LN8fF3MSBQRqDEr2pv8XXJZklPqeRZWpvAjFWNJPFbXDy0BJ3L+3IRqAvb07p7YVY5
         6kKzjhl/ig+oqDxnC45KMKT9GnheDQf2cFdWSc2U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302033651epcas1p14763ea4b6a237810926468199319734b~IfOtrViZG2267922679epcas1p1j;
        Thu,  2 Mar 2023 03:36:51 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.227]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PRxc25nqjz4x9Q3; Thu,  2 Mar
        2023 03:36:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.B7.37890.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epcas1p4f6f0aac3da82de167530260d128ff8e7~IfOsdvr-Q3273032730epcas1p4d;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302033650epsmtrp10b061fa587158d0800687eacdb98b1a4~IfOsdJYx62681726817epsmtrp19;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-57-640019d2e298
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.7F.17995.2D910046; Thu,  2 Mar 2023 12:36:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302033650epsmtip2e41b98ca7dbc1f3405a4acfe401a4f9b~IfOsSQlr02452424524epsmtip2U;
        Thu,  2 Mar 2023 03:36:50 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v3 0/4] Simplify extcon_dev_register function.
Date:   Thu,  2 Mar 2023 12:36:41 +0900
Message-Id: <20230302033645.23933-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmvu4lSYYUg1Wt+hYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        swK94sTc4tK8dL281BIrQwMDI1OgwoTsjBOfljMWXGWpWPrnKWMD42vmLkZODgkBE4nrK3qZ
        uhi5OIQEdjBKvH15E8r5xCgx79xzKOczo8SkY2eYYFrunZnNDJHYxSixecsBdgjnF6PElp63
        jCBVbAIaEnsuNrB1MXJwiAgUShzuzwYJMwuoSTxYtZEdxBYWsJN48noHM0gJi4CqxNp5QiBh
        XgEriRttc9kgdslLdP/7wwIRF5Q4OfMJC8QYeYnmrRA3SAgsYpdoWH0DbI6EgIvEw0uiEL3C
        Eq+Ob2GHsKUkXva3QdnpEiuv3IGycyRe329nhLCNJd69XQs2hllAU2L9Ln2IsKLEzt9zGSHW
        8km8+9rDCrGJV6KjTQiiRFmi+8ELaOhISix+egdqoofE04NnwQEtJBArMfvzUfYJjPKzkDwz
        C8kzsxAWL2BkXsUollpQnJueWmxYYAKP0uT83E2M4JSmZbGDce7bD3qHGJk4GA8xSnAwK4nw
        Lrz9J1mINyWxsiq1KD++qDQntfgQoykwdCcyS4km5wOTal5JvKGJpYGJmZGJhbGlsZmSOK+4
        7clkIYH0xJLU7NTUgtQimD4mDk6pBqbwdRl/S9n2PumaUtyWWhplJbGu+YCJle5k9vVMf7dF
        mAZW6rxovBZ2JL7iwr3Oax3LyptP3L240zB6xYLAwJzsoiPrXxq7xIev2Hy9febhhwtqSy4K
        +GkEnV7oHspsfaVlVU/IHqEVQZoM6Q3uUQc2eKYoxLhPYJo7m031YubU4p0xAtUlF7tkvQTP
        Pr7hMXGt/xe5o7LNHMGBYueaf2jVbwy99DT57krvx7wRk7xNIxS9CtP7Enc8vx12ZfHEuM73
        rbI/p8z6GHvzYHD7N8+eSzVlCaePXo8JnKIku9jv46rDroEiolWHuFbP/X+raMWVkzl3nvWc
        eKl7ccW6uR8vhF16KaPCkOY6Q/F20Q0lluKMREMt5qLiRABVwkD98gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXveSJEOKwapnYhYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6ME5+WMxZcZalY+ucpYwPj
        a+YuRk4OCQETiXtnZgPZXBxCAjsYJSbN/sIOkZCUOLv8EZDNAWQLSxw+XAxR84NR4kffGzaQ
        GjYBDYk9FxvAbBGBYokLBxazgNjMAmoSD1ZtBJsjLGAn8eT1DmaQOSwCqhJr5wmBhHkFrCRu
        tM1lg1glL9H97w8LRFxQ4uTMJ1Bj5CWat85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBUZ5
        qeV6xYm5xaV56XrJ+bmbGMFhpqW1g3HPqg96hxiZOBgPMUpwMCuJ8C68/SdZiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbszSenKGXKbMrqdX/X4izP
        Plf3fsypKYU2+uYX/oauibD0eRvF8rrtQPfhyXvOygpt4CnoUT3/z0Xkz53jb36on+W7sTCd
        YbKpwysLv0Uz+KeJtJ61rk6XWaas+/4wR9IRZum54asi/314cNayopkldIbrRYHOAxZLNkvP
        knB2Fev32jDRKVPMZkUvxwvhc8KhGp+WXxJ7c8YrPfvXBLV46TPP3EpuK1ke9cxxk5L/vSL4
        gXbQcc1vS959VeG6e05d8qJ/r7+rgdwqubPzGYpUCk7XiZTHs3Cr5ltqzdy06v6qjqKy/KUS
        fpMtJFr65ntqVM/5x7qwZJf9q11Huq3Xzr62YN2Fdat03xclWymxFGckGmoxFxUnAgAd1IbT
        ogIAAA==
X-CMS-MailID: 20230302033650epcas1p4f6f0aac3da82de167530260d128ff8e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302033650epcas1p4f6f0aac3da82de167530260d128ff8e7
References: <CGME20230302033650epcas1p4f6f0aac3da82de167530260d128ff8e7@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was modified to increase readability.

Chnages from v2:
resolved possible memory leak of dev->cables.

Changes from v1:
added return value handling.

Bumwoo Lee (4):
  extcon: Removed redundant null checking for class
  extcon: Added extcon_alloc_cables to simplify extcon register function
  extcon: Added extcon_alloc_muex to simplify extcon register function
  extcon: Added extcon_alloc_groups to simplify extcon register function

 drivers/extcon/extcon.c | 291 +++++++++++++++++++++++-----------------
 1 file changed, 165 insertions(+), 126 deletions(-)

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F94705D59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjEQCfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjEQCfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:35:18 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B135A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:35:15 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230517023514epoutp01dd81bba61fe043d62e52f6b3bee75501~fzamdySSg2342023420epoutp01-
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:35:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230517023514epoutp01dd81bba61fe043d62e52f6b3bee75501~fzamdySSg2342023420epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684290914;
        bh=lj84iqpsVooMp+lVk6fq7zMq0zN2LBL+aUslYEz4S3U=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=QJqS3JaK0BUEXWFnzXFAGkL3aStWQhT5i4s4N8Cl8OSf4EYzWJfiK/wJD7axpjs27
         hvi4R5StF2ApZCNzKQsAExkP4OcbTkPaRBAGsiTHx4IfUnHXOVkTDeJTLri50sgA2c
         KCY20vXHMl3DGWu4+CLm4e/+1tA5jxL+XlFFIMYo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230517023513epcas2p37901bef96fe45fca8c539f29c2904289~fzal_X-tO2059420594epcas2p3C;
        Wed, 17 May 2023 02:35:13 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QLcdr6x1Hz4x9QC; Wed, 17 May
        2023 02:35:12 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-d6-64643d60cfa6
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.FF.03265.06D34646; Wed, 17 May 2023 11:35:12 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 12/14] block: add helper function for iteration of
 bip's bvec
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512135410.GF32242@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230517023512epcms2p6ea6f88039f4aeeffc450cb342f28049d@epcms2p6>
Date:   Wed, 17 May 2023 11:35:12 +0900
X-CMS-MailID: 20230517023512epcms2p6ea6f88039f4aeeffc450cb342f28049d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuW6CbUqKQc9cC4vVd/vZLF4e0rRY
        ufook8WiG9uYLP523WOymHToGqPF06uzmCz23tK2uLxrDpvF8uP/mCzWvX7PYvH7xxw2Bx6P
        8/c2snhsXqHlcflsqcemVZ1sHhMWHWD02H2zgc2jt/kdm8fHp7dYPPq2rGL0+LxJzqP9QDdT
        AHdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0OVK
        CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DC
        hOyM329XMxWcZq/4fWgKcwPjb7YuRk4OCQETif7rk4BsLg4hgR2MEv0d24AcDg5eAUGJvzuE
        QWqEBSIlurYcYwGxhQSUJM6tmcUIUiIsYCBxq9ccJMwmoCfxc8kMsE4RAVmJKyvqQcLMAp+Y
        Jf6/M4DYxCsxo/0pC4QtLbF9+VZGEJtTQEfiy6NfrBBxDYkfy3qZIWxRiZur37LD2O+PzWeE
        sEUkWu+dhaoRlHjwczdUXFLi0KGvYCdICORLbDgQCBGukXi7/ABUib7EtY6NLBD/+Ur8PykJ
        EmYRUJVY+WMeNDxcJBa+mcsIcb22xLKFr5lBypkFNCXW79KHGK4sceQWC0QFn0TH4b/sMP81
        bPyNlb1j3hMmiFY1iUVNRhMYlWchgngWklWzEFYtYGRexSiWWlCcm55abFRgCI/V5PzcTYzg
        1KvluoNx8tsPeocYmTgYDzFKcDArifAG9iWnCPGmJFZWpRblxxeV5qQWH2I0BXpyIrOUaHI+
        MPnnlcQbmlgamJiZGZobmRqYK4nzStueTBYSSE8sSc1OTS1ILYLpY+LglGpgitgZfPXQlbe6
        7LpLD69o+PdM1y/243VbywlZRb0T172Tu5B9YFLyI8E637j7KeucbQwvzfxsvOfYy0/bBALN
        3FOUNt738z/257HIJpvkd+JrPuw8vEnixJwD+kxPvrgrLr7Y/z94Uxg3h6u65OoGk4snO9Le
        StaWd3L6TOGaJhMcubg+4u2dVV15XAFt+S9Y1qpdOmL60+9a/xx3sQu9b2oWSmpUPf9c8f3p
        mmtn3paeOfnEg2WSjnZDiqqkrc+3J4cV7gddCXztdGhFRMHtq3Hp7+aWGSmmNP5pj7hyyGL/
        io/PMmvrLtuxtezTmXjxBePPkj2btj+eI/v80em8kwf5L6k8LI0Vszvn9LQi6IMSS3FGoqEW
        c1FxIgCJtCc/RgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230512135410.GF32242@lst.de>
        <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <20230510085941epcms2p8ad574939bc3edbd65b8f208c80a85911@epcms2p8>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, May 10, 2023 at 05:59:41PM +0900, Jinyoung CHOI wrote:
>> bip_for_each_vec() performs the iteration in a page unit.
>>=20
>> Since a bio_vec of bip is composed of multi-page in the block, a macro
>> that can be carried out in multi-page units has been added.
>
>The naming here is a bit confused. =C2=A0The=20rest=20of=20the=20block=20l=
ayers=20uses=0D=0A>_segment=20for=20the=20per-page=20iterators=20and=20_vec=
=20for=20the=20one=20that=20doesn't=0D=0A>break=20up.=20=C2=A0I'd=20suggest=
=20we=20follow=20this=20naming=20scheme=20here.=20=C2=A0And=20also=0D=0A>sk=
ip=20the=20extra=20for_each_mp_bvec=20level,=20just=20like=20we=20don't=20h=
ave=20that=0D=0A>intermediate=20level=20for=20bio_for_each_vec=0D=0A=0D=0AT=
hank=20you=20for=20letting=20me=20know.=20I=20was=20not=20aware=20of=20the=
=20rule.=0D=0AAnd=20as=20you=20said,=20I=20will=20make=20one=20without=20ma=
king=20the=20middle=20level.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.

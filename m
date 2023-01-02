Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3217465AD0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 05:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjABE67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 23:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 23:58:54 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD9EB2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 20:58:52 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230102045848epoutp0340b4be633a0893535e751b3855234786~2ZSbDtt8-0645506455epoutp03B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230102045848epoutp0340b4be633a0893535e751b3855234786~2ZSbDtt8-0645506455epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672635528;
        bh=XigfiWqzt4IDYlHKXZufSRENVS875xFySlGXxJnOIfI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=l4QAGBYFi+eJ9eCCKcxLWQVyPaQMfK7U8nNTi6s1AD1ZQRzNTU32DmC/JPjGhJ8ZT
         hSN8ZuIzNXVmLKSuJu41mCHBARsh7U/Ciu0Z4z4K2LZsBz6qcr9kazJ58IJMdqbpv8
         DKP9eHfrHXR/OUZbtPQXGu81npgIn7f0rVokzhJE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230102045848epcas5p1e701d0a716af315a4808eaef6e4da54e~2ZSadJBC42590925909epcas5p1H;
        Mon,  2 Jan 2023 04:58:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NlkCp6zLpz4x9QG; Mon,  2 Jan
        2023 04:58:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.93.03362.08462B36; Mon,  2 Jan 2023 13:58:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230102045840epcas5p3adb63eab247eb2daee356f869ab40ebf~2ZSTdsDd42716527165epcas5p3J;
        Mon,  2 Jan 2023 04:58:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230102045840epsmtrp24468b003eeeb3f99c089addd775364cd~2ZSTce4Mu1675916759epsmtrp2c;
        Mon,  2 Jan 2023 04:58:40 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-35-63b264805ad2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.C7.10542.08462B36; Mon,  2 Jan 2023 13:58:40 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102045833epsmtip2a3b115f3aa38c515eb0bc2130a24e62d~2ZSMzlf3t0089200892epsmtip2R;
        Mon,  2 Jan 2023 04:58:33 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Bean Huo'" <beanhuo@iokpp.de>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>,
        <quic_cang@quicinc.com>, <quic_xiaosenh@quicinc.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'kernel test robot'" <lkp@intel.com>
In-Reply-To: <20221231150343.146274-1-beanhuo@iokpp.de>
Subject: RE: [PATCH ] scsi: ufs: core: bsg: Fix sometimes-uninitialized
 warnings
Date:   Mon, 2 Jan 2023 10:28:30 +0530
Message-ID: <01ac01d91e66$e18d6da0$a4a848e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJZo54of34DwWHAo+DCNZOa5QKymwNglvlarW6BhiA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhm5DyqZkg6YpJhYvf15ls7h/7DSL
        xcGHnSwW0z78ZLZYdGMbk8XlXXPYLLqv72CzeNX8iM1i+fF/TBaTrm1gs7i6+Cq7A7fH5Sve
        Hov3vGTy+DL1JbPHhEUHGD2+r+9g8/j49BaLx8Q9dR6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfFj8m7mgrmCFf+f
        hjcw3ubrYuTkkBAwkVi8fSprFyMXh5DAbkaJMxvuMkI4nxglzj/+yg7hfGaUmLp6GStMy+mu
        iUwQiV2MEtMeX4RyXjJKvPiymxGkik1AV2LH4jY2kISIwBVGiQuXtzOBJJgFMiVOz/rHDmJz
        CphLNC3bDNYgLBAkcWnhDmYQm0VAReL4nj42EJtXwFJi7+oXrBC2oMTJmU9YIObIS2x/O4cZ
        4iQFiZ9PIc4TEbCSeD3tGytEjbjEy6NHwH6QELjBIbH+2TEmiAYXiZuXP0PZwhKvjm9hh7Cl
        JD6/2wu0mAPI9pBY9EcKIpwh8Xb5ekYI217iwJU5LCAlzAKaEut36UOs4pPo/f2ECaKTV6Kj
        TQiiWlWi+d1VFghbWmJidzc0ED0kTiw/xjSBUXEWksdmIXlsFpIHZiEsW8DIsopRMrWgODc9
        tdi0wDgvtRwe38n5uZsYwUlZy3sH46MHH/QOMTJxMB5ilOBgVhLhvfx5XbIQb0piZVVqUX58
        UWlOavEhRlNgaE9klhJNzgfmhbySeEMTSwMTMzMzE0tjM0Mlcd7UrfOThQTSE0tSs1NTC1KL
        YPqYODilGpgYAw6HHZM/waxWuXKK2S+N1cyTT87fJpq3P+KyvssDpagoNcslbG3sX3jmMz37
        6O7hdCDExzpYrEdXddbHlosO3japjsVMabIz7tgqFSfc6c5Q/jzveaVs7two84rvmm+OPO/z
        aH87cRFDkaP2Y8fvEpenL1zUtuTMnV1trjzxMZkvr/qrG0uceafnIlBilpq88b79cwk1ows/
        ekLnqs22M60xWuvqHmmzPmh3V2WwANfdwj1C5psFZtZN89344nqVWGnltxjmMt+VYU9k+jbN
        6w+ZYKbMsSDq5aF70vdSVNjdvvrJ51p96Whxu/9ztWlw8txz+6rcNRZOYJkvvGRWlSbT0q/u
        hgf6dl5rU2Ipzkg01GIuKk4EAK9FfDtTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG5DyqZkg1XbFCxe/rzKZnH/2GkW
        i4MPO1kspn34yWyx6MY2JovLu+awWXRf38Fm8ar5EZvF8uP/mCwmXdvAZnF18VV2B26Py1e8
        PRbvecnk8WXqS2aPCYsOMHp8X9/B5vHx6S0Wj4l76jw+b5LzaD/QzRTAGcVlk5Kak1mWWqRv
        l8CV8WPybuaCuYIV/5+GNzDe5uti5OSQEDCRON01kamLkYtDSGAHo8SBnfNZIRLSEtc3TmCH
        sIUlVv57zg5R9JxRoqNxDgtIgk1AV2LH4jY2kISIwD1GiT0/LjJ2MXJwMAtkS6w7qg5SIyTQ
        wShx9JU4iM0pYC7RtGwzI4gtLBAgcXLiJiYQm0VAReL4nj42EJtXwFJi7+oXrBC2oMTJmU9Y
        IEbqSbRtBGtlFpCX2P52DjPEbQoSP58uAysXEbCSeD3tGytEjbjEy6NH2CcwCs9CMmkWwqRZ
        SCbNQtKxgJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcFRqae1g3LPqg94hRiYO
        xkOMEhzMSiK8lz+vSxbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFM
        lomDU6qByUP8piPLYpHzsW23688lO0VMFFvi+Drpi5/RLHOT8reG0mxTp+in365oOfB8xotD
        U/+f0th075F/jkPIt7kOFQe89J9ONeU+e84661xageZKN8t72YoT1j46fuSwRvziamOuFv8j
        9ts+xBrWlAc8NH91WrVN7hiHd+WpxOzNJpYbGLzqZC7OO10i8JhvTlvq7Hs3As/Uck9W9NVa
        suzd5qSeP99SZFmtQjfqM8Zee/5pelp21JoLntN6bb/+WmEZ+vEGU9t/A/GNK+bt2yYtM1Ms
        K7RCel17lOuR/VM3TNzurjRL5irPhnV/tp49Ki6Z1hyclfpt/VvFX95zVY1i95ycf3/JqZvH
        Yis++jbm/lJiKc5INNRiLipOBAAawAkNOQMAAA==
X-CMS-MailID: 20230102045840epcas5p3adb63eab247eb2daee356f869ab40ebf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221231150441epcas5p376dfc9832b2a0e1dc6ea9f98b80a2ecb
References: <CGME20221231150441epcas5p376dfc9832b2a0e1dc6ea9f98b80a2ecb@epcas5p3.samsung.com>
        <20221231150343.146274-1-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

>-----Original Message-----
>From: Bean Huo [mailto:beanhuo@iokpp.de]
>Sent: Saturday, December 31, 2022 8:34 PM
>To: alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
>martin.petersen@oracle.com; beanhuo@micron.com; bvanassche@acm.org;
>quic_cang@quicinc.com; quic_xiaosenh@quicinc.com
>Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; kernel test
>robot <lkp@intel.com>
>Subject: [PATCH ] scsi: ufs: core: bsg: Fix sometimes-uninitialized
warnings
>
>From: Bean Huo <beanhuo@micron.com>
>
>Compilation complains that two possible variables are used without
>initialization:
>
>drivers/ufs/core/ufs_bsg.c:112:6: warning: variable 'sg_cnt' is used
>uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>drivers/ufs/core/ufs_bsg.c:112:6: warning: variable 'sg_list' is used
>uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
>Fix both warnings by adding initialization with sg_cnt = 0, sg_list = NULL.
>
>Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in
>ufs_bsg")
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Xiaosen He <quic_xiaosenh@quicinc.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>Hi Martin,
>
>This patch is to fix two compilation warnings introduced by my commit:
>6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in
ufs_bsg").
>
>Apologies for this.
>
>---
> drivers/ufs/core/ufs_bsg.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c index
>0044029bcf7b..0d38e7fa34cc 100644
>--- a/drivers/ufs/core/ufs_bsg.c
>+++ b/drivers/ufs/core/ufs_bsg.c
>@@ -70,9 +70,9 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct
>ufs_hba *hba, struct bsg_job *j
> 	struct ufs_rpmb_reply *rpmb_reply = job->reply;
> 	struct bsg_buffer *payload = NULL;
> 	enum dma_data_direction dir;
>-	struct scatterlist *sg_list;
>+	struct scatterlist *sg_list = NULL;
> 	int rpmb_req_type;
>-	int sg_cnt;
>+	int sg_cnt = 0;
> 	int ret;
> 	int data_len;
>
>--
>2.25.1



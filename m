Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD86FE823
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjEJXfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjEJXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:35:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D86211C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:35:24 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230510233520epoutp02da1701719f4a6b34d36659258ccafcb7~d7F0-aNEb1405314053epoutp02H
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:35:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230510233520epoutp02da1701719f4a6b34d36659258ccafcb7~d7F0-aNEb1405314053epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683761720;
        bh=o752e7x8drNytVH+xeQYDrNah5bJ9JO8rEbU4yGJyIo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=mbgyUyX8aiR+wM2dpRPKJJcQG8/fG/vWw+pkJZ+biLK6Yn4F+Vci8KSA3+o0sCiPt
         oYctl5SqZ6GIvC9LXCgGqJYJXkZ497vEKcKXJ3gdZOY6N7pAmf4cppal+gyrsa7cT/
         k8rQunYNylgDu49JQGLZN5SdR47Rxzs/RrLpsjdM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510233520epcas2p15451d03fa410d7178aa5d6861e232e07~d7F0ULuQz2289522895epcas2p10;
        Wed, 10 May 2023 23:35:20 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QGrx339mRz4x9Pw; Wed, 10 May
        2023 23:35:19 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.74.17293.73A2C546; Thu, 11 May 2023 08:35:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230510233518epcas2p3897c71373d936a19339f02ca16fdbc5b~d7Fy-ueay2020620206epcas2p3J;
        Wed, 10 May 2023 23:35:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230510233518epsmtrp1f5c6035a1cd196d1dd43aa2def5ab3dc~d7Fy8aAuL0960809608epsmtrp1h;
        Wed, 10 May 2023 23:35:18 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-71-645c2a37a8f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.D7.28392.63A2C546; Thu, 11 May 2023 08:35:18 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230510233518epsmtip13321ccc948753e312a21d3bee2a10388~d7FytOsCO0879908799epsmtip1F;
        Wed, 10 May 2023 23:35:18 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Bao D. Nguyen'" <quic_nguyenb@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <adrian.hunter@intel.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <kwangwon.min@samsung.com>
In-Reply-To: <991cac52-22bc-0150-4332-76ac044c5bcb@quicinc.com>
Subject: RE: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Date:   Thu, 11 May 2023 08:35:18 +0900
Message-ID: <039001d98398$1478d0b0$3d6a7210$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGTQ//Bn9HITMBER2fQmcGpYd1IAgEVn6BsAYR8HMavy9ctsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeaS+3F5eaa0U8dEFKiSYwwBYpvV1EDTjsptlIyJaxLeu69to2
        faYPwszimOmwIJGClcXOoPKQrCwwCa2FsslD1zC3YdLhaqeERttQsWuHLptuM2u5uPHfd77v
        9zvf9zsPjM6aRNmYSmcmjTqphotuQDwzhcISYdG7cl5kLJuYvfclSix2e1Ai9ngeJabCLQgx
        2LuIED1BD41wB8cQIjB+FiVO/OxFiQH/UxpxesnPIFrvBAHR/zSO7GOKeydiNLG9ZxKI/xi2
        oeLfIiFE3DFxVHxy1AXED0e2iY9PnqDVYm+rdytJqZw0ckidTC9X6RSV3IN1kmqJoILHL+GL
        CCGXo5NqyUru/kO1JTUqTSoyl9Mg1VhSVK3UZOLu3LPbqLeYSY5SbzJXckmDXGMQGkpNUq3J
        olOU6kjzS3wer0yQKnxfrVwMJhiGKxsb/7K+1wQ8z7eCTAzi5bC9L4K2gg0YC/cCGP7FR0sL
        LHwFQFfPy5TwMIWvjKDPOuYW7iKUMA6gIxQB1CIGYHLeT09XofiLsCvsy0gLWfgKDQ5FzzHS
        Qia+F45+Pw/SeDN+CPZPWVf9EHw7TAx+mtoWw5i4CA59Jk/TTHwTnD1zD0ljOp4HL8fP0qkU
        HPg4cjGD4rPg5y3Nq3wWXgUv+TtW00H8BgaX7v4OqIb90NHvy6DwZnjfP8qgMBvG2psZaV+I
        q+HEhWyKboS9XXGEwrugM3ocpEvoeCEcHt9JVRfAq6G1ZBuhbeaftU2Y0NbMohoL4JPOU2v+
        OfDMrdtrnmK48PdVYAf5znUzOtfN6Fw3l/N/3/MAcYFs0mDSKkhTmaHsv5uW6bUjYPUpF9V4
        gSOeLJ0GNAxMA4jRuVnMeN87chZTLv3wCGnUS4wWDWmaBoLUoXfQ2Vtk+tRf0Jkl/HIRr7yi
        gi8sE/CE3K3MFypnZSxcITWTapI0kMZnfTQsk91EY8vbdh1QHjV/9cbW74q15j0Zr8V890UW
        X2ZLfvLwg4NPVLjIlReU1V2ou2UL173ZcDlUL7K3Ng3muQUzhfZ91+64cy3XE8uBOYPm9XMD
        w9/m5tY/ktmWChs17K8NO0qDku5v4tfQI0kk+5Vi9XO8OeNNd1/NxAcOkXfg1YAq57qA5IWH
        iJ9Uvzr6KpZa6pNVWvRRuy7/QHVOhGxw79imYCYuleg/ia58jBdwzmvxfPTPhljbQqdHzj65
        94Fzsaq4Wh6NIm+h3sMfhXg/dFpdgS+aayY15sRY12jCuoXfdrFogMU/ViVRhm525nBOoT9O
        3TiWXO62MwLW5eBtLmJSSvlFdKNJ+i+osvE0UwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnK6ZVkyKwecX6hYnn6xhs3gwbxub
        xcufV9ksDj7sZLFYvfgBi8WiG9uYLLbe2MlicXnXHDaL7us72CyWH//HZDH1xXF2i667Nxgt
        lv57y+LA67F4z0smjwmLDjB6fF/fwebx8ektFo+Je+o8+rasYvT4vEnOo/1AN1MARxSXTUpq
        TmZZapG+XQJXxoMb79kL9vNV/G6Ja2Dcxt3FyMkhIWAicf7eY5YuRi4OIYEdjBL7nr5mh0hI
        SpzY+ZwRwhaWuN9yhBWi6DmjxIUV25hBEmwC2hLTHu4GS4gINDBLzP9+hQUkISRwmlHi60QL
        EJtTwF5iy5mrYJOEBXwklh5sYQKxWQRUJd6vbgWq5+DgFbCUWDc9BSTMKyAocXLmE7AxzEDz
        ex+2MkLY8hLb385hhjhIQeLn02WsEHERidmdbWBxEQEniY3HJ7JMYBSahWTULCSjZiEZNQtJ
        +wJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHRqKW1g3HPqg96hxiZOBgPMUpw
        MCuJ8L5dEp0ixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dU
        A1PO/MzY/Vtk+f1YlLy4RXqMmCQtlzmeuBrSPenl5nwWxZcH5h/Qtpl0ozP2pBDHvL0XLtp1
        tLUJaGgVrpy+hHHHf8YNZSzno3NDbbcvvOMZFc1pz+0e4TmH6bO9+bFmufmcPj8Yzoq4qp5Z
        9Hbxv1xR6wPV7q3ndG9fn+T+7/uFCTa3AmPPOHmYrf6utOV7sNysZzvn+inzLfjRFim2WzCm
        LKtIfeHFg5F7tbddKpN/9/RrpsSUWVLnfvlnP+U53FyZHj95sWaenHCQyxSO65sWl6zPXv9q
        0aXbEzqvuixbaNvoMuXhK78zvJPXmMx4/rXT1aR1T2LnJDOxXMGnas3ZR+9LSzuarip+nnbE
        bYkSS3FGoqEWc1FxIgBHPtP0NQMAAA==
X-CMS-MailID: 20230510233518epcas2p3897c71373d936a19339f02ca16fdbc5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
        <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
        <991cac52-22bc-0150-4332-76ac044c5bcb@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/9/2023 1:24 AM, Kiwoong Kim wrote:
> > With auto hibern8 enabled, UIC could be working for a while to process
> > a hibern8 operation and HCI reports UIC not ready for a short term
> > through HCS.UCRDY.
> > And UFS driver can't recognize the operation.
> > UFSHCI spec specifies UCRDY like this:
> > whether the host controller is ready to process UIC COMMAND
> >
> > The 'ready' could be seen as many different meanings. If the meaning
> > includes not processing any request from HCI, processing a hibern8
> > operation can be 'not ready'. In this situation, the driver needs to
> > wait until the operations is completed.
> >
> > Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> > ---
> >   drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 96ce6af..fc79539 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -2368,7 +2368,18 @@ static inline int ufshcd_hba_capabilities(struct
> ufs_hba *hba)
> >    */
> >   static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
> >   {
> > -	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
> > +	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
> > +	u32 val = 0;
> > +
> > +	do {
> > +		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
> > +			UIC_COMMAND_READY;
> > +		if (val)
> > +			break;
> > +		usleep_range(500, 1000);
> Hi Kiwoong,
> It looks like you are sleeping while holding the spin_lock_irqsave(hba-
> >host->host_lock, flags) in ufshcd_send_uic_cmd()?

Right. Let me fix it.

Thanks.
Kiwoong Kim

> 
> 
> > +	} while (ktime_before(ktime_get(), timeout));
> > +
> > +	return val ? true : false;
> >   }
> >
> >   /**



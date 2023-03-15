Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4E6BA4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCOBqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCOBp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:45:58 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E84989A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:45:54 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230315014543epoutp047521389dcf19241ac8987f6858fa1cb8~MdGZNklV02439024390epoutp04L
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230315014543epoutp047521389dcf19241ac8987f6858fa1cb8~MdGZNklV02439024390epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678844743;
        bh=IDImruPWWXImxGSN6sNnktvBUTnspTBZBJWmjfDqMY4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZNlQhpKTmY8m18RMovNaAG9Px25xToIfwiET0vblEEBJtXyE/oA0ZM/BhNZnUnw/x
         ch7GxZ0ciatCGpEws65JPvFZUjKQr3eO/Jd+aIu48jTs6rE6yQIT5SRilECttICxPx
         xJwfV59SO2RNjdQir873qjwZ5Ihvl0muqpk3ZKyw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230315014543epcas2p2ce58824b21150c53758006ef558434ac~MdGYg7Mxm1321313213epcas2p2N;
        Wed, 15 Mar 2023 01:45:43 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PbtWp38jLz4x9Q1; Wed, 15 Mar
        2023 01:45:42 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.44.08750.64321146; Wed, 15 Mar 2023 10:45:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230315014541epcas2p3fdbf4ea817fbc87f9ba230e389914286~MdGXW2WFu0476104761epcas2p3U;
        Wed, 15 Mar 2023 01:45:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315014541epsmtrp1b2fe662e685c68cf8234b5f9ff801da0~MdGXUfaKS0238802388epsmtrp1n;
        Wed, 15 Mar 2023 01:45:41 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-a2-64112346c85f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.A5.31821.54321146; Wed, 15 Mar 2023 10:45:41 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230315014541epsmtip17f200e6ee17486c6456799e4617db009~MdGXIw3Yw2036820368epsmtip1h;
        Wed, 15 Mar 2023 01:45:41 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     <quic_nguyenb@quicinc.com>
Cc:     <Arthur.Simchaev@wdc.com>, <adrian.hunter@intel.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mani@kernel.org>, <martin.petersen@oracle.com>,
        <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>
Subject: Re: [RFC PATCH v2 3/3] ufs: mcq: Added ufshcd_mcq_abort()
Date:   Wed, 15 Mar 2023 10:45:41 +0900
Message-ID: <036101d956df$d9afe7a0$8d0fb6e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlW37LX9J9N3Z9WQoWloGX4SC/Ojw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmua6bsmCKwZT9IhYnn6xhs3gwbxub
        RefEZawWL39eZbM4+LCTxWLah5/MFotubGOyuLxrDptF9/UdbBYHPqxitFh+/B+TxcKOuSwW
        k65tYLOY+uI4uwOfx+Ur3h6L97xk8ti0qpPNY8KiA4we39d3sHl8fHqLxWPinjqPvi2rGD0+
        b5LzaD/QzRTAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO+Px/4WsBZMUK26dP8DYwPhfpouRk0NCwETi7qyNLCC2kMAORokrk+S6GLmA
        7E+MEu8ezWeHcD4zSjx5cZQJpuPXuTXMEIldjBLrHvVAVb1klLjeshZsFpuAlkT/2y1sILaI
        gJxE54UFLCBFzAK3mSSeNn1iBkkICzhJnJl/hxXEZhFQlTh5eBE7iM0rYCnx9cEfRghbUOLk
        zCdgQ5kFtCWWLXzNDHGGgsTPp8tYIRboSdyddIYdokZEYnZnG9h5EgIXOCTWbp4KNIgDyHGR
        eLREF6JXWOLV8S3sELaUxMv+Nig7W6Jxz1oou0Ji7ubJjBC2scSsZ+1gY5gFNCXW79KHmKgs
        ceQW1GV8Eh2H/7JDhHklOtqEIBqVJM7MvQ0VlpA4ODsHIuwhsf/tH8YJjIqzkLw4C8mLs5C8
        Mgth7QJGllWMYqkFxbnpqcVGBcbwqE7Oz93ECE7ZWu47GGe8/aB3iJGJg/EQowQHs5IIbziL
        QIoQb0piZVVqUX58UWlOavEhRlNgoE9klhJNzgdmjbySeEMTSwMTMzNDcyNTA3MlcV5p25PJ
        QgLpiSWp2ampBalFMH1MHJxSDUzyjVeeHL83Z/YM3v+W313vPJ61i3XdywcvtjOU/NVcwRbi
        85d32ZfopTGvmzxfzb+9KfFOlh7D1x8dx05OLhXLPd2SoKH9u/tO0bpvTNe8HhZ+umsyN1Pt
        Qk6rblL6x31W5yx7pUx3zzfrbUwvW3Zi2rENJc3LhGNXzdr3c234hYs75Bg1/qkFhWxz83rR
        3uySkPZngohQ1tKHfoln/liuSP56o+Xk10N1isen/i0Q4VhuyXzvcM0O/T7Pjjd5UYv+fXsV
        nTSfV5lVP6dgTaK4hqrG2cR9zNm/9Nial10xiEzYLjtjFVPH9r2Jwizze84ucanzYTJk+Mzx
        c6FxRuTKilnZzHFr2d+dT9jd2iOpxFKckWioxVxUnAgAY7nscGIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSnK6rsmCKwdFeXYuTT9awWTyYt43N
        onPiMlaLlz+vslkcfNjJYjHtw09mi0U3tjFZXN41h82i+/oONosDH1YxWiw//o/JYmHHXBaL
        Sdc2sFlMfXGc3YHP4/IVb4/Fe14yeWxa1cnmMWHRAUaP7+s72Dw+Pr3F4jFxT51H35ZVjB6f
        N8l5tB/oZgrgiuKySUnNySxLLdK3S+DK2HniHUvBZ5mKLYv7WBoYe8W7GDk5JARMJH6dW8Pc
        xcjFISSwg1Hixf6VLBAJCYn/i5uYIGxhifstR1ghip4zSnzf0cAKkmAT0JLof7uFDcQWEZCT
        6LywgAWkiFngJZPEqwV3wIqEBZwkzsyHsFkEVCVOHl7EDmLzClhKfH3whxHCFpQ4OfMJ2GZm
        AW2J3oetjDD2soWvmSGuUJD4+XQZK8QyPYm7k86wQ9SISMzubGOewCg4C8moWUhGzUIyahaS
        lgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjUktrB+OeVR/0DjEycTAeYpTg
        YFYS4Q1nEUgR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oq
        gcnYYXJhibx6+KwjmUdaVl+ONz9U77X38/+8x580i6bmbl6X33iAf69V+vZPvbl6bOkzViy6
        Grj5m0MUQ1FMs8ilvyx+m4TDm6ZkfH/+LyHse0Zia+knpkXrtZUmTmbYfSDkVaHPny0+h4L3
        L43ft/mE/pSvrzpWdKufLlFv2TppbeGPWNtbS7tiO8X/zXn2XkWHKaBS3kC1u/noe0/vT8ah
        BkY20wWYba9k6V9nmMlx7bWm8vRdCxU/fN1TZFP5u/XslDVnSkR2HXv12aFgtSjf3Iog+8kM
        0+eYC2xcr+EuOjWfb+ulW2UFXNs1goUbGfRM4ls/FL5/cfw543rBQyUSS98EFQRa/JJW+XNQ
        c4oSS3FGoqEWc1FxIgAlGLGeOQMAAA==
X-CMS-MailID: 20230315014541epcas2p3fdbf4ea817fbc87f9ba230e389914286
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230315014541epcas2p3fdbf4ea817fbc87f9ba230e389914286
References: <CGME20230315014541epcas2p3fdbf4ea817fbc87f9ba230e389914286@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c index =
4c33c1a..8d0019e 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
=40=40 -610,3 +610,65 =40=40 static bool ufshcd_mcq_sqe_search(struct ufs_h=
ba *hba,
 	spin_unlock(&hwq->sq_lock);
 	return ret;
 =7D
+
+/**
+ * ufshcd_mcq_abort - Abort the command in MCQ.
+ * =40cmd - The command to be aborted.
+ *
+ * Returns SUCCESS or FAILED error codes  */ int=20
+ufshcd_mcq_abort(struct scsi_cmnd *cmd) =7B
+	struct Scsi_Host *host =3D cmd->device->host;
+	struct ufs_hba *hba =3D shost_priv(host);
+	int tag =3D scsi_cmd_to_rq(cmd)->tag;
+	struct ufshcd_lrb *lrbp =3D &hba->lrb=5Btag=5D;
+	struct ufs_hw_queue *hwq;
+	int err =3D FAILED;
+
+	if (=21lrbp->cmd) =7B
+		dev_err(hba->dev,
+			=22%s: skip abort. cmd at tag %d already completed.=5Cn=22,
+			__func__, tag);
+		goto out;
+	=7D
+
+	/* Skip task abort in case previous aborts failed and report failure */
+	if (lrbp->req_abort_skip) =7B
+		dev_err(hba->dev, =22%s: skip abort. tag %d failed earlier=5Cn=22,
+			__func__, tag);
+		goto out;
+	=7D
+
+	hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+
+	if (ufshcd_mcq_sqe_search(hba, hwq, tag)) =7B
+		/*
+		 * Failure. The command should not be =22stuck=22 in SQ for
+		 * a long time which resulted in command being aborted.
+		 */
+		dev_err(hba->dev, =22%s: cmd found in sq. hwq=3D%d, tag=3D%d=5Cn=22,
+				__func__, hwq->id, tag);
+		/* Set the Command Type to 0xF per the spec */
+		ufshcd_mcq_nullify_cmd(hba, hwq);
+		goto out;
+	=7D
+
+	/*
+	 * The command is not in the Submission Queue, and it is not
+	 * in the Completion Queue either. Query the device to see if
+	 * the command is being processed in the device.
+	 */
+	if (ufshcd_try_to_abort_task(hba, tag)) =7B
+		dev_err(hba->dev, =22%s: device abort failed %d=5Cn=22, __func__, err);
+		lrbp->req_abort_skip =3D true;
+		goto out;
+	=7D
+
+	err =3D SUCCESS;
+	if (lrbp->cmd)
+		ufshcd_release_scsi_cmd(hba, lrbp);
+
+out:
+	return err;
+=7D

Hi, Bao.

Looking at the 4.0spec, it stops SQ before abort processing and checks whet=
her SQRTSy.STS is 1. Shouldn't this be added?
And need to check SQRTSy.STS bit as '0' after re-start SQ

Below is the original text of the UFS 4.0 spec

1. The device driver set SQRTCy.STOP as =E2=80=981=E2=80=99.=20The=20host=
=20controller=20will=20stop=20the=20fetching=20command=20from=20the=20Submi=
ssion=20Queue,=20and=20set=20the=20SQRTS.STS=20bit=20as=20=E2=80=981=E2=80=
=99=20to=20indicate=20that=20SQ=20is=20stopped=0D=0A=0D=0A2.=20Depending=20=
on=20the=20status=20of=20command=20which=20is=20requested=20to=20be=20abort=
ed,=20A.=20If=20the=20command=20is=20already=20completed,=20then=20go=20to=
=20step=203.=0D=0AB.=20If=20the=20command=20is=20in=20the=20Submission=20Qu=
eue=20and=20not=20issued=20to=20the=20device=20yet,=20the=20host=20controll=
er=20will=20mark=20the=20command=20to=20be=20skipped=20in=20the=20Submissio=
n=20Queue.=20The=20host=20controller=20will=20post=20to=20the=20Completion=
=20Queue=20to=20update=20the=20OCS=20field=20with=20=E2=80=98ABORTED=E2=80=
=99.=0D=0AC.=20If=20the=20command=20is=20issued=20to=20the=20device=20alrea=
dy=20but=20there=20is=20no=20response=20yet=20from=20the=20device,=20the=20=
host=20software=20driver=20issue=20the=20Abort=20task=20management=20functi=
on=20to=20the=20device=20for=20that=20command.=20Then=20the=20host=20driver=
=20set=20SQRTCy.ICU=20as=20=E2=80=981=E2=80=99=20to=20initiate=20the=20clea=
n=20up=20the=20hardware=20resources.=20The=20host=20controller=20will=20pos=
t=20to=20the=20Completion=20Queue=20to=20update=20the=20OCS=20field=20with=
=20=E2=80=98ABORTED=E2=80=99.=20If=20host=20software=20driver=20receive=20t=
he=20=E2=80=98task=20not=20found=E2=80=99=20as=20the=20response=20of=20the=
=20associated=20task=20management=20function,=20then=20go=20to=203.=0D=0A=
=0D=0A3.=20SW=20set=20SQRTCy.=20STOP=20as=20=E2=80=980=E2=80=99,=20host=20c=
ontroller=20set=20the=20SQRTSy.STS=20bit=20as=20=E2=80=980=E2=80=99,=20then=
=20resume=20fetching=20the=20command=20from=20Submission=20Queue.=0D=0A=0D=
=0AThanks.=0D=0ABRS=20SEO.=0D=0A=0D=0A

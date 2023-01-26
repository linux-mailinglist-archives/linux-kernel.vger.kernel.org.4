Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADC67C185
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjAZAZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAZAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:25:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B062D07;
        Wed, 25 Jan 2023 16:25:22 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PNBtbt008108;
        Thu, 26 Jan 2023 00:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+RCrcWbS7CVekzpCj861iGExbrDokQNGKMeHGD8EP0o=;
 b=b4ExrqTIQm0NEli2wMaNn6b0E/7AApb6T94QigCZeRfNidj84bWoifPt9U+VpY6IRKeE
 PXE4g7eQyDM+HhAjnfvq+zQVtYHW/bs+336DVhmUdzn/bNFguJXRfbW1eqSheQWFJaOr
 KkFUE096gL/LEDIGMDXSDkkzLwBTeBVvofUlOArEBD5L9HvfKgUbvKoFDiskKvRU1cGM
 K5rTRRYAZMT0CSEjgCzI0AnxDkbai4fW3uCLKDo5cjzvsaxnn4Hui7tJfL2TNrLazHqZ
 FJre1WmuTWHfa5TMe5lXMEiogOdegI0LWIIFO23yKNAjGoCxnKw4WsQES7kqyIfpglYX mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb5yn980p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 00:25:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30Q0PGUN026775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 00:25:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 16:25:16 -0800
Date:   Wed, 25 Jan 2023 16:25:15 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chris Lew <quic_clew@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] rpmsg: glink: Move irq and mbox handling to
 transports
Message-ID: <20230126002515.GA2156118@hu-bjorande-lv.qualcomm.com>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-5-quic_bjorande@quicinc.com>
 <4d9606ef-8b5c-4116-f2fe-bdd0d846ac3b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4d9606ef-8b5c-4116-f2fe-bdd0d846ac3b@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: puDlfn8rG7TMjLvcOOKmvNWdEUksMteq
X-Proofpoint-GUID: puDlfn8rG7TMjLvcOOKmvNWdEUksMteq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:55:47PM -0800, Chris Lew wrote:
> On 1/9/2023 2:39 PM, Bjorn Andersson wrote:
> > diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
[..]
> > @@ -305,8 +296,7 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
> >   static void qcom_glink_tx_kick(struct qcom_glink *glink)
> >   {
> > -	mbox_send_message(glink->mbox_chan, NULL);
> > -	mbox_client_txdone(glink->mbox_chan, 0);
> > +	glink->tx_pipe->kick(glink->tx_pipe);
> 
> I think that we need to check that tx_pipe is not null or validate that
> tx_pipe is not null in the native register probe.
> 

The function pointers are const, so it's only during development of a
transport that this could become NULL, and it's impossible to register
successfully without hitting that oops.

So I don't know if it's worth adding a runtime check for this. It's just
a handful of checks, but they would run trillions of times for no
purpose...

> >   }
> >   static void qcom_glink_send_read_notify(struct qcom_glink *glink)
[..]
> > @@ -35,6 +36,6 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
> >   					   struct qcom_glink_pipe *tx,
> >   					   bool intentless);
> >   void qcom_glink_native_remove(struct qcom_glink *glink);
> > +void qcom_glink_native_intr(struct qcom_glink *glink);
> > 
> 
> We could rename this away from qcom_glink_native_intr to something like
> qcom_glink_native_rx. Seeing this in the header, the purpose sounds a bit
> obscure.
> 

Perhaps qcom_glink_native_notify_rx()?

> > -void qcom_glink_native_unregister(struct qcom_glink *glink);
> >   #endif
> > diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
[..]
> > @@ -277,6 +301,24 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
> >   		goto err_put_dev;
> >   	}
> > +	smem->irq = of_irq_get(smem->dev.of_node, 0);
> > +	ret = devm_request_irq(&smem->dev, smem->irq, qcom_glink_smem_intr,
> > +			       IRQF_NO_SUSPEND | IRQF_NO_AUTOEN,
> > +			       "glink-smem", smem);
> 
> Are we adding dropping IRQF_NO_SUSPEND and adding enable irq wake for smem
> in follow up change?
> 

Yes, while I haven't reviewed all the details of that discussion again,
I was planning to follow up with something on that after this has been
merged.

That way we can discuss/review that separately.

> > +	if (ret) {
> > +		dev_err(&smem->dev, "failed to request IRQ\n");
> > +		goto err_put_dev;
> > +	}
> > +
[..]
> > @@ -314,8 +361,13 @@ void qcom_glink_smem_unregister(struct qcom_glink_smem *smem)
> >   {
> >   	struct qcom_glink *glink = smem->glink;
> > +	disable_irq(smem->irq);
> > +
> >   	qcom_glink_native_remove(glink);
> > -	qcom_glink_native_unregister(glink);
> > +
> > +	device_unregister(&smem->dev);
> > +
> > +	mbox_free_channel(smem->mbox_chan);
> 
> This might need to be moved above device_unregister. I think the release
> function frees the smem structure.
> 

Yes, that looks correct.

Thank you for the review,
Bjorn

> >   }
> >   EXPORT_SYMBOL_GPL(qcom_glink_smem_unregister);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B996971DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNXeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:34:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B8234C9;
        Tue, 14 Feb 2023 15:34:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EKS7KL022832;
        Tue, 14 Feb 2023 23:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=W7cAjMVtbpX/wOrIuXv65sTNDtCQNRmELgZedUKQ7r0=;
 b=RXkkLTksEg4TAXBmRi3RqJg+59p0ZGksfPOi3HZIm3tKtLwZFE5FVjcNq3d2KTcxdsht
 9FVcM66aG85qutLNgssIfpYE9AYHazvRFm1PEJzZW5T+IVFisCrOrm9BApAUp6JbLWmw
 HSEae4V5xDfxrIhtEqMGIOlmwJ5QNdU8/kOEVswZ7NQTrK6qE7KkhR9XR0r+1ldE7FvE
 hOinpYaFJpPyO94F5ORgh/glvPg/4bprB8TUsE4aaK348GFgwk5l4s7WeJjLVW4kgRv+
 QbQncq2bR+rTGdH4vEbrLcFyyOeJ9IkJwQS+AzPTA3hWDvUaMukn2t/JQrtK9PpvH8wD VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr4kpag2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:34:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ENYNPD010994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:34:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 15:34:22 -0800
Date:   Tue, 14 Feb 2023 15:34:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chris Lew <quic_clew@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: Avoid infinite loop on intent for missing
 channel
Message-ID: <20230214233421.GB1332049@hu-bjorande-lv.qualcomm.com>
References: <20230109223801.1706213-1-quic_bjorande@quicinc.com>
 <393b7d5f-b565-6287-bbab-3bf51cc981f0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <393b7d5f-b565-6287-bbab-3bf51cc981f0@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JyHIFyft5JE5wCVxxaCD5C3jsKcnW8IX
X-Proofpoint-ORIG-GUID: JyHIFyft5JE5wCVxxaCD5C3jsKcnW8IX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:55:02PM -0800, Chris Lew wrote:
> On 1/9/2023 2:38 PM, Bjorn Andersson wrote:
> > In the event that an intent advertisement arrives on an unknown channel
> > the fifo is not advanced, resulting in the same message being handled
> > over and over.
> > 
> > Fixes: dacbb35e930f ("rpmsg: glink: Receive and store the remote intent buffers")
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   drivers/rpmsg/qcom_glink_native.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> > index f36740cb6866..7b1320b1579e 100644
> > --- a/drivers/rpmsg/qcom_glink_native.c
> > +++ b/drivers/rpmsg/qcom_glink_native.c
> > @@ -946,12 +946,12 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
> >   	spin_unlock_irqrestore(&glink->idr_lock, flags);
> >   	if (!channel) {
> >   		dev_err(glink->dev, "intents for non-existing channel\n");
> > -		return;
> > +		goto advance_rx;
> >   	}
> >   	msg = kmalloc(msglen, GFP_ATOMIC);
> >   	if (!msg)
> > -		return;
> > +		goto advance_rx;
> 
> 
> Should we be dropping the packet for this case? If we try again later more
> memory might be available to handle the command.
> 

You're right, we found a channel above, but we don't have enough memory
to handle the message right now. That seems like a message worth not
throwing away.

Thanks,
Bjorn

> >   	qcom_glink_rx_peak(glink, msg, 0, msglen);
> > @@ -973,6 +973,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
> >   	}
> >   	kfree(msg);
> > +advance_rx:
> >   	qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
> >   }
> > 

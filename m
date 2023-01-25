Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B832E67B9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjAYS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:55:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBFD9EFA;
        Wed, 25 Jan 2023 10:55:58 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PBDlvZ013708;
        Wed, 25 Jan 2023 18:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=L3/5hDPRGEQidEXlkIYd10t70J2lUdzqn3DEtzJQsVU=;
 b=V/2BcYPWujtJAv6icS+r6q5vebwvz4mvm5awbtP2RhqGn51SmPIbMIQn3R8BgEkqpHmJ
 sRIQeBkj5lUSsSh5UwT2mhGXYAbTYLGrYnFu8xZTn69Zfx4TNktRpYb3tXmGLKGOdUrU
 3Jy3TbA+reVQoznJ9U7RwhA+TOroZAGFVb2ekc2zpMGno182lDaU7BAT+ZFhK6R/r+J3
 nr3uLnJtxxqWhjUHe3D2GGqKsxfVW4dXBjNvCcoY6ZEi0C1L8xn6atzBNJUyR5N5rN2t
 tZg5ZcLLD6MRJN2HDzVaxEEpBLzak7drLwCQ+o7Zf3XaegVqsfzKdjjGkCKZDZhFCxOu Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nar2n9vje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 18:55:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PItrBm014700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 18:55:53 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 10:55:53 -0800
Date:   Wed, 25 Jan 2023 10:55:51 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chris Lew <quic_clew@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] rpmsg: glink: smem: Wrap driver context
Message-ID: <20230125185551.GA2034155@hu-bjorande-lv.qualcomm.com>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-3-quic_bjorande@quicinc.com>
 <21302696-aadc-2005-bb64-ec807e737d1a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21302696-aadc-2005-bb64-ec807e737d1a@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Rwqn3LPX06hkxs5b3nWnALZf0iOcUdD
X-Proofpoint-GUID: 4Rwqn3LPX06hkxs5b3nWnALZf0iOcUdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:30:42PM -0800, Chris Lew wrote:
> 
> 
> On 1/9/2023 2:39 PM, Bjorn Andersson wrote:
> > The Glink SMEM driver allocates a struct device and hangs two
> > devres-allocated pipe objects thereon. To facilitate the move of
> > interrupt and mailbox handling to the driver, introduce a wrapper object
> > capturing the device, glink reference and remote processor id.
> > 
> > The type of the remoteproc reference is updated, as these are
> > specifically targetting the SMEM implementation.
> 
> s/targetting/targeting
> 

Thank you.

> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   drivers/remoteproc/qcom_common.h |  3 +-
> >   drivers/rpmsg/qcom_glink_smem.c  | 76 ++++++++++++++++++++------------
> >   include/linux/rpmsg/qcom_glink.h | 12 ++---
> >   3 files changed, 55 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> > index c35adf730be0..2747c7d9ba44 100644
> > --- a/drivers/remoteproc/qcom_common.h
> > +++ b/drivers/remoteproc/qcom_common.h
> > @@ -6,6 +6,7 @@
> >   #include "remoteproc_internal.h"
> >   #include <linux/soc/qcom/qmi.h>
> > +struct qcom_glink_smem;
> >   struct qcom_sysmon;
> >   struct qcom_rproc_glink {
> > @@ -15,7 +16,7 @@ struct qcom_rproc_glink {
> >   	struct device *dev;
> >   	struct device_node *node;
> > -	struct qcom_glink *edge;
> > +	struct qcom_glink_smem *edge;
> >   };
> >   struct qcom_rproc_subdev {
> > diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> > index 579bc4443f6d..703e63fa5a86 100644
> > --- a/drivers/rpmsg/qcom_glink_smem.c
> > +++ b/drivers/rpmsg/qcom_glink_smem.c
> > @@ -33,6 +33,14 @@
> >   #define SMEM_GLINK_NATIVE_XPRT_FIFO_0		479
> >   #define SMEM_GLINK_NATIVE_XPRT_FIFO_1		480
> > +struct qcom_glink_smem {
> > +	struct device dev;
> > +
> > +	struct qcom_glink *glink;
> > +
> > +	u32 remote_pid;
> > +};
> > +
> >   struct glink_smem_pipe {
> >   	struct qcom_glink_pipe native;
> > @@ -41,7 +49,7 @@ struct glink_smem_pipe {
> >   	void *fifo;
> > -	int remote_pid;
> > +	struct qcom_glink_smem *smem;
> >   };
> >   #define to_smem_pipe(p) container_of(p, struct glink_smem_pipe, native)
> > @@ -49,13 +57,14 @@ struct glink_smem_pipe {
> >   static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
> >   {
> >   	struct glink_smem_pipe *pipe = to_smem_pipe(np);
> > +	struct qcom_glink_smem *smem = pipe->smem;
> >   	size_t len;
> >   	void *fifo;
> >   	u32 head;
> >   	u32 tail;
> >   	if (!pipe->fifo) {
> > -		fifo = qcom_smem_get(pipe->remote_pid,
> > +		fifo = qcom_smem_get(smem->remote_pid,
> >   				     SMEM_GLINK_NATIVE_XPRT_FIFO_1, &len);
> >   		if (IS_ERR(fifo)) {
> >   			pr_err("failed to acquire RX fifo handle: %ld\n",
> > @@ -179,45 +188,49 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
> >   static void qcom_glink_smem_release(struct device *dev)
> >   {
> > -	kfree(dev);
> > +	struct qcom_glink_smem *smem = container_of(dev, struct qcom_glink_smem, dev);
> > +
> > +	kfree(smem);
> >   }
> > -struct qcom_glink *qcom_glink_smem_register(struct device *parent,
> > -					    struct device_node *node)
> > +struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
> > +						 struct device_node *node)
> >   {
> >   	struct glink_smem_pipe *rx_pipe;
> >   	struct glink_smem_pipe *tx_pipe;
> >   	struct qcom_glink *glink;
> > -	struct device *dev;
> > +	struct qcom_glink_smem *smem;
> 
> I think we're following reverse christmas tree in this file
> 
> >   	u32 remote_pid;
> >   	__le32 *descs;
> >   	size_t size;
> >   	int ret;
> > -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > -	if (!dev)
> > +	smem = kzalloc(sizeof(*smem), GFP_KERNEL);
> > +	if (!smem)
> >   		return ERR_PTR(-ENOMEM);
> > 
> 
> Would it be proper to keep a pointer to dev and avoid all the changes to
> smem->dev use?
> 
> dev = &smem->dev;
> 

That seems reasonable. Will respin accordingly.

Thanks,
Bjorn

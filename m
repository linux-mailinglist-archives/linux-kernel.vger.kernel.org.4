Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1686575D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiL1LU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiL1LUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:20:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13310B57;
        Wed, 28 Dec 2022 03:20:38 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSAbpKR000732;
        Wed, 28 Dec 2022 11:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=sY/S2Kz2GtGTbhkfwZyiHuEhly2TC7QnkS4x4W8hUa8=;
 b=gVuXthjREvM1vJ4muUeM2I4DB3NkQrMdm9FqftoVYmd8YA+M+xEsCBweG/+QFLYScuIE
 vB9r4g/q045XqsSuBQETPt2Yl3xiFYdXXwAfWIQjQuyKfiYbiHAS3QaCnKBnpeg6Ie4J
 cuUSS+f3JphgGC4RnmeHWZusTDg9kEXSepelUkz1VauWUd9cjvPw0Ky2vxmN8fl6zcfh
 FPaQM4S7WxdIazSIkIhHs81q4h3RqRD9mMK26PkwXathN93YvKQ2LO7AfZJQOirWB/mY
 9smMofEQ6D9u4M/ByBM3IhQR19jk6iIKOFST0b57xpylmReu9WmNBH7IPgvQPj44ywd0 Zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mrau40xww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 11:20:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BSBKO1m031470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 11:20:24 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 03:20:22 -0800
Date:   Wed, 28 Dec 2022 16:50:18 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Yogesh Lal <quic_ylal@quicinc.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] irqchip: gic-v3: Handle failure case of CPU enters low
 power state
Message-ID: <20221228112018.GA1600201@hu-pkondeti-hyd.qualcomm.com>
References: <1671734140-15935-1-git-send-email-quic_ylal@quicinc.com>
 <20221227103638.GA3974604@hu-pkondeti-hyd.qualcomm.com>
 <86bknnbx18.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86bknnbx18.wl-maz@kernel.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VPZWUVY937b3Qn-w27phP61DCng5DxBz
X-Proofpoint-ORIG-GUID: VPZWUVY937b3Qn-w27phP61DCng5DxBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_08,2022-12-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=614 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212280094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:14:11AM +0000, Marc Zyngier wrote:
> On Tue, 27 Dec 2022 10:36:38 +0000,
> Pavan Kondeti <quic_pkondeti@quicinc.com> wrote:
> > 
> > Hi Yogesh,
> > 
> > On Fri, Dec 23, 2022 at 12:05:40AM +0530, Yogesh Lal wrote:
> > > When CPU enter in low power mode it disable the redistributor and
> > > Group1 interrupts. And re-initialise the system registers on wakeup.
> > > 
> > > But in case of failure to enter low power mode need to enable
> > > the redistributor and Group1 interrupts.
> > > 
> > > Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> > > ---
> > >  drivers/irqchip/irq-gic-v3.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > index 997104d..4904f00 100644
> > > --- a/drivers/irqchip/irq-gic-v3.c
> > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > @@ -1376,7 +1376,7 @@ static int gic_retrigger(struct irq_data *data)
> > >  static int gic_cpu_pm_notifier(struct notifier_block *self,
> > >  			       unsigned long cmd, void *v)
> > >  {
> > > -	if (cmd == CPU_PM_EXIT) {
> > > +	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
> > >  		if (gic_dist_security_disabled())
> > >  			gic_enable_redist(true);
> > >  		gic_cpu_sys_reg_init();
> > 
> > static int gic_cpu_pm_notifier(struct notifier_block *self,
> > 			       unsigned long cmd, void *v)
> > {
> > 	if (cmd == CPU_PM_EXIT) {
> > 		if (gic_dist_security_disabled())
> > 			gic_enable_redist(true);
> > 		gic_cpu_sys_reg_init();
> > 	} else if (cmd == CPU_PM_ENTER && gic_dist_security_disabled()) {
> > 		gic_write_grpen1(0);
> > 		gic_enable_redist(false);
> > 	}
> > 	return NOTIFY_OK;
> > }
> > 
> > During CPU_PM_ENTER notification, we are not doing anything for the
> > !gic_dist_security_disabled() case. Since CPU_PM_ENTER_FAILED notification
> > arrive when CPU fails to power down, do we need to reinitialize the
> > system registers? IOW, should we do different handling for CPU_PM_ENTER_FAILED
> > based on gic_dist_security_disabled()?
> 
> What does it gain you apart from the extra complexity?
> 
Probably nothing. I am not very familiar with this part of code. If
gic_cpu_sys_reg_init() is written in such a way that it can be called even
when the CPU is not powered down, there is nothing to worry. The additional
complexity of dealing CPU_PM_EXIT vs CPU_PM_ENTER is pointless.

> gic_cpu_sys_reg_init() does very little, and makes sure we're always
> back into a sane state.
> 

Understood. Thanks for taking a look.

Thanks,
Pavan

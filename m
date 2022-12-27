Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9B65697E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiL0KhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0KhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:37:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B0DC;
        Tue, 27 Dec 2022 02:36:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRAXDwP023528;
        Tue, 27 Dec 2022 10:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=5dDK27AmB6IzropSzGtrdgFwCslHcsvmyoks4GeiwcQ=;
 b=JAzPwqvLm0ftvWq518OfsRYKUERuLRUy1ZzubfMJ8lq/6iiPone+wu+uzY6lTASZhA8R
 8L/hjoSuv9ag1FvwRzwEzHe9B8i4ACjvoJM0gyqyzHH9gQ0MCWntBTk/sl9qiOjEmFon
 Ud6ZfkadtoEWXhwgoSzCRbXKkbw2/8eEAhXUHgMLp2kZoUxut21sQb3s9QeZqIqCBnPa
 xMNIrZ3nujWE0HtqtCFPINKKevi1TCws0DW1sAlssueJAp6YJDUIbfxFwZ6KXLW2b5k3
 cm6wFG0KhIc3QSHhyBjBsSwAmqyE6JkU0JjibpvkbNC5ymG6f253fsrIl0sssC6sEDcQ Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrrrvyfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 10:36:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRAaiIc004774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 10:36:44 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 27 Dec 2022 02:36:41 -0800
Date:   Tue, 27 Dec 2022 16:06:38 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>
CC:     <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] irqchip: gic-v3: Handle failure case of CPU enters low
 power state
Message-ID: <20221227103638.GA3974604@hu-pkondeti-hyd.qualcomm.com>
References: <1671734140-15935-1-git-send-email-quic_ylal@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1671734140-15935-1-git-send-email-quic_ylal@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YT9Tol4BIV2PNhWDo7QZk1ZgtRt7_3c_
X-Proofpoint-ORIG-GUID: YT9Tol4BIV2PNhWDo7QZk1ZgtRt7_3c_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_06,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=544 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Fri, Dec 23, 2022 at 12:05:40AM +0530, Yogesh Lal wrote:
> When CPU enter in low power mode it disable the redistributor and
> Group1 interrupts. And re-initialise the system registers on wakeup.
> 
> But in case of failure to enter low power mode need to enable
> the redistributor and Group1 interrupts.
> 
> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 997104d..4904f00 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1376,7 +1376,7 @@ static int gic_retrigger(struct irq_data *data)
>  static int gic_cpu_pm_notifier(struct notifier_block *self,
>  			       unsigned long cmd, void *v)
>  {
> -	if (cmd == CPU_PM_EXIT) {
> +	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
>  		if (gic_dist_security_disabled())
>  			gic_enable_redist(true);
>  		gic_cpu_sys_reg_init();

static int gic_cpu_pm_notifier(struct notifier_block *self,
			       unsigned long cmd, void *v)
{
	if (cmd == CPU_PM_EXIT) {
		if (gic_dist_security_disabled())
			gic_enable_redist(true);
		gic_cpu_sys_reg_init();
	} else if (cmd == CPU_PM_ENTER && gic_dist_security_disabled()) {
		gic_write_grpen1(0);
		gic_enable_redist(false);
	}
	return NOTIFY_OK;
}

During CPU_PM_ENTER notification, we are not doing anything for the
!gic_dist_security_disabled() case. Since CPU_PM_ENTER_FAILED notification
arrive when CPU fails to power down, do we need to reinitialize the
system registers? IOW, should we do different handling for CPU_PM_ENTER_FAILED
based on gic_dist_security_disabled()?

Thanks,
Pavan

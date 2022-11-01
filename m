Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A346143E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAEa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAEa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:30:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECA65AE;
        Mon, 31 Oct 2022 21:30:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A10lfwl028121;
        Tue, 1 Nov 2022 04:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hoLgRDiYK5RzZsmXZv+AE8Nv4CBVihWdG2Zj2F4b9qE=;
 b=X9YeOo5rFX26axeoWrB3gIc5q/gOcTai2rotHSCXQuakHfnBUvapvbRf4nSO+LWYc8st
 /PIXrooHhdNwPoCcHDMxcaBCzfy05320N0/t8wNFgxN5jGjdH/8c51k8wxEEj6O+Jpur
 jiKDMchopsxacdNBj77uSrF+cjLOFv040F8XrqpJRLwaRQmWquFepZxL/Rnpx4MokjIu
 OTjKzekdtGMVrqWaEzoSTUPiKt9ZnRiKEY3kR++dodvK+hI5rpt+6VayjgnbvrwoxByN
 ZZhlqf+R8ZfKpHW9nWPtxbZkEiKz/zDnz0asSF7Jh4mbJ2JJvr0BFmumRM5CXeG44w9Y Yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjs7u0ga8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 04:30:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A14UrHF002603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Nov 2022 04:30:53 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 31 Oct 2022 21:30:51 -0700
Date:   Tue, 1 Nov 2022 10:00:47 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Maria Yu <quic_aiquny@quicinc.com>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: core: Make p->state in order in
 pinctrl_commit_state
Message-ID: <20221101043047.GA11893@hu-pkondeti-hyd.qualcomm.com>
References: <20221027065408.36977-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221027065408.36977-1-quic_aiquny@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3lYQlVNmjcghFKlJCLwUc3qRM7wHJgYr
X-Proofpoint-ORIG-GUID: 3lYQlVNmjcghFKlJCLwUc3qRM7wHJgYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_01,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maria,

On Thu, Oct 27, 2022 at 02:54:08PM +0800, Maria Yu wrote:
> We've got a dump that current cpu is in pinctrl_commit_state, the
> old_state != p->state while the stack is still in the process of
> pinmux_disable_setting. So it means even if the current p->state is
> changed in new state, the settings are not yet up-to-date enabled
> complete yet.
> 
> Currently p->state in different value to synchronize the
> pinctrl_commit_state behaviors. The p->state will have transaction like
> old_state -> NULL -> new_state. When in old_state, it will try to
> disable all the all state settings. And when after new state settings
> enabled, p->state will changed to the new state after that. So use
> smp_mb to synchronize the p->state variable and the settings in order.
> ---
>  drivers/pinctrl/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index 9e57f4c62e60..cd917a5b1a0a 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -1256,6 +1256,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>  		}
>  	}
>  
> +	smp_mb();
>  	p->state = NULL;
>  
>  	/* Apply all the settings for the new state - pinmux first */
> @@ -1305,6 +1306,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>  			pinctrl_link_add(setting->pctldev, p->dev);
>  	}
>  
> +	smp_mb();
>  	p->state = state;
>  

From your commit description, are you inferring that this p->state assignment
re-ordered wrt pinmux_disable_setting()? btw, I don't see any locking that
protects concurrent access to p->state modifications. For whatever reasons, if
a client makes concurrent calls to pinctrl_select_state(), we can land up in
the situation, you are seeing. correct?

Thanks,
Pavan

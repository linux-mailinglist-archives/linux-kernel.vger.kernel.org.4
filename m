Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57981733398
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbjFPObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjFPObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:31:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9A30EA;
        Fri, 16 Jun 2023 07:31:49 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GBxSw8010503;
        Fri, 16 Jun 2023 14:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=QRmknCCl0lyR6k6/V1KGpl6AoQ4ICI5UlwGTrZvz4To=;
 b=pE/KKLIhPKKiLUJlYeVVT3elSWg1+23LzAmu9rP7A7hfsv94qgLKDm4RAIIhtBM7vNBy
 jLN8ZeuhyC/WdRYDLdsBX9HrNum99vyh6jIGdwhl+NxutJ3ApqrgXZisp7pDIFlJ7KN/
 Cs6I/nl4Ninpl3uyX8HnZ/Jkb2lENFPUsp4P5qIqkf0QWfHlTwBfzC9bAcwZtS3xpzNy
 2hYzhQRMD6eADIcCa24lEO5TOEl4UtHKR+1JTD/E2E5A34yYhO+4oYBmXc9Ma8AHMvX+
 CkrvP7sH0uuZlrFe65SEPh3K38dNzKnI9rCFqHkMu/p3Or4huW5Ekq1S6WN/qEZhGY/g aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8axuhm56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 14:31:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GEVhQ5016770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 14:31:43 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 07:31:42 -0700
Date:   Fri, 16 Jun 2023 07:31:41 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] OPP: pstate is only valid for genpd OPP tables
Message-ID: <20230616143141.GA4034918@hu-bjorande-lv.qualcomm.com>
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
 <lmdbpkttrawedkozfo5exh27jlj3hisulnk4zj6s2mv66yzr6n@zegr4pdzz3pn>
 <20230616061830.fysc7l7jxymmhb3m@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616061830.fysc7l7jxymmhb3m@vireshk-i7>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AEyPOpUW9-w_HsjkonvDjZ9RZxiG1_M3
X-Proofpoint-GUID: AEyPOpUW9-w_HsjkonvDjZ9RZxiG1_M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:48:30AM +0530, Viresh Kumar wrote:
> On 15-06-23, 18:35, Bjorn Andersson wrote:
> > On Wed, Jun 14, 2023 at 04:07:25PM +0530, Viresh Kumar wrote:
> > > It is not very clear right now that the `pstate` field is only valid for
> > > genpd OPP tables and not consumer tables. And there is no checking for
> > > the same at various places.
> > > 
> > > Add checks in place to verify that and make it clear to the reader.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/opp/core.c    | 18 ++++++++++++++++--
> > >  drivers/opp/debugfs.c |  4 +++-
> > >  drivers/opp/of.c      |  6 ++++++
> > >  3 files changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > [..]
> > > @@ -2686,6 +2694,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> > >  	int dest_pstate = -EINVAL;
> > >  	int i;
> > >  
> > > +	/* Both OPP tables must belong to genpds */
> > > +	if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
> > 
> > I have a platform_device, with a required-opps and with an associated
> > genpd which does not implement set_performance_state(), but its parent
> > genpd does.
> > 
> > This results in me arriving here with src_table of NULL, and boom...
> > 
> > 
> > Looking at the very next statement in this function, it seems arriving
> > here without src_table was valid up until this change.
> 
> Fixed as:
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 48ddd72d2c71..3f46e499d615 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2694,12 +2694,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         int dest_pstate = -EINVAL;
>         int i;
> 
> -       /* Both OPP tables must belong to genpds */
> -       if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
> -               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
> -               return -EINVAL;
> -       }
> -
>         /*
>          * Normally the src_table will have the "required_opps" property set to
>          * point to one of the OPPs in the dst_table, but in some cases the
> @@ -2710,6 +2704,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         if (!src_table || !src_table->required_opp_count)
>                 return pstate;
> 
> +       /* Both OPP tables must belong to genpds */
> +       if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
> +               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
> +               return -EINVAL;
> +       }
> +
>         /* required-opps not fully initialized yet */
>         if (lazy_linking_pending(src_table))
>                 return -EBUSY;
> 
> Thanks.
> 

Looks good, thanks for the quick response.

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

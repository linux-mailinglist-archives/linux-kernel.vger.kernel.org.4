Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2F732735
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbjFPGSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjFPGSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:18:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46172268C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:18:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666b73777cfso164053b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686896313; x=1689488313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33axWVpAdkybJSty7OAw0pClQ78I+2x7otiVEbb6t44=;
        b=ZnfE0GV4mcmm7BP3JOS+Ma0UW+aZBWS0f8J1N4j3bZnOPgsK1X7zTehNC6OJMuJr52
         2rfqpjXI7MlNp6IevG5WE5WuiO/RvLI+VRD2elw3ZUtoPp8fk+TJOHaH+tQm1K8JlOY7
         ig4+bQ5sO3EakzS6U1jie8BdEDZzlR7ElAIwW68V214j+SdiA2J802W80wK65Z0R2zsr
         572JiurWUWq83O+KPH9SDHvE776a+12lIz5zIH2YX1BsVLszkZRoLbretycn4VLFgsi2
         6n5dp+U4S9eH3bB0C7fq8BAhtSbNh5fTVMvjgtQF7JXejfPi9NbmqyAE++ctVkecU+Sx
         D38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686896313; x=1689488313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33axWVpAdkybJSty7OAw0pClQ78I+2x7otiVEbb6t44=;
        b=ejY5y8rclC4s5npQZDIZKg9UgZN8SM4Z6s/zWPOCpuqRevLP7vABwNm1KfeVMM5nnP
         53ETB4UFwE0bpV0lEORWIJ74s6fzOfBFPKHWe3SJO54qH5HILxdhOr7xgpJGhIAhXulw
         zpGI3/RZBzuwHGGygtO40VUYQVimtmxbGM2bSEUgCtl85curulnIFHEi3m7/CI3AGnUe
         gfQ7/dhY2QzE7h8iXi9ylTENWdcrwcJMZyamEVTu2fnT2B4CvFw9y3CpV0pAI1Xp7HP2
         tatCf6NamtY1JgyX30IXh7DjOTe2Bo8jaedN4eBJCHXY1oKTJVo6OkK/nz9HTi2amOfY
         TEiA==
X-Gm-Message-State: AC+VfDz0JULuv22lkuWkbAKNycNwq6bKiRVDpuXf/XVvbJMHL89zjvAA
        dtMTHrZKRLDNrZIYTdweBfG47g==
X-Google-Smtp-Source: ACHHUZ75bqm5EWIC3SKzc9Dh4zfPc3BeEpOPtZp+Ot3ohaui5+DjVGihPR2W5pqWl2nsHyzIwRiJXA==
X-Received: by 2002:a05:6a00:1ace:b0:634:7ba3:d142 with SMTP id f14-20020a056a001ace00b006347ba3d142mr1077339pfv.10.1686896312736;
        Thu, 15 Jun 2023 23:18:32 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b0064d2ad04cccsm511264pfo.175.2023.06.15.23.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:18:32 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:48:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: pstate is only valid for genpd OPP tables
Message-ID: <20230616061830.fysc7l7jxymmhb3m@vireshk-i7>
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
 <lmdbpkttrawedkozfo5exh27jlj3hisulnk4zj6s2mv66yzr6n@zegr4pdzz3pn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lmdbpkttrawedkozfo5exh27jlj3hisulnk4zj6s2mv66yzr6n@zegr4pdzz3pn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-23, 18:35, Bjorn Andersson wrote:
> On Wed, Jun 14, 2023 at 04:07:25PM +0530, Viresh Kumar wrote:
> > It is not very clear right now that the `pstate` field is only valid for
> > genpd OPP tables and not consumer tables. And there is no checking for
> > the same at various places.
> > 
> > Add checks in place to verify that and make it clear to the reader.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/core.c    | 18 ++++++++++++++++--
> >  drivers/opp/debugfs.c |  4 +++-
> >  drivers/opp/of.c      |  6 ++++++
> >  3 files changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> [..]
> > @@ -2686,6 +2694,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> >  	int dest_pstate = -EINVAL;
> >  	int i;
> >  
> > +	/* Both OPP tables must belong to genpds */
> > +	if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
> 
> I have a platform_device, with a required-opps and with an associated
> genpd which does not implement set_performance_state(), but its parent
> genpd does.
> 
> This results in me arriving here with src_table of NULL, and boom...
> 
> 
> Looking at the very next statement in this function, it seems arriving
> here without src_table was valid up until this change.

Fixed as:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 48ddd72d2c71..3f46e499d615 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2694,12 +2694,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
        int dest_pstate = -EINVAL;
        int i;

-       /* Both OPP tables must belong to genpds */
-       if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
-               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
-               return -EINVAL;
-       }
-
        /*
         * Normally the src_table will have the "required_opps" property set to
         * point to one of the OPPs in the dst_table, but in some cases the
@@ -2710,6 +2704,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
        if (!src_table || !src_table->required_opp_count)
                return pstate;

+       /* Both OPP tables must belong to genpds */
+       if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
+               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
+               return -EINVAL;
+       }
+
        /* required-opps not fully initialized yet */
        if (lazy_linking_pending(src_table))
                return -EBUSY;

Thanks.

-- 
viresh

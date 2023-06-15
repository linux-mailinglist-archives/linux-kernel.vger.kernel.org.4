Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6E7323B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbjFOXgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFOXf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2EB3;
        Thu, 15 Jun 2023 16:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F23F61A74;
        Thu, 15 Jun 2023 23:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC689C433C0;
        Thu, 15 Jun 2023 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686872156;
        bh=Fvk5Dc9K0rFsG6EAHYFj3OY5iRKxvUDW3ss1RR11yBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH15AYzP+pzlTa81fcWg4skrONtIm9GVkLZfw26IH0TX44xUAUc0ROJ60Vcw12I1P
         3/q1yqlwaNnx254o4igPuRwhViIhXZ7l/QHYkKKwbAv4aZxB1cMr/prUS+VtFf+Gzo
         nG5igMmC1IIwp0pVTCC5/jf6hxJhbAP8ig+AwMW7y1kipwycUIyOCpR0HTjoWQ1Sup
         CBz0J8BaccwXzC53F6JiCdnjWkPm4TC7w3j5If8pnZYt1DPW7tSDM5qWBiIgB6nZI4
         oMGyRtLjKP45CJBSb3295Li4zaki16jnM4ex55TvoEiImsnqVSulPYAp4EbqmcdRlA
         TmRJPSK/HE0mg==
Date:   Thu, 15 Jun 2023 18:35:53 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: pstate is only valid for genpd OPP tables
Message-ID: <lmdbpkttrawedkozfo5exh27jlj3hisulnk4zj6s2mv66yzr6n@zegr4pdzz3pn>
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:07:25PM +0530, Viresh Kumar wrote:
> It is not very clear right now that the `pstate` field is only valid for
> genpd OPP tables and not consumer tables. And there is no checking for
> the same at various places.
> 
> Add checks in place to verify that and make it clear to the reader.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c    | 18 ++++++++++++++++--
>  drivers/opp/debugfs.c |  4 +++-
>  drivers/opp/of.c      |  6 ++++++
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
[..]
> @@ -2686,6 +2694,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>  	int dest_pstate = -EINVAL;
>  	int i;
>  
> +	/* Both OPP tables must belong to genpds */
> +	if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {

I have a platform_device, with a required-opps and with an associated
genpd which does not implement set_performance_state(), but its parent
genpd does.

This results in me arriving here with src_table of NULL, and boom...


Looking at the very next statement in this function, it seems arriving
here without src_table was valid up until this change.

Regards,
Bjorn

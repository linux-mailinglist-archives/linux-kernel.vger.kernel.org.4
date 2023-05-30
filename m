Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56FB71588E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjE3IcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjE3IcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:32:01 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3665B0;
        Tue, 30 May 2023 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=xxZiuTwjLOZE6OJVRI8BOAJnaeWqlQ7edowHad2fcVc=; b=R5wIjQrLvjYY7D/iqXCshIqAwj
        h0AhxKvT+FoY/KsdQm7aaEQahuzBhYl1YyhJ3RVpk2qJeT/A72T1ZfbSnNLDJFw+eyeoXdrRGNCvz
        dpVeD3bh5KRjebQi+hYomrZmiOp9b+5PDV+gViI4jMcePuXL44sXqmhQDAdnM56y7WRdAeEdnT1FW
        YisBpnv35Csu8rtDBOyX+nPNa4pXBnr0ob3L4IP8JytQP0CFHZ3xzujxMT1ZmvLpHGbAxXrTOg2gv
        7LqKHolRTTkhrwzKzNg9fgWNtH4l7KlThTY04bdtTeW/VWxQV8xij/OU2DqPBSpVm8bv6BKEQv6EH
        ia0o9aeg==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q3uli-003bTB-WA; Tue, 30 May 2023 10:31:51 +0200
Date:   Tue, 30 May 2023 10:31:44 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
Message-ID: <ZHW0YY4xoUmR_UPg@kernkonzept.com>
References: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
 <20230529053148.xuhuv6skg2xqworr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529053148.xuhuv6skg2xqworr@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:01:48AM +0530, Viresh Kumar wrote:
> On 24-05-23, 19:56, Stephan Gerhold wrote:
> > When dev_pm_opp_of_find_icc_paths() in _allocate_opp_table() returns
> > -EPROBE_DEFER, the opp_table is freed again, to wait until all the
> > interconnect paths are available.
> > 
> > However, if the OPP table is using required-opps then it may already
> > have been added to the global lazy_opp_tables list. The error path
> > does not remove the opp_table from the list again.
> > 
> > This can cause crashes later when the provider of the required-opps
> > is added, since we will iterate over OPP tables that have already been
> > freed. E.g.:
> > 
> >   Unable to handle kernel NULL pointer dereference when read
> >   CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-rc3
> >   PC is at _of_add_opp_table_v2 (include/linux/of.h:949
> >   drivers/opp/of.c:98 drivers/opp/of.c:344 drivers/opp/of.c:404
> >   drivers/opp/of.c:1032) -> lazy_link_required_opp_table()
> > 
> > Fix this by removing the opp_table from the list before freeing it.
> 
> I think you need this instead:
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 954c94865cf5..b5973fefdfd8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1358,7 +1358,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>         return opp_table;
> 
>  remove_opp_dev:
> +       _of_clear_opp_table(opp_table);
>         _remove_opp_dev(opp_dev, opp_table);
> +       mutex_destroy(&opp_table->genpd_virt_dev_lock);
> +       mutex_destroy(&opp_table->lock);
>  err:
>         kfree(opp_table);
>         return ERR_PTR(ret);
> 

Thanks, this seems to fix the crash as well. Are you going to handle it
or should I send a v2 with this diff?

> > Cc: stable@vger.kernel.org
> > Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> > This fixes the crash I ran into after adding an OPP table with
> > both "required-opps" and interconnect paths (opp-peak-kBps).
> > 
> > By the way, the "lazy_opp_tables" does not seem to be protected by any
> > locks(?)
> 
> It is always accessed with opp_table_lock held I believe.
> 

During _allocate_opp_table() it's accessed without the opp_table_lock,
because of

	/* Drop the lock to reduce the size of critical section */
	mutex_unlock(&opp_table_lock);

	if (opp_table) {
		/* ... */
		mutex_lock(&opp_table_lock);
	} else {
		opp_table = _allocate_opp_table(dev, index);

		mutex_lock(&opp_table_lock);
		/* ... */
	}

This doesn't seem to cause any problems in my case though so it's
unrelated to the crash I observed.

Thanks,
Stephan
-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

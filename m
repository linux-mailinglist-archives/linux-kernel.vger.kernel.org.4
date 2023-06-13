Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311572E3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjFMNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbjFMNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:01:34 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806019B1;
        Tue, 13 Jun 2023 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=xL3SKjwiHCpd8kLBPoRyAkV9GFKfhsegjy/weRwTSYw=; b=TMoFAiN5y9di+xneXdNc+1XQyA
        Oebum0Mk/l6qXAeAGIeqG01E6iM+kAZpnABB0/jimSicC2ILv1Dp0YQaNxVMJ9+y/5GikO646vewT
        6UovqZo+xJL3b0fHB3FqTM2StsR8WVwaIgnV/ybjbSUVUyrRb6nw7G2Vxzrx9Zh9mf4nKReYZPrX2
        ZSk7X7UzwxkRXTyAI0OF0wS4JwtoucggNdajvWHsuTCmI+0TtHwFR9UY6JxuMpvQdUu2ENS2LjqgJ
        AhdMxPfpws8vMFJYmprFE/xRVJ4pkV56pnhD4c21aLjoIiZXiUvaoebtgxHqZdxT9Ar9niur5MxKa
        t0MT18zg==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q93e2-000zHL-NE; Tue, 13 Jun 2023 15:01:10 +0200
Date:   Tue, 13 Jun 2023 15:01:02 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Protect `lazy_opp_tables` list with
 `opp_table_lock`
Message-ID: <ZIhojuakyEUct7YN@kernkonzept.com>
References: <167eb2bd947d9c04b0f6f1a5495ce4a99eeab598.1686210112.git.viresh.kumar@linaro.org>
 <c0bac65236cf77fa8ac17c2645449544b73a0104.1686210112.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bac65236cf77fa8ac17c2645449544b73a0104.1686210112.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:13:23PM +0530, Viresh Kumar wrote:
> The `opp_table_lock` lock is already used to protect the list elsewhere,
> use it while adding or removing entries from it.
> 
> Reported-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Stephan: Can you please give this a try ?

Thanks, works fine for me. (Note that I don't have any races or
corruption without this patch either so the testing result might
not mean too much.) The patch also looks good!

Tested-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

> 
>  drivers/opp/of.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c740a907ef76..ac2179d5da4c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -21,7 +21,7 @@
>  
>  #include "opp.h"
>  
> -/* OPP tables with uninitialized required OPPs */
> +/* OPP tables with uninitialized required OPPs, protected by opp_table_lock */
>  static LIST_HEAD(lazy_opp_tables);
>  
>  /*
> @@ -148,7 +148,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  
>  	opp_table->required_opp_count = 0;
>  	opp_table->required_opp_tables = NULL;
> +
> +	mutex_lock(&opp_table_lock);
>  	list_del(&opp_table->lazy);
> +	mutex_unlock(&opp_table_lock);
>  }
>  
>  /*
> @@ -197,8 +200,15 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	}
>  
>  	/* Let's do the linking later on */
> -	if (lazy)
> +	if (lazy) {
> +		/*
> +		 * The OPP table is not held while allocating the table, take it
> +		 * now to avoid corruption to the lazy_opp_tables list.
> +		 */
> +		mutex_lock(&opp_table_lock);
>  		list_add(&opp_table->lazy, &lazy_opp_tables);
> +		mutex_unlock(&opp_table_lock);
> +	}
>  	else
>  		_update_set_required_opps(opp_table);
>  
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

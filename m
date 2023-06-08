Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27B7276C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjFHFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjFHFeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:34:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D34E4D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:34:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b011cffe7fso472175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 22:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686202489; x=1688794489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi3h3STrD8nAW7/sg6jcuBzQ5Kz2zlpfMrjH0c93LuE=;
        b=t3Csx9jDOUGENAtJPJP0Bujqdp02H1al9yUYvJhgfDb5TYN7yPNiQ53mifoKoBQSW5
         XRL+1BDN4BBdaz+F7j6Aa1TZIrEPMH2IfCi3aAXWrJ81JqsUDN3lTE3vYclFSkSXXjyh
         rT4rlUEHxODl6nFE7lQ9QRPdETQq+FfWZbXW9Ef8hBjDhSzU5Q+hsZQ3y3mZw5WdyiEH
         EuP0B60BiEtYEJB8UbFkBEWBk9qNx7XLg6SHllGl3V8yyCA57+kRlalVsRMjU0Px0CN+
         u2zfS0lftayqESTQ4rUk9VUlYnB7df1oDDteQQ+siDAqVIQ9c6TBIS+sXcn5Yzi2P3xV
         +iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686202489; x=1688794489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi3h3STrD8nAW7/sg6jcuBzQ5Kz2zlpfMrjH0c93LuE=;
        b=Cr3YkwZfY04cjd6oaayi5jawRdqRFjTwGjhpSOT1j6U4/eijIIFm8IIxbjNosaMLt+
         73bFArkBfLZ+YJFGauHosbI1NmpSWDtfgtXZArAc8wTDgtVwECxyr7k9uKX16HaDIiXq
         fz4+BzR5DbGA4VElRnO7hWhP7Bej1mOStOocM+WLqUfvoc1uqNB3PZZqVGmniXkZLlO0
         qjt/yHTcyWEEZrddCbEu29N74uaRrzUzvuj2q0v2ngO1FU9IgAliT0xQg3jwC28VtYi3
         vB2EgRsoqNmfoaWzldqPZcmaIolidR/t1K0R6ITgZB+SkTQ1CWtU+ndBKEIxyzFrJGkO
         El4A==
X-Gm-Message-State: AC+VfDyvlOM3uf0gJgk12auRuIZqUDat0z9E8RPMvxfSlgdHDsEgE/su
        GNKnI/WlqFJdJ4DZwanHmXJLlg==
X-Google-Smtp-Source: ACHHUZ69DUeIZySrAUAki+m1E/uiJQzSlLA8X20Zfy3gPcqX9L/hc9WeD08FTtkNJ1y0TBB4FQQQgg==
X-Received: by 2002:a17:903:493:b0:1ae:55c8:6b60 with SMTP id jj19-20020a170903049300b001ae55c86b60mr3174132plb.1.1686202488870;
        Wed, 07 Jun 2023 22:34:48 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b00199203a4fa3sm446622plt.203.2023.06.07.22.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:34:48 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:04:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider
 support
Message-ID: <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124628.157465-14-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-23, 14:46, Ulf Hansson wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 79b4b44ced3e..81a3418e2eaf 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1112,6 +1112,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  			return ret;
>  		}
>  
> +		if (opp->provider == DEV_PM_OPP_TYPE_GENPD) {
> +			ret = dev_pm_genpd_set_performance_state(dev, opp->level);
> +			if (ret) {
> +				dev_err(dev, "Failed to set performance level: %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +

I don't like this :)

We already have these calls in place from within _set_required_opps(), and we
should try to get this done in a way that those calls themselves get the
performance state configured.

-- 
viresh

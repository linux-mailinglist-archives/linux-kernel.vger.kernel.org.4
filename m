Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB4602989
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJRKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJRKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988C6AE200;
        Tue, 18 Oct 2022 03:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3350961509;
        Tue, 18 Oct 2022 10:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E444C433D6;
        Tue, 18 Oct 2022 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666089936;
        bh=YRTmL5xkaTfmRIDMwKf4sITaZkX+1CA1Gi17Z9hNhhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9DQEQIeYvuOr94UHcB8/w6+XKlbTtNHsCfGxKmNYFsMe/R4ksbgiBMyrSgsW7z6g
         NGPv1qyKxl/iHZ2jE9gYnUx35636+z/DmQbfI7N9dnZPigNKo1igrJJ58UTiJJi+MC
         aKD2aq/R1XDPIM7PH89BO5P843aAts8+0oXbHfwNQHdWmdzL+Vm8KCQqITKQTF3i9Y
         YGNPmhY4kXs2oZc/YKSKP2c3Hca02EssGU625oIgzzId9xqUwpoivjwm2b1TZU/02+
         qAqvywdhMQkGOFjFnnIpAf03ulX1tWFKdBxHhPVNybX3ypLzbfF0a5C864MVivCwxM
         LsclmgRus5e/A==
Date:   Tue, 18 Oct 2022 12:45:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Message-ID: <20221018104533.GC1166572@lothringen>
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018013906.3890007-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> When enable CONFIG_PROVE_RCU and built modules, the following
> error appear:
> 
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> 
> This commit fix it by exporting the srcu_check_nmi_safety().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Paul, whichever way you prefer, editing the commit or adding this
one on top.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

> ---
>  kernel/rcu/srcutree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 382236dd5e46..bcd629f5f902 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  	}
>  	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
>  }
> +EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
>  #endif /* CONFIG_PROVE_RCU */
>  
>  /*
> -- 
> 2.25.1
> 

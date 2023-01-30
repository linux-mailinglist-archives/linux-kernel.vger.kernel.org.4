Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFB6813FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjA3PA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbjA3PA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:00:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086C1DB97
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:00:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so19438982lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9flGG7hLPl+f0Bqit/Q9K1nyhUDfEEywIAWrZa8U+I=;
        b=yDu7O3L4w145aQfIK8WzTBC5TLyNo598BQ+AOSvadpEmPKuIRZ48IgdNP0FzbZZqxR
         wbNqkKJkbGDIfk8vPkgz/ajLbQWoO9UW/uRAeBrR8Bsz3YnAWOTw56dTr1PKE+6da2yA
         iXWE+ydY2KP8gNN8LJvPDLbE2uQ9ITXrBAU4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9flGG7hLPl+f0Bqit/Q9K1nyhUDfEEywIAWrZa8U+I=;
        b=refz4wtM0Z3g08UMVuDBr7KJ4c/hBSlkBWvyKY6s7tLf+xMSIg5yHXrQUgpWx9wUdV
         7d199nPHfRGRUYHCwBzvhedaxer8ostqpBFKGagYhVRJ22sfrvuHnC4HCvnS6fn5avnK
         dNmTBrY6l32I5dZwlloKEFn/TV+aQ8sk3lT5NFv7lrUgrtmBsGmuT7xm7VvYC2pLnlXU
         G8jcHF8io6vmUWK5Y+sW655bBUdMX30o9qTeK33HubdB4vCY3tBeX+Rd1MqPJCrbNwhF
         KkeS1y0EUU2lskGwCCpxI36htDyuDT12WnhFxeJSM3JHK9U4vkDuia255y8PXxgLoYje
         mCnw==
X-Gm-Message-State: AO0yUKXrKbqcWgbzCmA6Zg7+oW9u+oq5qPZXIqyVndHdItL0mVXYJYCy
        vG5a+SlHhV3YsOCsZLY2YXEm3aMOu+8e702naK5as/tzloI89g==
X-Google-Smtp-Source: AK7set9mxZT5Aw8/FIVawoszhEYIKruznGmUEbQiD1mCtpFb/o7+kDbDlcI+A9ZZ2u6rjXnWbV/aNv8ZmCDLdpKQmGk=
X-Received: by 2002:ac2:4907:0:b0:4d8:767b:8b6b with SMTP id
 n7-20020ac24907000000b004d8767b8b6bmr69963lfi.63.1675090854426; Mon, 30 Jan
 2023 07:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20230130071737.2806534-1-qiang1.zhang@intel.com>
In-Reply-To: <20230130071737.2806534-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 30 Jan 2023 10:00:42 -0500
Message-ID: <CAEXW_YRUV_P7oEbtkRdKyRGcrWjkr9331SD4ymw_7q-54Ggx7A@mail.gmail.com>
Subject: Re: [PATCH] rcu: Register rcu-lazy shrinker only CONFIG_RCU_LAZY is enabled
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 2:12 AM Zqiang <qiang1.zhang@intel.com> wrote:
>
> The rcu-lazy shrinker is registered without CONFIG_RCU_LAZY enabled
> is meaningless, this commit therefore make rcu-lazy shrinker is
> registered only when CONFIG_RCU_LAZY is enabled.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.

> ---
>  kernel/rcu/tree_nocb.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9e1c8caec5ce..28c1c092817b 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>
> +#ifdef CONFIG_RCU_LAZY
>  static unsigned long
>  lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> @@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
>         .batch = 0,
>         .seeks = DEFAULT_SEEKS,
>  };
> +#endif
>
>  void __init rcu_init_nohz(void)
>  {
> @@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
>         if (!rcu_state.nocb_is_setup)
>                 return;
>
> +#ifdef CONFIG_RCU_LAZY
>         if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
>                 pr_err("Failed to register lazy_rcu shrinker!\n");
> +#endif
>
>         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>                 pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> --
> 2.25.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEE68A03E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjBCR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjBCR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:29:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F5A6423
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:29:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v17so8775278lfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbZhNZQfkIpMP3YzG3dViPJP0EAHEBqEBfOn7DzU4C4=;
        b=sC6yxmoSi5fDh8bWdU6NyBaZ/sLegU3FRbI830WHNsLFzdvdMouJyOIXj6dRWi4F6a
         +/tl9mGxD/a4DylYifBw1y3K0tUXp2t3Y2bJiryE1JBIEosf+eLQhX4DfIsjokAtPN25
         Lejq+/E7oLILfnlfWk3LK8s1VS5LWCUstPfVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbZhNZQfkIpMP3YzG3dViPJP0EAHEBqEBfOn7DzU4C4=;
        b=7epdAt6JffQ4kTUeiRUjsDoM5mGEBb3XiPe+1waYY9ZjjDLOTO1Rhg3LMd39wXMZox
         MLmhDtGvoQLdGPHeBEv72NIEm8n2Rzyp4MHrAeOrI6FfWXq+yoDy/6yjloVqhyqVD23H
         cWYre3Kfk4Vq4MATSdQKS8fKUX5UxuZROH7YT3G2ST1pubZ8rDxl+/Tn+JSLkAvRyBa7
         c1FKbxbqAZ5EmXUsnrfC09sK8fv1yjvaGIMuzyzKSym5aXiJR51VYOlkmABF3ps2iTi5
         8DRge2eUV6okmFjp3xwmWtNC9fnD6rh27uP/zJ0NAGIFmfp4j1/uSdaQYN7m9CqQWPeu
         2Z7Q==
X-Gm-Message-State: AO0yUKUxXIj2/ZWVv73TSiqIKjboP7H+QY/xoJyLWuWKT+FvQ7ijmTRI
        PjvQEQRYhv9Ll+5mQBXksJHszTWfTXGX2lcZrJAt10YbcOJX+q/E
X-Google-Smtp-Source: AK7set+K8TmFkonfZbIlxcE44JhCs6CiwIjF/8RGcS3EsEy3I9ZDNXFKR5+xqymjROhNrKL6+7kuBS/a31z3XjX+YX8=
X-Received: by 2002:a05:6512:374c:b0:4b6:f2a8:884e with SMTP id
 a12-20020a056512374c00b004b6f2a8884emr1965786lfs.191.1675445375147; Fri, 03
 Feb 2023 09:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20230203064054.3418539-1-qiang1.zhang@intel.com>
In-Reply-To: <20230203064054.3418539-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 3 Feb 2023 12:29:23 -0500
Message-ID: <CAEXW_YR3F+hb4hWuaONM4qCqAkH_6MMBWKAaK7b2TAzodKhz8g@mail.gmail.com>
Subject: Re: [PATCH v4] rcutorture: Create nocb tasks only for rcu testing and
 CONFIG_RCU_NOCB_CPU=y kernel
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

On Fri, Feb 3, 2023 at 1:35 AM Zqiang <qiang1.zhang@intel.com> wrote:
>
> When setting nocbs_nthreads to start rcutorture test with a non-zero value,
> the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
> to toggle CPU's callback-offload state, but this is meaningless for non-rcu
> testing or CONFIG_RCU_NOCB_CPU=n kernel create nocb tasks to periodically
> toggle CPU's callback-offload state and adds unnecessary testing overhead.
>
> This commit therefore add checks for cur_ops types and CONFIG_RCU_NOCB_CPU
> options when nocbs_nthreads is non-zero to avoid unnecessary nocb task
> creation.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/rcutorture.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 297da28ce92d..d01127e0e8cd 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3708,6 +3708,12 @@ rcu_torture_init(void)
>                 pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
>                 fqs_duration = 0;
>         }
> +       if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
> +                                       !IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
> +               pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
> +                               cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
> +               nocbs_nthreads = 0;
> +       }
>         if (cur_ops->init)
>                 cur_ops->init();
>
> --
> 2.25.1
>

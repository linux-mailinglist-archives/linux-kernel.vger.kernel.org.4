Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A936BF4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:16:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F803A4DB;
        Fri, 17 Mar 2023 15:16:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so6732513pjp.1;
        Fri, 17 Mar 2023 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679091384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmDs8RJ+PZJLRT42fwa/YYu6afWrb1yUlxIHwxmYAWU=;
        b=W2ubJ7KO1+SGwZ4iqpDKSfg3qLC/Kj4KtWLIBE6u7NwCLzEzfGARy27RkqJvWem53j
         h5XJzUTXVZctcQf9JzxBHTb2TqgpThw/rS9HHa9f/wTVrKE7mG5Dtg9bqHJEv0E1/9Ev
         VflMtC4CiSQbhQw1lOWxI5BygSyUmPJoEJxLBMtdZs+mHbjhvxixIMWmeYBxvS2I1jb3
         4D6lZahKkeUQNlQCwxCg93wmK519PKaz+QcrCIOgQ9RMcZrYVCFb9FB/9LZfFMTK94Pk
         FGSoWPpsTwbAIMF78n5rB+jyVVrj/ce39TLvB4xdEe5fapzL6w8uqXTFBVq9H2o5apIl
         2LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679091384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmDs8RJ+PZJLRT42fwa/YYu6afWrb1yUlxIHwxmYAWU=;
        b=7NdwbPN0lUG2sAi9THswLS6DiLHlLyav36Gnwchr9hbWe7H2fXvHuDlTqgT3fpDwo5
         jVIZMMWvRnAHxRRYq44Ufl4FIMirHJrdpImzx6tE7QFQVWJd1ogDRmTfKPUYFNFKud+S
         Z/5UVfe4SRCJFa/OpVbjhDsWRwbHMsJonRaq9aOG16vo+8/BoZtHyDaiiVCyo06QHSI0
         jNMSoB/jn+cZpKDHczdjUCTny6vj2liWQsCGiHNT/OGnkQLapIg2TvG+SwN2FAORM84F
         d//GhK52GSmooK9qk32F2RsbwQzoF2ndkTyiaW6rGv4ONsZM+o74WYM/ap6KajmffBcQ
         Qvbw==
X-Gm-Message-State: AO0yUKV/u9zdrSnDMKx0iPu9/kLsOT1416crGmx5TlOqtfHnn72oNytT
        Q6LXCVAspJuR4FF3mVWRT/0=
X-Google-Smtp-Source: AK7set89UPhuSkv0OGSMfnoxaxO3jZLef+XgDHC26amKtSYFKik0rJNh9sdAWSSeIXz8PMJqcyEhzw==
X-Received: by 2002:a17:90b:1c0a:b0:23d:3549:82a8 with SMTP id oc10-20020a17090b1c0a00b0023d354982a8mr9643204pjb.27.1679091384077;
        Fri, 17 Mar 2023 15:16:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gc23-20020a17090b311700b0023f685f7914sm1095218pjb.49.2023.03.17.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:16:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 12:16:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bw365.lee@samsung.com, yw85.kim@samsung.com,
        huijin.park@samsung.com
Subject: Re: [PATCH] workqueue: Introduce show_freeze_workqueues_busy
Message-ID: <ZBTmtiyHpreu2btd@slm.duckdns.org>
References: <CGME20230315130515epcas1p40823f20da586c1b5813b41e66e754309@epcas1p4.samsung.com>
 <1678884357-38253-1-git-send-email-js07.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678884357-38253-1-git-send-email-js07.lee@samsung.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few nits.

On Wed, Mar 15, 2023 at 09:45:57PM +0900, Jungseung Lee wrote:
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 6c1c7e5..590550f 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -93,7 +93,7 @@ static int try_to_freeze_tasks(bool user_only)
>  		       todo - wq_busy, wq_busy);
>  
>  		if (wq_busy)
> -			show_all_workqueues();
> +			show_freeze_workqueues_busy();

Maybe name this show_freezable_workqueues()?

> @@ -5043,7 +5043,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
>  /**
>   * show_all_workqueues - dump workqueue state
>   *
> - * Called from a sysrq handler or try_to_freeze_tasks() and prints out
> + * Called from a sysrq handler and prints out
>   * all busy workqueues and pools.

Can you reflow the comment to 80-col?

> +/**
> + * show_freeze_workqueues_busy - dump freezable workqueue state
> + *
> + * Called from try_to_freeze_tasks() and prints out
> + * all freezable workqueues still busy.

Ditto.

Thanks.

-- 
tejun

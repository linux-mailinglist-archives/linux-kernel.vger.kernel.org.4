Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C4708760
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjERR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjERR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:56:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A010E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:56:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f610c11472so10351851cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684432586; x=1687024586;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P5biNPwYfR18w3NMIiZCFUrhCLe5ppM25LOp2X6CUy8=;
        b=bQml6t32bqkDufFQ/BT60JRW5y6xpyjs4h85onZDSkHQZ4fvE4KllPHdskeUDRmCz1
         lPsuCcCAzK7PCkfD44KNfOssaEGfwoXSxfoK7lpNyNxK240AbQZvvLW/jpAy7ModYAuv
         HD5K6CR6GPOSP4r9SXq5sWY4z3RDQ7LTLKllMEMp3GlvhvQbznwuPSzw1Ejk0qMIPrDt
         J8aP18NAq22sb9WfOvUVc2C/zLSsSN8uXP8zXXTqMBYRoun1IC4KqIesI40AaKjHKaVc
         s2hDD50eBNCX/3otHAuCoRJ8NZy0wYYNqV+xeifER7hFLaVflagmDSj5XQ4MgFvrzsFE
         HDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432586; x=1687024586;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5biNPwYfR18w3NMIiZCFUrhCLe5ppM25LOp2X6CUy8=;
        b=gFnPAOlIL8fBmBhRGA3v7Xef1Dbgzy2G+jb3BUnu6qO1ZhTDHmx/2SfoQ1SXf4UJxT
         7stVQbkqL6VtadJTVlntftFXUqLU80OVM0T3WPQTfi0bwiukug32JISVr1F25zS1qzqy
         1JMDgestdbPMmTvM+0ZsWCQQ2CNSoXF++ZlE7UMi2NJaowgpFYzTaE7ZXzoqGsyaBl0A
         gYIgSK8iVPT0QkPxpXuRz7MD248LeUBN3ZtwxnojMXi2EHNRBREK8E8OwsCaqztGrioN
         CHiiq180Bf6fBQZJM1VW3LS8p+28PMTHzVwRIb3LI1ugeg4V6Rpk6MNvT+bziDk3+tZ2
         JikQ==
X-Gm-Message-State: AC+VfDwuucccICW9QDF5QYHqvouYkDQAAaO72ZKDC7hiWQzewoWszkno
        eZnqc4KHzDCHleSQVDMMOkPd
X-Google-Smtp-Source: ACHHUZ4yhIyFHeMkMSbwLVqL/yKk5RzGeoCchz2DhRf9sIsYcWtyz3QcpFHt8BokPVacWrfrFfqBRA==
X-Received: by 2002:a05:622a:100c:b0:3f5:1865:8d1 with SMTP id d12-20020a05622a100c00b003f5186508d1mr714340qte.59.1684432586535;
        Thu, 18 May 2023 10:56:26 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id f3-20020a05622a114300b003ef59e2b9a6sm655062qty.78.2023.05.18.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:56:26 -0700 (PDT)
Date:   Thu, 18 May 2023 13:56:25 -0400
Message-ID: <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: deprecated fs ocon
References: <20230511123213.722912-1-cgzones@googlemail.com>
In-Reply-To: <20230511123213.722912-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The object context type `fs`, not to be confused with the well used
> object context type `fscon`, was introduced in the initial git commit
> 1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.
> 
> The paper "A Security Policy Configuration for the Security-Enhanced
> Linux" [1] mentions it under `7.2 File System Contexts` but also states:
> 
>     Currently, this configuration is unused.
> 
> The policy statement defining such object contexts is `fscon`, e.g.:
> 
>     fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(system_u:object_r:conB_t,s0)
> 
> It is not documented at selinuxproject.org or in the SELinux notebook
> and not supported by the Reference Policy buildsystem - the statement is
> not properly sorted - and thus not used in the Reference or Fedora
> Policy.
> 
> Print a warning message at policy load for each such object context:
> 
>     SELinux:  void and deprecated fs ocon 02:03
> 
> This topic was initially highlighted by Nicolas Iooss [2].
> 
> [1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
> [2]: https://lore.kernel.org/selinux/CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com/
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 4 ++++
>  security/selinux/ss/policydb.h | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Thanks, this is a nice catch, although some minor suggestions below ...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 97c0074f9312..31b08b34c722 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
>  				if (rc)
>  					goto out;
>  
> +				if (i == OCON_FS)
> +					pr_warn("SELinux:  void and deprecated fs ocon %s\n",
> +						c->u.name);

Instead of having to check if 'i == OCON_FS', why not simply put the
pr_warn() call up in the OCON_FS case block on line ~2249 and let it
continue to fallthrough to the OCON_NETIF block?

>  				rc = context_read_and_validate(&c->context[0], p, fp);
>  				if (rc)
>  					goto out;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index ffc4e7bad205..39cd6222e1a8 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -225,7 +225,7 @@ struct genfs {
>  
>  /* object context array indices */
>  #define OCON_ISID	0 /* initial SIDs */
> -#define OCON_FS		1 /* unlabeled file systems */
> +#define OCON_FS		1 /* unlabeled file systems (deprecated in 6.5) */

Since you are likely re-spinning this (see above), I would just leave
it as "(deprecated)"; those that want to know where it was deprecated
can always check the git log/tags.

>  #define OCON_PORT	2 /* TCP and UDP port numbers */
>  #define OCON_NETIF	3 /* network interfaces */
>  #define OCON_NODE	4 /* nodes */
> -- 
> 2.40.1

--
paul-moore.com

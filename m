Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171F5675A61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjATQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjATQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:46:20 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4CBCE22;
        Fri, 20 Jan 2023 08:46:12 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id hw16so15352838ejc.10;
        Fri, 20 Jan 2023 08:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=312xYwnLz5cacggAuSe9muCPby1Aby9dhCgWb/T+ruM=;
        b=l/oaEG/3ZKYPGvUCdNKR7206bgzz4DMd50LFCOucuBTuCrrR9d4FKIsyBKSNP269vC
         J45hNIsfeKyADwbkrStWew9/vB1w6YNs2VYc6UZ4lXYoezYnMwUUHnk44YTAQHBrN9PW
         X4KunW+OCgz49oCcSUnTX/dDlFJCahBhst+9J2wt6whKbo1C/XCZSl4mkASo/WqKX8Xs
         XlKW3TqFM5qE23fHs6mbcNCdE0rUK09iab8/sDSn4TNAMut/0bGxzp8jFSj+MA4tSV7O
         nmLAcGKQz80kOy/SG4zrUkKgu9jjH0P26WUPihXIUw6Ml2BDp6YlbFJpGvthUncop1cM
         U+pA==
X-Gm-Message-State: AFqh2kraq/hZ9lOspaFw7kxMCPgtD52xnrmGgrCXkrm9JVEL7CdQFexj
        9+4HLcGU1dQaA4bNmlJPWql4xs+vQOySZxciG2g=
X-Google-Smtp-Source: AMrXdXvhb7C0T8m+7x5vnfEhE69z7624giygkvR6JKePgXoVfxAOW9H6Y6jsXeTTooXkOuc0dmUn3M1F+icmGnZYHIU=
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr1216124ejh.78.1674233170685; Fri, 20
 Jan 2023 08:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20230112052453.3365-1-kunyu@nfschina.com>
In-Reply-To: <20230112052453.3365-1-kunyu@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:45:59 +0100
Message-ID: <CAJZ5v0gunKQKOtMz4wOWAkyn1_Q5fGFtyqOWd7Y7=FedWAJikw@mail.gmail.com>
Subject: Re: [PATCH] power: hibernate: optimize function structure
To:     Li kunyu <kunyu@nfschina.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 6:25 AM Li kunyu <kunyu@nfschina.com> wrote:
>
> The goto statement jump is not required at the end of the if statement
> block, because it will be executed to the lower part of the goto
> statement.
>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

The patch itself is OK, but its subject should be something like "PM:
hibernate: x86: Drop unneeded goto statement from arch_resume_nosmt()"
and the changelog should be more precise, for example:

"The last goto statement in arch_resume_nosmt() is not necessary,
because the target label is right next to it."

Please update.

> ---
>  arch/x86/power/hibernate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index 6f955eb1e163..936558c4e821 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -210,8 +210,6 @@ int arch_resume_nosmt(void)
>                 if (ret)
>                         goto out;
>                 ret = cpuhp_smt_disable(old);
> -               if (ret)
> -                       goto out;
>         }
>  out:
>         cpu_hotplug_disable();
> --
> 2.18.2
>

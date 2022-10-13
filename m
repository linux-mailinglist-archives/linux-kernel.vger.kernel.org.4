Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97E5FE5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 01:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMXMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 19:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJMXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:12:03 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A816D8A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 16:12:02 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-360871745b0so31567147b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRapBg1ifNHo1rNSZIfOYVmhwzlN9nPaATTK2xd999E=;
        b=oBSeHd6tYzrdgGaAOmtNUEvZ6hb/5oiq+IEYg6UZTujCOk1CX1Vrhk4jnql+KnyC51
         oi7y6w5w36zQWhSdDw1D4L9ExCuYkQmxyj/li5hPP3WDdkcZctwaW/rSePQR6OrjiVFd
         WabCFaHbyybLAnmE7LX7jGUmILYfb2j+PMRXdotabQDql2MWSwvsUkTJL1p/k+8QMwTU
         lGUUHmD3X9XrMhIiG0tmXP1LBxfD+irxA0BiY8uph4P+yNuAeWM6DfWx3/JfirNSVzNj
         Ud571jcjCLYuRwmQ3PqGgY5ZT49EBSFHnpG2a06j28FjQDPEDRUJ2nN9r4foPoanjSTJ
         P06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRapBg1ifNHo1rNSZIfOYVmhwzlN9nPaATTK2xd999E=;
        b=dZECUtmqMe7dqblwJ9ZEg1XllVk6mPhBS6kDyckYL0RfpfKE6ldY9VrokwU6uSOpGz
         bGe9xq779CN03Aesl/f9c2Utkt+ybNEPngGtjbbdBprctKoBv5zmTxn4u//eQlG6h68q
         xth4q9C+Ko0y/QfhIl/ZRVuTX0ld5SIBgRkPSMONqYR/WbS2rhv3eerqQPSgkupYvVlr
         281/g3RKNTwbAhdOjsKoazJFUWZ38WxGyLYCd4VSPkzj112cuRjS3LbiJ98GkslSvVsQ
         WcDQ7jsOYmLSlJh4d7GTKx2otFAajK999/Xt8VabKWWEQtSs5szi0q0KasniwG1v8cKy
         /ULg==
X-Gm-Message-State: ACrzQf22qd4rsrXcUH5kl3UFZfoMKQNW10tXaCbuhD7xrRdT54vFL/Xw
        VbMmZHACT7bqNfNw0OSaIVANQypdBP0m1NBrpzxw
X-Google-Smtp-Source: AMsMyM6F9MFNMVgJrPw5tCXRJlu6M5uRf+UE0Zr7N7ecstochrV906GL/9PRGmPakJxlfhI6ugY+Kq4lEPffEwGxmXg=
X-Received: by 2002:a81:4e97:0:b0:358:3053:f3cd with SMTP id
 c145-20020a814e97000000b003583053f3cdmr2149129ywb.482.1665702721581; Thu, 13
 Oct 2022 16:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-4-ankur.a.arora@oracle.com> <20221007004943.2910736-1-ankur.a.arora@oracle.com>
In-Reply-To: <20221007004943.2910736-1-ankur.a.arora@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 19:11:50 -0400
Message-ID: <CAHC9VhSnWZ1ovEeajasBPQA0-_AgNW21K2Ycpc3wvSHw5uQZ9Q@mail.gmail.com>
Subject: Re: [PATCH v2] audit: unify audit_filter_{uring(),inode_name(),syscall()}
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com, sgrubb@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 8:49 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> audit_filter_uring(), audit_filter_inode_name() are substantially
> similar to audit_filter_syscall(). Move the core logic to
> __audit_filter_op() which can be parametrized for all three.
>
> On a Skylakex system, getpid() latency (all results aggregated
> across 12 boot cycles):
>
>          Min     Mean    Median   Max      pstdev
>          (ns)    (ns)    (ns)     (ns)
>
>  -    196.63   207.86  206.60  230.98      (+- 3.92%)
>  +    183.73   196.95  192.31  232.49      (+- 6.04%)
>
> Performance counter stats for 'bin/getpid' (3 runs) go from:
>     cycles               805.58  (  +-  4.11% )
>     instructions        1654.11  (  +-   .05% )
>     IPC                    2.06  (  +-  3.39% )
>     branches             430.02  (  +-   .05% )
>     branch-misses          1.55  (  +-  7.09% )
>     L1-dcache-loads      440.01  (  +-   .09% )
>     L1-dcache-load-misses  9.05  (  +- 74.03% )
> to:
>     cycles               765.37  (  +-  6.66% )
>     instructions        1677.07  (  +-  0.04% )
>     IPC                    2.20  (  +-  5.90% )
>     branches             431.10  (  +-  0.04% )
>     branch-misses          1.60  (  +- 11.25% )
>     L1-dcache-loads      521.04  (  +-  0.05% )
>     L1-dcache-load-misses  6.92  (  +- 77.60% )
>
> (Both aggregated over 12 boot cycles.)
>
> The increased L1-dcache-loads are due to some intermediate values now
> coming from the stack.
>
> The improvement in cycles is due to a slightly denser loop (the list
> parameter in the list_for_each_entry_rcu() exit check now comes from
> a register rather than a constant as before.)
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/auditsc.c | 76 +++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 37 deletions(-)

Thanks, this looks good to me.  I'll queue this up for when the merge
window closes.

-- 
paul-moore.com

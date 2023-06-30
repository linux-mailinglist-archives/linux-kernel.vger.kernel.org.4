Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA5743D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF3O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjF3O2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:28:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CA13AAD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:28:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfee66a6398so1660483276.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688135312; x=1690727312;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRMN0RaJzHYAyXMyga4ctoKFK0XbdFwKMcCpI/juWEU=;
        b=am0dqL8tuDa5C5eAHIW+joInjR/a055ifnjo+XJOjG+qcVcc7ILCAG4uVycrP+mFcK
         FAn7/4Eq65Dj34v0YTkD597Txnxmc+yQPxISjWUK0rVlT9d0BVlp9L1X8s3nUnCLaM5/
         gouPMfh60JcbsvPSV6U19hQ1Yf139QyGWx9RbOfUmcfTgQVSrgUU6K2AbQpJnLu9iLO7
         fJs1jOtYs29gobQ1SfpvZJE3vM8gac16O3IHANQE9D6y/hF72mLvpEzVgIxJRx/Kz32Q
         xEJ560pfJvDmiswQ/NIhDKt5VHKXP+GaRT/ApbOWVkNFq+RXhECgD5nn/0xPbotUDJsA
         nUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135312; x=1690727312;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRMN0RaJzHYAyXMyga4ctoKFK0XbdFwKMcCpI/juWEU=;
        b=Y/8PR6xx6ObDdROl7oVqIHPM0OcEM3LcrtkMeRKkChUHHBNDEdVjVhbNPgso88OvMW
         zzj0+0gav3z57yV39e6+HYSJrgBy2J8sFBuwC2Ppofcu1lbAeOW9yxKoWXQ8bx4whLdf
         BZ/Hvc3CdwiHB0ct8LQqlsJ0529ZiYnUBDpeWAnIaA8br06hPk6aqz5MFlMgNu2rZ28M
         uBhyWMmiUgM0mtwGVpCR8ElSWsb3bz0SLjZ2CRw8zTIj3mty4AO/AgEgrEY10q2dnu0R
         qpHoYuLPQstxJZpGjVzgh4+7IiojMQ3OKJBpccqBIuFFaKhx5egRtMVFbfkYtdtHrS0z
         LS5Q==
X-Gm-Message-State: ABy/qLadakyoSrzBEKdWAupbmJmg+pWhHKeDtRXQRWGvUN1/pw/7gDLK
        obPYf8g4GBxWvt3Oe6TO5SOjGd+Zqvs=
X-Google-Smtp-Source: APBJJlHOOLORAgt37+VIRI8/WOvT0fj13Al51joe6mbUicQPhnu539E1jFNneO9sew/vI5ZTflnm86W+tdM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:f602:0:b0:c11:bb8d:75f4 with SMTP id
 t2-20020a25f602000000b00c11bb8d75f4mr17391ybd.8.1688135312230; Fri, 30 Jun
 2023 07:28:32 -0700 (PDT)
Date:   Fri, 30 Jun 2023 07:28:29 -0700
In-Reply-To: <ZJ65CiW0eEL2mGg8@u40bc5e070a0153.ant.amazon.com>
Mime-Version: 1.0
References: <20230504120042.785651-1-rkagan@amazon.de> <ZH6DJ8aFq/LM6Bk9@google.com>
 <CALMp9eS3F08cwUJbKjTRAEL0KyZ=MC==YSH+DW-qsFkNfMpqEQ@mail.gmail.com>
 <ZJ4dmrQSduY8aWap@google.com> <ZJ65CiW0eEL2mGg8@u40bc5e070a0153.ant.amazon.com>
Message-ID: <ZJ7mjdZ8h/RSilFX@google.com>
Subject: Re: [PATCH] KVM: x86: vPMU: truncate counter value to allowed width
From:   Sean Christopherson <seanjc@google.com>
To:     Roman Kagan <rkagan@amazon.de>, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eric Hankland <ehankland@google.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Like Xu <likexu@tencent.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023, Roman Kagan wrote:
> On Thu, Jun 29, 2023 at 05:11:06PM -0700, Sean Christopherson wrote:
> > @@ -74,6 +74,14 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
> >         return counter & pmc_bitmask(pmc);
> >  }
> > 
> > +static inline void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
> > +{
> > +       if (pmc->perf_event && !pmc->is_paused)
> > +               perf_event_set_count(pmc->perf_event, val);
> > +
> > +       pmc->counter = val;
> 
> Doesn't this still have the original problem of storing wider value than
> allowed?

Yes, this was just to fix the counter offset weirdness.  My plan is to apply your
patch on top.  Sorry for not making that clear.  

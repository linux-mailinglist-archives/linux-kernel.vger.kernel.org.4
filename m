Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1D700981
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjELNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjELNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:52:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79413850
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:52:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-305f0491e62so9592663f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683899548; x=1686491548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlqtYj2sIx0sjwwCMtZ7w/k64brEWXitqz4tOF+SKWQ=;
        b=ikM1onuzF3Q2H1SPl3vp3GOfHcQ+i0G5uF9g9tbNOkzp8gBEtd0oUKEFRDxfL9LnOQ
         JfEkQeoEAU2gKgbpS/KjT0ta/VG6CP75xgy7ao5vtDsXQUFAJx6BJwnhlEGOJOAk3d/7
         AptQCENFBIBebQimL+ZHRUT8eDT4YH9BW1UuXCZFa0O4wnqhByXHQrRfylk5N0s2GhLu
         FizGaUOzpuqFK8zQPZN+rchWGEOO1O2TiXromozhQbkYEKO3KW/XF6Hp3jnp1PHSdCg9
         QRYQ05kei/nv3fNKIn0wqzZD6tiarLvKdaHkPrNVweYs7f/SqzE+ot9y5P6EpLG+s98Q
         Is2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899548; x=1686491548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlqtYj2sIx0sjwwCMtZ7w/k64brEWXitqz4tOF+SKWQ=;
        b=RjfjjKZrVE9imRTI2pHzyc3O4PWiBqKwiS98bjFNf0rJ/McZUvpR1IdbFDiWPOxr+l
         WEWZIbvR9LsZbDE9JORPlhmQHP+x7FUfghy8sVOd5hDKLSI/ggOxoCwgFi5golMa5QJj
         nG0sVG84JuwEaITU6d7qMo1YJYsDEL/ZAkcUpM5in4OxyK8M0a0VNm1IlRMwyRi0DV6P
         Z59nxDSnocClc6DOH/5sPYE4FBVX3SFOQMql3QTjW9Qksg45MM7cw5HUlJqqVpjes0p9
         oK8e1/Cgxr9VqqB641CpFttPsXQ9UvrEejy6cNhc7mJaR5BIbd5Aa9Xe7erte8LQ/5qn
         gsaA==
X-Gm-Message-State: AC+VfDwzASPFiGpNEhLhLLuKJ2kPRQ+BO+Esb1xbFUZBNBpahC/j7liE
        JA8n+2AvuSDu7Wb7pG5kUZUGZw==
X-Google-Smtp-Source: ACHHUZ5gks0kesTcYHQGZmDMSB53C9RWSGJ2R9t+vGgAq1ZD4zyk0Htxw3eMp2IcxpNoLZT/HXSQMA==
X-Received: by 2002:a5d:6246:0:b0:2f6:25a6:9788 with SMTP id m6-20020a5d6246000000b002f625a69788mr16443692wrv.35.1683899548461;
        Fri, 12 May 2023 06:52:28 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id i11-20020adff30b000000b0030644bdefd8sm23519775wro.52.2023.05.12.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:52:27 -0700 (PDT)
Date:   Fri, 12 May 2023 14:52:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if
 !CONFIG_KGDB
Message-ID: <20230512135225.GA217187@aspen.lan>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
 <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:34:30AM -0700, Doug Anderson wrote:
> Hi,
>
> On Wed, Apr 19, 2023 at 3:57 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > To save architectures from needing to wrap the call in #ifdefs, add a
> > stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> > handle anything.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v8:
> > - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> >
> >  include/linux/kgdb.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 87713bd390f3..9ce628ee47cc 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
> >  #define dbg_late_init()
> >  static inline void kgdb_panic(const char *msg) {}
> >  static inline void kgdb_free_init_mem(void) { }
> > +static int kgdb_nmicallback(int cpu, void *regs) { return 1; }
>
> FWIW: I just realized that the above needs an "inline" to make the
> compiler not complain. I'm still hoping for more feedback on the
> series, but I'll plan to fix that in the next spin.

On the next spin feel free to add:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

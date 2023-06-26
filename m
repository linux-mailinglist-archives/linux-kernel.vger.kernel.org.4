Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724B73E228
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFZOar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFZOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:30:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287498
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:30:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa71e253f2so39118335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687789841; x=1690381841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOo0XC/Y4flNUsbiJzBoRTnJAgB9VDv1XM+zJzFrca0=;
        b=QsW3/nHLhkexzxGA0twe/x2qW+MofrKWc20XzfvTwk9ZpPAmfEi5ih1e5YIuIT2lNC
         tjzCItcBDxFEFpbD7plDyGkfJ6B6tktDh1RDsc6ybYsCUOAiNzUnoB7b3UCawebRTjP+
         IoVoceQUvr2vN6a2MOQFkk1b5sL3SecejNjv+vqiS03ImU7+AJ6TLazciDLoJy1LmNi/
         QDPMsiuJuIIhwrC2wnDBhy0BD7hQrTbGaXffjQQ/QtmqFhMAfZPpTXoSijvnZwqpNWbS
         O7tcEJhLj/e72X+eQkt3abY6eNBxVugwOG2ALiWE2YSEe8VNPf1Bl5GntO/vsmEX50nc
         9ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789841; x=1690381841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOo0XC/Y4flNUsbiJzBoRTnJAgB9VDv1XM+zJzFrca0=;
        b=ZTyknMNP2t6WJUZgqM7sfDRMdoYJPcvHv8Hq9srkG5AgrsADuSJPDgkua+QIZiJOUW
         XpEfFYHdRvV8794a4mbPAU8vw7jvT/JCnlcaqgpqx3nV2pEgTRrxsVlnE0VvaJTeGHaE
         zMtvRRtf7TWVo7KyEHkVrPhwd2ZTzbLhfEm6T9IePIUTTrq6Y/LtA05OgPc0JS2Osk43
         v5QN6PnAGaDitPlU93e7Qllvw93/MJ6+NDMZrjy7/+eFyrmJuNjZjEGqZBfh9eTRd7rC
         S/6u+hWzuhc24qdyD9rkLseZfKZUSYfovr0jogk6VAnt9NTSUY/tTzmMtlztZJByvDXf
         Fafw==
X-Gm-Message-State: AC+VfDwWkt4F+QixI4n5UmWAcW8narHojQkY0to18myrABy1qoXzvGqs
        fFQBnl3rO38Z6myOCec064Y/Kw==
X-Google-Smtp-Source: ACHHUZ6VWP4raj9cfLAIOeEgLIdxBNSr9wdsVkIQVnyoeIOHSC4oDNzgvxTcgh/C0ZjUg/zNHcMRlg==
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id l17-20020a05600c10d100b003f7a20a561dmr27638549wmd.8.1687789841362;
        Mon, 26 Jun 2023 07:30:41 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b00313f676832bsm1380811wry.93.2023.06.26.07.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:30:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:30:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] kgdb: Provide a stub kgdb_nmicallback() if
 !CONFIG_KGDB
Message-ID: <20230626143038.GB95170@aspen.lan>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
 <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:14:18AM -0700, Doug Anderson wrote:
> Daniel,
>
> On Thu, Jun 1, 2023 at 2:37 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > To save architectures from needing to wrap the call in #ifdefs, add a
> > stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> > handle anything.
> >
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > In v9 this is the only kgdb dependency. I'm assuming it could go
> > through the arm64 tree? If that's not a good idea, we could always
> > change the patch ("arm64: kgdb: Roundup cpus using IPI as NMI") not to
> > depend on it by only calling kgdb_nmicallback() if CONFIG_KGDB is not
> > defined.
> >
> > Changes in v9:
> > - Added missing "inline"
> >
> > Changes in v8:
> > - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> >
> >  include/linux/kgdb.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 258cdde8d356..76e891ee9e37 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -365,5 +365,6 @@ extern void kgdb_free_init_mem(void);
> >  #define dbg_late_init()
> >  static inline void kgdb_panic(const char *msg) {}
> >  static inline void kgdb_free_init_mem(void) { }
> > +static inline int kgdb_nmicallback(int cpu, void *regs) { return 1; }
>
> What do you think about landing just ${SUBJECT} patch in kgdb right
> now so it can end up in v6.5-rc1? It seems like this series is
> currently blocked on Mark getting a spare moment and it seems unlikely
> that'll happen this cycle. If we at least land the kgdb patch then it
> would make things all that much easier to land in the next cycle. The
> kgdb patch feels like it can make sense on its own...

Yes, grabbing this one should be fine!


Daniel.

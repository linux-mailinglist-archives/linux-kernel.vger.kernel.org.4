Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510B731FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFOSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjFOSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:14:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE010F7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:14:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b39bf8d5faso23873461fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686852872; x=1689444872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyNYAJPbrsk4+kV6DyQJsOygOqO+LfaaaEVKNin4xFM=;
        b=FYscYYVsxDxn/+cJkq4UPRu4HqpXyg4D3FwGUrOibNEdKQjSw0euEBZVPfDUR6DCTF
         vkHZnjSJ/0vBEzmEaoZxIeEdLo/1YMK0NSrE6B5UQI7tV6Eo1QmM2WT8kfbMRyFPerTx
         pThLyNJ5QnqnXo4JBtrlmlDufSHgtFuSMHWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852872; x=1689444872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyNYAJPbrsk4+kV6DyQJsOygOqO+LfaaaEVKNin4xFM=;
        b=Gwhh3+KimLgVtp7m7BAR6mAi9hszh3iFxN9eawwkHukQ/wIgBMPJw46TLb6M3AV0IL
         FSO9/KKycGolLck3FHaMdPB5vJ1DHJT6k4HYMfl2+IsQld0XHVMvjYTlPgL2c2jN51lW
         WUG/b5bibou9Gpz0vT2feEpn2KLnvYbmup2dLEuep3/F/7KhH7KYR74qfneL23YvkMol
         Woj1XGbJVfVXfK2hDruNiCgQ6wxdoOOh/VnEFDa9G3FscnWq/VisbIUkuN/Ct9tXyxO9
         s4fICZm7+MwmhR24uDDFqoQYG7upDk5Rf0A/Z7awDpFRD5fN6SPTlCkbxczzskcOSzRL
         yAQQ==
X-Gm-Message-State: AC+VfDyaE8W7k7QJ6NujR1G6uhJtMT5musop9HBqeCdqsJpLranR0fbX
        8ycr/KnhNAsFjIdvnx2eRdxpf7aohK28xPd8/cSvj8Z7
X-Google-Smtp-Source: ACHHUZ7fIZ7LRK/jdPzO0/+fEQCUiCUp8lnL5Ed3zc4ey81RdOGKWepvIA0znjMbEeEjWGSTnQXHFw==
X-Received: by 2002:a2e:9615:0:b0:2ac:7d3b:6312 with SMTP id v21-20020a2e9615000000b002ac7d3b6312mr200774ljh.22.1686852871888;
        Thu, 15 Jun 2023 11:14:31 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7c40a000000b0051a315d6e1bsm233103edq.70.2023.06.15.11.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 11:14:31 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso1447a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:14:31 -0700 (PDT)
X-Received: by 2002:a50:d697:0:b0:510:b2b7:8a78 with SMTP id
 r23-20020a50d697000000b00510b2b78a78mr101415edi.5.1686852871368; Thu, 15 Jun
 2023 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org> <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
In-Reply-To: <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 11:14:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
Message-ID: <CAD=FV=XbnUZh2uQ5Sr3Dg=+Kiz7rfZVyP-zNQtXrV_NSsCTFcA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> To save architectures from needing to wrap the call in #ifdefs, add a
> stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> handle anything.
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> In v9 this is the only kgdb dependency. I'm assuming it could go
> through the arm64 tree? If that's not a good idea, we could always
> change the patch ("arm64: kgdb: Roundup cpus using IPI as NMI") not to
> depend on it by only calling kgdb_nmicallback() if CONFIG_KGDB is not
> defined.
>
> Changes in v9:
> - Added missing "inline"
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
>
>  include/linux/kgdb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 258cdde8d356..76e891ee9e37 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -365,5 +365,6 @@ extern void kgdb_free_init_mem(void);
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
>  static inline void kgdb_free_init_mem(void) { }
> +static inline int kgdb_nmicallback(int cpu, void *regs) { return 1; }

What do you think about landing just ${SUBJECT} patch in kgdb right
now so it can end up in v6.5-rc1? It seems like this series is
currently blocked on Mark getting a spare moment and it seems unlikely
that'll happen this cycle. If we at least land the kgdb patch then it
would make things all that much easier to land in the next cycle. The
kgdb patch feels like it can make sense on its own...

-Doug

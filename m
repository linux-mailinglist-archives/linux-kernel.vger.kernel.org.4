Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D606FF487
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbjEKOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjEKOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:35:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAF11B63
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:34:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7577a91cfd6so261854185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683815686; x=1686407686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDAnVIuo236iFwX8Q4PwBvcDGXZtwfSqujw0bG7p3X0=;
        b=GTmTypfqSNuLbRXk7CoP5u2QhIfP2ABwgsrnyU8SyjwRhri7xhRhiCPlxWYdoU3vL6
         QFPcynxldEMfc6XpkSco9M92VA3cEELBoJbd600audt762yS1ER/PFkDdjZJO4jP2j++
         g4DGXREKQ4yO+KZmco1dWlLLRgejdc3Buw1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815686; x=1686407686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDAnVIuo236iFwX8Q4PwBvcDGXZtwfSqujw0bG7p3X0=;
        b=cDmZ4NXt6IdHzJAGEDOz3hfIrrkfDGIQSevr+Bw7LKnF0Tq9NWoRNYedSldrCuEfxX
         BOtfUpBorIYxnb+mf9YS+Cn9aX13T90PsjAEli7bxE0kHU9rbZ/anC2znSzC5PZ0gUGx
         nzxjYDcv5x2Iny5DmZK/5WkBX1MK5wZi8r/vfeYwjpSSBn71FRs6dua9hKXjQ8FTyuZV
         oDecG/gVvjym+EgaTziinrOw86PLRBwC2V5/WWXyE4zkfY6WgTXqNSdr0e+Bnuamm2vg
         ApGdmm3azjCwDsrRoR+gEs6oT0JNWAkBx/OWGobkd0G/6uZFIMvoamoONzclTIincn2I
         Gjdw==
X-Gm-Message-State: AC+VfDyt5ph1hv+FPA2KdjSpLf1FTnlFPZnZ9tdU0wLfUHblkRe5U+OV
        nEJ+7TkvWDqMP9Qx0qEuWEa8ftnZhxwhrG2xz7YocA==
X-Google-Smtp-Source: ACHHUZ4qOeBrL1ZbcIJTI6KIQPB7dC0axNQ1JT4+TnG0VmMU8yYLVjE9mht0T8HYlVzhqhumlDiYHA==
X-Received: by 2002:a05:6214:e46:b0:621:2641:c656 with SMTP id o6-20020a0562140e4600b006212641c656mr19549867qvc.31.1683815686455;
        Thu, 11 May 2023 07:34:46 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id a3-20020a0cca83000000b00621626c7003sm528747qvk.56.2023.05.11.07.34.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:34:43 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3ef34c49cb9so747821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:34:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1a05:b0:3f3:9c91:fee7 with SMTP id
 f5-20020a05622a1a0500b003f39c91fee7mr421512qtb.16.1683815682956; Thu, 11 May
 2023 07:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
In-Reply-To: <20230419155341.v8.8.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 May 2023 07:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
Message-ID: <CAD=FV=X=tm_smsi9itwK_Ku2vU0d676JT+MK3fkALn5QMsduiQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> To save architectures from needing to wrap the call in #ifdefs, add a
> stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
> handle anything.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
>
>  include/linux/kgdb.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 87713bd390f3..9ce628ee47cc 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -377,5 +377,6 @@ extern void kgdb_free_init_mem(void);
>  #define dbg_late_init()
>  static inline void kgdb_panic(const char *msg) {}
>  static inline void kgdb_free_init_mem(void) { }
> +static int kgdb_nmicallback(int cpu, void *regs) { return 1; }

FWIW: I just realized that the above needs an "inline" to make the
compiler not complain. I'm still hoping for more feedback on the
series, but I'll plan to fix that in the next spin.

-Doug

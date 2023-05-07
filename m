Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B356F9941
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEGPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:20:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C57AA2
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:20:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab0c697c2bso34300705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683472838; x=1686064838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpz7HOvQ4sbM65oc1RHD60Zy17J1MPnakrLeLIsq2CQ=;
        b=M4Z7QCpBi8ZXwuooS/eX+qNSdz3KypQirIzggSbfO50pBYzVJN+m0wXBv0C48wRFV1
         UVfAIs4kKtCF03a3wVYkVgntgNpIV35k4SS4f50751iv5e09msjGB8uN67ZQRxYXhVc3
         r0w4DCYgLzwXafkL2yrZZkrlJUjIJUhaeIHLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472838; x=1686064838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpz7HOvQ4sbM65oc1RHD60Zy17J1MPnakrLeLIsq2CQ=;
        b=dg9Kg3JrdxiELsl1PxbrY1IFV2N9mQ/GVbtp8ip0bBDMtOZogNk/tlGCBoycPxgCjl
         sgnfBeGaOdQpipU4CakxRtk/K5HrXyr0mfkgJMPT+8vcy1IpyAluEZVcHEYt584yL7OA
         4mLFme5EGA2lNhG4eb8zja4JqDs7uSJBjLH5g15VliKWywo46jeBq+ILl+5ayQEBe8bm
         Fh8HwfiDZAvzcQ2CVQEh08XsSfu4iLmwy5mqmETVm1FxtVEiudriDy9jpNDKcagPxqBo
         sDb4jVy1ntQSANflFtWU5wnN+p4myUFOma+NDdRk+9qJSChc7mgtwRW4VHEy9TLdN/HW
         UTTQ==
X-Gm-Message-State: AC+VfDyn8JyjXCt6Hk519ur+6lWTcsiELaHI2uYqhnj0ZFQZyN4cG02E
        uc1iSTqFbGXmJwrOeI6MbzjfQg==
X-Google-Smtp-Source: ACHHUZ5iczZH9IUaSLs91dVgHohXAqrhze6RILukG1s65EnShELl45vuFv2gSidDE+1nOlw5G8yU5A==
X-Received: by 2002:a17:903:48f:b0:1a6:4cbc:14dd with SMTP id jj15-20020a170903048f00b001a64cbc14ddmr7160987plb.8.1683472838646;
        Sun, 07 May 2023 08:20:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001a4fe00a8d4sm5302064plq.90.2023.05.07.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:20:37 -0700 (PDT)
Message-ID: <6457c1c5.170a0220.36712.8d84@mx.google.com>
X-Google-Original-Message-ID: <202305070820.@keescook>
Date:   Sun, 7 May 2023 08:20:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under
 UML
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:33:43PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 7, 2023 at 12:27 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> > running with --altests to gain additional coverage, and by default under
> 
> two L's in alltest?

Oops. Fixed. :)

-- 
Kees Cook

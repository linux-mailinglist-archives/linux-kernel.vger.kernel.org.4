Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC546628BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjAIOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjAIOn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:43:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8E1D0E3;
        Mon,  9 Jan 2023 06:43:28 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c124so8670866ybb.13;
        Mon, 09 Jan 2023 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oOV5umT1eYSPCClB4+myHjuitl4aoXhb6nSLgQO08gk=;
        b=Ib8K8rpcpPPnd9UkyVa/rWjXDwToqrzgUpjzVKUSRZwwpX1/bygdNFWszldeYNJSKv
         2l2s465QUYwoiGziVnnF+6sSA0Ej93BBrzdBGvm7sXf7hiGWgcQRVHIJO1B7896Eh7tf
         1j4CN9XN5vSSv4S4fR29YT+fN3APmmwcoBNEw1xh4GC6Lutp0cu54vQee31/gXmmzluQ
         P5uoZfOVYbNt9L1Hc+i31cFQP/6NHfK1WqLbPz2Jglew/mwYo1kS+FqRiVDf9jGR/7Tt
         Kp6UnbAdy87hgMXFq7W93ytiR9shY9Ix+tjFLUIWWDPM1RRwnFzQBV3biIyw0HbibwU9
         8TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOV5umT1eYSPCClB4+myHjuitl4aoXhb6nSLgQO08gk=;
        b=g55Qrfu03NIF6y994ds0T8MomCF6SvdzFW6p68Y8myu8spAerfUlXaRJY/eJegkO1p
         IRskS2vduODwUvOY/3F7zVBXqo1dsJNGA1OQv20NMKLIHDm5jVyE7F9FBK9nIaYDKNFx
         vP3PL2YyNAaBZfF/ktH8LFFnMg0eo6eI7hc1trNpItReAyfzM5Di/WUvTh0B5rAjPITV
         Wd823RQDSocpQ9ibp0ouhHwzT0Fu3ecfgXRJYlSsSQzCTg/UbueB1Fp9qVvyFBWk5SBj
         IZ3DPe0qZumiCRPqGLrSpaRlaXMnzCW/cAz5j1opX32nd3XoIg53lGqbnAja5veGd6sS
         Qd+g==
X-Gm-Message-State: AFqh2koHgTXt768F1ywGAuL09xIzHCndeJyiKy/tjwM9YDZnUwgcs3WO
        3NKPdhU1QJ5CHRp9kMTPRXdEtVNucsyoj/ztnYI=
X-Google-Smtp-Source: AMrXdXvKAG5k8loTwZqxTwRU18wP1QE+Dt8R/ykgqKVgjUlqiWFM6VPMl5w1bD4uIBxMdKmhYHCFhd88rGVJU2HCyQE=
X-Received: by 2002:a25:af13:0:b0:7bf:b130:9e24 with SMTP id
 a19-20020a25af13000000b007bfb1309e24mr164044ybh.328.1673275407758; Mon, 09
 Jan 2023 06:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20230109135828.879136-1-mark.rutland@arm.com> <20230109135828.879136-2-mark.rutland@arm.com>
In-Reply-To: <20230109135828.879136-2-mark.rutland@arm.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Jan 2023 15:43:16 +0100
Message-ID: <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment workarounds
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 2:58 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> As far as I can tell, GCC doesn't respect '-falign-functions=N':
>
> * When the __weak__ attribute is used
>
>   GCC seems to forget the alignment specified by '-falign-functions=N',
>   but will respect the '__aligned__(N)' function attribute. Thus, we can
>   work around this by explciitly setting the alignment for weak
>   functions.
>
> * When the __cold__ attribute is used
>
>   GCC seems to forget the alignment specified by '-falign-functions=N',
>   and also doesn't seem to respect the '__aligned__(N)' function
>   attribute. The only way to work around this is to not use the __cold__
>   attibute.

If you happen to have a reduced case, then it would be nice to link it
in the commit. A bug report to GCC would also be nice.

I gave it a very quick try in Compiler Explorer, but I couldn't
reproduce it, so I guess it depends on flags, non-trivial functions or
something else.

> + * '-falign-functions=N', and require alignment to be specificed via a function

Nit: specificed -> specified

> +#if CONFIG_FUNCTION_ALIGNMENT > 0
> +#define __function_aligned             __aligned(CONFIG_FUNCTION_ALIGNMENT)
> +#else
> +#define __function_aligned
> +#endif

Currently, the file is intended for attributes that do not depend on
`CONFIG_*` options.

What I usually mention is that we could change that policy, but
otherwise these would go into e.g. `compiler_types.h`.

> +#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
>  #define __cold                          __attribute__((__cold__))
> +#else
> +#define __cold
> +#endif

Similarly, in this case this could go into `compiler-gcc.h` /
`compiler-clang.h` etc., since the definition will be different for
each.

Cheers,
Miguel

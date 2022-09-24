Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382D5E8DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiIXO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:58:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE081B29
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l10so2584101plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A4T+kyw377orQQtPiOvYt9e0D29BYPUlLzt2R5wjAss=;
        b=R1sH2TkWj77H3g/bP3nEOSG0YjWqrb+dM9Ntz02b5KBX5jfO3NsMPm5ze66YWrNR9f
         kdRjg9teybAjH55Wkx5f24ieS2aYd4fqgbCfkeFroTeLH1t3Gbef/8x5f4zvcu1YAVzo
         ABxk2hoi5oOIk4sKmgcOCR0iftwfAYJmOwySE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A4T+kyw377orQQtPiOvYt9e0D29BYPUlLzt2R5wjAss=;
        b=mTyVvAcbQRIvme6ZMFZ0W4DYeLsNTV6746DYygEy13kCyuXWiBkoqtWuSUFFURBQu4
         7jkNSQxK3H7TzOD+yIUjxnjssDP9qrxFTMMKUBZhAyK2vQpIjYqzyQsXxBqxzR3l81pU
         ZbW5DqziPBy1vQ0aR4scB3LAhC84KVeBktFQE0Gx0asyie0ihlo65OqeOJtyruLk1DSK
         GKQSdVS1nozSX7vsc2DfJcwc5/+VpdShQIIoSeLYwt64cX/jjKwA96cD4cNRu5gNbE97
         eHbpid6TR23j0LFH3gxpDOj6bbDnhe1IB9EnSBo1ISA6Yo+0BbxUozDqMpji+JuREzoJ
         ywXw==
X-Gm-Message-State: ACrzQf0gEx+zUmWdniFEbCKlngaBVkFfHUUQWG5I7TRoUnxA5X8/k5a0
        r2f/X7MDwf/7dATSgWMPWdWbxQ==
X-Google-Smtp-Source: AMsMyM7kevo+f32kAEhGZsgaVY0iUt0RhFVuHM/4Cd8FeTJRnT4o/Efhy/oEyMRjra2SK2TrSMG3cw==
X-Received: by 2002:a17:90b:194a:b0:202:e6eb:4b62 with SMTP id nk10-20020a17090b194a00b00202e6eb4b62mr27737434pjb.33.1664031536143;
        Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902edc500b0017534ffd491sm7875331plk.163.2022.09.24.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 07:58:55 -0700 (PDT)
Date:   Sat, 24 Sep 2022 07:58:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Introduce __access_*() function
 attribute
Message-ID: <202209240757.3AC47AC6@keescook>
References: <20220923235424.3303486-1-keescook@chromium.org>
 <CANiq72n6zK=sXn2j71bAEUUYwRse2dT9f8kLrYzncnPjN1XTow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n6zK=sXn2j71bAEUUYwRse2dT9f8kLrYzncnPjN1XTow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:06:31PM +0200, Miguel Ojeda wrote:
> On Sat, Sep 24, 2022 at 1:54 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > are specified. While it is legal to provide only the pointer argument
> > position and access type, design the kernel macros to require also the
> > bounds (element count) argument position: if a function has no bounds
> > argument, refactor the code to include one.
> 
> Should this bit be included in the comment of the attribute? (since it
> is specific to the kernel)

Sure; good idea!

> 
> > These can be used multiple times. For example:
> >
> > __access_wo(2, 3) __access_ro(4, 5)
> > int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
> >                    u8 *src, int src_len);
> >
> > (And if "dst" will also be read, it could use __access_rw(2, 3) instead.)
> 
> Also maybe the example could be nice there too, since it uses the
> syntax for the kernel and you took the time to write it :)
> 
> By the way, shouldn't `src` typically be `const u8 *`? Given it is an
> example, I would qualify it.

Yeah, I will update this.

> 
> > +#if __has_attribute(__access__)
> > +#define __access_rw(ptr, count)        __attribute__((__access__(read_write, ptr, count)))
> > +#define __access_ro(ptr, count)        __attribute__((__access__(read_only,  ptr, count)))
> > +#define __access_wo(ptr, count)        __attribute__((__access__(write_only, ptr, count)))
> > +#else
> > +#define __access_rw(ptr, count)
> > +#define __access_ro(ptr, count)
> > +#define __access_wo(ptr, count)
> > +#endif
> 
> If you do a v2 for the above, please take the chance to indent with a
> single space after the `#` (like `# define`) for consistency.

Fixed! I will send a v2.

-- 
Kees Cook

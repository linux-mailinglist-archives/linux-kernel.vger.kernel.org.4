Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5C692311
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjBJQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjBJQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:14:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC9749B8;
        Fri, 10 Feb 2023 08:14:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w5so6937292plg.8;
        Fri, 10 Feb 2023 08:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLSb4oI7+G/vrSC0uBHgAIzrNQ2OQDigOg7jJ9N0vsg=;
        b=PCPKWUiaCusJdtCnECjumkp3J1QvA96YuTv4FJeFmqch8ud9Ii1ettciB81E6lmxzM
         ojwbJHWAygEfNd6w0P6ZsUJAubVYEOs26iO6TxuOgvL32qs0t9jkmKfoMSza9drYHX8x
         UFPZ7dTgd7iPZey2976DHnac0YGp0YxcroCQDglPkZ4yQh2SkjDr5AgfRs5mLjxHVhD8
         uv/PbxLh9NRocXRsPcut3fJ1I3akWLndIeS392QoS5f7noQpMgleq/gOAgHuMLND/72J
         M8bjq7qDCYjFiqx6zRhz7mJPr5lXINJVZ1N+uIvDonwqgR4TaXio8FAhxjmKH23KLHvu
         LWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLSb4oI7+G/vrSC0uBHgAIzrNQ2OQDigOg7jJ9N0vsg=;
        b=vbCwR5EUfs6y3oxiHor41umpFAyLGFR3R9WMNIRlwwB30G7URUdMs9Bfj5nDVOv0Zp
         /TGnJTRvYRu1W6eWa04MzUzmoB5EW3XEa/1YfpnCcYsrMt4AwhjPzO8daEvSFyb1hFep
         B0ZQlirlf0qQF0g9Tzk3PNeI273dl9ZljM3ugYbBmO5GjTxzxb3m7yRPtVxCwH8wq1dK
         +u8BVFxa+GzWvpqPDENRfDqn/hTSayXOOTg6wNlwO9ixK1ut2NCH0xDKixdNbISI8VYu
         0tTfYKeFW8IaL2+4tvXjutC2XvwzLd2+LfJs4D8lVGG54TT5qcIqrIImmj2ETvHhqFk9
         tN2Q==
X-Gm-Message-State: AO0yUKVjm7AEXl6e9fnIwUg5FNhSXIQZbvAnAsx7eVDgTprl0aCJqbY/
        GpCXVlUiIBNH04F5bYicXVY=
X-Google-Smtp-Source: AK7set9p9yRN0uGRPX49Nz2FWepxAbly3CMmVUioeLM705OspCHjKCSUUpUpjuwRsqWhbSyuJdCL8w==
X-Received: by 2002:a17:902:d2d0:b0:198:a338:b9c5 with SMTP id n16-20020a170902d2d000b00198a338b9c5mr19125012plc.2.1676045668657;
        Fri, 10 Feb 2023 08:14:28 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902a70e00b0018997f6fc88sm3590399plq.34.2023.02.10.08.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Feb 2023 08:14:28 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:14:15 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     concord@gentoo.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
Message-ID: <20230210161415.mktok5dt5fiqmqss@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
 <20221219132731.6ng4sz2nv6ujvu7i@ubuntu>
 <202301061929.6881F6CD40@keescook>
 <20230107154213.ocyghxd2k66gbvv6@ubuntu>
 <63e3f989.170a0220.60c91.c5ce@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e3f989.170a0220.60c91.c5ce@mx.google.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08, Kees Cook wrote:
> On Sat, Jan 07, 2023 at 07:42:13AM -0800, Dan Li wrote:
> > Hi Kees,
> > 
> > In the next version I'll make the gcc implementation consistent with clang.
> 
> Hi!
> 
> Just checking in on this, since there are a lot of interested folks. :)
> What's the status on the next version (and has anyone been found to
> tackle the x86 backend part)? Is there anything we can help with?
> 

Hi Kees,

Sorry for the long delay. It's been hard for me to find time to finish this
until the end of February due to job changes (even weekends are busy :( ).

As much as I'd love to get it done as soon as possible, I'm sorry I probably
won't be able to submit the next version until March (maybe mid).

If anyone could help improve this, I'd be very grateful, otherwise I'll have
the next version done by the end of March (as a promise), and also try it in
x86 platform.

Sincerely apologize!

Dan.

> Thanks!
> 
> -Kees
> 
> -- 
> Kees Cook

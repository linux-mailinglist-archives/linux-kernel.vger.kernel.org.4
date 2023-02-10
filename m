Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2D69232B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjBJQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:20:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C97284;
        Fri, 10 Feb 2023 08:20:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t17so3818220pfj.0;
        Fri, 10 Feb 2023 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+s3+R4BwN91gBepBEWrEY8Vvh5YNXMDaNjOtbjtONA=;
        b=PUD2yf2TNOz8iOQztqPJfdJ9ELRnWxBC9OXLVvc0IMpv2hMRfQrlK0ITtiAdKBU+hf
         vxUuKzjUsfHAY0amGyhDBmbYFLp9jyu+2l1wbj0hM2w1m4vZaEtz/nkmxs6lVQLolEi9
         H6TpF62UjRYsKAjxBWJFu0xALWrrCFLrdjELIMPIHZuuyQmv8eOw9r/khi+IPv5UC5Tw
         rVWB2YIsKZGJHrLiEZqJdsvwqFWegdKM7enGODXCgR/bQqsBw5TEeoEoLBtYDz44hYd1
         4Ee9OBaXLQXdoS4ianvnXhjRuGc6E6k7hOS4SKR1ulB57R9R4a8XTclSEFIQ007wNoUP
         nPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+s3+R4BwN91gBepBEWrEY8Vvh5YNXMDaNjOtbjtONA=;
        b=0fV1m7pFdxa2LSjYNLxwt1e0JGBA5aDMAnV4DZ/zefwYf9M+krkQWt3IcxdPTQahJ7
         SuTBhRWObY+MnVvIo4QRlpwOdiwODqa0eKMuVB5577KWKtbfiT23B/1+bf+7fVM+RH7B
         1kfjRJT0u9ahohgCck+cr1kCPapKQp6G0IV0acCbY9cv7Jea7j4x4eRP471iHV0fBSg+
         myybA21Ra5Lq2QPA1fWYuqGmq4GUZLWRFPDDVVDPoTg5zk4iWNdkpjbRqMdpcVmjoMjP
         N2swQd2kUGldJRLLnX4TIXoBKnNj8ADa626soWwZIy+8ajYUcnEU+8q2NCgcEtte7xme
         DcaQ==
X-Gm-Message-State: AO0yUKWbzZInZBzUYb3sycLc3bc/WCGLNGECDoJT+aoQpKk6yZm7AZVA
        /YoRMCvm8dEr3aSg2XrQbvs=
X-Google-Smtp-Source: AK7set99SI3pKlRjrZCRkEnyIZEEUot5w8CzY221yQ6oODsw8IKivq7tbJBLTxpHBLVzJB9Y5m+i2g==
X-Received: by 2002:a62:1d91:0:b0:5a8:718c:5ee9 with SMTP id d139-20020a621d91000000b005a8718c5ee9mr1786799pfd.25.1676046046923;
        Fri, 10 Feb 2023 08:20:46 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id i1-20020aa78d81000000b0058ba2ebee1bsm3433711pfr.213.2023.02.10.08.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Feb 2023 08:20:46 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:20:33 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT 0/3] Add compiler support for Control Flow Integrity
Message-ID: <20230210162033.tb5b6cd3j3vxr6vv@ubuntu>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <CAMn1gO6hwaSDCqigwoH981ffVbU8OvgJhrGh997kGseCSbpAJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO6hwaSDCqigwoH981ffVbU8OvgJhrGh997kGseCSbpAJA@mail.gmail.com>
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

On 02/08, Peter Collingbourne wrote:
> On Sun, Dec 18, 2022 at 10:06 PM Dan Li <ashimida.1990@gmail.com> wrote:
> >
> > This series of patches is mainly used to support the control flow
> > integrity protection of the linux kernel [1], which is similar to
> > -fsanitize=kcfi in clang 16.0 [2,3].
> >
> > I hope that this feature will also support user-mode CFI in the
> > future (at least for developers who can recompile the runtime),
> > so I use -fsanitize=cfi as a compilation option here.
> 
> Please don't. The various CFI-related build flags are confusing enough
> without also having this inconsistency between Clang and GCC.

Hi Peter,

Got it, as discussed before[1], in the next version I will use the same
compile option.

[1]. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221219061758.23321-1-ashimida.1990@gmail.com/

Thanks,
Dan.

> 
> Peter

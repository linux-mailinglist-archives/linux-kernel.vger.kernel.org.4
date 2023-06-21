Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929147391D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFUVy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFUVy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:54:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82387E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:54:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b5422163f4so42225505ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687384459; x=1689976459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBUEVo1q7n30FsHvjVeF7u+PkYrRTPaQ7gRodIMSGHc=;
        b=g0lMw2Rz4vHh0LSVgW2evkSBz+6/980KZyjZCsSI0elex38mMOmUGcG6hJIiOfkjOa
         hh9nR9eDwEO3P9OIJboZkfv2xpsj/GYudHRuxRO2OZ4Gse0PeeiSZgwxjlJpooJyIBmZ
         sdaEEBVfiOw3VSNlfZehux7NzQbiE9ZT91y68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687384459; x=1689976459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBUEVo1q7n30FsHvjVeF7u+PkYrRTPaQ7gRodIMSGHc=;
        b=J/CL2o15yqX7HPXjBVDOKiIdRzwhutjPVwSvCaY0HJG85b6lj1ApOjarYpwRa+QjE6
         uNOwepKfGO7Yw5jWVMltjJmPBq88mfYoIUSjdxoIeHlFnPJkuGy2oxY/ma3ong1tpS0u
         iv4p8aw297GHE9Clp/VZpr0X9Xfs5wmipu4zUakonZzLqu2wm5b1BZYANaVu63jP8NiM
         8qkM/3ceiEeKqxuMRlt+nhQF2DuOOn9RUZ+3jHAIgLSgZscpNY7jAKh7RvDGMZGZneBC
         9uFFI//D0D9bb3RKk75mJ58MUMApCkxAc9Ye+1Hbd91f3kVPG3zgqTK+X65AAnOadOeI
         gxNA==
X-Gm-Message-State: AC+VfDzYW56YiAR5eW8DpC6vkE2+8hlGUmBsaPztPM2TyXzSSOknCIEX
        o4QUwAmpsbR5nebRK71zCZ8kvT4x/gMWhmdtdDE=
X-Google-Smtp-Source: ACHHUZ7sSNSEdyXfVFVbwQZyuo/RmgZQEi8YADL8wI+y2YjTTaLRDJ6GJgpQ9q7lMzepkoUPJatsYg==
X-Received: by 2002:a17:902:8c94:b0:1b1:a9e7:5d4b with SMTP id t20-20020a1709028c9400b001b1a9e75d4bmr15712370plo.22.1687384459016;
        Wed, 21 Jun 2023 14:54:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001b6758a2d94sm3903265plr.305.2023.06.21.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:54:18 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:54:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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
Subject: Re: [RFC/RFT,V2 0/3] Add compiler support for Kernel Control Flow
 Integrity
Message-ID: <202306211451.CB0A34563@keescook>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <20230325081117.93245-1-ashimida.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325081117.93245-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 01:11:14AM -0700, Dan Li wrote:
> This series of patches is mainly used to support the control flow
> integrity protection of the linux kernel [1], which is similar to
> -fsanitize=kcfi in clang 16.0 [2,3].
> 
> Any suggestion please let me know :).

Hi Dan,

It's been a couple months, and I didn't see any other feedback on this
proposal. I was curious what the status of this work is. Are you able to
attend GNU Cauldron[1] this year? I'd love to see this get some traction
in GCC.

Thanks!

-Kees

[1] https://gcc.gnu.org/wiki/cauldron2023

-- 
Kees Cook

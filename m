Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA06413CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiLCCxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiLCCxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:53:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F42A724
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:53:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x66so6569512pfx.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdsbvopHdpWN4t4Xyy6LXgHJs384GWwdgMIM91slJ/E=;
        b=XT2jmzsk2Vfm9w+DkN1Lz1Tjy71qjWPoao8qtRj3bZrZPfwXB1hyqIpn57pvB90/rq
         63d7fOq2Mmf1kO+vR788ukxfPlAiT1KSgQZg9/z58zWQ7i9nFvKwjhfZPugl3zobOmso
         EN1WafQcrekEIywXwOWjLrHS2LNPk4WBZLGxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdsbvopHdpWN4t4Xyy6LXgHJs384GWwdgMIM91slJ/E=;
        b=jx2c+5fLnb7YYrCU8EkX9iCQV2zsPam1OtSD69HaQ7IdCOwnbsroSNPQo+Mu/JzBUN
         iOJuzJQtRZw0i9yQy60K1nZC3QMlBJT0gOzJw1Yvl3vhHPvYI1g9xTocxDwHmVcihPFN
         ZNcp5ey24xLxXo4kqXaANBnGGdJg96AUKKa2EnuClM6iKQiJVm/MYCcNrL9HyilX5MQ8
         qgob58g6zJYOjR0rRA5MZ3rNV0Jr2FTnEm8PwsYxc4tIC9FLKPsLtlPOjB0XI3izr76T
         bI7DhffA4h7+giSkvDaw3sxGiNUTRy6Xsic8zRrZojR7SnVZzAqjo5jHPY17VO3cFOFt
         QGKA==
X-Gm-Message-State: ANoB5pnPTcbweel61HEj3rtY1IaZzzjKuHKR7ITMmYEjZmsjIKfK4oU6
        VBCZAk46MkusUnNrS7QwIyS4NQ==
X-Google-Smtp-Source: AA0mqf6LVB3GIyJWeUGBPXDf0PbRYROGSN6hS1j62oC6woS8D14mopgLVA3lzwvQcDRjfAOqKPjecA==
X-Received: by 2002:a05:6a00:1f10:b0:573:578b:e773 with SMTP id be16-20020a056a001f1000b00573578be773mr58396836pfb.11.1670035980821;
        Fri, 02 Dec 2022 18:53:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i20-20020a170902e49400b00168dadc7354sm6231569ple.78.2022.12.02.18.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:53:00 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:52:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v4 32/39] x86: Expose thread features in /proc/$PID/status
Message-ID: <202212021852.0EC80A46@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-33-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-33-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:59PM -0800, Rick Edgecombe wrote:
> Applications and loaders can have logic to decide whether to enable
> shadow stack. They usually don't report whether shadow stack has been
> enabled or not, so there is no way to verify whether an application
> actually is protected by shadow stack.
> 
> Add two lines in /proc/$PID/status to report enabled and locked features.
> 
> Since, this involves referring to arch specific defines in asm/prctl.h,
> implement an arch breakout to emit the feature lines.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

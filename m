Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D40674890
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjATBG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATBG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:06:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A5AA45FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:06:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so3978292pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHc2YeJq1gC5PoZgY4Iwlw6CmkZ3lmJ2eSzoR5B0bDk=;
        b=cffzrV13cP1SfkGDGwWIi6b5Qk7srRb9yfkQ37nKk2mfz1wl74Ve1N6L+5A9akzYNy
         5TKDPPgSZdo7qU0dnHQX5bOVXBZRlfeU3+Shm/OIR8OZ2A0aO/0oOcFmUYEZeCnecet9
         qhD/FMRgIBZJFSLPSAZ19NerE/VVAkCbyw3zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHc2YeJq1gC5PoZgY4Iwlw6CmkZ3lmJ2eSzoR5B0bDk=;
        b=tkB+TJDea20/BMH+PNX57KFAK0mO8Q5wl6ZMhiP1YP8UpcuEgB/89Qy9adksGr8FQc
         dnGqX2jIMSfiW1BOmAb68I66xXp0mKBtGuDyA4AGrYcUfMqKo7H2qZBhi6Sj+QFdWHrK
         80c55OB0+JoQktATu1R+tV5fgwkVe47fw5rHd0UlxRc81AQPknzc3laqFokp2x4WcuGS
         95d2OzrCwMwmLPQHR+3tZ05NbOr+dHhMq4n1oJWV7TcG5+NITPNBDKir2ocoXmn6TvXD
         +TAqf86KEFQjLlFHMWQ2k11zHuJSnZqBrZLqPIOHNlBiM9ACPiO1Q8GGn7jTvunBGEJ6
         5ylQ==
X-Gm-Message-State: AFqh2kpTovjhIZ2sJ5ZdDZaawVLewrsy7G3ijwKhhnrDGRAdZ/B3AjyF
        2zugEszTNWmXtOhezR5nttWNaQ==
X-Google-Smtp-Source: AMrXdXvEX6WcL5MmC1RJ71EoKqmiP+PPfRbNrQ2cA8a2Ol2LXSgn4VtXBHKMCL4oTD0OjlFr4BrC4w==
X-Received: by 2002:a05:6a21:1646:b0:ad:6305:a4 with SMTP id no6-20020a056a21164600b000ad630500a4mr14254496pzb.48.1674176814001;
        Thu, 19 Jan 2023 17:06:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a631b42000000b004cd1e132865sm5244496pgm.84.2023.01.19.17.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:06:53 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:06:52 -0800
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
Subject: Re: [PATCH v5 32/39] x86/shstk: Support WRSS for userspace
Message-ID: <202301191706.BF1B7E3B0@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-33-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-33-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:10PM -0800, Rick Edgecombe wrote:
> For the current shadow stack implementation, shadow stacks contents can't
> easily be provisioned with arbitrary data. This property helps apps
> protect themselves better, but also restricts any potential apps that may
> want to do exotic things at the expense of a little security.
> 
> The x86 shadow stack feature introduces a new instruction, WRSS, which
> can be enabled to write directly to shadow stack permissioned memory from
> userspace. Allow it to get enabled via the prctl interface.
> 
> Only enable the userspace WRSS instruction, which allows writes to
> userspace shadow stacks from userspace. Do not allow it to be enabled
> independently of shadow stack, as HW does not support using WRSS when
> shadow stack is disabled.
> 
> From a fault handler perspective, WRSS will behave very similar to WRUSS,
> which is treated like a user access from a #PF err code perspective.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

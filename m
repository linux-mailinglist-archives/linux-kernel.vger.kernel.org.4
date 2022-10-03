Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2655F3908
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJCW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJCW2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:28:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228D16590
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:28:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c7so10850558pgt.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+wnywtAQvf5k8l6QfV3gcIXHNKvc8BplZWtX49oDhHc=;
        b=H/p7lvN0ivhZ/ZUi0b1ymdJCdg09uvOJ+n08JqQMJX34z0HB4NQM60kOzdXXVDMjYr
         xvwOo7FvBT/LWZkr+sqMomIG4ecCsdqBQOKTMQoFnDScjMd/yg5qd907sZvhultWzURx
         SyYeNSNrz5ok6t2vENsv7nnoAKrZbbweIbd0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+wnywtAQvf5k8l6QfV3gcIXHNKvc8BplZWtX49oDhHc=;
        b=qckt/V6jcbeAgoVPRkldtz4m3mIiareU48zmRETJ0mpZfx3rSS7biHKWE0eHEG+O1x
         9hWD9Lj4kTOsXRJJqwPNJDS2S6FKR3P5a0BxcVTkXyyBl40Dyn8YRYqdc88UK+4n/yYb
         2CO8a8XizJV6KKs9xeYIhVHh/QwNCyWt3HiovhYd9cD2/kWz6a4GMdkenFLeRB3kcsxP
         /vun7sfUOl8PK47+jIy3JNDNKK7CUQUCk2kk+A7ay36bisOhUULxW9q5amAG0ZLAUdBX
         Q5dgqAg5hUP/6I0CnV7T6mpbaat1Kk9vBaaCvsUBVP245R410rZbthpObkIJqzjSiXUV
         aJ1w==
X-Gm-Message-State: ACrzQf2HdqVUgyTHKynyeX0kwqePAiptTWQqwfp7hk90L6fcBg3Vc/Q+
        1rqb7KW4DGFlZRl1AottSD7Xbg==
X-Google-Smtp-Source: AMsMyM7u4PcmOvVI/uNaqNfnpw33KHljDf3vY+Qdun5s8TjCJBcY3DqmJr+5IYdkQEWD6PqNwIPWug==
X-Received: by 2002:a63:1141:0:b0:454:ae43:14e7 with SMTP id 1-20020a631141000000b00454ae4314e7mr788927pgr.527.1664836128678;
        Mon, 03 Oct 2022 15:28:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 129-20020a621787000000b0053e20a0333fsm8096309pfx.93.2022.10.03.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:28:48 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:28:47 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Message-ID: <202210031525.78F3FA8@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-30-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-30-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:26PM -0700, Rick Edgecombe wrote:
> For the current shadow stack implementation, shadow stacks contents easily
> be arbitrarily provisioned with data.

I can't parse this sentence.

> This property helps apps protect
> themselves better, but also restricts any potential apps that may want to
> do exotic things at the expense of a little security.

Is anything using this right now? Wouldn't thing be safer without WRSS?
(Why can't we skip this patch?)

-- 
Kees Cook

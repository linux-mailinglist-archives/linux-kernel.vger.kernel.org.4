Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455D68859D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBBRio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBBRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:38:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3239BAE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:38:32 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be8so2586472plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejS+fA6FXopXLvgXoYeghfO4Gq+OL51G2M5fMvFWUSA=;
        b=b3x1gtRASyVfGRtlJoCkIywjYwfoZC5CtHFS2el8MYUbQdx4cgghkl94J/FCr8Wbbe
         yZXH3ZnZxx/1IHJ/deyGQhwon38isJshX5XBUzawlFvToU3NKOzBSyShAMv3nOipxFL0
         O0TYJ7toYRLtk2hDXrtiXCz8PYBmcOSUD5M/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejS+fA6FXopXLvgXoYeghfO4Gq+OL51G2M5fMvFWUSA=;
        b=KvL8hr32vuFUf34FUmTLB26L6eu8hL/FMhLqV+iVF7ugamzSyOm1vPekS3Q6uXvleQ
         LcWSfgO7OebszUjEseUThGEgp5M1zMVlmv4ad2o5s+SkjtKXsXXiCex2YX8N3p7qt3x8
         A2eWc/PoHgjNTyrZ5ihcRRA1OKjOOt9Qy6hqH5mTd3HWvzc1Zk/y9gMCP32RvQdR0sju
         YHHmuyTR3bpoN1sN5u492oC9Tj3cjTKhcyHbnn9qablnvQq4XUBxjeTwF7f5PPYWH+nC
         XttiSPaSF+VyR4gAIUHW4nyh+76r3UWNBfjo+MA5v6Ssl/9iUOMHL4dyuzjplt8C5hWI
         5aLw==
X-Gm-Message-State: AO0yUKVIaTmPQxWMtfqS9Tfl3WGoleijVWdn1Z0mNCsoz1auq344gCVs
        4wgO/c33oKh8T/hOVeyCVAKy4Q==
X-Google-Smtp-Source: AK7set80/QWi2ZBrv8yRSPbkEc2D7xyp0jIgn+EHMwhfhvi+pHfUa4N0s+tXpJ+i+2BV4s1sZRxfLA==
X-Received: by 2002:a17:902:d292:b0:197:90f8:f3b with SMTP id t18-20020a170902d29200b0019790f80f3bmr6363019plc.57.1675359511761;
        Thu, 02 Feb 2023 09:38:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79256000000b0058baf8694e1sm13785961pfp.71.2023.02.02.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:38:31 -0800 (PST)
Message-ID: <63dbf517.a70a0220.d9b66.9217@mx.google.com>
X-Google-Original-Message-ID: <202302021738.@keescook>
Date:   Thu, 2 Feb 2023 17:38:30 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     akpm@linux-foundation.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Dan Li <ashimida@linux.alibaba.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arch/Kconfig: Fix indentation
References: <20220518054801.364376-1-juergh@canonical.com>
 <20230201162435.218368-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201162435.218368-1-juerg.haefliger@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:24:35PM +0100, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

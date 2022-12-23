Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C36553B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLWSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiLWSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:41:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C171EEF0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:41:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so9511071pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR8IA5HghKSQ9FgjGdgnRa1qakr0JhCwjYS6vZEikZU=;
        b=LnhS/jgwr3aFvQJYbl+K5MsWVcPAP5jRbK6RiU1mm7FqD5WaS6fHe0JdjgBCEYZ26m
         676+zKKbgSDVBO+1a3g+zDTowtMA0w7l/Qsc6a1tmLPL5Kf+/IHV8YXMUNfKJOaTpkpE
         BXB+Ba0gx+Tq5B2Cq3z4tKWx1+qt39I9vRI94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR8IA5HghKSQ9FgjGdgnRa1qakr0JhCwjYS6vZEikZU=;
        b=FLyuPCWmbeMxCaFirGajlELY5Jsp+/OiBHTUgU9L5cBH8qrh7540SqGFfbSO1IvAoo
         GuCPeXOUL92fEc6JIhucz/jb+9+TDFBQD3FmE1Z1M09BuKY1FmMkLXi/H0F8zg0tZf5l
         rFlMDOhKNqaHrTcUAXgsf4w4/qpenZHpsWqVPxaGniARNqvvL8jpQiYtbYz9kbNP8h1+
         QH73neslkrsowZq7NonSVDbVk64bR5OyTrJsEyGFnO/34Oro2RjO5ySiQXMkQF8SUcxF
         FoZO9gQ6mvCIaMoXo6s+WvVAQYEtshjyz4L6XW6ZYedFE2F/mhDM56d44RCrazIHJoeT
         57ow==
X-Gm-Message-State: AFqh2krkHGrs3f2zwK/s8tBWYPKbc1uoq+Q0rl38V1LjHay0xYFV7qWg
        7GoAityNGWQxkgM5rHsic7nNNw==
X-Google-Smtp-Source: AMrXdXsAa24RroS47+INAqXRa2gPvLFTO4iM9NRBoXhjWS+RYk/23NCC7e9uMO2E4ap5gEywVStVLQ==
X-Received: by 2002:a17:902:b60e:b0:189:89a4:3954 with SMTP id b14-20020a170902b60e00b0018989a43954mr11176601pls.41.1671820871085;
        Fri, 23 Dec 2022 10:41:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00178b9c997e5sm2723760plf.138.2022.12.23.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:41:10 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:41:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        kernel test robot <lkp@intel.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [GIT PULL] kernel hardening fixes for v6.1-rc1
Message-ID: <202212231040.2D92409F@keescook>
References: <202212231009.EC864645D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212231009.EC864645D8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:10:19AM -0800, Kees Cook wrote:
> Please pull these kernel hardening fixes for v6.1-rc1, collected over the
> last week.

Ugh. I mistyped the version obviously. This should be v6.2-rc1. I've
sent another PR with the tag fixed. Sorry about the noise.

-- 
Kees Cook

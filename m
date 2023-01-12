Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC26686A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjALWNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbjALWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:12:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4673BE9A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:06:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n12so20538226pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FnbKiO7ajEV7SWU0kUyNEcHLUgki6RWJkndix3Av1gE=;
        b=BfK7XPga9+5vXyUQP/v/aDW7Ka8vj9ZKyVNeKr+vpx+bcmPMsQuyUDO1oFuXEe6JG+
         rKdPLD7AC6VpKpBGiGrG+5uT+b+rkVYgt/1ErXvL76wmK9aiIrDKpRW4ymU8kWJfn73s
         ZVx7dMRxLaxDIBX+1sE9G0T/Pm4T9KAQw+UXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnbKiO7ajEV7SWU0kUyNEcHLUgki6RWJkndix3Av1gE=;
        b=DMlagKoTSYwMQjObcNTd+cQMcbp9N5P+hofz0HQJZYetA8NebdcEKxSEaeJ5FSytHr
         qa80T5uwnu2TNWh06QfpSB7StoA4amXzQVoiZmjROCR5sh4EO4E7dQS6UyNR0cuuWO+G
         zXVZLm8sXyjkNGKYY3WYkVT8tDH+3DgK7HF7OpcgL/Xx/uzQXVJtA8U7gNeW50HZb1wG
         VNW1ndlTTses1NZqSpX4/oB6R/ZQanAeTmdyANZLrNsEAtG0IGCtWgQukbDVsL4e14Nk
         A7HPiR+7Clk8krqcyBXc/r6uNCZcQ3lA9XJm0Djh1l+mZ2eIfkXlkuuwdze2yUj1i/sb
         pc7Q==
X-Gm-Message-State: AFqh2koR14JxoRGXTRA2apZRpw8PVMOGa3lGNFgqrtUWWANkMfgCNBWb
        u1UvrPFBYfsM85Drl+uYWnYawB6dcO1wN5cP
X-Google-Smtp-Source: AMrXdXs8n0YkIxD05d524WSSC25s1n3FfRw1ADxQs7JTf7HSV70djM+27SyCQh2Rsa5KQa+0i78IpQ==
X-Received: by 2002:a17:902:6a87:b0:194:6d39:5911 with SMTP id n7-20020a1709026a8700b001946d395911mr490309plk.40.1673561210990;
        Thu, 12 Jan 2023 14:06:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001946a3f4d9csm226007plg.38.2023.01.12.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:06:50 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:06:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] scripts: handle BrokenPipeError for python scripts
Message-ID: <202301121403.599806C597@keescook>
References: <20230112023006.1873859-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112023006.1873859-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:30:06AM +0900, Masahiro Yamada wrote:
>     def main():
>         try:
>             # simulate large output (your code replaces this loop)
>             for x in range(10000):
>                 print("y")
>             # flush output here to force SIGPIPE to be triggered
>             # while inside this try block.
>             sys.stdout.flush()
>         except BrokenPipeError:
>             # Python flushes standard streams on exit; redirect remaining output
>             # to devnull to avoid another BrokenPipeError at shutdown
>             devnull = os.open(os.devnull, os.O_WRONLY)
>             os.dup2(devnull, sys.stdout.fileno())
>             sys.exit(1)  # Python exits with error code 1 on EPIPE

I still think this is wrong -- they should not continue piping, and
should just die with SIGPIPE. It should simply be:

signal(SIGPIPE, SIG_DFL);

Nothing else needed. No wasted CPU cycles, shell handling continues as
per normal.

>     if __name__ == '__main__':
>         main()
> 
>   Do not set SIGPIPE’s disposition to SIG_DFL in order to avoid
>   BrokenPipeError. Doing that would cause your program to exit
>   unexpectedly whenever any socket connection is interrupted while
>   your program is still writing to it.

This advise is for socket programs, not command-line tools.


-Kees

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF215BAF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIPOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIPOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:38:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F62CB3B30
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:38:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r23so11965559pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cKDTNYSujMHhHC8oskKxTsGs14KRpTgwA0hXaRQXqJE=;
        b=LHdnib7NohNt/B5VsHS71bRWCyRwWHlluIwZWIqC++4bLbYNnIejD0i+Vmu2TXtlsD
         9EuBpBms8xebBJVcdKpNFvqK+AUgmJ8GriGB8g8/+s+JFFGbWp44RBMzhdfoguAAvaM9
         Iab+b9A4XMNstm4V+iyB4SyEu89dq6ySAc6pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cKDTNYSujMHhHC8oskKxTsGs14KRpTgwA0hXaRQXqJE=;
        b=OIBYl0UigNEqefyxUEPHlsYKr7XVdtj1CTT009llFnzIcKSipgB1EEcD18/EvnNT9R
         66F67oLDZJpTm1/6Q6U2FrUc67FmLJFGmvS7Q5eFD1oTAnT/6sEFXxTY8j9CE9FPQnoM
         HDYFSNhoHB4aIyS+MIJ57mLzZ3Pi9DXFmVnjnNSMWOWdXsr65Jm/asm+6K+s/2RcJpCs
         o6sRLSvGicG0Sl/t1mDx7iml/t6XP/zCXKv3gJLC08K5VyGHk6ltrh5eMcwzIXc+47iR
         K+5Pu3pcEAJQogSA6Kfx1Poa6tkJ+ilnFW6ImBDF1hwQ08JFSRv74mgYRvTenrccl8tp
         sLyA==
X-Gm-Message-State: ACrzQf1Y0ZN80wDO2G9xc6BlbU+Cs0WH/nnatF3avjG8rUrDJtpRIL35
        goQf7cmJY9buoSz5zLOW8rzk2Q==
X-Google-Smtp-Source: AMsMyM5y2H35r4+gPV2IegQA4AFtLolRboe7pBtrjBSrgvkHNeL6xS5tbIfEhmbPm8A5jhIzxJ93AQ==
X-Received: by 2002:a05:6a00:1823:b0:544:b4db:50c with SMTP id y35-20020a056a00182300b00544b4db050cmr5039980pfa.33.1663339119577;
        Fri, 16 Sep 2022 07:38:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001784a45511asm8184760plh.79.2022.09.16.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:38:38 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:38:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202209160727.5FC78B735@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> Currently, execve allocates an mm and parses argv and envp before
> checking if the path exists. However, the common case of a $PATH search
> may have several failed calls to exec before a single success. Do a
> filename lookup for the purposes of returning ENOENT before doing more
> expensive operations.

At first I didn't understand how you were seeing this, since I'm so used
to watching shell scripts under tracing, which correctly use stat():

$ strace bash -c foo
stat("/home/keescook/bin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
stat("/usr/local/sbin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
stat("/usr/local/bin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
stat("/usr/sbin/foo", 0x7ffe1f9ddea0)   = -1 ENOENT (No such file or directory)
stat("/usr/bin/foo", 0x7ffe1f9ddea0)    = -1 ENOENT (No such file or directory)
stat("/sbin/foo", 0x7ffe1f9ddea0)       = -1 ENOENT (No such file or directory)
stat("/bin/foo", 0x7ffe1f9ddea0)        = -1 ENOENT (No such file or directory)

But I see, yes, glibc tries to actually call execve(), which, as you
say, is extremely heavy:

$ strace ./execvpe
...
execve("/home/kees/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/usr/local/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/usr/local/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/usr/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/usr/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
execve("/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)

This really seems much more like a glibc bug. The shell does it correctly...

-Kees

-- 
Kees Cook

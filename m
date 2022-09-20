Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73BB5BF004
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiITWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:21:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2A50074
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:21:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fs14so4537412pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=upw72VMgBHjGqZ0U19GWpMgzVWGJTdhRQ+B6JpzBzhI=;
        b=XaT90E8n2dHZfoQg35IwewP1F01hNnFj3HR28CQPhteLbf8K8/qzEfH4PnmvQwUc1l
         Vu5c/N1czJLmPcijnABkGU3shW911nCwc2oVYG2knnKsFI1BDQSZF90+wU/meXdN5gS7
         I8viMtcF9E/E7sWpN7MRpPJZUesU/n2ObnUtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=upw72VMgBHjGqZ0U19GWpMgzVWGJTdhRQ+B6JpzBzhI=;
        b=p+o5dXApPSR0jSVXhg0Ux9oulva51Q9fleDVThygwOk7rQy2GaCKYET3Ov8YZ6Nlx0
         +MbENYs8VUizWnghdrG/k2UYH46S1vQFgnurod5YuPMOlF+FW+5eAcyFQik4EPETpmYs
         5ZuGpE6K/tQzSd7Na649x50gy9HVr3Xx5sx9uldZdtPzi1kZy9P7AL8Exn5m6RKmyF4y
         Y2blurYnnOkwRSb+eG5OkCaTQUXq69RCMEc+noVQRI8fmhMMbzZIRFoI2GD5y9TClz96
         D1nP0FN5elWFgJB1bH7gFGXYWCsn9keSuphoaf4qtp1ASZ+a/GUBq3fCId+1MDsq4Nem
         9esw==
X-Gm-Message-State: ACrzQf37axvDWEwxxBG/lPrZ0CeBQ2e1dX/BwXqw1Y1VeBClcmoPTcvG
        hLABTDthTNDv0CYCe9T4gF1SRg==
X-Google-Smtp-Source: AMsMyM6nY7sNxH3PAXOplIR0CNRRrYOg/61kDeU+ppTPOusz6Hzev6Euv38+l4THkA3nyZ4g+ysgFw==
X-Received: by 2002:a17:902:ec82:b0:178:6b70:7eca with SMTP id x2-20020a170902ec8200b001786b707ecamr1729657plg.164.1663712473795;
        Tue, 20 Sep 2022 15:21:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709027c0400b001637529493esm426472pll.66.2022.09.20.15.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:21:13 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:21:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tanghui20@huawei.com
Subject: Re: [PATCH] exec: Force binary name when argv is empty
Message-ID: <202209201516.966D6EF@keescook>
References: <20220920120812.231417-1-renzhijie2@huawei.com>
 <87sfkmyumv.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfkmyumv.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:42:48AM -0500, Eric W. Biederman wrote:
> Ren Zhijie <renzhijie2@huawei.com> writes:
> > From: Hui Tang <tanghui20@huawei.com>
> >
> > First run './execv-main execv-child', there is empty in 'COMMAND' column
> > when run 'ps -u'.
> >
> >  USER       PID %CPU %MEM    VSZ   RSS TTY    [...] TIME COMMAND
> >  root       368  0.3  0.0   4388   764 ttyS0        0:00 ./execv-main
> >  root       369  0.6  0.0   4520   812 ttyS0        0:00
> >
> > The program 'execv-main' as follows:
> >
> >  int main(int argc, char **argv)
> >  {
> >    char *execv_argv[] = {NULL};
> >    pid_t pid = fork();
> >
> >    if (pid == 0) {
> >      execv(argv[1], execv_argv);
> >    } else if (pid > 0) {
> >      wait(NULL);
> >    }
> >    return 0;
> >  }

The correct fix is to userspace here:

  int main(int argc, char **argv)
  {
-   char *execv_argv[] = {NULL};
+   char *execv_argv[] = { argv[1], NULL };
    pid_t pid = fork();

    if (pid == 0) {

> [...]
> For a rare case that should essentially never happen why make it
> friendlier to use?  Why not fix userspace to add the friendly name
> instead of the kernel?
> 
> Unless there is a good reason for it, it would be my hope that in
> a couple of years all of the userspace programs that trigger
> the warning when they start up could be fixed, and we could have
> execve start failing in those cases.

Agreed -- the goal is to help userspace fix how execve(2) is called.

Speaking to the proposed patch, this idea was considered during the
development of the ""-adding patch, with the basic outcome being
that creating a _new_ behavior was not a good idea, and might cause more
confusion. You can see the thread here:

https://lore.kernel.org/all/202202021229.9681AD39B0@keescook/

-Kees

-- 
Kees Cook

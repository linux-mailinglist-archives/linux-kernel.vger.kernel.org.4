Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD755E59A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIVD32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:29:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6F2620
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:29:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e67so1764200pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pqhyB4n8mW9pESHxEHFTaLjKHSZd85Wd1s19sc/rej8=;
        b=IFjiEXaGfjMf+zDXXED7pAIe7AmwE8pJsNLQ7y5imCs7hbvhjIIBwZ95eD0WUnI0cF
         hv0iQ+VKd14d70uqHPnZJRy7xlbKAPBhlXkOiLlKw5/NsfQGJcxqrAz0J99b9TpU1IZh
         62vGXlFj9p2om12mUpkG42eJDs2xdngDU+1YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pqhyB4n8mW9pESHxEHFTaLjKHSZd85Wd1s19sc/rej8=;
        b=yy32W1FMFGo9YrsvLLPHZ4pSNsCxafr4S2SwmMOnRRAtyumlGuC/hhF5Gnw5EKvQHY
         8eVS4aABAjYhZPXUg4OJDAEZpuQmW2bOwqp3UBPVTbm1vERWknuIejFJJTWnRS/Bs9cF
         3gkvQUPrZuXshFfdEQoal3cW0UsL5ZW0oxmb58xNAYMsTxLDqHwrc2r/AKIcm6JPibZp
         Nj08uDtqG2TcTiPi3e/cbVgnNG2seAp0r3XU8TI/XTIM5EwhhZLlOKHGXHBzo8BC2IVf
         56LXCdvvf/050y8v16LObgIoJe04dhkiTJdOQwb5LKScibRjncLrQA0XqiN4iAreii95
         iLjQ==
X-Gm-Message-State: ACrzQf3vW42ZbW10y4CnScCZVxdB+GKQjQB4wNY0AlkawLvLdOFMrZrk
        s2sLVKmYMKb6uOJZ3731BAMrSA==
X-Google-Smtp-Source: AMsMyM7oQxMcmClTCmYIcTcbKqOxn/EPG5l5MFw2J9INIz5+Sot8bKKVxeWd9yeNgir6IPvcaVRbsw==
X-Received: by 2002:a05:6a00:2491:b0:544:2599:6f08 with SMTP id c17-20020a056a00249100b0054425996f08mr1447812pfv.47.1663817362744;
        Wed, 21 Sep 2022 20:29:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b001780e4e6b65sm2814874plg.114.2022.09.21.20.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:29:22 -0700 (PDT)
Date:   Wed, 21 Sep 2022 20:29:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fs/exec: switch timens when a task gets a new mm
Message-ID: <202209212028.0C060F98@keescook>
References: <20220921003120.209637-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921003120.209637-1-avagin@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:31:19PM -0700, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> Changing a time namespace requires remapping a vvar page, so we don't want
> to allow doing that if any other tasks can use the same mm.
> 
> Currently, we install a time namespace when a task is created with a new
> vm. exec() is another case when a task gets a new mm and so it can switch
> a time namespace safely, but it isn't handled now.
> 
> One more issue of the current interface is that clone() with CLONE_VM isn't
> allowed if the current task has unshared a time namespace
> (timens_for_children doesn't match the current timens).
> 
> Both these issues make some inconvenience for users. For example, Alexey
> and Florian reported that posix_spawn() uses vfork+exec and this pattern
> doesn't work with time namespaces due to the both described issues.
> LXC needed to workaround the exec() issue by calling setns.
> 
> In the commit 133e2d3e81de5 ("fs/exec: allow to unshare a time namespace on
> vfork+exec"), we tried to fix these issues with minimal impact on UAPI. But
> it adds extra complexity and some undesirable side effects. Eric suggested
> fixing the issues properly because here are all the reasons to suppose that
> there are no users that depend on the old behavior.
> 
> Cc: Alexey Izbyshev <izbyshev@ispras.ru>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Origin-author: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

This looks good -- my intention is for this to go into -next after the
v6.1 merge window closes. Does that match everyone's expectations?

Thanks!

-Kees

-- 
Kees Cook

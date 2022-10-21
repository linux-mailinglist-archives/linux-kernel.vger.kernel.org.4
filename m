Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4E607BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJUQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJUQB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:01:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77BB27211F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:01:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y72so3808638yby.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFj00Pytc1eVtk5kxWQzFS9bf1Zt+kboGQFUu9iOLCY=;
        b=blMCRxL83xZvPorKkb258kqBGV3yOjTV223sbCqOZEW/FqDCYKdFJCIDfKYnjtci0b
         5OCBCZbAnOmLoHzqtYU6C9+L19aZ91UeDMCqkVnaev5R5AJseFQkMUMvSJUtcORNHJcp
         red3TSWbYa2+dwPdgk9HXvAAenhWIDP89wGcZsZJ/nVxfHxKtbpiKtsyP3pgcM0eNe5n
         96empZlfTZZlxeQaogqSZQLfg/PP0Bg53dvvp9zHRswkTSgKDFxKN2gSFdNRjb7V/em5
         B5OKAbBMwBM/G6VoSH2Gj1VDlPLDBS+lVopx202o3+PPj66HcipjN4DO91HBYdghgxv6
         +OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFj00Pytc1eVtk5kxWQzFS9bf1Zt+kboGQFUu9iOLCY=;
        b=Pr+oZnDB8KesMOVXcmxdcW7PRxB98Pgf4fZPRR1iGgQ4YQIS+9ykIjZEVvvFlu6qMb
         xG4L56OI/pKEGBhI7h2EK9G1eDGORkoNp7KdgoWIrfs1UPxn49prJvzHdoqxxQECXWEe
         YA7tKYV24G0o22dnGtr9q/wLrkbn/HDc9gNYrngxbEHq43z+WND7J0qXy458LXT/SibK
         4ifx/l16AKa226irnXabA5vEr9C0TzIQD7JsZUa9AFvwflnL4C8RshWaIUi9qXkXcko3
         dr6vDZtdzitI/maN6Zt1LWQr+G0qZL1m5LkwWJY0X91AGhXUX0vRLJyghmom7zooQ4Au
         0o/A==
X-Gm-Message-State: ACrzQf0MP1NprJ7lmEwrcr4zdhdBsKpDYV3O5tG2E/iW5BRTJjyei9Aa
        6G+t3d+IqIGv5+cd4IlR9pX1hvHPknJdL/qsSP4x7A==
X-Google-Smtp-Source: AMsMyM7Tz3m5Pg1s6h7WSF0K+et5CufbXX1+XkslpjM/+CmQIbfo4cWyRz0IbZVJX5H02ofpOoQYXWcf2rm+wzmDowQ=
X-Received: by 2002:a25:ab2c:0:b0:6ca:1f6e:da97 with SMTP id
 u41-20020a25ab2c000000b006ca1f6eda97mr10150236ybi.231.1666368100015; Fri, 21
 Oct 2022 09:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221021040622.815143-1-luwei32@huawei.com>
In-Reply-To: <20221021040622.815143-1-luwei32@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 21 Oct 2022 09:01:28 -0700
Message-ID: <CANn89iK2N5Vo3XoTcxHJWu3XtDD=B1Axnr1axx-NbKvnAEHXxw@mail.gmail.com>
Subject: Re: [PATCH net,v3] tcp: fix a signed-integer-overflow bug in tcp_add_backlog()
To:     Lu Wei <luwei32@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, ast@kernel.org,
        martin.lau@kernel.org, kuniyu@amazon.com, asml.silence@gmail.com,
        imagedong@tencent.com, ncardwell@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:03 PM Lu Wei <luwei32@huawei.com> wrote:
>
> The type of sk_rcvbuf and sk_sndbuf in struct sock is int, and
> in tcp_add_backlog(), the variable limit is caculated by adding
> sk_rcvbuf, sk_sndbuf and 64 * 1024, it may exceed the max value
> of int and overflow. This patch reduces the limit budget by
> halving the sndbuf to solve this issue since ACK packets are much
> smaller than the payload.
>
> Fixes: c9c3321257e1 ("tcp: add tcp_add_backlog()")
> Signed-off-by: Lu Wei <luwei32@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

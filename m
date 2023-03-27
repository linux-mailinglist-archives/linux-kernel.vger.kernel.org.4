Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128FA6CA916
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjC0Pc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjC0Pc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:32:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9936F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:32:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so37929032edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679931174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIvQReY1/Tt9tUASlHa39t+YceqbsMK5EEQ4kAYFJZs=;
        b=DI4mWd7kssc8ivjpPnIbucqvY45WV0DTghFt1CHge5gcZelxoPBi/8pMkvAakL9/mm
         TkBfjH2khefzFWe7traYvI8KUpiC4p7WNZTzyzUEEoytU15Nh3xyTLvuHdItcXkb93wj
         uKu5t9cybrPWZuQzEXWxARxVuXREM2d1cMWbqxNwSzihu0yxytmqeltfrbSxQ+4UDDFI
         y+FJ8ThGjofjMhlnGtdwjs8sA8htQbUhZzh0vij/IYzncr8r7upkgWIJPqe4i5dvecfA
         r3z6XiBtu2ho7+YE/aMnwEIuu8v+4IPoL/Y/t3ZbbJ0mjA5KryswMprKhwtLh+UNUZ1I
         jJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIvQReY1/Tt9tUASlHa39t+YceqbsMK5EEQ4kAYFJZs=;
        b=pzIdaYef0cRogN9DrY0pVY7CeHQPuaaxigUS2IrOKA2sH6BY2Y7AT8sDESbA1OYvqz
         2lt+TgkjlzH1NYmA/Xlx6U4hVEI8ZfBW0F+uiDTIMYsjkPj6wRkUKnPkFmoRCv6uqnYj
         z3tyzTjOrfYcpqtFGRVYJrybfPQ61s24NnZ1WRqu3wDlBxisZZhkerV0JvPlPyIB1Vpz
         KqIjLvfLXjCz3rPoM0D8gJO922/sOIXRlLJdcp+oybdVBUdICRmGX2upIAsIO/8494l9
         rFlJRjUL3tJNaYH7M2oqS9sAKGy0wY7a3hoYJ7DaJydZk0HYC4IklJZ/59Aug4QS1v1E
         UiPQ==
X-Gm-Message-State: AAQBX9dtSZ0JvZcZPBK9GyyCzzNiz3z+dMjp6pqPmTsgnuKtnfXpwtZl
        wqFqQ96WE1NkT91SHPVcNQ==
X-Google-Smtp-Source: AKy350Z8sxZPpiEiZ7hmD6Q5jafDBmvxn4y5v8GGwMb+louNVLvBvpTw/CRkT1fRa688kqC8Zx5J2w==
X-Received: by 2002:a17:906:facb:b0:93b:752:d2a9 with SMTP id lu11-20020a170906facb00b0093b0752d2a9mr13285456ejb.31.1679931174118;
        Mon, 27 Mar 2023 08:32:54 -0700 (PDT)
Received: from p183 ([46.53.253.24])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b0093b6d1db84asm7773532ejb.120.2023.03.27.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:32:53 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:32:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <c0584807-511c-4496-b062-1263ea38f349@p183>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
 <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
 <ZCCgJSEIqLQ9ZIOC@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCCgJSEIqLQ9ZIOC@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 09:42:29PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 10:38:39PM +0300, Alexey Dobriyan wrote:
> > > I'm not seeing any issue with your approach instead, let's
> > > keep it as-is for now (also it does what the stack protector is supposed
> > > to catch anyway).
> > 
> > There are no guarantess about stack layout and dead writes.
> > The test doesn't corrupt stack reliably, just 99.99% reliably.
> 
> Sure but it's for a regtest which can easily be adjusted and its
> posrtability and ease of maintenance outweights its reliability,
> especially when in practice what the code does is what we want to
> test for. And if an extra zero needs to be added to the loop, it
> can be at a lower cost than maintaining arch-specific asm code.

For the record, I disagree. Use volatile writes at least.

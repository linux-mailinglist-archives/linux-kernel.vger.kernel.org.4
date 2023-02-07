Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301268CC50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBGBvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBGBvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:51:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45627212A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:51:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so17096319pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/P+Ysw+V8rM7aMjDpjokIi+ge5Io7jOZWNDRJqIR6sY=;
        b=lyvMNgYcfap+TaP7B8tx9iwmNS2CSy39y+O8jdJn5JgRidYXUX68QaVdSD3TrS/MTz
         5OtNBTVjNrvCc3MSy1K2Ia7mKegalgnH7W4NuF8NBruLyUoaoPvOHvqLPAKvIX5RctiR
         rvY2qZY8RV4Jeoocc4Dsmyp2KvcGLjok48E10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P+Ysw+V8rM7aMjDpjokIi+ge5Io7jOZWNDRJqIR6sY=;
        b=cTJAb7Taj2nhtauzn4CS72yENuCrFIBroM047LU7koKfwZP3nQYcVsdCFjWpWPgOJM
         D1/EqMSsNmMI/FXlv49QprujjZ2qGzMtUF/keR9r3FGvfZ2SwCisj03JEIOhUrxwr67R
         Xsv15PAI0eSZ2QUnRxXpJlTp6EqSjyRzf+HLNcaH/O98QpQMCFjZ1WnFp/uxTW9BIM7K
         61APuAPnaVIf9DJoZgEmB/ON8/x7yLIKOsGvmsYeyP153jIcTbmBEx4Y9F/mZ90tYZKa
         CkGyvfGYeuqCMggVuXenZ0ksHqj5IAxvVQVQ0w/28JlXu1YM2KfHjKAHRki2IKlKogOj
         3B+Q==
X-Gm-Message-State: AO0yUKWQ0BtRgrsXocBjhib6tLO/7CIvIFyGiNwywpTpXKGJw2IIFSDq
        X4EVURlzJQ5pa91LJ4XAaMuGnrqJ6avOhoWw
X-Google-Smtp-Source: AK7set8JNTtey3lYShCopEUgALNSf/zV5u96r9cgVV2l14Gc2SKcWLYkPtoIckg9mTnuVWTvPtLVVw==
X-Received: by 2002:a05:6a20:549a:b0:bc:a63f:423c with SMTP id i26-20020a056a20549a00b000bca63f423cmr1896483pzk.11.1675734697836;
        Mon, 06 Feb 2023 17:51:37 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id r16-20020a638f50000000b004eca54eab50sm6758773pgn.28.2023.02.06.17.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 17:51:37 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:51:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND v4] printf: fix errname.c list
Message-ID: <Y+GupENpWtqWXLRs@google.com>
References: <20230206194126.380350-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206194126.380350-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/06 20:40), Arnd Bergmann wrote:
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
> 
> lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
>    15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>       |                                                                   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>   172 |  E(EDEADLK), /* EDEADLOCK */
>       |  ^
> 
> On parisc, a similar error happens with -ECANCELLED, which is an
> alias for ECANCELED.
> 
> Make the EDEADLK printing conditional on the number being distinct
> from EDEADLOCK, and remove the -ECANCELLED bit completely as it
> can never be hit.
> 
> To ensure these are correct, add static_assert lines that verify
> all the remaining aliases are in fact identical to the canonical
> name.
> 

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

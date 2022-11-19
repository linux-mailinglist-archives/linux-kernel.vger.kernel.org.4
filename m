Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435E630AFE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiKSDN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiKSDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:13:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B4B97DA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:13:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so12080086wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WRoRAJzXbZdVpH5/85FgX4Lr3Dwq6As4FBoenx1ba+4=;
        b=jnWImsC+xU1HXX/azdDIpbM6IL4buvlm0Rw19hjfavzTbRS0uWj/pGvEUy6/fv3gV7
         sJYUPHHZdKOTw6K+D5uCEzpVyf7NxFYzAF8U0PEs6gOuFdPh2KZJ6Cwl/0b4063BWx9T
         WTzGugNjyIrrSHzcExgAQOyriIicEOQNRKoftU5isTUlETmcueIEJro32RE1ai6iUHjH
         6mlO5wKVKoQBSW4Xh3dxFh7Y80cZCbG9SEJsuQ1BDln5Uvck/evAh+GRzwC6kb5U17gp
         5LC3w3cWaa6fmz9xmbFVlRAjF8Mtg3MAocUoQ36/YAbd+TkrUf9TdMw9MimPv96v9xl+
         JzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRoRAJzXbZdVpH5/85FgX4Lr3Dwq6As4FBoenx1ba+4=;
        b=Hj/fGYRR9YwIkwaczlUdM8g/IBtf3I5PnyjzDK1B4g43MAkgCJMsEHkmXl8SCTZkPL
         nrFZmx5KtUxmdxvOb/oHa2tcwFIrR4lN+xM6Nc+CDam/bMjX9OT0YGBR4zEpoAbsyN3N
         ZO79wtoOFhtWFzLswtx+YLvYcM4UA6vWKd1OpmHni9ruI0hLgKn3+OQ0mc2VrwYkMx6G
         uOymFNy4cd9h3oQRhkSabu/ixKUVq7cEqhM2u6IWc2n29w87BpDETxECr0ZjhRnQwJD8
         gBYchOqK/emSt/PhDDgpVNHz4M3FxA+JedrasPuTukaEMTx7IETqmySrkwYULyF92EBv
         Y44Q==
X-Gm-Message-State: ANoB5pkrsXXZCxahWIRXR3hCTU3HQUmPew0Xxg43XI9hoMJCZDWbYzpr
        +5cPNzjdkpAUeSabSQS0ZM2+1Q66Mby8FbuZx+QuGQe1+FI=
X-Google-Smtp-Source: AA0mqf6XA4qo/20y4PUrdQ5wRaCgEyz9c+MVY9+Y6xyG//kswSrXNUuP69lxDLA+euU5tO23gBN9zC4NG1vDhWJh5Yc=
X-Received: by 2002:a05:6000:a13:b0:236:a920:73e8 with SMTP id
 co19-20020a0560000a1300b00236a92073e8mr5829682wrb.5.1668827601861; Fri, 18
 Nov 2022 19:13:21 -0800 (PST)
MIME-Version: 1.0
References: <1668825419-30584-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1668825419-30584-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Sat, 19 Nov 2022 12:13:05 +0900
Message-ID: <CAHqPoqJKG7sW7KcWnQNxcFL9a2iOhbqp-1D4W0BC+5-HRF-bhQ@mail.gmail.com>
Subject: Re: [PATCH] tools/vm/slabinfo-gnuplot: Use "grep -E" instead of "egrep"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 11:37 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
>         egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
>
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/vm`
>
> Here are the steps to install the latest grep:
>
>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>   tar xf grep-3.8.tar.gz
>   cd grep-3.8 && ./configure && make
>   sudo make install
>   export PATH=/usr/local/bin:$PATH
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

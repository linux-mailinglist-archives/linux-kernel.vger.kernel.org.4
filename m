Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99044641FB9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLDVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLDVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:03:25 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58FF58E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 13:03:24 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u10so7072277qvp.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 13:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKd7A2ySfckvcP/WSPOwepMQ4TZ0rFcNRmP+2MvjT4A=;
        b=XnfhUClfXXxSzRvNxJMqANfGlMdg+aWxnIGjQQjSdkLEcMH5jf2oJ4VjtiTUtKP7Zf
         JrIy1duQqMiXakjzyJSwOhxEC2ceVsoSnon2ncSf6bUed65NwhuzL0sBBMHvfVD8msZH
         edqW1lUF5hfB/SpOPxFKHU+w8jnTfDNfs96NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKd7A2ySfckvcP/WSPOwepMQ4TZ0rFcNRmP+2MvjT4A=;
        b=FFZzBgOsf9HIRxP0ch+n4XU2pDINjhEjBYysq9YRg+jlwHgWVe8SutMq/rfRszOtt7
         YWTONHGHtDxRHDSllt0XBiFPmt359QZLpA19EYTAXATBoZs0yG+0QwqJLCuRAc+bTo7X
         zDa/ATT5QnF7XEcZbE1CtoZNEk9vBw3dq4zoIa71lmOjlWp2J/tpAWO5IZXSsARk18T7
         aOtI6uE9jmUQUWG+c0htWtG3NbwiHtm61F1dI1xeAHGY/c6sbHoleUeb4cZqcIaBH/HG
         vYBCqPAPGtQw198AYmZqmV0qXgQcd3kLxEX9kZfjf+3QWOPLJMqaz313B5v+NMyHvcIj
         6cSA==
X-Gm-Message-State: ANoB5plZAoFHPJgyTLZUb+9cnoDr9tDARwFiPxmwAYKkB4ric20R68LU
        +vZFsKbICWSSo6x07mPS6SFcrO6ZGzrHARAf
X-Google-Smtp-Source: AA0mqf5Bqn/E0OpKB4k5jX0zyHqk65Jrbe01kqv0BeCFijngH7uIUROPzvsHXSgfPnUPmuDgBdaUaA==
X-Received: by 2002:a05:6214:3981:b0:4c6:a9fa:47f7 with SMTP id ny1-20020a056214398100b004c6a9fa47f7mr60778422qvb.34.1670187802875;
        Sun, 04 Dec 2022 13:03:22 -0800 (PST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id f4-20020ac80684000000b0039cc64bcb53sm8365589qth.27.2022.12.04.13.03.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 13:03:22 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id p12so7052754qvu.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 13:03:21 -0800 (PST)
X-Received: by 2002:a05:6214:390c:b0:4c7:7282:5817 with SMTP id
 nh12-20020a056214390c00b004c772825817mr542557qvb.94.1670187801671; Sun, 04
 Dec 2022 13:03:21 -0800 (PST)
MIME-Version: 1.0
References: <167016324121.413036.10816787460130337195@leemhuis.info>
In-Reply-To: <167016324121.413036.10816787460130337195@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Dec 2022 13:03:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCHBWN5VbCAc6=bKMnEBjdumqDGYG=X1E27VWG2H_WQQ@mail.gmail.com>
Message-ID: <CAHk-=wgCHBWN5VbCAc6=bKMnEBjdumqDGYG=X1E27VWG2H_WQQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-12-04]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 4, 2022 at 6:16 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi Linus! Below you'll find regzbot's report about regression from this
> cycle the bot and I became aware of. But first let me highlight a few:

Ack. I fast-tracked the tpm fix and the mm performance regression
revert that everybody seemed to agree on, so that they will be in rc8.

The others end up being less clear-cut and remain.

Thanks,

               Linus

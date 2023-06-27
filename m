Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AB74030F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjF0SRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjF0SRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:17:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C94187
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:17:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso51437521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687889835; x=1690481835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WtgfYTHi6I8JZ4MvciwexJ1Z4h0XfBA5L2+WUJORGE=;
        b=WLYlYkskDVo32palZZF8+iJHKdhcCy43cTuhbh5IR4Zz01SFb6rBNpDiYWLCvU2098
         UMgTl1S4gOzzWkkiexmk0Np/gETb8MPEBgq1zKxW0T+otAhsSacAySaekeOdmbhEqDpB
         RIfklIL36ktyVzB+JWSU5s/O2Sni8diRnHEmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889835; x=1690481835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WtgfYTHi6I8JZ4MvciwexJ1Z4h0XfBA5L2+WUJORGE=;
        b=iOtq75QXpxzLLSBAfNHwwgFxzaAt5XICq8+Qs+MMN/5VNZllKRcq/Z+Ch5tqGTQ6d2
         1W6NHVhgq7uk/X//xLfzAIBfedGi2IEVZASxbP9r16UtbMA1lbEpQmPRCEivEWLEb3Dg
         46PfY53hJIPKgnEtOBVvdPiIKDwtgHmyB2rGpmhYArGOixGR72k4kfbBbWJP1nTZR1Lp
         GpfTaSYi+ptQYHQSue0YLOlKjSfcNFpipzQI2fI6Re+glQz79Xa29KQZ8vOrPRgXA+w0
         7c+KE2AYGeC/MSxTfBH91R8J39SUwudBhfUs3ZsH5kd/6jZ+yj4agNkzQL/JaHDloTxT
         iW4Q==
X-Gm-Message-State: AC+VfDxXJYDSo/5f+V7K1Akvo4j8DUhyTGVFeYO0mPQ7DSN4j/6HuSPp
        4kZIAhvq/aL9fMBXr/yp0Pe8YuXCaXm7QHO0oHMQRg0A
X-Google-Smtp-Source: ACHHUZ50k078GHpN5A7f6lqzGkMeuOiQxyhWCIQXncp0LN6dJnPW8Kpmj9WDunT0+PISLNx+NIdEYw==
X-Received: by 2002:a2e:b60e:0:b0:2b6:982f:df9 with SMTP id r14-20020a2eb60e000000b002b6982f0df9mr5763370ljn.23.1687889835421;
        Tue, 27 Jun 2023 11:17:15 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h23-20020a2eb0f7000000b002b47e824518sm1824569ljl.76.2023.06.27.11.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:17:15 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b69ff54321so41610601fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:17:14 -0700 (PDT)
X-Received: by 2002:a2e:a314:0:b0:2b6:b2bf:ab4d with SMTP id
 l20-20020a2ea314000000b002b6b2bfab4dmr1933019lje.14.1687889834287; Tue, 27
 Jun 2023 11:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org> <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
In-Reply-To: <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 11:16:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB8AOsrje6-bLOt2xHS4MMxnkL=k-Danx17hL=jb3pyQ@mail.gmail.com>
Message-ID: <CAHk-=wgB8AOsrje6-bLOt2xHS4MMxnkL=k-Danx17hL=jb3pyQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 6.5-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 11:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 25 Jun 2023 at 08:42, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > Please pull the following Kselftest update for Linux 6.5-rc1.
>
> Hmm. I pulled this, but it causes multiple objtool warnings.

Sorry, repliedt op the wrong email. It's the KUnit pull that causes
problems, not the Kselftest one (which is next in my queue)

             Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D1F6124B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJ2Rf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ2RfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:35:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF2124084
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:35:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h24so5304920qta.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqpQmjad+jHpdMyOWzvRhWOYCEqrGvCFu9OYewrFBNQ=;
        b=EOq0roFccIxde/xokGChC5X/vq1RwLTKqaDlXunQmKD0kkzthh2sdKDqH9guzvm7DH
         7hRMbbtQr6Z9L2arZWR8HGnM77MO3eWKB3R65ArkgoH10MY+yMYhUPI5UjCVwNuMIJ3n
         L/hZ00WN4gghSpyLI4b9Qg8QLkdTZ+Hv/E1Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqpQmjad+jHpdMyOWzvRhWOYCEqrGvCFu9OYewrFBNQ=;
        b=bGtaGCM1B/dSxifahfGoXGPXUaaBwDGNQoKx9miW53xltxoW+OQcSh4Ntm2iohhxN1
         /83GqiQamUO9FfPCcVSye8cTK4OqWa9jPc8r/1coTU59NzUAmSqTNa/4lXu7dwEOmxi6
         joHudQXOnRqEbL6f5QayWODxpr0A4aB6gwe+3Q2l/UbonEHh2GePQ5xdfPu5ZhKSbn18
         Xu9Q6wibvW2uM14BS2e9K3hLcL0PdUupRCJasoWz8j6lMFuG0JtqwuZDmGpwzsSIsBR0
         4CElfFP2jKr++5CRtyHc2c6JYF1p660AiC7MB/UwENL8KInJpKBnXy5xTq5eD8OMC/Kh
         KZ/Q==
X-Gm-Message-State: ACrzQf0ecP8QqcsGHzQolbXehkr2/J+b0Jsd88GIBYQq2bklI+uVgrQE
        48uIBvr8P6k2gOrGaiSh1jC0w3vMmnaQlw==
X-Google-Smtp-Source: AMsMyM6KU42zW038v/Ci49Qf3ZZ8tSTvQFDerSGPOCa8TCMBoT3mvZ8oruoH4bu5C0NpkyYU7w5S8Q==
X-Received: by 2002:ac8:5a16:0:b0:39c:efc6:b370 with SMTP id n22-20020ac85a16000000b0039cefc6b370mr4374423qta.374.1667064918931;
        Sat, 29 Oct 2022 10:35:18 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006f84ee3a4f3sm1441070qkp.48.2022.10.29.10.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 10:35:18 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id f205so9454705yba.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:35:18 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr4655898ybb.184.1667064917770; Sat, 29
 Oct 2022 10:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221025200656.951281799@infradead.org> <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
 <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net> <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
 <Y1osYVoLrpCabNrR@hirez.programming.kicks-ass.net> <Y10OyLCLAAS6rsZv@hirez.programming.kicks-ass.net>
In-Reply-To: <Y10OyLCLAAS6rsZv@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 10:35:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgT_4xCPuAkz=w1zw_Y6F5GH7QPVPUtvhOxAPweSDRkw@mail.gmail.com>
Message-ID: <CAHk-=whgT_4xCPuAkz=w1zw_Y6F5GH7QPVPUtvhOxAPweSDRkw@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
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

On Sat, Oct 29, 2022 at 4:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Got around to it; I added the below patch on top and things seem to
> still boot so it must be good :-)

Thanks, looks good to me, and as I see your simpler version, I
realized that my broken MUA version wasn't "rox", it was "ronx".

                Linus

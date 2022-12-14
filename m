Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693E064C2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiLNDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiLNDR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:17:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93121E06
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id ay32so1547619qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pZzxYed+rirR3C2VJ7+pwucxo++7zostLTlZmXbVKVc=;
        b=fXKtYTIn4pZxcW36MOyoaO4EwI5DmglsMTAKTAgSVcStoq6jRQ2aeNQLNrZF1Zh1EX
         wEcbAKzRAa/NFu4iUCOyfs3DdC6Gt/TtM2rA+G8p67wA4fot/4wKnGfgBPTvrmPyu+EF
         PQTyQ31XCoS7261Bv0hrwyBwpExRTeC6Cywqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZzxYed+rirR3C2VJ7+pwucxo++7zostLTlZmXbVKVc=;
        b=xOOkDgbXnAZPFP1BEw7ADrs40fBL3zrMa9uMttN/oyNsVpo+FLF1ye9UkmGKMcTZ0L
         Z3pt70MevR41rDM8MzNuav2DfgwByqkeaFLALUdxsC9lv+AxaEjdCtWOb4cPrLrj73+J
         jDE57zDo3A2y7yFkzXZRaBbT3w5UHDiXP1upBIuF4a7hzHwW2LXae7KBO6nADg64yCLB
         xEX0XB7x14giVTAmliuaWNyxev2KOJCiawJjJEe6Xuz5LJvnW5g/yg7uWz26BGZhKcDN
         T8t7f28S0kFzef07vQ/3buv+QKg63MGjOOOWA1uK5kgZptoUWAoUogAqlOI9pMGXYHF4
         S+xQ==
X-Gm-Message-State: ANoB5plA7moWhKp0ClLsBmJMGjGMhksShXsdxf9AhsZAzPLKIdEhklNC
        8gPOKRFh5XtCqZ+uxvhtwu/+OrjGZ4RllwPW
X-Google-Smtp-Source: AA0mqf5phPgj3JTDn2kFkym9ob7pRFx1nTatk+NPKCANCC1qLnvBgc5WFV1zHnEqsfw6jbyUL+dh1w==
X-Received: by 2002:ac8:7117:0:b0:3a8:1178:5652 with SMTP id z23-20020ac87117000000b003a811785652mr17848556qto.58.1670987875352;
        Tue, 13 Dec 2022 19:17:55 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id bq34-20020a05620a46a200b006fb93acc788sm9313050qkb.6.2022.12.13.19.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 19:17:54 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id h8so730202qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:54 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10808413qkg.594.1670987873998; Tue, 13
 Dec 2022 19:17:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgDEq2LYW6rnfQXmEOSfF8ECPkuwjJ3CR7aC4N2zuRLWQ@mail.gmail.com>
 <34d950e1e11dc91281adf3d2e8bb52645b4a7d6e.camel@linux.intel.com>
In-Reply-To: <34d950e1e11dc91281adf3d2e8bb52645b4a7d6e.camel@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 19:17:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOe2ki51yGgxRFG+wcFv6K6O4u=19YhZKf029NxFSkww@mail.gmail.com>
Message-ID: <CAHk-=wiOe2ki51yGgxRFG+wcFv6K6O4u=19YhZKf029NxFSkww@mail.gmail.com>
Subject: Re: thermal throttling on xps13: unchecked MSR access error
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Tue, Dec 13, 2022 at 6:12 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> I sent a patch " thermal: intel: Don't set HFI status bit to 1"
>
> Please check.

Yup, just replied to it.

Again - I can't guarantee that I actually triggered the situation that
caused the problem originally, but it does look fine now.

               Linus

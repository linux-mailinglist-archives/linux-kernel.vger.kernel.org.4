Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E75628FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiKOCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKOCCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:02:12 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C42C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:02:11 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o8so8978835qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkzQiToEU9dB0dXo1aJ1m+wMG1bO3KSZ0nJlOMyyzXw=;
        b=d7zC4TWvN/HXA+TpGYf22VEIQojxkZq53V6wUqrwB1q87uUHPL6raoohidTNsegzO9
         BYgDelDDIB50tlWQQYfNsM9l1THt4o2m4X1bnIgwmzFsF+Vd0YwaGcb9SfEIDt/n3Smp
         7IrqJslt8eC3coW9ge0GNJJwDGJvX2B0vVKVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkzQiToEU9dB0dXo1aJ1m+wMG1bO3KSZ0nJlOMyyzXw=;
        b=SGZfaL9CjIJ4VendTmFw+Sra617N8/c7rYHyjFw3mEq38FRw98JLoCMMPU7AwG7eIY
         ckTgUquhUiMvxKZ7GHcv7yXGd1/zRwB4vrc/vVEPVUrDrgoil1LLAIBe4jtjYO18mlt1
         zhK8qS1oACcznzDVPDN2upstk6l8l56+/Uaq/c63dinxjQPo1PgY2w/NwMMWoKOD0zxA
         SEn/1YhBB8fKKNCytxXhoIzrX253orr8W8hi0Ry1QNA3jKHymPgNmp5OkJMX4VADJbIU
         hRW1kpmcX5z/Z5SbVAayVRbHnh/fb+HHJnHsDkwngf55ZhvL0aIYCsg29LlhYJ1zRc0b
         kc8g==
X-Gm-Message-State: ANoB5plEqea9T7mPMs6QI8STmFyMZ4VzzkVNOZbEx15+X38i8aaRmKJR
        7MdX9WC2nQViYZyqNwzLbv4/ZwvgDLSz7w==
X-Google-Smtp-Source: AA0mqf57JqRfgu3Ynkm0L5UMeql7r9D15QFIoP/ZTko3JbEeTE8kM+gIXa72+P5ghCyr88MvuA1D+g==
X-Received: by 2002:a0c:d803:0:b0:4ba:68ee:b470 with SMTP id h3-20020a0cd803000000b004ba68eeb470mr15455859qvj.76.1668477730268;
        Mon, 14 Nov 2022 18:02:10 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id m15-20020a05622a054f00b003434d3b5938sm6696271qtx.2.2022.11.14.18.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 18:02:03 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id hh9so7966740qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:02:02 -0800 (PST)
X-Received: by 2002:a05:622a:5c91:b0:3a5:47de:a214 with SMTP id
 ge17-20020a05622a5c9100b003a547dea214mr14770431qtb.304.1668477722237; Mon, 14
 Nov 2022 18:02:02 -0800 (PST)
MIME-Version: 1.0
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
In-Reply-To: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Nov 2022 18:01:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
Message-ID: <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
Subject: Re: CET shadow stack app compatibility
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
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

On Mon, Nov 14, 2022 at 3:15 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> I would like to make this go smoother all around by having the kernel
> detect the existing elf bit and refuse to enable CET for these
> applications, like this[1].

Honestly, I don't want to preemptively say 'this won't work".

That said, once CET is enabled in the kernel, and it turns out that
people complain that it breaks existing binaries, at that point I
guess it gets disabled again. Possibly at that point using something
like your suggested patch. But I'm not doing it until actual problems
appear, and until we actually have this code in the kernel.

I'm disgusted by glibc being willing to just upgrade and break
existing binaries and take the "you shouldn't upgrade glibc if you
have old binaries" approach.

But hey, I guess that's part for the course for glibc, and there's
nothing I can do about that.

But yes, once people complain, I'll just make sure that old binaries
continue to work, and at that point the glibc and tooling people will
presumably have to fix their broken situation to get CET at all.

Because no, the kernel doesn't enable CET if it breaks binaries.
That's how we roll.

             Linus

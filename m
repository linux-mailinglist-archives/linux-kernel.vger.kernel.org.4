Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B456EE717
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjDYRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:48:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C03AD0F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:48:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so45695578a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682444888; x=1685036888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxFO2xTMg36i/5Q7JJH9AJ6hiZ7aJBXinwK6USz+U8=;
        b=C+hC2vLGnqrjt5SK8tv5gRii/6G+4ON+BWBn3I7OgJtyc5iOGqVCLwciwDPWgAkQVZ
         WWSrszk2b7YsCbgx6m0IpcqPc0VUrVcIOOiKcmR5iL3hIqAd5shI03nDWeigC9X4OMlO
         Lw0iIC20hKARS04Tvaa4VSoi73dN47mvEBETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444888; x=1685036888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcxFO2xTMg36i/5Q7JJH9AJ6hiZ7aJBXinwK6USz+U8=;
        b=evYLmmZ60yZimnbEZkq7b/DguIaZUcmUGvvWGw8SUZGX9zOZte1A2I3EPZsUN707sV
         v/i9pCTmelIncN/W3ttNY8ySSjfAPFY2dpqiXMBG+5HcKt2s2b5+jH2ri88l94VfG7a7
         74ng0YkDjRhXeF/xIX1Kp3BXX85e1p2V08uH2g/M30nV97zSlTpuD4juYGvqRV2HnwrV
         Lbki99zx25AGJ7jt5cItKcxUo6sp45XKviKgwksvfYkJrnbYHHvaWF4DVQ2+aIn5qlCO
         QpOhXo8qkYthA8G/3DIQaQoFUyB6ltdDunh83Oetku+e9QGqVMf7fwpnWanHP3fCCoVY
         5TTg==
X-Gm-Message-State: AAQBX9f6fVYbdpPNSxIbPtYloyw/uVhNJerVlRxs1H9Ag+ZB+e+8wZVP
        Se7onniMnSNhlFdeSDUs3JJ1xhSSpOUUvDfrh3KN0Q==
X-Google-Smtp-Source: AKy350bLC+UXyA5tG78neKsa82EPX06trZv1cIZwZ0UFkFDehq8098elmzgHF/IDq/mLEfmCh+oyog==
X-Received: by 2002:a17:906:90c2:b0:953:838a:ed61 with SMTP id v2-20020a17090690c200b00953838aed61mr12680864ejw.30.1682444888178;
        Tue, 25 Apr 2023 10:48:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906779500b0094eef800850sm7041339ejm.204.2023.04.25.10.48.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:48:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so45695330a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:48:07 -0700 (PDT)
X-Received: by 2002:aa7:c50a:0:b0:504:81d4:118d with SMTP id
 o10-20020aa7c50a000000b0050481d4118dmr16059608edq.3.1682444887178; Tue, 25
 Apr 2023 10:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
 <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com> <20230425173520.GDZEgPWMmi7ZXrTLs2@fat_crate.local>
In-Reply-To: <20230425173520.GDZEgPWMmi7ZXrTLs2@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 10:47:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNnK--B_K7DHvU28PKX00fUpb9oUmSq9OpkOLPDrMkUQ@mail.gmail.com>
Message-ID: <CAHk-=wiNnK--B_K7DHvU28PKX00fUpb9oUmSq9OpkOLPDrMkUQ@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.4
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 10:35=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> While we're on the topic: when we send you tip urgent fixes, we base
> each branch off of the current -rc, put the urgent fixes ontop, test,
> ... and send them to you in a week's time, roughly.
>
> Now, after you've pulled, we could fast-forward the urgent branch to the
> next -rc where new fixes come - and I do that most of the time - or we
> could not do that because of, as you say, if there's no really good
> reason to fast-forward (important other fix, new functionality from the
> newest -rc a patch needs, yadda yadda) then those urgent branches do not
> necessarily have to be fast-forwarded but simply get more fixes applied
> ontop.

That sounds right. Do the fast-forward thing if you want to update to
a newer rc for some other reason, but if there's no major other thing
going on, you can easily just continue on top of your existing fixes
branch.

There's no reason to actively seek a new base if you already had a
stable base that you were on.

So whatever works best for you.

(Of course, at some point "that base is just _really_ old" becomes a
reason in itself, and then fast-forwarding to have a newer base to do
your fixes on top just becomes a convenience)

> Oh, and I'm sure if a branch is based on what looks like a random point
> but there's a good explanation accompanying it why it is based on that
> random point, then I guess that's perfectly fine too.

Absolutely. Things that look wrong when I look at the pull request
result may have good reasons for them. If you know there's something
odd going on but you had a particular reason to do it that way, just
mention it.

For example - I can get quite upset when I see that all the commits
are very recent and have clearly not had a lot of testing. But if that
isn't your usual pattern, and you had a clear *reason* for the commits
all being shiny and new ("I had to rebase to remove a completely
broken commit"), please mention it.

Of course, if that particular reason keeps on happening, and there' sa
continual stream of "I know I did things wrong, but it was because of
X", then maybe that "X" is a huge problem and should be fixed?

So the occasional oddity with explanations is perfectly fine. But a
consistent _pattern_ of oddities is a problem, explanations
notwithstanding.

              Linus

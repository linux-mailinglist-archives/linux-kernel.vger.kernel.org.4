Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F7613E05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJaTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:07:56 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFDA11C2F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o8so8945233qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIRCeB57mif3WLLjzHJdENrFUL9U/TfVQ593vGFl6q4=;
        b=PzRtrjqO02eaWa33Zq3luOuXf6b8F5IN//bl0BoITVBRXmcMh7nbJhnqTYWRRryu5y
         8iDxEI/HfGaS1+1tz8lnXx3Ny5EVlFEYhPErbdEJhiUGODUQeS5CyUWmCheYQW971isr
         K+Mc3Us7oEuRSM2JN/G6i+LXwzXpZEIcmSr+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIRCeB57mif3WLLjzHJdENrFUL9U/TfVQ593vGFl6q4=;
        b=hRo3O1eG0ih4hkXhPYcxJgB/6b8hdHGEWVyQnc/5PTshqGwsKgNPSigsbUifMNnvTx
         Hk9DMqke7fqCbwBggEEd5dAhH2xt0gY1rvvS1y7ANMY5e4atI7Rquc7GOl9WXxdo4qlN
         PJ8CjPXW5ENGux8tdiBWLgeiasFtqBhOc12my+8R+KsHxoYAq6BAC1L/4wvgpyGKPAiF
         9kr2H2eTN2cYnPgGwCOZod5upXgNVV4eGdm4141hLGTk0npBNJmqjOhuXCbaTYpdyqcb
         rEFMde6tjcIU81YpL4+DP5nJx7x3ciGRCZvs4xxZyvoA1xB1bazb9omIOXeGVCuVqzHT
         Q0CA==
X-Gm-Message-State: ACrzQf2epp5BQH0hpiw3tnCWdoo5GtHy4nMtsTKvICRpTzD3Uv2US+BE
        efNd8MwFOfTDPH5GWqfXuFRTJd13kxZFZQ==
X-Google-Smtp-Source: AMsMyM4Ee+TZhvFESxifDL5ZbYRMf3zJ0lb6HTgKveEGgF8voG8drknnCpgUM2yOpEkJV7laSI1VRw==
X-Received: by 2002:a0c:e18f:0:b0:4bb:5b84:fb2c with SMTP id p15-20020a0ce18f000000b004bb5b84fb2cmr12651354qvl.28.1667243274274;
        Mon, 31 Oct 2022 12:07:54 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id c17-20020ac853d1000000b0039cc944ebdasm4023765qtq.54.2022.10.31.12.07.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 12:07:53 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 63so14813677ybq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:53 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr2992665ybg.362.1667243272872; Mon, 31
 Oct 2022 12:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221031175256.2813280-1-jannh@google.com> <Y2APCmYNjYOYLf8G@ZenIV>
 <CAG48ez094n05c3QJMy7vZ5U=z87MzqYeKU97Na_R9O36_LJSXw@mail.gmail.com> <Y2AYecOnLTkhmZB1@ZenIV>
In-Reply-To: <Y2AYecOnLTkhmZB1@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 12:07:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
Message-ID: <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
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

On Mon, Oct 31, 2022 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, it's unrelated to the patch itself.  I'm fine with it in the current
> form.  Will apply for the next merge window, unless Linus wants it in right
> now.

It doesn't strike me as hugely critical, so I'm fine with it being put
in any random pile of "fixes to be applied" as long as it doesn't get
lost entirely. But if y ou have a "fixes" branch that may end up
coming to me before this release is over, that's not the wrong place
either.

I would tend to agree with Jann that the re-ordering doesn't look very
likely because it's the same cacheline, so even an aggressively
out-of-order core really doesn't seem to be very likely to trigger any
issues. So you have a really unlikely situation to begin with, and
even less reason for it then triggering the re-ordering.

The "original situation is unlikely" can probably be made quite likely
with an active attack, but that active attacker would then also also
have to rely on "that re-ordering looks sketchy", and actively hunt
for hardware where it can happen.

And said hardware may simply not exist, even if the race is certainly
theoretically possible on any weakly ordered CPU.

             Linus

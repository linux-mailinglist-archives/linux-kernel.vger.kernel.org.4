Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB325F6DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiJFSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJFSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:48:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC0B6007
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:48:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n83so3015398oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ9aXvF0UV+hPF6vLhTwevLaf+MHU+7z3WZDrs6PuE8=;
        b=C92DsrJa5pMHAVCLNB/mBu5Se8g4ReDdr4exh89KR8dSfA2vbRsHRJIS+8WJVKh7Hx
         x3HTDXWT9+itDjTTvo+rRQuBc/f4nbRtWpv5Kk6ZOys8syaQSHrTO/XveqoM7wUChlyI
         Yz8nvI/k5xSKmWTB2VxQGD63/h3PqBSNkLnZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJ9aXvF0UV+hPF6vLhTwevLaf+MHU+7z3WZDrs6PuE8=;
        b=7TesMG5NJcYVbrVQ694eJ/OWj0BC9Rwvopv9UHtdam4nHVn4KrcJTn3qtR9FLDL7Uo
         TKAz6UUDd9dhKrLrDlWCs3h7pXSArBokyUywwSbaxnZiIvj85C1unQ51kJkFJU6E7UNR
         sP0Z3CDlq46Z1Hd4MUkHNa/WKMmVZlGDHTzfsQZ1/yrwFB6/GbzEzEYM5MsSUNrB4Cw8
         4eqeecuHVoidAxuYVjIAtYo+uZNl44t6QXr8KP7VxkTmc7FtwUuOGDVuk/capW5eQ2UD
         fvgICrrkPo+f/8+bIFFDCscly9MUolsJdwuO6Olev2hDkYkqJVjKffNgOBduo6GSmi7t
         penw==
X-Gm-Message-State: ACrzQf1i7yIt8p78EUxwXol1wTsBfo2/kZvF/2pI9m965c4i+pFTC20T
        7Za6UkwWTghkZ0eS1VwIon0lhNt5N0p0RA==
X-Google-Smtp-Source: AMsMyM5JqsbuNRomH1eOZ6A4xFxCDoUZZd7x/4lNOlLoJCmfB/GW6PtZJKyxGXGns1Td4wk8WRF3ZQ==
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id h11-20020aca180b000000b003528bdac428mr5581657oih.13.1665082082479;
        Thu, 06 Oct 2022 11:48:02 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id w45-20020a4a97b0000000b0047f992f1b87sm699385ooi.41.2022.10.06.11.48.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:48:01 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so1998090oob.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 11:48:01 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr574454oti.176.1665082081255; Thu, 06
 Oct 2022 11:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
In-Reply-To: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 11:47:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
Message-ID: <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Oct 4, 2022 at 8:42 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Lots of stuff all over, some new AMD IP support and gang
> submit support [..]

Hmm.

I have now had my main desktop lock up twice after pulling this.
Nothing in the dmesg after a reboot, and nothing in particular that
seems to trigger it, so I have a hard time even guessing what's up,
but the drm changes are the primary suspect.

I will try to see if I can get any information out of the machine, but
with the symptom being just a dead machine ...

This is the same (old) Radeon device:

   49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)

with dual 4k monitors, running on my good old Threadripper setup.

Again, there's no explicit reason to blame the drm pull, except that
it started after that merge (that machine ran the kernel with the
networking pull for a day with no problems, and while there were other
pull requests in between them, they seem to be fairly unrelated to the
hardware I have).

But the lockup is so sporadic (twice in the last day) that I really
can't bisect it, so I'm afraid I have very very little info.

Any suggestions?

                      Linus

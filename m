Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78538606734
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJTRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJTRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:42:45 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58391E3EFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:42:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o8so162921qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aC0xfu1B6fNyRi+1a2HnBL+x9wtUXIlU+HXHRKa4l7k=;
        b=Tm1MXKnUw1VmVXhBYAslQYVYO9XkI9B0equhCEe2+4qqf2dyeJSPfCIFoOg/W5W2k5
         M8asFhc9A90rqAqHhu3BLnAWM9VJXmxyoyc+6UuJ3g5GOwiHxozmDuVLu6Ap38EQ59Yi
         R3qGIE/ZwrslbiK7DUV5hDTbmAWFjUEOzgDGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC0xfu1B6fNyRi+1a2HnBL+x9wtUXIlU+HXHRKa4l7k=;
        b=yg21C5V5SwVWCZEIEjiUMb82HK+TnmNCXeLasmflnIRYHuVqv2yRmbNntp9A9gUg1S
         Nwnb8vMtMOhkAjOIj9k7p+Y9r/6u7plkzsdYf1UkCq18kreCBSWXyl9549godBkwdWC7
         50tV276RZyeTVxG1qT215NuuHKvLAwsZ7/ah6BM8m5IQdFkxQg0YkcMddsCdPzNf3s1v
         msID7UfDtwlRW9N9BqQwqjo6ClRhU28MJ7dcEL+YGs/V/MzFjDYeUg8bDOX3bNCtirwt
         3936cAyN+l2Qw5HQdGvWoNiDSG3r+F0gqx78xRfL025//H3M78nB697kmXcltQWeCRXT
         yheg==
X-Gm-Message-State: ACrzQf0FKz1Ydro9HpJiZfwIrRIYA0i14FUrrUSRjZ8h1B/5lLFqD9Cl
        1KhOoPEQ2YvDMlBiGBg9FawUxEcA2cTQlw==
X-Google-Smtp-Source: AMsMyM71XM/yfo9FY/lRizu1VBHSlHqzXZUj3IEB8ZF02Ry2YYFSFzf6QXEKQ2M4wZMmst9AK9PVRA==
X-Received: by 2002:ad4:4ee6:0:b0:4b1:80a5:49e3 with SMTP id dv6-20020ad44ee6000000b004b180a549e3mr12690104qvb.67.1666287763870;
        Thu, 20 Oct 2022 10:42:43 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm7909759qkp.126.2022.10.20.10.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:42:41 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-345528ceb87so287247b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:42:41 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr12443561ywr.401.1666287761185; Thu, 20
 Oct 2022 10:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com> <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
In-Reply-To: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Oct 2022 10:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
Message-ID: <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:33 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Or sometimes with objdump, I've had more success by keeping debug
> symbols, and then trimming offsets from jmps.

objdump is what I'm using, and it actually seems ok on individual object files.

Now I just need to script the "do all the object files" and see how
massive the end result is.

                Linus

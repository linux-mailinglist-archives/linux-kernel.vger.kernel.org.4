Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51065F653
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjAEV7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjAEV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:59:06 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16969509
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:59:05 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id bp44so126654qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0w58Jmxv23GOP82cSaTaJVOpSQ/WlFhaNSuDNLLtbw=;
        b=ZWrnuV/+oK0I3Jv9lK5gtYSMcmV/0S825Fft8v4+B9jE01S0vbNlAglhlXm1JBzOnt
         hA789qQ/CxOJyLAVaAiljJ8LwxY9uzFDesBGbhGuh64/4VlEraovgbmSdg4YkcLxbAsy
         KmBIDGAcYFHhTBTNHQpsOXZR/a/BtttWpNy4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0w58Jmxv23GOP82cSaTaJVOpSQ/WlFhaNSuDNLLtbw=;
        b=X4157ePpWvbaou6EGXxerevxTkhtYGPYpHlhca+gPbngY+VcKhhh/i3bkxxk9WY3UE
         3RacCIgUtYqobH48rY6P6lwGKSEBwadD7CwEKVCB8gu4j5jbwxNd5Iyzv0thg+SO/wsE
         qQwU5ZpsXXm3S9FrhhU/prUxk7Cl87Xox6hgcJ3ADOLHfaXfy/f/5J57cdf+T01+VR6D
         +6bVMFOkfoO/0kwnp8TS0GQ6mYXu2p5U8B9WAUVRoYicPiCzq3Lz43XGSh/R1AGC/G1Z
         C+8OOesz2QxsldcLebnrg52QnJEi1T5ARLtwOjZ+a3FD9UJyDkqmDzB6gtVtTzv8pkmf
         2WMg==
X-Gm-Message-State: AFqh2krWcRNtbBEd7e9dXXXBULX+ItJq/KfUskjyRvIYzFRgkp9AI/YX
        lv3asX/NGO9/TFRGMXjzwWPdQmGeoTxXVhqQ
X-Google-Smtp-Source: AMrXdXsoIf9/VN/LDu8quZSAW6Vx2f5+qR52SA3Zfb4DxNRXC8ojn8jqEdj52TZKparBLBJAWmdAyQ==
X-Received: by 2002:a05:622a:400c:b0:3a9:80b6:8347 with SMTP id cf12-20020a05622a400c00b003a980b68347mr86251974qtb.1.1672955944808;
        Thu, 05 Jan 2023 13:59:04 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id z3-20020ac81003000000b003a6a19ee4f0sm22096836qti.33.2023.01.05.13.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:59:04 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id h8so18560608qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:59:04 -0800 (PST)
X-Received: by 2002:a37:a93:0:b0:6ff:812e:a82f with SMTP id
 141-20020a370a93000000b006ff812ea82fmr2294712qkk.336.1672955943954; Thu, 05
 Jan 2023 13:59:03 -0800 (PST)
MIME-Version: 1.0
References: <370a2808-a19b-b512-4cd3-72dc69dfe8b0@suse.cz> <20230105144742.3219571-1-Jason@zx2c4.com>
In-Reply-To: <20230105144742.3219571-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 13:58:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxaSHcHeo10JGz3EMJZBfC1LarcrerLos7uHbE1URhtQ@mail.gmail.com>
Message-ID: <CAHk-=whxaSHcHeo10JGz3EMJZBfC1LarcrerLos7uHbE1URhtQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable hwrng for TPM 1 if PM_SLEEP is enabled
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Altmanninger <aclopte@gmail.com>,
        stable@vger.kernel.org
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

On Thu, Jan 5, 2023 at 6:48 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> TPM 1's support for its hardware RNG is broken across system suspends,
> due to races or locking issues or something else that haven't been
> diagnosed or fixed yet. These issues prevent the system from actually
> suspending. So disable the driver in this case. Later, when this is
> fixed properly, we can remove this.

How about just keeping it enabled, but not making it a fatal error if
the TPM saving doesn't work? IOW, just print the warning, and then
"return 0" from the suspend function.

I doubt anybody cares, but your patch disables that TPM device just
because PM is *enabled*. That's basically "all the time".

Imagine being on a desktop with a distro kernel that enables suspend -
because that kernel obviously is expected to work on laptops too.
You're never actually going to suspend things on that machine, but
maybe you still want to register it as a source of hw random data?

          Linus

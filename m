Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EB5F2551
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJBUqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJBUqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:46:37 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98125EBC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 13:46:36 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13256dbfd58so1981646fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GA1eijPhe2qLHfwUccL2m31o18WRn+HtU/gv3+g46xc=;
        b=OQ5Fdojd2dOl5xXkqKGgU5wBp9DAbTQrcyIlOkSTvNgzB+qErBRKm4zcjxEI9C4Trc
         KNjmKitUVAp3JCwG2LUbHYnaMpen+vbGQxlsJperGdZuHM8s4F9EwhUbN8CR2zsL7RyE
         KeOYBIUftyho6wUoyQTJmezJBUVx4kY5Bed5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GA1eijPhe2qLHfwUccL2m31o18WRn+HtU/gv3+g46xc=;
        b=4bIcwgOq8rSPGuWW5v/sbZ5wY/YOxIGBn0hHaixY4ShCdiWDPM20v38/lDnkF6il/o
         0k7IPf05mXYPM9qFxZrdXqJy8UzoOcUDbVFmm9VkZmhDHgSoQNsTOERhP1KC5Rab0gfH
         3LWChcMSwYcYL9Or2IKOg2xbCLPIYwOHGnybwIl9LPeXfHHjLQPl2lRfgHCpQOUQep6l
         sazUurQ4Ldu6FPEzATljCIIyOv4E7ygVQSMkC3Apl1SmFadLgEmttOEVB+Hj1btDtsX3
         gnxLGyHT5CnZHl1shE+Up6dFe2/PSTJTK8Vf2Kn11tMCmehxjn9LQ8AH7JdlnANhJxWL
         3SsQ==
X-Gm-Message-State: ACrzQf0PsFo37d386rgtpUqlR/PlDbckS5+X2OxNHagCs+JS/GyXc+pZ
        LVUIcmKQTirlOQIWPeugDtNeAgyHXwXV0g==
X-Google-Smtp-Source: AMsMyM7GJzO8Y1NVv034nafwn1wTBiBWRD7LqBcvKTfUplLHFkXko2BJ477X+GjTnzVDne5tAc1xlA==
X-Received: by 2002:a05:6870:d60d:b0:132:7e6f:bd0 with SMTP id a13-20020a056870d60d00b001327e6f0bd0mr126403oaq.184.1664743592996;
        Sun, 02 Oct 2022 13:46:32 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id q23-20020a0568080a9700b00342eade43d4sm2026031oij.13.2022.10.02.13.46.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 13:46:27 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so5638003ool.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 13:46:26 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr7102608oti.176.1664743586515; Sun, 02
 Oct 2022 13:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com> <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com> <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <YzmhoglDyEf3z0n8@kroah.com> <ce0b5780-a8cd-83fc-5b91-3acc574f426e@gmx.com>
In-Reply-To: <ce0b5780-a8cd-83fc-5b91-3acc574f426e@gmx.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Oct 2022 13:46:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGZEGY7kDXSD3ryL3yJ6fMp-+zzdyRFUc30kW+512-2w@mail.gmail.com>
Message-ID: <CAHk-=wiGZEGY7kDXSD3ryL3yJ6fMp-+zzdyRFUc30kW+512-2w@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
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

On Sun, Oct 2, 2022 at 12:27 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>
> It's so weird to read this I'm just dumbfounded.

The *real* dumbfoundedness here is how you seem to think you have the
right to tell people how to work, when you've been told over and over
how bugzilla doesn't fit in the workflow, and isn't worth the effort
and time.

And when people tell you that if you care about bugzilla, then it is
*you* who should spend the time there, you say that you are
dumbfounded. Because only you can tell people how they should work,
right?

Please go away, and look in the mirror a bit.

                  Linus

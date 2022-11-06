Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E461E6EE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiKFWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKFWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:40:33 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B2FD26
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:40:32 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so7062281qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPf/Gd71vI86uhaO11Q8X+M4aTImSGV033adrVl/wKY=;
        b=VCC++cBKZ7VxBWi6idlukGZx46COL57+5Ta879dPbJ6KyYuP9H0snHPXPDQj/2+5Ex
         8nHdEKv41YdUbvE6TraKM7ODbirIa02klLClU6P5VM6IacmVVbwguLRqt0R48bwO11Xv
         ne7y2eswnt7KsNbliIdPcdUq4PsKrlF/MiZBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPf/Gd71vI86uhaO11Q8X+M4aTImSGV033adrVl/wKY=;
        b=c2PW67JhzIusx57SUEnPvFRLurFgvR5ilN4Z+4snSUwgFoOam2GizscqD8RpP3bbDU
         E3SDgpdUWA7JmKeYw4DujaNKX8fCLH8CZeBmzI2BS5jKuMLGZWPB6N63IkS4QB2TsjRz
         JKBUn8n6yO2hdMVBhCEbfONkJ0j2Mz+QSDTTAeGyjqZXE5XixF4enJ/Jtb9jO51oczSZ
         aW4I/WjlDTlO645LAnlmrml6vJjw72gTYUWaCGwJ3tmathAL+Ez1rwpyN6YLdlVn+fFQ
         zVnOopPqV2M9wHqm6y6HvswNXu23TjISHeSjzhOurKMjnv67PYFzDOgyAQFYsswT2beQ
         UOng==
X-Gm-Message-State: ACrzQf3m/UGCd3LIn6z76YcDRrzkRw6EsrMjbDF/Biq6vs9qg6x7M6sC
        jwitCK3uyx7IT3YpsVc6dvFM0B8u0+i9KA==
X-Google-Smtp-Source: AMsMyM4B7lJzQcgNELVkck2dHo5cAg29cXaFJeunnXy+UFL6Ob9cdGeUwPeAYBTGQFC32W+RCVnrfQ==
X-Received: by 2002:a05:6214:c21:b0:4ad:75e:93bb with SMTP id a1-20020a0562140c2100b004ad075e93bbmr43660846qvd.27.1667774431704;
        Sun, 06 Nov 2022 14:40:31 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id bq44-20020a05620a46ac00b006f7ee901674sm5335663qkb.2.2022.11.06.14.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 14:40:31 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id k13so7876639ybk.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 14:40:30 -0800 (PST)
X-Received: by 2002:a25:bd7:0:b0:6d7:7464:4859 with SMTP id
 206-20020a250bd7000000b006d774644859mr1588895ybl.362.1667774430652; Sun, 06
 Nov 2022 14:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org>
 <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
 <20221106160956.2414d73f@rorschach.local.home> <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
 <20221106165220.4d7e5dac@rorschach.local.home>
In-Reply-To: <20221106165220.4d7e5dac@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 14:40:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
Message-ID: <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to timer_shutdown*()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
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

On Sun, Nov 6, 2022 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can update the change log to include:

Yup, full running instructions for coccinelle patches is probably a good idea.

I've done them semi-occasionally, but it's rare enough that I always
have to look it up anyway, and I suspect many others have never done
it, so having it in the commit message is probably a good idea.

>       when != ptr->timer.function = E;

I do think that you should just remove that E expression and the
"function = E" part.

Really, _any_ use of the timer after the timer delete makes it questionable,

It doesn't change the patch in my testing, but I think it's silly to
have that very specific pattern, when the more general case of "hey,
if you use the timer after deleting it, it's not obvious that it
should be a shutdown any more" just is more sensible anyway.

                 Linus

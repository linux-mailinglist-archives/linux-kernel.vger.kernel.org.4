Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25A95BA048
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOROZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIOROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:14:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494398371
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:14:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 130so28681335ybz.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AbP6CVs2QyPBwuEArSUrorWYOdYxHwW8OIfOfTn5CKQ=;
        b=eOa25gfwje15AbAqwKI/mJQjw1D11JnbJ1y5vLhY0zMwPhKwwItsPsXB8GLxGFu7sI
         cwDeNb2HpbwezE7WMZF9aa2m2n3Qvt6a28Azr5tShVTCqLZigd3D+kOwm6ciP62uoVAd
         xhNdeXJOTzSTkx5W3OUAedy8cRtrHEA0+l8p77vEEQZBn8rsound+XYLc0x28T8woXQh
         IlOWBYgnt0FzFQlHrOD6dZajt0F22shBPoNgF1QOQxkhNYi3KdUItJuuBem/B7BmaNmT
         ZsDvrYVfcrNmbVRbGjAUEiQn9LU5OckBsiDWGwpPIrSKyCxALEi+CkKzEw01GjH4vLIm
         L+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AbP6CVs2QyPBwuEArSUrorWYOdYxHwW8OIfOfTn5CKQ=;
        b=4B2Sd2vkeKaH3JVVk34IJklzjT8QcURHupAvOcuGLgQfhi+rjR3fxPNEi1Fl0irWou
         yoM1jifoDHDeOJxcW3xbUs7r9Q7/UDSFpUgee1t7rBr12HIIeqBHF0cL9pPcBsC9luqD
         QZHruA3oMNehQDzZuJh6pFOXf51VVc8tFFqijPibpN20ZXYk/cOSuebxomklIYq7jj64
         tWwBu6iAMUYE66L+XL+29nt78SBmfEVYQuqaLYRLD7lje9DrTqi8FwMfzK0yN5ONTLIh
         yhKejdvb+wYgAFHkbIOwFQE3HbMPiIcbVgCur6yc8AUj/FBdJ05R/kRkmA8DuVzn8oJv
         5SZw==
X-Gm-Message-State: ACrzQf2YCnvF1x1YtxhPyrUfBAsIcAtni/szY1FD70lof0LFTEHaqHDE
        SaJsFlh5t6iqLq4pA8KmSeeW2V0ZqgyQqlRBwio=
X-Google-Smtp-Source: AMsMyM5ePgz3WZw5h5kzguoj3p8a7Ccsygth2HM2b53KBz7qrZFMHiJK6dKIc2jAkDWuPFT5BFMS9Xe4gYXoTMvfkQY=
X-Received: by 2002:a25:adc6:0:b0:6ae:e4dc:942c with SMTP id
 d6-20020a25adc6000000b006aee4dc942cmr684152ybe.599.1663262061676; Thu, 15 Sep
 2022 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220914080016.67951-1-namcaov@gmail.com> <YyLmEpJBG7fPZ8iN@kroah.com>
In-Reply-To: <YyLmEpJBG7fPZ8iN@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Thu, 15 Sep 2022 19:14:10 +0200
Message-ID: <CA+sZ8B8ogeKhNwvLtj3hSkTUg8AED45unEYP7GCGYuLq8Do8vg@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: replace spin_lock_irqsave with spin_lock
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 14, 2022 at 10:00:17AM +0200, Nam Cao wrote:
> > In vt6655 driver, there is a single interrupt handler: vnt_interrupt(),
> > and it does not take the spinlock. The interrupt handler only schedules
> > a workqueue, and the spinlock is taken in this workqueue. Thus, there is
> > no need to use spin_lock_irqsave, as the spinlock is never taken by an
> > interrupt. Replace spin_lock_irqsave (and spin_unlock_irqsave) with
> > spin_lock (and spin_unlock).
>
> What is the speed difference before and after this change?  And how are
> interrupts properly handled anymore in this driver if you took away the
> lock that was being accessed in the irq?

My understanding is that no lock is accessed in the irq in this driver. But
it seems like I am wrong. Sorry for sending a buggy patch, I may follow-up with
this later when I figure out what I did wrong.

Best regards,
Nam.

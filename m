Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF669342E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 23:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBKW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 17:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBKW2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 17:28:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B523318153
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:27:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m2so23789920ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMKDRs1lk34OrFvNVQWLS3WpiXxoEN/LYfhGx5x/hFU=;
        b=IH79DS3M0l1mAVgFhKyQehHTB+DbUiF3+hhzIIFUVk1nh0Po91xw++G416SsMO/ZcC
         4gjsFf2P6dazBaU4ouymoeADTw3d6T7nQllB/ePdX2+hBt0Qg68jfTWgAnzPfT4AqJF6
         mqcX3E/gcA5ZSuxYGWBoPw6TnKrVfNLzlYJYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMKDRs1lk34OrFvNVQWLS3WpiXxoEN/LYfhGx5x/hFU=;
        b=Ox8Nx3+sZp/wQtKUSf+LbKm/7Y/RIfnN9ER0KP48lXh/bxdZf2Z+hDTDIKxPRQYtGr
         q8ebuK3lH4vO1AzS61BlN6WfbILxRr98XCMPSJpit7a/lJo7q5KKLJ16JC5W/0N4m6S7
         xUNzywMPKDGks9WB+RmJgDbWIn2r/eWwP7sml7VVDqE1N9UhHguiNVhwQMqKkHzsAbJG
         JFf2zQK55WXpu6oEaYy3dnFh9Ato99X3woqo3VVxdygeAuyA6YC8NzhaEVHh3wXTopfQ
         kdEz1cdSKk/Pm/a5oosF82f8JCbdnEXtCXSmY4j59S3k6anDMce9/5sNklTMgupJCe3G
         GC+Q==
X-Gm-Message-State: AO0yUKXB5y8KCjrZdqzP6YhIkRR7Neov4PNPgRvwwzyBzB3vidZOiT3E
        xPciG7Rv46lzpe44ygp3ZrI3WeJnFW7sIcZdhBCnQA==
X-Google-Smtp-Source: AK7set9JpTVbpYWUVgepjW5bgCdwbzAkwbaYv/BpCtcgEuja4oCK7L8gRQDx4pRmHB1tc3UCXUgfkee/nxYBeAmfHA8=
X-Received: by 2002:a17:906:1ba1:b0:879:b98d:eb08 with SMTP id
 r1-20020a1709061ba100b00879b98deb08mr2688866ejg.3.1676154476257; Sat, 11 Feb
 2023 14:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v3-1-0a52ac225e00@diag.uniroma1.it> <20230210142634.2exh6mvbvysy3hqo@mail.corp.redhat.com>
In-Reply-To: <20230210142634.2exh6mvbvysy3hqo@mail.corp.redhat.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 11 Feb 2023 23:27:45 +0100
Message-ID: <CAEih1qXsWT2u_M45cuY0RbOts8RM2cM6iPDju07ZtT-gtgr=xQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] HID: bigben: use spinlock to safely schedule workers
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 at 15:26, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> [...]
> >
> > -     if (bigben->removed || !report_field)
>
> You are removing an important test here: if (!report_field), please keep
> it.

To my understanding, that check was added in commit
918aa1ef104d ("HID: bigbenff: prevent null pointer dereference")
to prevent the NULL pointer crash, only fixing the crash point.
However, the true root cause was a missing check for output
reports patched in commit
c7bf714f8755 ("HID: check empty report_list in bigben_probe()"),
where the type-confused report list_entry was overlapping with
a NULL pointer, which was then causing the crash.
Let me know if there is any other path that may result in having a
report with no fields. In that case, it would make sense to keep the
check.

>
> > -             return;
> > +     spin_lock_irqsave(&bigben->lock, flags);
> >
> >       if (bigben->work_led) {
> >               bigben->work_led = false;
> > @@ -219,6 +229,8 @@ static void bigben_worker(struct work_struct *work)
> >               report_field->value[7] = 0x00; /* padding */
> >               hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
> >       }
> > +
> > +     spin_unlock_irqrestore(&bigben->lock, flags);
>
> Ouch, having hid_hw_request() called whithin a spinlock is definitely not
> something that should be done.
>
> However, the spinlock should be protecting 2 kinds of things:
> - any access to any value of struct bigben_device, but in an atomic way
>   (i.e. copy everything you need locally in a spinlock, then release it
>   and never read that struct again in that function).
> - the access to bigben->removed, which should be checked only in
>   bigben_schedule_work() and in the .remove() function.
>
> Please note that this is what the playstation driver does: it prepares
> the report under the spinlock (which is really fast) before sending the
> report to the device which can be slow and be interrupted.
>
> With that being said, it is clear that we need 2 patches for this one:
> - the first one introduces the spinlock and protects the concurrent
>   accesses to struct bigben_device (which is roughly everything below
>   with the changes I just said)
> - the second one introduces bigben_schedule_work() and piggy backs on
>   top of that new lock.

Thanks for clarifying. I will work on a v4 patch.
Best regards,
Pietro

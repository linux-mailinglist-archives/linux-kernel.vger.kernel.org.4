Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B690690948
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBIMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBIMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:51:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361B5EA07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:51:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gr7so6024894ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywP3wLh4wvDo/QwHV+7wcEtytTJklLTirZ53i2LI+a8=;
        b=y57Jl30p79bkWAwhCErecjA1/fhZzTO0rQRmaFWHaJnrGCtBXwt2rgLlTjoXBVA9w5
         KZVVVbiPys08N6RJQsKe81Olitaki+L4gDlTKfTH49aHT6AZfrBuT/QwpENmsOuWp1pR
         NsOxYMQ5PUuccIOSYuZKcUfL6SseU2xmnLG7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywP3wLh4wvDo/QwHV+7wcEtytTJklLTirZ53i2LI+a8=;
        b=j+9077qVBMPYYNdChBCDKpU/EXq7InYiYG4OXsnbWq9tvVZjGPYcrP8oUhmzG60nzX
         0qRJDdKWtkoNSSaipHZRTLM1U7a7YkJu0s/0ZAFoxgm+YzAnslvMIodXocW6SsL4Nhtd
         l2B6wV8RHob1Uk0Y4Mvz8IorO1p+QJxcYP2aLhcFWEV8tl30/rvw3ZPdYIiIEyJSCz7c
         5qr4p53MsPQMI9NJ9gjxuZU36KES7JmCHV7IKlSgVS54aTXdqhksT7HcpOm+7YqIEAaw
         Dkk4GqcqZHgon7w2qaBLQUOkLjYzXM8a3q9Vmdb4LYJxnqTpS4H9m7JUEnIugjNauCfB
         rpIQ==
X-Gm-Message-State: AO0yUKVT81gAFXvjizyl2O4xY5hd5a8+q/+P7JdOMZpVZa97JxwkEE+O
        w8kumWGjM3CyQLeLD8nOn6+FtTR8T6y6XQ2QPCfgjA==
X-Google-Smtp-Source: AK7set89S6gOohopl7qmpc8RRReO1+qyCnm+U5+12hPjJ/MHQU8IzBZTxBKKWyR49jL9TO4Ct+VZCPsVPAdjohi/18w=
X-Received: by 2002:a17:906:1e0e:b0:87a:56fc:9df1 with SMTP id
 g14-20020a1709061e0e00b0087a56fc9df1mr459986ejj.3.1675947068622; Thu, 09 Feb
 2023 04:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v2-3-689cc62fc878@diag.uniroma1.it> <20230209085940.53mrapggf6nagkdh@mail.corp.redhat.com>
In-Reply-To: <20230209085940.53mrapggf6nagkdh@mail.corp.redhat.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 9 Feb 2023 13:50:57 +0100
Message-ID: <CAEih1qUU_aaHk7xFuyocgUq0pYLHemuRQiTboZDwyBTd7u2L5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] HID: dualsense_remove: manually unregister leds
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 09:59, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Jan 31 2023, Pietro Borrello wrote:
> > Unregister the LED controllers before device removal, to prevent
> > unnecessary runs of dualsense_player_led_set_brightness().
> >
> > Fixes: 8c0ab553b072 ("HID: playstation: expose DualSense player LEDs through LED class.")
> > Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> >
> > ---
> >
> > Contrary to the other patches in this series, failing to unregister
> > the led controller does not results into a use-after-free thanks
> > to the output_worker_initialized variable and the spinlock checks.
>
> And so we don't need that patch (nor for hid-sony.c) because we have a
> guard against scheduling a worker job when the device is being removed.
>
> So please drop 3,4,5 from this series, they are just making the code
> worse.

Sure.
I kept them only due to the Roderick Colenbrander's comment, but I'm happy
to remove them.
For reference:
> [...] I don't mind the change as it
> prevents the work scheduling functions to get called unnecessarily.
Link: https://lore.kernel.org/lkml/CAEc3jaCEKfqEJSV4=6GRj1Ry97xH+HwVSeEOZReNwkt=rLNvNQ@mail.gmail.com/

Thanks,
Pietro

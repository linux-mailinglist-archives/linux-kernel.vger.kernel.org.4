Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA166E3029
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDOJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDOJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:51:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106F30FA;
        Sat, 15 Apr 2023 02:51:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud9so51469691ejc.7;
        Sat, 15 Apr 2023 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681552305; x=1684144305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWQ55XCgxMzVrYbC4f0gRBhCKgR8TSk192DndIkYVbU=;
        b=D10Ide1QWyGQiItP6shdmRzVzxuiDNMeNaZhIi8tgc+Xf0lJm5xo71AgHGFGMhqnHF
         MdesI/Oh24NeXwgb0HNK7zq7dwz6sKXXIUWXyTLj5r1+G0lxGHQ9B03SvECb4vcEyTPw
         dPXzcXYY/Fn7wJiKFlljVscbPuGPevY/qV09k7cXEBqvnDoo8RAw+CEwHkilfQPn6AT7
         iHCNs76q3cY4mIyMJHeRZVyl+wX7NzcTwo1CDGufBL3Og1B4P5LrdNgfRIe+2QOJYgG5
         RCYBY9tSpd3FKtK1/olJikqbVt4CDUaJnvRQjS+E6QqTOLaPUZ1Q3CKt6KcRWcjjoEsm
         JJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681552305; x=1684144305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWQ55XCgxMzVrYbC4f0gRBhCKgR8TSk192DndIkYVbU=;
        b=Q1dneSN+C8UIkbbf/pmwYvcOlLTR+8EUM9jXkafd8xhuSWgUXlYFkcYYXBjuSCy6dd
         957+AeJ0PdxUT0ubqpI0CzyGBltHjf8hz21Yz3Z7S9JphZI1+sUnyRiUhDyGEt/VF2yf
         4/ryl2MDVKBIPekcyZw9IBgol4Ap9+UGgh3p1Gd8hkxzAAg//vHEgKt5T6Hf7fDGR7+R
         H1pJ4rSIRSjTzHaT2PW/r7Yf9lU0u34dGgW5vrHa1fOwXshhbLuOt3vw6YmsCzIV4JHe
         j7EUEOSQht47v4slIteq1HPLxn5+o1FAsIRspUuIzu49vdzTY94RS4JxzVpd5Vxn72w0
         ZKcg==
X-Gm-Message-State: AAQBX9d6wIAjTyjDl+s9VDfFWLilQeEgUacvXPENaIFXCTMQ0mm4ity/
        47+OVrKOSpAU9JcJRwqo7xDv22f03Ig=
X-Google-Smtp-Source: AKy350b1QR7MHj04ykvekWmpeGKoJxXk7uY+wdSd5IPW8aUUCxYmmf/ktNoJ8B2uWa0q+vqJAO8nZA==
X-Received: by 2002:a17:906:264a:b0:94f:2d5f:6949 with SMTP id i10-20020a170906264a00b0094f2d5f6949mr363481ejc.42.1681552305288;
        Sat, 15 Apr 2023 02:51:45 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id bl8-20020a170906c24800b00949691d3183sm3554040ejb.36.2023.04.15.02.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:51:44 -0700 (PDT)
Date:   Sat, 15 Apr 2023 11:51:43 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-sound@vger.kernel.org
Subject: Re: ALSA: arecord : silennce recorded as 0x80
Message-ID: <ZDpzr8VOD5w5UhsR@kernelhacking.kernelhacking.example.com>
References: <CAHhAz+haVH-4Hgsz0PpTgUSW1pX4XxwxXwEd7nLVb0sFFwQwCg@mail.gmail.com>
 <CAPDUAqPVDi4TgAja92tMqMp6rGAyC-eabS_6+W0zThKfsZAxGA@mail.gmail.com>
 <CAHhAz+g-Mtz3xhnU9hDHG9DzBuBM_e9_4n0BSRpALRJcyLF0LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+g-Mtz3xhnU9hDHG9DzBuBM_e9_4n0BSRpALRJcyLF0LQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is what I found after Googling a bit:
> > Since you didn't specify a format, arecord defaults to 8 bit format (U8).
> > Being unsigned, a negative value for maximum negative amplitude is impossible. Therefore the value is given a bias of 128,
> > making 0 the maximum negative amplitude, 255 the maximum positive, and 128 the center point (or silence).
> Thanks for the clarification.
> So I tried passing signed 8-bit format (S8), and then the arecord died
> immediately, as mentioned below.
> 
> $ arecord -f S8 test.wav
> Recording WAVE 'test.wav' : Signed 8 bit, Rate 8000 Hz, Mono
> arecord: begin_wave:2481: Wave doesn't support S8 format...
> 
> For other format S16_LE, the arecord hangs for a few seconds and
> throws an I/O error.
> 
> $ arecord -f S16_LE test.wav
> Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> arecord: pcm_read:2032: read error: Input/output error
> 
> I am not sure why recording works only on the default format of U8.
> For other formats, the record either dies immediately or hangs for a
> timeout and then throws an I/O error. Any ideas about this behaviour?

The flag --dump-hw-params should show the formats arecord supports On
your installation. On top of that .wav does not support any big endian formats
as well as no signed formats below 9 bit. You could try testing with raw
file type instead.

The i/o error *might* relate to incorrect device selection.

I hope you can pinpoint your issue to something more specific - and
provide more information - so people with actual expertise in this driver can
help you, I just googled a bit to not leave your questions hovering around unanswered.
Maybe take a peek into the guide on how to ask good questions, linked on
the kernelnewbies site, to make your questions more concise and worth busy people's time.

Best regards,
Luke

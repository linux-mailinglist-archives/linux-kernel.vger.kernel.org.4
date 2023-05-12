Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70193700DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjELR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjELR3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:29:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C9E74
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:29:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52c6f81193cso7186646a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683912586; x=1686504586;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=R1kCvuryMHsFO2mHpkYGGBtTve3Q7WEfvsZIrGLBy+M=;
        b=XPkEbnEQrJcA9kBV44J3LUSsi2+josMPi43vuSB+cYYZgQCDURMBaKkKZrko5jNQTB
         B6arjiJOAKw6WzD4phdJTPjlOFNEUWZ3n/eUopX4EpQ4diJQiXsiNW+Mo3ztQCHO0N2g
         1/iq0KhOIKBVIe6ttcVZDceplziC639WKs9LoeaWSvFU7H0q6kY0KgRfp5mrJ5lBj6Za
         jMNdHSxLyq06YLO7BnVBOodkM30w/SkOX+Ac09JpBEU189RDzg65iYT12H3fdJ7owyKW
         /VIF/d4neXcZDkgXFapNwcg0UmP8O2EmQOoLoyMDsjPXCKlUs/U/OEjGx/kg6mGwklD2
         XjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912586; x=1686504586;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1kCvuryMHsFO2mHpkYGGBtTve3Q7WEfvsZIrGLBy+M=;
        b=CRSEzYtN970vuPDqHyCXZUaMnCLKflJhQxVE9iM3am+k2AJFwAoLeQmhKMZob7cbjv
         3PCyjv0ENsfrUemobtRCvqMjzwE7tGEMEtdpRK20BAxxubX28MYAr+lAdz4oTSmMECXR
         /41Vw7mZ3Tc6DrST9IvjTF0wY87SgPHRZ3e3xp2kdmE3k7JKcVFxOxS18nZFM5imuj7u
         tziKMliRXBnPtUSsGez5uOnM+MPOyyi7Jgcvfe5GIXSeg6IjLQeosJgPC81fsolvCjxN
         HTo44SUiZpmTDwAPoKkBcZ47uepBQyhCwwGc6BjyPWo4mBGnhEdqBxjNqVdASPSnMgjA
         F0cw==
X-Gm-Message-State: AC+VfDzGul31qru0S9QymNYFXpRlRZIHghPypb2MjJPMLjxTH/0oCNJe
        QoTl6Br7a9fC/OwTA/FWcHAYNg==
X-Google-Smtp-Source: ACHHUZ7LL3aC8Z/WvhcNzSO5r4cxusiD6K6cemOQ3vp56w6AvA7Ok9DuYgCX82voHO6j5IkaDpbrOw==
X-Received: by 2002:a17:90a:7e90:b0:24e:272:2469 with SMTP id j16-20020a17090a7e9000b0024e02722469mr25665003pjl.18.1683912586345;
        Fri, 12 May 2023 10:29:46 -0700 (PDT)
Received: from localhost ([64.141.80.140])
        by smtp.gmail.com with ESMTPSA id iq14-20020a17090afb4e00b0024df400a9e6sm21935527pjb.37.2023.05.12.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:29:46 -0700 (PDT)
References: <a68fca00-666a-bbf4-b4d3-acd409dd69d2@gmail.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ryo Munakata <ryomnktml@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: Rust ENC28J60 ethernet driver working on Raspberry Pi
Date:   Fri, 12 May 2023 19:28:09 +0200
In-reply-to: <a68fca00-666a-bbf4-b4d3-acd409dd69d2@gmail.com>
Message-ID: <87mt29e9vb.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryo Munakata <ryomnktml@gmail.com> writes:

> Hi all,
>
> I've written an ethernet driver for ENC28J60, a stand-alone ethernet controller
> with a SPI interface, in Rust.
> It works fine on Raspberry Pi 4B with Raspbian AArch64.
> You can connect to the internet and play some videos on YouTube with it
> (10BASE-T though).
> I hope it will be an example of real-world drivers in Rust.
>
> * ENC28J60 ethernet driver in Rust
> enc28j60rs: https://github.com/pfpacket/enc28j60rs
> `impl Sync/Send`, mostly because of raw pointers, and the initialization of
> `workqueue::Work` and `sync::Spinlock`
> require a tiny bit of "unsafe" code, but otherwise no unsafe code used.
>
> * The forked kernel with Rust support for SPI and netdev
> https://github.com/pfpacket/linux-rpi-rust/tree/rust-netdev
> Forked from the Raspberry Pi tree and merged Rust-for-Linux `rust` branch into
> it.
> (BTW are there any easier way to get Rust-for-Linux work on Raspberry Pi? If so
> please let me know.)
> Then I added the SPI support referencing rust/kernel/platform.rs and netdev
> support.
> The netdev support is based on the following GitHub PR from Fujita-san:
> https://github.com/Rust-for-Linux/linux/pull/908

This is cool, thanks! I will check it out at some point.

Best regards
Andreas Hindborg

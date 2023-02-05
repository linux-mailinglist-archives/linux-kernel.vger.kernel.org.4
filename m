Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF568B18B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBEUR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:17:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1C5599
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 12:17:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu11so28907283ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuDqBGiso2ipHrhZ3TVaxXym8pN3xmoOWp0BE38pfVA=;
        b=W42BN5rreyugL2nruL5TpgbVeOyHyYADshRnETRXpZ5gWTEDwZoz/ZJhrzw9p/mSU5
         4GYap/Db9VgulivKnMUfaXM0q9OU1KpEiXQ5xlkckCsLSbJ4VbVzbPhSAelVtxyMtQhz
         VeQ+DzCoz5BKRUNlvjpF4X2Wterev09VDMhRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuDqBGiso2ipHrhZ3TVaxXym8pN3xmoOWp0BE38pfVA=;
        b=qOoCoLmh0dKgyDseihGrFFgopKzIWr17gLRz9pCoiWgSyGEktYq4T1TnfLCQvBX5kx
         51YSUNFBIPdJR0eCeAzNHio9CsEfunQFZwNTxiNaMw2n9KrJzDdwf4/+08PSKVSacGi8
         foaPR6JcKrKj9X7Dg7avP6QdIpbjJ2ckMbV5lKfJMazke1LprMAEZc6Uh+TDU5By2GPz
         +fD6Za8fdahdxnIEjSZbIo/fV6QzhmgLclYw9ldzAZM11FyX4eyxve0GR19cctjv5asv
         27Fog4MraqBYUX0/C/u0Zk6bw+UjUQ+hcgj2N1Ziwh02xOQuDP9CfK9tNGEZKnUMCAgA
         ZfZQ==
X-Gm-Message-State: AO0yUKXj9AL6rbimBO++2arMbjPMGYiWnE8kKpAtueZN/WJMr7L4eBq3
        VFmhnrMAe3U3DsSyUjfqeJEcj+GRVEfHngT0hrk=
X-Google-Smtp-Source: AK7set89hWceBNwzir/HBl3sGmuq9S6Tnzub8MEvrsobPttw8+fYjy5yYja/3Q0j4/SUMIa8qyt/SQ==
X-Received: by 2002:a17:907:d410:b0:887:9a32:9a2 with SMTP id vi16-20020a170907d41000b008879a3209a2mr20792179ejc.0.1675628243447;
        Sun, 05 Feb 2023 12:17:23 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906391900b0084d4b8f5889sm4511575eje.102.2023.02.05.12.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 12:17:22 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id bk15so28834958ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:17:22 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4391723eje.78.1675628242466; Sun, 05
 Feb 2023 12:17:22 -0800 (PST)
MIME-Version: 1.0
References: <Y9+Yv1CQKNP0Bwqq@kroah.com>
In-Reply-To: <Y9+Yv1CQKNP0Bwqq@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 12:17:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
Message-ID: <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
To:     Greg KH <gregkh@linuxfoundation.org>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
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

On Sun, Feb 5, 2023 at 3:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> George Kennedy (1):
>       vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF

Hmm.

I think the "goto unlock_out" should be a "break". A partial read
should return the partial success, not an error.

That situation didn't exist when the check was outside the loop, but does now.

Now, I don't think this matters for any sane situation, but since I
looked at this patch I thought I'd mention it.

                   Linus

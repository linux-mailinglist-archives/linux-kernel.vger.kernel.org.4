Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EA6A4C02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjB0UH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjB0UHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:07:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1428D1B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:07:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ee7so30799233edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oqSuHyd58upkN+REe6cNpWdbGmeGTPNZYBxYA3mJCI=;
        b=QNq5ZFOBMWMe087lgTL0w/9PiBLy3Nqgwhna58XI6PQXysMgseTVTYmKejL+jeRj6j
         LelmxO5Bq2l/Ve5cGo4Y55I8VkmuHqpaJv/KH+UyDNN2QSR+eFT7p9LBG6z6Az7Y9+Sx
         PZvVkULrHJM3qoerf5FLEgJVvwSUyWSeZz22g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oqSuHyd58upkN+REe6cNpWdbGmeGTPNZYBxYA3mJCI=;
        b=nd/N8x5jPzUu4Poc4omzIQ8DHm46sefVbnozD/I2mfw75i2Tz9hepjCDJMEbvv3/bb
         FQ9flPDggu2YOyXBhV1XQOG43dbrdO13OU2CJWIbEBfB20BdfKH4YqXrNWQWuuoxspN8
         nrgXnaMvElrj5yjeO9RgqGEu/QH81HHX+UyhikxA34U1i+KAJk69JQEBvMOndvQIdPmS
         cZnFmeYhpqG0jDPUoJ2biMm/jNAFs3IapA/vOxWtBOYulhp8QdXqH/e47rfZOEv3H1Np
         065CtjkF41Av3jtIls+AZP6Hej/GKyJZaLuZVuaKfWdH8cujNvn/3e4OKdBhazwddXI0
         XjyQ==
X-Gm-Message-State: AO0yUKV3bwMwQ+wTgMv0gCTpVVuKZzU1e+3AkldTBOIzigvRHiNuqtCT
        0rOUSWoym2e3OqviSmFHXYg7Xbu4/s0CBNzfed4=
X-Google-Smtp-Source: AK7set8IgaC/Lz8kE5/IbPFicXZ7EjWfgFokPyYnv5bAW3rw9F9a8qeWLQbqk1AVmsMCPJs8tSPLQQ==
X-Received: by 2002:aa7:de9a:0:b0:4ac:b2c8:aeac with SMTP id j26-20020aa7de9a000000b004acb2c8aeacmr754598edv.40.1677528425519;
        Mon, 27 Feb 2023 12:07:05 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906544f00b008f89953b761sm3501231ejp.3.2023.02.27.12.07.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 12:07:05 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id da10so30759626edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:07:04 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr13023299ejx.0.1677528424547; Mon, 27 Feb
 2023 12:07:04 -0800 (PST)
MIME-Version: 1.0
References: <1677527001-17459-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1677527001-17459-1-git-send-email-george.kennedy@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 12:06:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjaz=muuHR-bS9KfELeMf56z1BS2ecB9isAKxf0EwqCYQ@mail.gmail.com>
Message-ID: <CAHk-=wjaz=muuHR-bS9KfELeMf56z1BS2ecB9isAKxf0EwqCYQ@mail.gmail.com>
Subject: Re: [PATCH] vc_screen: modify vcs_size() handling in vcs_read()
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@weissschuh.net, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:43=E2=80=AFAM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Restore the vcs_size() handling in vcs_read() to what
> it had been in previous version.
>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Please also add a

   Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data
pointer in vcs_read() to avoid UAF")

or whatever it was that broke this, so that we have that context to
what the "previous version" actually was.

               Linus

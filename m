Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959756F4A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEBTOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEBTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:13:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E704213E;
        Tue,  2 May 2023 12:13:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a824c3a95so6031762276.1;
        Tue, 02 May 2023 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683054835; x=1685646835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7bqXSElpi/kZ95+932oHdNMDi2f2Hw+ckoBAhrXnLU=;
        b=NugvqEoNVCmNjjMu6rG8gjVmAacxV4qKihwwPet1KOg7WBeNEHQ3QykLvtHRCmiEoP
         /4JtJupV8eWfNDU0YrSN+cUrcCYrAlgSQpNnQP0l9i8nurV8GHCZl7vwzJrNB5K4DjRW
         kkOB0Mtq3rdzfsm5way8BcoVSF1TyzH3mZLEJG3eponnOoOLqjjXtXzbUV9gyY7dHxav
         +FpiQW49wLZ4Ka/UHpUSX9Z0C68HiLWTMdI+/Umrgz5vTM1fsVdLvZ9iCJKJWPbiahWb
         zoQqUk6lSJlwggyLc8UYURXhkkR3rFQYdUO89F7eHF3SP1CdPoO/Y159cLsHGLhSlv9z
         pJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683054835; x=1685646835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7bqXSElpi/kZ95+932oHdNMDi2f2Hw+ckoBAhrXnLU=;
        b=U8ptOWkMv1YiHAHE9TO1nDYh0W6udKJWCx0mC47loo3oi5cdQXaNENOeGgXCoMR8OJ
         WVPs3PcKM8QUne7s4P36iPEanHhz9sVNH4vvZB/m7ks1X7b/QBvlvz7ezkwBCwdu6TYr
         x1BrB38i36rp/mERqNOX/qRbOcirxaJCR69jvIwwOGd1tRWTF+zEhw7fccGt1vIekoBs
         oF4TrcUgci4/BNhInMUYSgb4Tv2uytrzsbRer5EDThgMNE92e75RQvyMyKZ3oMMMNcTT
         NrGbj/fn/T2eKY2uttqsEP96msvWJKefr8I6GiMbOklHOlupEwnb/lBpl55N7yeKq76e
         q1IQ==
X-Gm-Message-State: AC+VfDyza5+DarkkQ5uykHvR9GCnfLnSNbcpRTFvN4IgB7j/O600Gdoh
        BrnMENDZj8u3F2aYiP7xg/Bel8ioeH1VWs6fFZLm2JfC
X-Google-Smtp-Source: ACHHUZ6Z7yFXaaRPi3hIqKCJhW8bL57T6q3yhMHwB9Hwm3KXVJ5ba3Lnkt6dghfWd/qqs175p0LFPF+AzcxBRTiBcDA=
X-Received: by 2002:a25:e74b:0:b0:b99:75f:8f24 with SMTP id
 e72-20020a25e74b000000b00b99075f8f24mr19203396ybh.30.1683054835487; Tue, 02
 May 2023 12:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com> <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
 <20230426163512.GE18120@pendragon.ideasonboard.com> <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
 <20230426172539.GD2326@pendragon.ideasonboard.com> <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
 <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
In-Reply-To: <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 May 2023 21:13:44 +0200
Message-ID: <CANiq72m8cOWrO21PhUFcBap2j7ooKtAKdkOU9u8y-xGj_8fvoA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Asahi Lina <lina@asahilina.net>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Antoni Boucher <bouanto@zoho.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 10:17=E2=80=AFPM Asahi Lina <lina@asahilina.net> wro=
te:
>
> Unfortunately I don't think actually replacing the C implementations
> will be possible until Rust architecture support is on par with C, which
> probably means waiting until gccrs is ready...

There is also a second approach via `rustc_codegen_gcc`: Antoni (Cc'd)
showed in Kangrejos and LPC last year that it could compile the Rust
kernel code (with a few tweaks).

Cheers,
Miguel

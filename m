Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F16A2FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBZN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:56:20 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEA113FD;
        Sun, 26 Feb 2023 05:56:19 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53916ab0c6bso108058157b3.7;
        Sun, 26 Feb 2023 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2ts1GdBaI5yZyaOizgF74ytm6/pL7kpF7zQHufJ0bA=;
        b=VwflOH0TfCHFHLaMPZDGRDSxtmafqNNzSbRl2rpSUkyic0lIiewaF0bHQNH5KsLdeL
         2U06MboTEgDBNx4v1Nx6/CLD47KC4ITNQRlrzPlWNx0JFJwW+Ny69ucUl6NBv5vwQBOH
         fDvh/Tz0IyzaIJZSa6QdKLnJL6dyJT3n0+TuJmMQsHr0NH4DDpAzKA/tlkPWIww8bUZY
         vMjBGlpk0MK5EhDkqn2TECdylbuxwo7b5G7Di4Ob3iS5Flsh3oRrdnXuLrPBwmyza0FH
         sKKeQBvBIU28uaqDyxUynI5cuY/c+QuIO1pAOuIOF+5vObPpncAz7CaU7ZUnOokvOWyz
         MNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2ts1GdBaI5yZyaOizgF74ytm6/pL7kpF7zQHufJ0bA=;
        b=qVhvgqMMP2sWRzV/TNxr1s5dpHjCii4BHZvuOgic8ABEmIEWIQeJ6WQT4lBQoDjgec
         J3rXfsI8p/NV+lm3YVgvzK1ov0jPtYzX7OhYznCOA6fyeP5GWgNZ6To61rc/er7H07Km
         cAtoIOfZVGZjPjT2z+7i9Yg89APqwOiy0v57ceGZ0UGyA67tIrr0pA0+VEsUObfIHuFE
         JCAU5fdc1kEbtVNEwONRb3a0MqYONyRjtYytJ0MdfH6U9T6zGWn1GOVmeTF/O8QRrcxK
         dJC6kL4/pFpXj3jZCLK+nkZTRhLF8pmwFWlemkDvVunBqOnIj7YWQzNLaYykMjgtSOUj
         bVLw==
X-Gm-Message-State: AO0yUKU913Rtym2YgfiMt6Oc3LTfiDYnqRf8I0nrInlekQe5b2xynbqY
        Gu8I8WkFkAEwi1QoGdGvniOy83g13+GWIBsZE/g=
X-Google-Smtp-Source: AK7set+3MIhcC3XotHdZeApYs7aBgp83b5XfkTiXvXlXQXkp8joYQ4fYn3WpYA8XGIWBYphJvnqD15afjNTs1frIyhk=
X-Received: by 2002:a81:af5d:0:b0:52e:cea7:f6e3 with SMTP id
 x29-20020a81af5d000000b0052ecea7f6e3mr8296596ywj.10.1677419778344; Sun, 26
 Feb 2023 05:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net> <20230225221921.4b4bc87d.gary@garyguo.net>
In-Reply-To: <20230225221921.4b4bc87d.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Feb 2023 14:56:07 +0100
Message-ID: <CANiq72k7jN4COyGTGUCUc9jdmYcc53FHpOSOd=uLv_NLKR9gPg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: error: Add Error::from_kernel_errno()
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 11:19=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Maybe just `from_errno`? I don't know why `kernel` would need to be
> emphasised here.

Yeah, that sounds good to me. It is clear and we don't use "errno"
elsewhere. This identifier came from the original import, so before we
started to think about naming policies.

Though perhaps we can clean it up in a patch later, since we should
change `to_kernel_errno` below too at the same time. Or if you want to
send a quick patch for that one, I can put it in first.

Cheers,
Miguel

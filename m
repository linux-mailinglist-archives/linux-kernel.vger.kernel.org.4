Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59C6AF69B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjCGUWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjCGUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:22:44 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEABA6144;
        Tue,  7 Mar 2023 12:22:40 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536cb25982eso265730007b3.13;
        Tue, 07 Mar 2023 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678220559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBSyTdrPOJVHUi62H8HJoL0JClhcgKSy5jHuy2pt1Ro=;
        b=moRxMRhToGIlBlURExNXwaSqcDqloQmsfa6GGj7GDlwLRkD93O48yrUADnGC/lXSPJ
         V2GzzO1lYJkNgtJqoVmZm0aT4Sm3u3lU7Hi07XGKEzZrWMhuDxKZEopMfzNbLWhpBTRF
         7slSWL0b0G9RwjS9Zyd0L0Ud3ta6nb20QvbZuFQq7zksZtlo2337D76LNG+yePOD3SBK
         gQuDRvl5CbKHea+RINhAva920U0ekvqLvXhd6aZ8Rwkcj8C2Bd7qPEcaiPW1of7ifyW+
         /M6XgrYJklZmaQo+cVa8uBIJEv3il2+ty2MWxddrKfjJrs569x/u9QpK/pcBx2vykkDj
         dOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678220559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBSyTdrPOJVHUi62H8HJoL0JClhcgKSy5jHuy2pt1Ro=;
        b=edQQxAz8XjNL0keK1dE/TgZha12g+Et6ficUKjvpzPiWdbUQOWQyNyh8xmrml1rDGH
         nXFu1TtL1Devkf8BNYL7b6wp2Rz9OI40geHIlkyb78YUD4146LIcNpg09SlQ9Vf96Tgn
         GOtsBjeFTdseJbZunabWoyYawT97fZ1oD1vqElXopiAy56y2DZYtQ3/QlEkEaVEYr1Ej
         eH9v21rQ4lGjsKJbkBeSJ2iGMA2DGZHfn6chGKISWUDOK7yw1lCDthvuj8gcjU4G+7uv
         dd7vIZsGrUOeN2WtM9AESUAbTPNvDbcjSoUnZePOv5bTK/3ZWHLvT4GFNov4MaHCh4oq
         MLow==
X-Gm-Message-State: AO0yUKWsxt+GtHPnmGh4Z1Sb5H3qeJee83HRDX2146zEDmsvcjRPqY+9
        wk4iORISd/vJpINiTNLrDvthDwQFsBuOvCfn384=
X-Google-Smtp-Source: AK7set+L982y6Gqt0c6yuAz3Ny1/mK3S/lN4t37WxZPkJKzOI8RPld789a+1NBfsZIEjJtxEa8/6pZZjmpfINNZCZ/M=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr9466387ywh.10.1678220559220; Tue, 07
 Mar 2023 12:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net> <20230225003156.4858d79e.gary@garyguo.net>
In-Reply-To: <20230225003156.4858d79e.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 21:22:28 +0100
Message-ID: <CANiq72mSjqkib1gpocT3YbWRMz1Uj68Yh5DTZjthAd+=z_4tSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: macros: concat_idents: Allow :: paths in the
 first argument
To:     Gary Guo <gary@garyguo.net>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
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

On Sat, Feb 25, 2023 at 1:32=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> It seems weird to me that this is called `concat_idents` despite
> working for more things than just idents.
>
> How about just implement a simple version of the `paste` macro instead?

Opened https://github.com/Rust-for-Linux/linux/issues/983 in case we
end up applying the patch.

Cheers,
Miguel

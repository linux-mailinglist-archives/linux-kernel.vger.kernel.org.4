Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8C565C865
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjACUsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjACUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:48:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AA311;
        Tue,  3 Jan 2023 12:48:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 186so34441223ybe.8;
        Tue, 03 Jan 2023 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duAdSZgkhcA7cc0zesMwNi8WiFxSphG7fXlOLJEeLBw=;
        b=BoHDK28hBRmwxKsS48EJAqumEn9XPz2jIk2d4T2n2f1GgS+6Gxs7VpTj6RzGGmvGCv
         V6ea4JDTaw2RMkP5koQDKrsBSmmR8O2QPnhm/H0twBrymEYyIvN3jQJKoULwztX4uPqb
         DZtP4lknvC2KAol9ytugiaLKOPUpus1Sa+X63KiCZEsN2ZyjIRKAkDHS2LkWNJRFWInf
         FN8JEPF0U+3T39cUjP562n61zU60UllhbxJuYA/WzBFX03JAhGJedjz6a6eKHqKe9oU5
         Zzbb1hzOhM61y494APqgqVlnGnSMqbawt0rJu1YvLEE+d9206aFlnGQhf5KP31+GwGfz
         62lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duAdSZgkhcA7cc0zesMwNi8WiFxSphG7fXlOLJEeLBw=;
        b=y+GVFRxagxUbRDhnWKY0JeV/3dLRgnLMdQd4cvZd/tDo+GUVpv45L3CTHAt1LCSdsJ
         VT84tZHogT843AxLrvARMtoaO9PIeRyRJRCqa4xxmiX8f2K/zscE7i/+mx6YEW9EC/x1
         LnPjmQSVawdKonSO1D+VvBl+a07CHNnfpijJK3kfmWelT+fRRFUb3mhvyuVr9hE9Cs6R
         FLTs51sZDzoejlvOrOZfsMQMGiaVxQzgJw8SjT0b8RPRUEaB+6rHB/pzaRLCIqpPFVhY
         8x3udw/idxf6xfII+UAN1w14r5SPKZ1hTQPXRQ31wK9jd18YuTjMHKDY063lgkGsE8Iq
         alZw==
X-Gm-Message-State: AFqh2kocBR/dOzah8nJuWFxRE0HeVrTROeMMc5BiO1SJKJhnuqO20KxM
        dGyQ9P13PszQu3PoaiLV8of52jZbz76RWKjWV0A=
X-Google-Smtp-Source: AMrXdXu7h3AK56tJ03BL4g1ut2vqiv8Nz5cNJiDAoHXKlID+o57/TAlbvZxogAXPir6kGBgsFXCH7DKPp+y6fH77Ieo=
X-Received: by 2002:a25:b95:0:b0:744:76b3:8aa3 with SMTP id
 143-20020a250b95000000b0074476b38aa3mr4416884ybl.581.1672778896953; Tue, 03
 Jan 2023 12:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org>
 <CANiq72m5E1MehfqdrkmJt43fAzUMc9kEKu7x4WaALdgDGJ30-g@mail.gmail.com> <CAK7LNAQOaLHizg24CrMUz7veX0fa0QYwgJzAi5tOT+-CDCmUzw@mail.gmail.com>
In-Reply-To: <CAK7LNAQOaLHizg24CrMUz7veX0fa0QYwgJzAi5tOT+-CDCmUzw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:48:05 +0100
Message-ID: <CANiq72nDTJyeS2Re9zayaUsE67W9cuTrOgpKjxqKmJ67u26Qaw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix dep-file processing for rust
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
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

On Sat, Dec 31, 2022 at 4:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Yes, my plan is to get it in the kbuild tree with your ack.

Done, also compile- and boot-tested each (on top of -rc1).

Cheers,
Miguel

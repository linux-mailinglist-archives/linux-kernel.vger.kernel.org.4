Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CA73DB96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFZJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFZJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:40:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3ADC;
        Mon, 26 Jun 2023 02:40:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd729434fa0so3406805276.1;
        Mon, 26 Jun 2023 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687772444; x=1690364444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkfbd+mjNe8bYAliUp48UHONMltNteP2PilREF950C0=;
        b=aWdnVxIX9AMIXDoeSX0DZZNbyDBZ5SOrIICrTxz3TkgvZk9DurtkLA+RCKOOXqEyiX
         iYbrDEvea6k8aMkIfl9g/oeaWZhvFKotA1gccu3aXbK0Hmn+Rl6gI+0/+6Gp9LA8J2te
         TWgVB/MM06FqE5S7p/mxD2DHog01Yk0P+vFdWBvGJAyQR3hOvITUbKs2MLoOMse+ph8l
         uTsl05GirF5DVCZ1gz6sLmAYdzcxKPkQWojPFXq82nGwiEJKxhv1+gKa9dGP5/DmLdC/
         l7TgJSmQLVupDg0joVMHWvKGUs2WLirPIS0nRRl1K7b0fGAw+SQ3JUJktdBUOaGKhf4/
         dOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772444; x=1690364444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkfbd+mjNe8bYAliUp48UHONMltNteP2PilREF950C0=;
        b=f8GZo91sSf3Dr16+Pg/enycN+adXp4HgzI0qE5Lm0EsLoYZkJBVsVAjEePWV8J/KXu
         Jode4nVkTmgsc5hQylp2aSLIj6OvaW8UpB/U4MZ6883/IIjWwFAj83a0z0sy/NDnvYMN
         XEyq8zvn/Hm/RU5mTu+iw+C9f6qUM6Wx0ST8fhop3f2qE5FkqUPE5tm6z8QHaX9mqZzy
         k1Gsr5KH5sOhfBD0MBNXjeCfC4ynR03Q113ajYF7KRH/V6WfkqZMYMPdNHgC0a0Daf++
         rYwWvgquG2lu7dazgUYk5lu8FgSzSCvynu909cgOcamRjl98jyaUwp8PJVZrpJ3DaZcV
         vY9A==
X-Gm-Message-State: AC+VfDxVfTVKvfoJXM2oJMLSjuoN8gqgWCaQwQcNNvZSx2fPdiBU9MCY
        rIRaY294SRD2WvkexmKY4H0H2CDvMZFKhS2YNMvEeesZ
X-Google-Smtp-Source: ACHHUZ6TWMgGAy4/efXJ77Q26EdA0AgX8OxNUeLvDcH6OmvDK1ajBKzXHbUP9w0zeDEP4iwrSlVrTzahI8yoHcUYtLU=
X-Received: by 2002:a5b:c8:0:b0:ba8:3613:76a8 with SMTP id d8-20020a5b00c8000000b00ba8361376a8mr27531316ybp.41.1687772444135;
 Mon, 26 Jun 2023 02:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230625232528.89306-1-boqun.feng@gmail.com> <a79002ec-aa2d-1eec-58be-372c3b2a0efa@gmail.com>
In-Reply-To: <a79002ec-aa2d-1eec-58be-372c3b2a0efa@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 26 Jun 2023 11:40:33 +0200
Message-ID: <CANiq72kVUv4djvhLxz5tRYn-U2kXZMs0N1M=CZxdznnN0jY47Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>
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

On Mon, Jun 26, 2023 at 5:34=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> I think that this should go above Link and Signed-off-bys, although I'm
> not sure if maintainers do it when is merged.

Both styles are used, it is fine either way. Personally, I pick one or
the other depending on the kind of comment.

Having said that, there seems to be a missing `From:`, but I can fix
that on my side if Bj=C3=B6rn is the intended author.

> Newbie question, aren't tabs in the commit message verboten?

I am not aware of such a rule, and there are commits in the kernel
with tabs, e.g. commit 9828ed3f695a ("module: error out early on
concurrent load of the same module file").

In any case, that text doesn't go into the commit message, because it
is after the `---` line.

Cheers,
Miguel

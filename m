Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8A6F56D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjECLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjECLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:02:56 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609E5BAE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:02:28 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-44faec9af51so117650e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683111747; x=1685703747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI5Vmo1n9WVQ52iHISY1XSCymjgacKmLWlfwdFrbt94=;
        b=wQdFGYuqSsDhzrL443sj/TI+sREIt7TLgtUMwAJo2IxdDSlaOVfWHAlYXmtZifaesR
         BwDjv3sUvJ9L5Rqqp3hYulZy+Y5Z9mibm+i1LByHJ+48ThnV7k9TekyqIk3IYARbGuju
         XNku37Bg9ZmXnuCb7XXvuooX4el722Em2JyPemlnnQKZF2R4RA8iJqP5srpUVSYuxo3S
         qoZpgZ7gCnZq0z5bFX6joslypxteNg1ssnJtIk2eG2pMm7zLxzlQ7b2PmGeMPzaKdOLy
         Et+kQ616N1hGFMcbVWFB32CbY43U/afQF6bLC8Fljznlo/blu+Fcix/yQ4UO/s+OkdS5
         EhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111747; x=1685703747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI5Vmo1n9WVQ52iHISY1XSCymjgacKmLWlfwdFrbt94=;
        b=DFqjYXEW50/L6A0wr7eIGwr2/nC93XOhbwTs1QPc93f1vA4ZCNFPKqP0K9hQMkeh6J
         Xv7fYVBLzthWXzOKzhgKehSHmSuWiJX2cJ2fi12W9O1NhtCriQN+Js3fU06kSgL8bMqO
         nfVRhGAucqMscvA+/u1+lKgCnY0UaWwY0us/UVMlPeuntYRKlO+LAhsAVAg50QG3FekR
         1Z0ZbVscQHsUYO7Pxec93K9C7+1TbOJJw3g/YY0UssjYvhCR67nfkLCE45h2v2WZRSs8
         mHyNM+TzLiagpDH52wRcIY7fXdSaTYGvUkv9tbvRjX6/QH9yKTPRsynyKwjdbBzTcU+B
         kQLQ==
X-Gm-Message-State: AC+VfDxm4BAsptn+kdq0iJ/m5MLtEJQoMTokqx/OySZmpdFASw51xCnF
        y03fx7IhP27xVngO6enCrzzGDmmWYyJTUepj4bqL8A==
X-Google-Smtp-Source: ACHHUZ7a5yuleZaxORTVPNKd+rxoBKRyDLVjIwdER/Rea+eKxqfnJsgDo4w/7lXvEkkRAjVgc3nJCSfw4PxyL8fRoZE=
X-Received: by 2002:a1f:4d44:0:b0:443:ddfb:d58f with SMTP id
 a65-20020a1f4d44000000b00443ddfbd58fmr5643234vkb.14.1683111747034; Wed, 03
 May 2023 04:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230426224748.34056-1-materoy@proton.me> <20230503105935.518315-1-aliceryhl@google.com>
In-Reply-To: <20230503105935.518315-1-aliceryhl@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 3 May 2023 13:02:15 +0200
Message-ID: <CAH5fLgjq8-pq_6mO6FVrnfeHwnUKPR+h_CF_XWvrvJ_w8SXXkw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: error: add ERESTARTSYS error code
To:     materoy@proton.me
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like I messed up something with this email. It's supposed to be a rep=
ly to
https://lore.kernel.org/all/20230426224748.34056-1-materoy@proton.me/

On Wed, May 3, 2023 at 12:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On 27.04.23 00:57, Roy Matero <materoy@proton.me> wrote:
> > Fix sorting of rust/bindings/binding_helper.h's includes,
> > to maintain consistency and rust idoms
> >
> > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1002
> >
> > Signed-off-by: Roy Matero <materoy@proton.me>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

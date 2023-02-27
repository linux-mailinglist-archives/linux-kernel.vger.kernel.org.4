Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785A6A4359
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjB0Nw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjB0Nwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:52:53 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB03C2A;
        Mon, 27 Feb 2023 05:52:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536bf92b55cso176232507b3.12;
        Mon, 27 Feb 2023 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpHoYwBSJYrD+dy9oWzkcgpva3nGOcVMTl9avKAE77k=;
        b=RMNjwlwFyEj0eQRR/s+b/9HN3KQrlK6zHKN7pnqbC9jBEyosiPM3kyuStsDITeQyvk
         Ml/TMeaxU769rgHfji9Abpixu2Z+RO6Z8YWr5F17A2vHK/r+MrAWGHERHpUPTmton7tl
         Lnp60HD0KcDhAzTfQiBc+QBREoMcGlyEVpmVMJTdOa3g5Ak9/7aQto2KyNWH7jhFsX9m
         VkimLpEHfn1AO64/s5z3rnl0iTSfHdDdAN94jsT5drIEI35IvLkZiw/kO/e1/tJycqY8
         aUi/cYMTiKYA0k8+AQALxCI5R+8+vfe1KC7yuUP3R+nN4AAaYleTTzmzHiM11AXQMnBJ
         z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpHoYwBSJYrD+dy9oWzkcgpva3nGOcVMTl9avKAE77k=;
        b=PYXlRNPuOej0uZzhVpBNUOaME7/nfCOChQUuV3gOIXxNuTOrfCCyhSMXWUU4N4zvl9
         BBKPvLb578BhXGK7G3NMTYh1kN8dvJ4+CV6VIbhUFrWSwvNR0FUop3XiRLHWgpYE9YdB
         THj/Vx6CbzhToKB0i2BDqGnI9zXTK9H+BR96wWSbQ88jMdcRfqZ+vtKJXb6GeJ8gBsyl
         mPjbv4ukbq2Yc1bR2sVMwG2Pn5qpojULc8XfLnnWcWx8ktbXt3+H/siBWg/EY5xRcJmG
         XZNC6ISEc86E6PJ4+OG0m0/8dSB2urovOu6ua9esN6AnH6LPPrlgMCpINBgjl9Ny3ZKp
         BNkw==
X-Gm-Message-State: AO0yUKXn6nrwIvmSZnvl7ZdB/ULbsfPzA3RfBDdiQOvyon40aRR0GUA5
        XvJF2aNmS4bHxYPcRJAgbL6+bea8iK7W4ZocHXY=
X-Google-Smtp-Source: AK7set98yphOPe9BepvIDu25JZbS3zDNASmaTD1t1U0BDqTOdcpo/jqpm7Ks8YTTrowrcWXJsvKGX2uES95BodH11Wg=
X-Received: by 2002:a05:690c:c1a:b0:533:9d13:a067 with SMTP id
 cl26-20020a05690c0c1a00b005339d13a067mr8132245ywb.3.1677505970814; Mon, 27
 Feb 2023 05:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-4-f8f9a9a87303@asahilina.net> <87a60z9qb2.fsf@metaspace.dk>
In-Reply-To: <87a60z9qb2.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Feb 2023 14:52:39 +0100
Message-ID: <CANiq72mxFPs7fcdPMuuhEY0a-iNsbCwc9dumbFHoJm=aiNQvLw@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: error: Add a helper to convert a C ERR_PTR to a `Result`
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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

On Mon, Feb 27, 2023 at 2:43=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> For consistency, if `from_kernel_errno()` should be `from_errno()` this
> should be `from_err_ptr()` as well?

Sounds good to me.

Cheers,
Miguel

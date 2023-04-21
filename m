Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA816EB52B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjDUWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjDUWq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:46:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255F1FCE;
        Fri, 21 Apr 2023 15:46:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b8f34bca001so2934465276.3;
        Fri, 21 Apr 2023 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682117205; x=1684709205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUUOIxrjpun/24RZv7I8ONxLUOsWypQs9rpKT/sGscM=;
        b=Q8aUqJuWAgeaQceyp3w7NMH6kiF/bAlhEBz0LOUheInmP3kOueg8pAgUKhqV394irT
         PqAWxm6mnhI78XaqtXQZWDSUtP5gPyR5UFsgf97x2Z5IcnzdekCfnB5ixtnkROc2ubFw
         qY14EDO/S/W4ozktddGWRVbQUyLHyZ6LKygUHC20VxSaQ5o5PtECnmYPz4H5URTYwinE
         RzemI+UIR4tm+0OeMaW037iVsB2XPVWy/9KJ1JjKsn9SB5hvRNW2/C1OEXqwnDzgwdzC
         NuyU71JQSvBSP+NbOfanjl/vEvgW54aaHUOsUTFYOmImBov0zqm0NvV8RjV2Fvv7VRtd
         nPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682117205; x=1684709205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUUOIxrjpun/24RZv7I8ONxLUOsWypQs9rpKT/sGscM=;
        b=ZIdO8Hjodnr2xItB3LGQCiLNGvzykFZlazzS0BmJSoD8huOzlFBR18ialTFPHfaGwh
         +UFEzgc58S0+HQbsC8LZ/331NKmrDQt96YZuMEPUjsEncb0h2IAjoCnB23ewztwDQ6Fp
         vKKtFKYEPs+4WEZFar3SBONAjReHOFc8aroDsiB4tPk3KTMiNxZlssFb4ZHjxOdsfqpi
         Kg8aa0JC16TeFZE5TVHa3mGjrItGqUYQl/1+j1zGUWShDn5045/wNH/s1OWqjveBvZf+
         UmHd2cjsY0U2Ht/1m9KM/NxlVSW7biaQStgYwwxelIx/WIhemY85WH0f3rfFjT4ASRBA
         thAw==
X-Gm-Message-State: AAQBX9cctxft//xjwt4g46c8nEnmM1CsPTsgWtU5bPR5BtdVqPssOe3W
        4l850rMCKo27/MWGoBGjINnk4lGb8nJRIPWqERo=
X-Google-Smtp-Source: AKy350aAwaz5VZPCRreYkS3JrJcWaOP0Y6dLHzltykRV9YdT1BXuRHlfrSKtjt5f2GbfmQR3Zmrmj0j3/wZE4zDHG5A=
X-Received: by 2002:a25:2085:0:b0:b96:f486:9efa with SMTP id
 g127-20020a252085000000b00b96f4869efamr3478748ybg.40.1682117205383; Fri, 21
 Apr 2023 15:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230413100157.740697-1-benno.lossin@proton.me>
In-Reply-To: <20230413100157.740697-1-benno.lossin@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 00:46:34 +0200
Message-ID: <CANiq72nbRDp5Ei0dzkKZJw16CzO6iXwXaBZUigz7qKdjBn9ypQ@mail.gmail.com>
Subject: Re: [PATCH] rust: init: broaden the blanket impl of `Init`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Thu, Apr 13, 2023 at 12:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> This makes it possible to use `T` as a `impl Init<T, E>` for every error
> type `E` instead of just `Infallible`.

Applied to `rust-next`. Thanks!

Cheers,
Miguel

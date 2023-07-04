Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490E74784B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGDS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:28:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE0E72;
        Tue,  4 Jul 2023 11:28:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso6531409276.0;
        Tue, 04 Jul 2023 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688495332; x=1691087332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3PJtAPnB3IiOfzd5jucwamisnKKM0e0SB/4qZ4XKIo=;
        b=PkS7NgwqRmfIMF+Qr68qlEEcL0GZwMKb9hLfgb6BG/0Ru1T8ToIIZ2UVzCIWv04Msd
         y3Ku1mPqmecCsdTmAO50wznMyefunXF2YM3+L0TXcYCLqyRkKmzBnXZVk7Oi7xtuMltj
         zF1e984lnshfnm3M5wnfYegFdfBfgG2uS5pATaTAbClfIfWQu81OMKyO4Uiy2PC+5fSJ
         IxWDFiQiJ3n7CUSo9xSHkO9EAKKC7D+AtqeQkmmIIPO65OIPJxHRrOFfBR3b4teGgj+E
         /ytTm6PonxiIpbOlClF8jCdpJO6xoPBN1znQIK1iEcOaV5YFoQEvX8Iw8V44awyKOqSq
         4Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495332; x=1691087332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3PJtAPnB3IiOfzd5jucwamisnKKM0e0SB/4qZ4XKIo=;
        b=RgzGqihdmZ0M9X4qHaRCp8cSBeCcz+ycedk7tfOJa+W6SzBjA61tWGELFS7sodpIfk
         STvSccouGtKe/YNOeloW3Ea92a6f7fWpjdK4J8O/idnNB/UhZH2PqTR2A9DWqUScxndm
         RZrWlfd5dObLA1SfdgDsjR0axiaMxHeNP3HiaKIzAo9+4+1ftXeUiBFKW2PLo8s+ZLCd
         4WVFxF6JQ9Gq7yhfMvOxd9JpEt/vXcRQdnfpXZfiX2p7rjaksk0TQP1rvLsSkO7juvdR
         AfduVGf3K2I6ylcX/Z917nvxVf0MvmVzGkq9oZigQwQ37c9DUdgg+zuURQrfOC2Im9XR
         KkXA==
X-Gm-Message-State: ABy/qLZrUXWk9vtjcbKR6VzLyyC9qW3IZ8nKht8TlL604CdJvzYBLwya
        1v6+iWsG75yJYYdEPgDDopKcWWaL8Zs7kWg119zIUZHp
X-Google-Smtp-Source: APBJJlHqL45XLlvtAgnlxZhS+dQ462SKuqcXGbxGvaYICYWSwfqPu0MLxOYOn+xW9zmnVGFgd9FkKt5LT/osIExGN5A=
X-Received: by 2002:a05:6902:287:b0:c41:a05d:5da7 with SMTP id
 v7-20020a056902028700b00c41a05d5da7mr11166993ybh.5.1688495331770; Tue, 04 Jul
 2023 11:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <327e5e5a-5aec-316f-c4b1-b1dfcbb4c44c@lineo.co.jp>
In-Reply-To: <327e5e5a-5aec-316f-c4b1-b1dfcbb4c44c@lineo.co.jp>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 4 Jul 2023 20:28:40 +0200
Message-ID: <CANiq72kZeLs1oWbUeZtx3CkGQxMa3Qnn3neV_yEfC+T_D-xtww@mail.gmail.com>
Subject: Re: Rust for linux build error due to Clang (bindgen) version
To:     Yuta Hayama <hayama@lineo.co.jp>
Cc:     rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Tue, Jul 4, 2023 at 11:06=E2=80=AFAM Yuta Hayama <hayama@lineo.co.jp> wr=
ote:
>
> I am a beginner in Rust and LLVM, so sorry if this is a rudimentary quest=
ion.

No need to apologize!

> But I think this patch is still in the rust-dev branch of the rust-for-li=
nux
> tree and has not been merged into the mainline. The current mainline kern=
el
> seems to have a issue where if the Clang is too new (16 or later), the bu=
ild
> fails even though `make rustavailable` passes.

The upgrade to `bindgen` will be merged after the merge window is over.

> Does this mean we need something like max-tool-version.sh? But that might=
 be
> a bit silly... If such "error occurs because the tool is too new" is repe=
ated
> in the future, I feel that it is necessary to check not only the lower li=
mit of
> the tool version, but also the upper limit.

`make rustavailable` already warns for "too new" versions for `rustc`
and `bindgen`. We could add something like that (as error or warning)
for `libclang` too, but that particular issue goes away with the
upgrade in place, so (at least for mainline) it is OK.

Cheers,
Miguel

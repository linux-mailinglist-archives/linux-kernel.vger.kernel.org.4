Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9925265C858
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbjACUpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbjACUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:45:41 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857C1409E;
        Tue,  3 Jan 2023 12:45:40 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4b718cab0e4so1509437b3.9;
        Tue, 03 Jan 2023 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WtaX5rgNEE8X9vVIt7pdi7IDfT2jiUlHpVuKAzMWDm4=;
        b=EY3Ag657qNIy+G0o5zyQtPYRszic6Wkmv6x14IgiIJDvmg8wRjB+kAFsomNXdugRbq
         TQ0jTahxXO9QIn7v8Um8VQtD4OT2UiBaftY3pjzGagueWKVhIhVsphbXFJiakNHdGXRg
         F6Xk7igQzsop37sbuX73smVrGaLaT+E8Gg27NR+uxyV4HPdlqhw5v3zX8g4k56DQCvrp
         G3p3PEVuyvdqeY1gRrF8UmctvwY95npBIBxdyCrGwxLu5FEAwQMqTQWV5zdTP8Z1gu6N
         7SMmbkIVt9tyG/ZhFu04d555CLtaEMBjaBF1+DQs3Y3UUttzchpCGIHF1F0g++mslJ40
         qyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtaX5rgNEE8X9vVIt7pdi7IDfT2jiUlHpVuKAzMWDm4=;
        b=ixdtHLKf5CmJhkmohMwA/uH5MWCj3oLctimabvhnkbR0liKhsnaFECGfIEy9G7OHdV
         udtJ22Z2gp8aNi5XLyaCf2hfRuTz3dko/Kl9Q933AodSy7oWt5YEw2oCQ3MPYEp1/K99
         4Wd8ydQ5m7F65ba9nl71z2OLH35Ziiq59IOxcrdlP5udw1pe83vIiiYCjIfV912wBavz
         PKdV4nm1BJJVx4pM95QMXocqK1qfl1x8iMG7mIetUgcrT9f0XveB0KxPf8F8K0pbGIdB
         C8lkTs5L7nnP5dmk66WAX4agv4xmR+EQMrqFfkWbM6sta9aKsc1fF0nn4eNZpQspHgup
         qwyw==
X-Gm-Message-State: AFqh2kpjZ36tntmF9IwkFXLSdM4gqW2musRfwHTQLBdICcexOQxT/W6D
        nfC317fxqhpjwaVXfPMFzdvduI2IEsEhnJrm0e4=
X-Google-Smtp-Source: AMrXdXv3RMIAOz3FWgR7hVgZiRP9TllQFm+is2m0R0QTQ0YQjTdZ1l3ZydZbc1Z4hrvLWpIABtr4Z5K9tt9tYEJTxIs=
X-Received: by 2002:a0d:fc83:0:b0:3ed:90d2:2ab8 with SMTP id
 m125-20020a0dfc83000000b003ed90d22ab8mr4070126ywf.67.1672778739470; Tue, 03
 Jan 2023 12:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-4-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-4-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:45:28 +0100
Message-ID: <CANiq72mSEZtBNCocOuNAyy9P3v-7nF9UAhZeQKD4f99Trd7LSA@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: remove sed commands after rustc rules
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

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> rustc may put comments in dep-info, so sed is used to drop them before
> passing it to fixdep.
>
> Now that fixdep can remove comments, Makefiles do not need to run sed.

Finally!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

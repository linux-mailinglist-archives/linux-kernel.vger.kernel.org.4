Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A77F6286F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiKNRXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiKNRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:22:48 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FF22B2C;
        Mon, 14 Nov 2022 09:22:46 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-370547b8ca0so113505917b3.0;
        Mon, 14 Nov 2022 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVt/oFN+blh8k3TM/7jbMZ0qqobahGcF8Xv/SNk9ry8=;
        b=JxRsi2r8POhUZC2Jpt9hW8/vEhZqbOlsDBFVPHtJ+MqwwYJQynqIeZgMLiIS/3Qsj8
         fLza3JPx4tA3Lu5EvbWMONrZp0sdBBb408cH40SYnGzMBsFzTrsXi61airCZCdHP6SSe
         sr68V/3uEX+Zh0By77vVlPycMCu74NCMfxO3Bvf2+XxNnza5aoOlqI+RddGfC2RhMXN9
         lyQ9tyqtH0W8D0k2TX21qv7+J5lVZzz/Pav4K+eOHt83vtdura8Tukg7KwpfqVcqhtij
         czchqbxLt30dcm3CZe7E8PEB+6fGP+uVD5Ma2G09+/HnMlVQk5tCcY7aLk0bnomdyf6W
         4XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVt/oFN+blh8k3TM/7jbMZ0qqobahGcF8Xv/SNk9ry8=;
        b=8DONwyoqVPrNBKEwLlZLmz+JPZpR53113CRTZd4ECdAS+BqdftkGrOEmkuJvvE/SR4
         AHnTtEcsmbAbWKv6bSq2gFpDtpmOUZ4Qiytr/97kBIkW8lsv3x0ESvFNAGZ9meuOpb0L
         5+UMSMC6EepbmVYx4S/fxMJC/+6lsfkf3abeJALn6jbkM4vQotoXDjQpfABYBy4AzS0J
         7ygriTNDDxJOcCTEDGUFSNc2jGqPb8HRt42tshGsEqtZ39Dj2Nk/GMbJRqUlH+sllMRX
         gMqwHyHqsXQRK67t0BQkfL3wsIb51jC8HbbwDfovDgoycdDh8UGCAbaFktjQDDUylvAo
         M0mQ==
X-Gm-Message-State: ANoB5pknHlBO8zsNJq565XAD9haKZUyYFmMasDzitiOyGvx7ivSPanlG
        neC5of8OtmmI2raQx0+cOkiVmCaqK52FI6Zw3v8=
X-Google-Smtp-Source: AA0mqf4c2cLC/QN9jBTixqIHgPnVn5eykA6zqD6gyzAo3/QKG3yVYltgm8C0uuAUZmYmQNdqG8amU6+xiEgsnFdyeHU=
X-Received: by 2002:a81:9c12:0:b0:352:4422:d530 with SMTP id
 m18-20020a819c12000000b003524422d530mr14111616ywa.256.1668446565529; Mon, 14
 Nov 2022 09:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-6-ojeda@kernel.org>
 <20221114142611.2a21d4e9@GaryWorkstation>
In-Reply-To: <20221114142611.2a21d4e9@GaryWorkstation>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Nov 2022 18:22:34 +0100
Message-ID: <CANiq72naZ_dpgCo2VukXmoGNefXTzR-WUN_HywRrgJ+bUbeEPQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/28] rust: macros: add `concat_idents!` proc macro
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Mon, Nov 14, 2022 at 3:26 PM Gary Guo <gary@garyguo.net> wrote:
>
> Probably clearer to write `Ident::new(&format!("{a}{b}"), b.span())`
> here?

Same as Bj=C3=B6rn, it also looks better to me. I will update it.

Cheers,
Miguel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849866158F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjAHNtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:49:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DABF70;
        Sun,  8 Jan 2023 05:49:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95FEEB80B28;
        Sun,  8 Jan 2023 13:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37720C43396;
        Sun,  8 Jan 2023 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673185742;
        bh=zLtCdXZBHP6OIgitz/DPRftk5BFq77Rv/Yrlcpe0Kis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZ81gpJJcQDca6FaHFn1kPsPgWqdJqEJEkrldo94oQxqDNfd6A1q6LoTtPw4XDe0y
         g3oIgfW3p5AM0Al+IkGyZgbQwuw9LNmvOFM1w9wlzRFrYDKikbcATv9f2tLifPbskz
         RLoM91WpWcEzmeN0t//bIp+d+awG15WopmAb+/3FzsFSccPNaX+LRC78GgxQdAp4tN
         BPKaKHrUNNsQ3mc/1CKEFNFsJsC7e287dtKnJCy5NiItBkdZCV54rKletDHxEvtv7k
         feZbv5IGQQuYEeWEyDwzTCFjdowwyyGIHEjawOkWvVQJOD7yux3CtALeU0stU2m5Z1
         qUnVJqjmO5M4g==
Received: by mail-oi1-f181.google.com with SMTP id n8so5083199oih.0;
        Sun, 08 Jan 2023 05:49:02 -0800 (PST)
X-Gm-Message-State: AFqh2kquqnYD5ldPXBhBUzu44Aq9yDxABSmXkqdrz3xCoXhoSEYg6F3D
        wwSOBvG8tQiAWctpcCIitLhZonxYAu6eu96QO5Q=
X-Google-Smtp-Source: AMrXdXuMjSTirPjIemMT8QqWuO6pnofc1VmaqzghamwSJBSctAOgphRLKHGKsx34+OxeTQXQUAaG7uR8713+O4uWyEM=
X-Received: by 2002:aca:2b17:0:b0:361:24b6:466c with SMTP id
 i23-20020aca2b17000000b0036124b6466cmr2537054oik.194.1673185737978; Sun, 08
 Jan 2023 05:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20230107094545.3384745-1-masahiroy@kernel.org> <CANiq72=q9pk2ZB2K9Zjn-COY1KD3MFAGthx7VJ_2YmtH61tdng@mail.gmail.com>
In-Reply-To: <CANiq72=q9pk2ZB2K9Zjn-COY1KD3MFAGthx7VJ_2YmtH61tdng@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Jan 2023 22:48:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHqMHyX75MAwG6vh0V6Op_EGRXzprnBiNPeDmUuhHD_g@mail.gmail.com>
Message-ID: <CAK7LNAQHqMHyX75MAwG6vh0V6Op_EGRXzprnBiNPeDmUuhHD_g@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: move rust/target.json to scripts/
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 12:47 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Jan 7, 2023 at 10:46 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > +hostprogs += generate_rust_target
>
> I see that with the cleanup now we can also rely on Kbuild triggering
> it from the `target.json` prerequisite. Nice!
>
> Do you want to take it through kbuild or rust?
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel


Please let me pick this up to my kbuild tree.

If I have more spare time in this development cycle,
perhaps, I may refactor the code a little more.




-- 
Best Regards
Masahiro Yamada

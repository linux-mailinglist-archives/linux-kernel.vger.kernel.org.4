Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4E66C931
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjAPQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjAPQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:46:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D692200E;
        Mon, 16 Jan 2023 08:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0337E61077;
        Mon, 16 Jan 2023 16:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC43C43398;
        Mon, 16 Jan 2023 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886845;
        bh=PHoXdymKCTzntkAfTdjdzQTnGceuWU92Eq4icmqJ+SQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YnQscdTTuH2O94/ODYtGL6yYGQY4uXw1duyUIP4dyuFWOuxlm6nXta7GRV0GXq6jT
         zaQpEJskm4DPixK/BkkIftqJGut+elVYSMsJ9YKohHRpwhDavQJUpvC10E+ODhO2jX
         cHCTJ+4qt9yd+F6l0rK/grHRAYs2vYQOuJy3gC53HDP8wMVq31d5hPnBOETfbsDIJ7
         f3NLNO8JovghIFsC3clLYi/CcJz+/tRSKFaAMWPXtJFfbvvCIizbw0hgLGNRdRBa0+
         NAIyQPiwSmazMpEQnhCX1UbakoziAUvl1W6GfLt9DnctkQWYE6p6XgkqfABSNG97Yl
         VWTfb5lT2cCbQ==
Received: by mail-lf1-f52.google.com with SMTP id o20so11497083lfk.5;
        Mon, 16 Jan 2023 08:34:05 -0800 (PST)
X-Gm-Message-State: AFqh2krLz2eaGgSRHgeZL6p9u2WB1dRzLCg2tpotzi2wHgDH7r3Y02vz
        9Vb5hSuLSvhbfQ+32cj5NNC1DEflXHdzKMUGHc8=
X-Google-Smtp-Source: AMrXdXsFntJTUVVFudMh+leuZNhGCxxZdUbGhF6VUPCz9KJ+QlzW7McPfzdg4S/OdnEdlmedpbDR7niE/aiAt+8nqEI=
X-Received: by 2002:a05:6512:54b:b0:4d5:76af:f890 with SMTP id
 h11-20020a056512054b00b004d576aff890mr251110lfl.228.1673886843392; Mon, 16
 Jan 2023 08:34:03 -0800 (PST)
MIME-Version: 1.0
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
 <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
 <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca>
 <Y8VuB7kmn9dQ8/en@wendy>
In-Reply-To: <Y8VuB7kmn9dQ8/en@wendy>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Jan 2023 17:33:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE3v1_pUVT4HSCoVZO512cGMxjBNcDEhLpf22v9iFmoSA@mail.gmail.com>
Message-ID: <CAMj1kXE3v1_pUVT4HSCoVZO512cGMxjBNcDEhLpf22v9iFmoSA@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Peter Lafreniere <peter@n8pjl.ca>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 16:32, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Mon, Jan 16, 2023 at 03:20:59PM +0000, Peter Lafreniere wrote:
> > > Please don't send encrypted emails to the mailing list. Plaintext
> > > only, with the patch in the message body (not as an attachment).
> > > Please use git send-email if you have trouble configuring your email
> > > client.
>
>
> > My apologies. I was having difficulties configuring git send-email,
> > but now I believe that I have the issues resolved. Future patches will
> > be properly formatted.
>
> It landed okay on lore:
> https://lore.kernel.org/linux-crypto/IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca/#t
>
> I've seen enough of these now to know where this is going, I'd bet that
> you're a protonmail user...
>

I am still receiving encrypted messages, and given that I am a direct
recipient, the mailing list server does not cc me then unencrypted
copies.

I am not going to reply to the patch until it lands in my inbox in
plaintext, sorry ...

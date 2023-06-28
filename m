Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683C7741026
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjF1LhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjF1LhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B02D59
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8E6612A0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827AFC433C0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:37:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oXO2ikKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687952224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7V8cx2COCWLuhqZLmALdHL1pDFdOboHvGUMjL91x1k=;
        b=oXO2ikKrD7cdDntVD6EcYaKcrsgz4U8qPnlk5pgU8ByJuzT1/JU+CtuTDsZSu3E1RUnLgJ
        UcZNvIeaoh10PlQ3mJnkBWjlTY+ClKMQk9oVbOJbj1vqWLVKVaFf53Fv/HhASotavr6hIu
        inteatlaFt0xtZ1dwy8ujeXVgZ1OpWw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d1c8eb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 28 Jun 2023 11:37:04 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so1981585241.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:37:04 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCGgBbL2I/i4AQjmzJUEzSdLWmwsGAGxvfMmrkGivAjADMoGhh
        ygns1tebS52GBP4Y4YboZuW0uxF5601jcxsDlOQ=
X-Google-Smtp-Source: ACHHUZ6xiQNT2OICOGcio1jgmxqaSlg9cjdkPkjx5dulrEZta+hHY7cmjUq8dYs15G1mSkKdTfHlhdFbn3PcQWwkB/0=
X-Received: by 2002:a67:f553:0:b0:443:6180:778f with SMTP id
 z19-20020a67f553000000b004436180778fmr5138638vsn.33.1687952223378; Wed, 28
 Jun 2023 04:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230531095119.11202-1-bchalios@amazon.es> <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
 <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de> <2023062834-lark-frostbite-9710@gregkh>
In-Reply-To: <2023062834-lark-frostbite-9710@gregkh>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 28 Jun 2023 13:36:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9pd7AV6a2Ot_zHspwisH06nKhSaQHu0BiDjEw8T=hQhAw@mail.gmail.com>
Message-ID: <CAHmME9pd7AV6a2Ot_zHspwisH06nKhSaQHu0BiDjEw8T=hQhAw@mail.gmail.com>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Graf <graf@amazon.de>,
        Babis Chalios <bchalios@amazon.es>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        mzxreary@0pointer.de, xmarcalx@amazon.co.uk,
        Amit Shah <amit@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 28, 2023 at 01:13:40PM +0200, Alexander Graf wrote:
> > Hi folks,
> >
> > On 16.06.23 17:07, Babis Chalios wrote:
> > > Hello all,
> > >
> > > Some time has passed since I sent this. Any comments/thoughts?
> >
> >
> > Can we please get this merged somehow? Greg, any advise?
> >
> > This is purely a device notification event to user space, similar to ne=
twork
> > link change events and the likes and has nothing to do with Jason's
> > envisioned random reseed event exposure. We can happily send RFC patche=
s for
> > the latter after this is merged too.
>
> Sure, I can take it, but it's the middle of the merge window and it's
> too late for anything new right now, sorry.
>
> I'll pick it up after 6.5-rc1 is out.

Please do *NOT* do that. I'm still unconvinced that this isn't just a
subset of the vmclone work that needs to be done in conjunction with
the RNG, and I'd like to get those recent virtio patches merged first
before we move onto this, so we can see where this fits in
holistically. I would not be happy if this got merged prematurely.

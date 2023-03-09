Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE366B1C75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCIHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCIHft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:35:49 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF60DD345
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:35:34 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536cb25982eso18863497b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdV+4ekYzEX2zluka+Ae9nWocB3Egh4fr8hk8d8QYXw=;
        b=EKqMsvpzCXKMI5aX8f3xs8CPEOPXJewyVNUUcFc3G1GZMv/azP+RNWKyKqL46InX6N
         hFsidcfiHk+6LTbg40j/pNi4FctywQqkqtTldJuHmmK2wWJn1CGiyvwXmPNFUd7MYS9s
         yBIzGzMnbRqvgBdI7k7BBCzZDBOLSa/MEd7XCq0eV4vRemoZEtoIyNo9ZhllagHDMGt+
         SvISprl8K2ROh7M+n/VGk22USiGzWlY90WvsynSqZ+IBRcJ0XEMrVx57kv/19euyyO3r
         pQtwcGlJksyL4OyHuGAloXQOjiSLg3amE7olnED8VAI2gGJ59whqvSJjl9YCF/g9Uhrm
         8lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdV+4ekYzEX2zluka+Ae9nWocB3Egh4fr8hk8d8QYXw=;
        b=I8+8pGTnZ53xvUp9iQrRwWoQgA7ix4IW1/WAnTGwK6OkQH40nRFsBM/eTW3qma0jj0
         7dtkHnLZ+RLh0p99MjiAHOH/wJ4XE+OWgUsyK5YXME7HLYbcGwq5HFotbES4osh/oijz
         v/8zcqtL4gVHB8BgIr8Ymxg4HMWNmJOhNutDcxPa789H3sIonbxoJSSsF0SAD+JiBYfq
         xlXERJDdUrvoOGqd2bxqkVB9CbdxIhvgP7zKRK2kVVByt3ko8PeSEjbUvjDpeovc2xBU
         pb2k701M80GDn6RnxsMUuDoEXe4IEZgPp/NP/+QQJiazSk3MA5KT1W98VbI6dPRWPRK3
         QLZA==
X-Gm-Message-State: AO0yUKX58Q36ZqqTXtPs/e2t/41hJb0JZ+ECfibUGEA1gvC4I8N9m+cj
        LUT/8MS47/LpozrQI+I3sOn3KesZPO10r0CRQS0i8A==
X-Google-Smtp-Source: AK7set9Ja/GCRaDydWCAyQwBS9jZIATgAx4CvCrcuDDV4SJYEpzXZqeohZJdyNwu6e4Mu4KnpP+hODHjLJmyQAVNWdQ=
X-Received: by 2002:a81:b149:0:b0:530:b21f:d604 with SMTP id
 p70-20020a81b149000000b00530b21fd604mr5782757ywh.9.1678347333493; Wed, 08 Mar
 2023 23:35:33 -0800 (PST)
MIME-Version: 1.0
References: <E1pZ2fs-000e27-4H@formenos.hmeau.com> <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au> <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au> <ZAgDku9htWcetafb@gondor.apana.org.au>
 <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
 <ZAhfBmlNHUpGEwW3@gondor.apana.org.au> <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
 <CACRpkdabjrpsiVgm=EyGrTK7PGXth6FdvxSp=QULA+LyqtdBgg@mail.gmail.com> <ZAl1gGCv51FKOXtm@gondor.apana.org.au>
In-Reply-To: <ZAl1gGCv51FKOXtm@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 08:35:21 +0100
Message-ID: <CACRpkdY4gAT7RUtL6ctcsqxEX2_rZMyjMktPta7e4UB19OyGow@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 6:58=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
> On Wed, Mar 08, 2023 at 10:19:48PM +0100, Linus Walleij wrote:
> >
> > So now the driver is fixed from a Ux500 point of view.
>
> I think there is actually a nasty bug in it that may be hard to
> trigger.
>
> The stm32 driver as it stands will write up to 256 bytes into
> the FIFO which on the ux500 is limited to 64 bytes.  We need to
> change the fixed 256-byte size to be dependent on the hardware
> type.

Right so that is done implicitly by using a buffer of 256 bytes.

But actually I think the bug will never trigger, because the datasheet
for the DB8500 (Ux500) says this:

"Then the message can be sent, by writing it word per word into the
HASH_DIN register.
When a block of 512 bits, i.e. 16 words have been written, a partial
digest computation will
start upon writing the first data of the next block. The AHB bus will
be busy for 82 cycles for
SHA-1 algorithm (66 cycles for SHA-256 algorithm)."

The way I interpret it is that if you write 64 bytes (16 32bit words)
the AHB bus will simply
stall until the data is processed, so the writel() hangs there and
then 66/82 bus cycles
later it will continue.

This isn't the prettiest from a system PoV, as it can stall interrupt
handling and
cause latency jitter, but it's not actually a bug. It's kind of
similar to that user
experience "bug" on x86 PCs where the sound starts breaking up if you have =
too
intense graphics going on, because the bus is too busy so the sound FIFO go=
es
empty.

But I can certainly make a patch to shrink the buffer from 256 to 64 bytes =
on
Ux500 if it's the right thing to do.

Yours,
Linus Walleij

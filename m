Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348276E7D83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjDSO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDSO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:56:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F80191
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:55:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o11so12900352ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681916157; x=1684508157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsAnyIg0tja7z/MHVd1oLlFsDX2n0uEj29cmVpgYxuc=;
        b=Yjyr2NLxfwCkZ2ONh23Vb4RYnMb0t263toOyB3WYTAtzM+vdMqlZysuUlahSuFR9pE
         bOvJhB6GKi9DhpwU+gTWQbC6Gf37cZpX0CvLh0w2F7FSaSFqZYt3pAxfyALlAelyvsZe
         stmaK/2DsyifEBSEA1fRs0hk1MxzaDqpBwaIfrtEijxdwErtaeLJ0D/hOmGZruUcI62m
         jJ5os5Xwhtn5X9VtkHFFRqrJ5WpfWLRfF8/eTR22aho2NOjzxdi9/29VTH8FU/L8yRmP
         s96wBhILfwczB2AiEyxhNoDy0pVfVZxWN7QEk4utG5+S9OWnjFIAiDuauI1oqiPIWqyC
         qCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681916157; x=1684508157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsAnyIg0tja7z/MHVd1oLlFsDX2n0uEj29cmVpgYxuc=;
        b=DARTs9JuzGo3IUq557Z5FS/e22Kv1k/hr0Pp+wno8nwSKWXCJO/alSO410HF0Os/um
         keGAaLbiUa8y6X9ReDkitWCxio3N73g6AxEHKuaBQpcGJlakka2DrmpH/hYIdI7tuLZY
         ySTzUb8sv33KCfl0hhCBgfCVlpQLt9pqH2NOaWhAhpJC2N7PkbVPe35Z4yuRz3uxO3pB
         jqu23RvAy7RetWoCena23UDXW13P+2z9sPRCmJ7SsEGwt+0tb+lDS+j6FGUglueQGs6r
         RgJ84Wl0FaZe4iHNplvmEFIpCF8yKo7VyIdZPR90FAF72UO9yGGlNini4Pl2sFiVbhBk
         foeQ==
X-Gm-Message-State: AAQBX9em3JmrZQacOVK205J9ea6xbjYK3p+C486wxiO/ERbOJBVuUwav
        IELJ8T7edJJI9IaXDfljF946EpAN+G0R/UH68xnycQ==
X-Google-Smtp-Source: AKy350btuammnNCPIH2gq9ooigjmRSZ8jv694MOoj+DgIaXVDrl3EJBXLaFHIMlj9Gj4EFRl4NNiry9gyIH9XLjEj9g=
X-Received: by 2002:a25:218a:0:b0:b8f:648d:4bf9 with SMTP id
 h132-20020a25218a000000b00b8f648d4bf9mr2653122ybh.24.1681916157524; Wed, 19
 Apr 2023 07:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com> <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com> <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
 <ZD/VO1cuBYGCP4O2@smile.fi.intel.com> <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
In-Reply-To: <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Wed, 19 Apr 2023 20:25:46 +0530
Message-ID: <CAOSNQF0ATN5AdJsgQ4CzxyD_eOFyjbd9p5j3JcV7+GxQa1bnog@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
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

On Wed, Apr 19, 2023 at 6:18=E2=80=AFPM Joy Chakraborty <joychakr@google.co=
m> wrote:
>
> On Wed, Apr 19, 2023 at 5:19=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Apr 19, 2023 at 11:18:25AM +0530, Joy Chakraborty wrote:
> > > On Tue, Apr 18, 2023 at 1:08=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:
> >
> > ...
> >
> > > > > +     /*
> > > > > +      * Assuming both channels belong to the same DMA controller=
 hence the
> > > > > +      * address width capabilities most likely would be the same=
.
> > > > > +      */
> > > >
> > > > I had a small comment on this In v6 thread.
> > >
> > > Sure,
> > >
> > > Your comment in V6 thread:
> > > "
> > > I would add something to explain the side of these address width, lik=
e
> > >
> > >          * Assuming both channels belong to the same DMA controller h=
ence
> > >          * the peripheral side address width capabilities most likely=
 would
> > >          * be the same.
> > > "
> > >
> > > I do not think the address width capabilities are dependent on the
> > > side of generation like memory or peripheral.
> >
> > Yes, they are independent. Memory could do with 4 bytes, while peripher=
al with
> > 1 byte and so on.
> >
> > > From what I understand,
> > > address width capabilities are solely dependent on the transaction
> > > generation capability of the DMA controller towards the system bus.
> >
> > What do you mean by a SB in the above? Memory? Peripheral?
>
> By system bus I mean anything that is connecting the Memory, DMA and
> the peripheral.
> Something like :
>
>           +-----------+          +-------------------+
>           |               |           |                        |
>           |   DMA    |           | PERIPHERAL |
>           |               |           |                         |
>           +----^-+---+          +-----+--^---------+
>         *** -->| |                         |    |
>                   | |                         |    |
> <------------+-v--------------------v---+------------->
>                     SYSTEM BUS
> <---------------------+--^----------------------------->
>                             |   |
>                             |   |
>                      +----v--+-----+
>                      |                   |
>                      |  MEMORY |
>                      |                   |
>                      +--------------+
> *** : Address width capabilities should be the capability of the DMA
> to generate transactions to the system bus on the marked interface
> irrespective of whether it is destined for Peripheral or memory is
> what I understand.
>
Looks like the diagram did not come correctly, repasting:
        +----------+          +---------------+
        |          |          |               |
        |   DMA    |          |  PERIPHERAL   |
        |          |          |               |
        +----^-+---+          +-----+--^------+
       ***-->| |                    |  |
             | |                    |  |
             | |                    |  |
<------------+-v--------------------v--+--------------->
                    SYSTEM BUS
<---------------------+--^----------------------------->
                      |  |
                      |  |
                      |  |
                 +----v--+-----+
                 |   MEMORY    |
                 |             |
                 +-------------+

> >
> > > What we intend to highlight here is the assumption that both tx and r=
x
> > > channel would belong to the same DMA controller hence the transaction
> > > generation capabilities would be the same both for read and write
> > > (e.g. if the DMA controller is able to generate 32 bit sized reads
> > > then it should also be able to generate 32 bit sized writes).
> > > With this assumption we are doing a bitwise and of both tx and rx cap=
abilities.
> > >
> > > Please let me know if you think otherwise.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >

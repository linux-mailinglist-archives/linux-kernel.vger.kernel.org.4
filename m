Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705486E82FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDSVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDSVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:03:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79E5B92
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:03:50 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fb615ac3dso18658547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681938230; x=1684530230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQiggG3o2RYfkSueu3n51t9vPaOXp7k+C+N1iEzYTEk=;
        b=DDIqZEKcT4jRp6nDbXkScFkNmbm5AgSEIJZPPSGj1A+qNr77ePB+hefmGWnPS7PF0q
         /CG3WEVzHEUAYzVf8iL8BjlEmyurmWswnKK4KqxahVsjSMB7Z35E2GnOODyQw+f6upQN
         UNiWfKG8jOlM2oo6GLBS+a3hpglneBdNYKbKbpbzHujA5DjTy00EvDMgGd/BHh8bHk0l
         j/S5wiFZw4KkZXzfss6FgcDzc512CjtUL/eemQVQw6NnhBTC7Ak7FYkv27SK/EeOLw4U
         /xPWiY4CHnDv6JlPSBqGdlk6DuSKsLoIQlEEv4SKUoRsjYy0/SJBfgUNv6yAMAm9mLx7
         AXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938230; x=1684530230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQiggG3o2RYfkSueu3n51t9vPaOXp7k+C+N1iEzYTEk=;
        b=f2ADvefctbGZ2qtM40Ys7PnfR8tI51Db8tM5SPMqeAjrW4KK+4Bqj8y8HBl2o4sSMm
         rJElpW6XKimaKBRJapc5tS4XpOEYhHM19/oC4NvrJ9+coGdKmrBmRDSXMRPqc9q4U8J2
         HEryNCKXtcwOuD7t1w31B7wXD7EVZoUfTf+VSFXvFr8EpmKZOmBtzwsrJueiuWHVNUqV
         OrXVfaxqGxKjGpfV1IFzN3A/WTjIrkVtuLgxtnVDOYuiy/hrEndvl9BQULNoWKp5hZP2
         HRQeMJsVqSxOxLJyJpI89RQLRUpUctyOWOLvKLwnhEcTFBVEQdgrsTnOFaopq7Z7Gx9w
         x6Qw==
X-Gm-Message-State: AAQBX9fwXg4AYbs+PR5Lg4+P5nwxd52E03rMLoDkqgqzEO6kMsvKEu4F
        O6rWwHAjvvdR04boaAk7hG4Qx+s4RvoifHCAcnT4CQ==
X-Google-Smtp-Source: AKy350ZqAwMZuGujmctNj5/4RDX2TlF72A4V6FVYK1MnZdscKftu5mlDwi3GWrsOP9qhOGlaoZJPJ5ndRNMNYzm04PM=
X-Received: by 2002:a81:5b04:0:b0:552:b5db:45c4 with SMTP id
 p4-20020a815b04000000b00552b5db45c4mr4852907ywb.15.1681938229498; Wed, 19 Apr
 2023 14:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com> <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com> <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
 <ZD/VO1cuBYGCP4O2@smile.fi.intel.com> <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
 <ZEAmS3huMHla7Ifo@smile.fi.intel.com>
In-Reply-To: <ZEAmS3huMHla7Ifo@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 20 Apr 2023 02:33:37 +0530
Message-ID: <CAOSNQF1vFh=8NGyrQ5NAuefK=_0TTt3CECZ0Q9cfaGdpE2G5qw@mail.gmail.com>
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

On Wed, Apr 19, 2023 at 11:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 19, 2023 at 06:18:04PM +0530, Joy Chakraborty wrote:
> > On Wed, Apr 19, 2023 at 5:19=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Apr 19, 2023 at 11:18:25AM +0530, Joy Chakraborty wrote:
> > > > On Tue, Apr 18, 2023 at 1:08=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:
>
> ...
>
> > > > > > +     /*
> > > > > > +      * Assuming both channels belong to the same DMA controll=
er hence the
> > > > > > +      * address width capabilities most likely would be the sa=
me.
> > > > > > +      */
> > > > >
> > > > > I had a small comment on this In v6 thread.
> > > >
> > > > Sure,
> > > >
> > > > Your comment in V6 thread:
> > > > "
> > > > I would add something to explain the side of these address width, l=
ike
> > > >
> > > >          * Assuming both channels belong to the same DMA controller=
 hence
> > > >          * the peripheral side address width capabilities most like=
ly would
> > > >          * be the same.
> > > > "
> > > >
> > > > I do not think the address width capabilities are dependent on the
> > > > side of generation like memory or peripheral.
> > >
> > > Yes, they are independent. Memory could do with 4 bytes, while periph=
eral with
> > > 1 byte and so on.
> > >
> > > > From what I understand,
> > > > address width capabilities are solely dependent on the transaction
> > > > generation capability of the DMA controller towards the system bus.
> > >
> > > What do you mean by a SB in the above? Memory? Peripheral?
> >
> > By system bus I mean anything that is connecting the Memory, DMA and
> > the peripheral.
> > Something like :
> >
> >           +-----------+          +-------------------+
> >           |               |           |                        |
> >           |   DMA    |           | PERIPHERAL |
> >           |               |           |                         |
> >           +----^-+---+          +-----+--^---------+
> >         *** -->| |                         |    |
> >                   | |                         |    |
> > <------------+-v--------------------v---+------------->
> >                     SYSTEM BUS
> > <---------------------+--^----------------------------->
> >                             |   |
> >                             |   |
> >                      +----v--+-----+
> >                      |                   |
> >                      |  MEMORY |
> >                      |                   |
> >                      +--------------+
> > *** : Address width capabilities should be the capability of the DMA
> > to generate transactions to the system bus on the marked interface
> > irrespective of whether it is destined for Peripheral or memory is
> > what I understand.
>
> That's misunderstanding. You used only one possible HW design, there may =
be
> more. For example we have Synopsys DesignWare DMA that has a lot of param=
eters
> to configure bus mastering. One of such a case, where it makes a lot of s=
ense,
> is DesignWare SATA with the above mentioned DMA controller where it has t=
wo
> masters and they are connected towards memory and towards peripheral "bus=
es".
> They have _different_ configurations.
>
> So, generally speaking what you are saying is not true.

Got it, thank you for the clarification.
I misunderstood what you meant, that peripheral access can be from a
different path.

I shall add to the comment as you suggested and send another patch.

>
> > > > What we intend to highlight here is the assumption that both tx and=
 rx
> > > > channel would belong to the same DMA controller hence the transacti=
on
> > > > generation capabilities would be the same both for read and write
> > > > (e.g. if the DMA controller is able to generate 32 bit sized reads
> > > > then it should also be able to generate 32 bit sized writes).
> > > > With this assumption we are doing a bitwise and of both tx and rx c=
apabilities.
> > > >
> > > > Please let me know if you think otherwise.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

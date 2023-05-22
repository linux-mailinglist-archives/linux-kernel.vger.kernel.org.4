Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1570BB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEVLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjEVLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B819A6;
        Mon, 22 May 2023 04:08:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75b0830e2eeso43894785a.1;
        Mon, 22 May 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753714; x=1687345714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxi3fyG/zPxjmTcYvTx1jlSTEemn9oWDhNhnAs8Y07c=;
        b=qO/pODfdZ7sKoPrTVtTX5Sux9ZLRu1P7SW7qhrz8vktSmXbzrXPGcuCetXDrT+hXhx
         F0+B7p6QmFo6UQly+zqyT18pnsAVqSCyGDJDRc1/d9DC/C254CjBaDdxciDHs9Fnucg3
         a+Ij2Uhw37KHzqd/XOFUwXc9QzE5npAu7o20TxVnTZ8oFDVHNLPFAUDWzU2dHNjqZc2+
         Z996iQdYTwmophBHPcgTIi4apuXKo22hgnecIFSzzfObB06MDnMuxh1/uJUowUPHgru+
         j5yiR8iClEkNfZ6uduGEwQ4JpANGxNP0evjJlt3zhdAh/vGxVIt+9lGdAUWpUQEZgHJ8
         +rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753714; x=1687345714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxi3fyG/zPxjmTcYvTx1jlSTEemn9oWDhNhnAs8Y07c=;
        b=VDFXj8Bub/yyklQP7YGxyQ3TC3zeYo7/dwT/kTsMj3cBKbHTr4RKPnOFfZ1JpEL0rC
         vc+51OshCYbbD+MOPJ/BKtkdZggn5KeCHoppcf0MU1QIugJvmIj3F6Ja0/XSFQbkMfI5
         axdO7sAFcwsfOWOSuBu/Hf9G3tlQeTLQrh0Xk+xvzqRvLsxp2ru/Se2XF6/7HsleH07Y
         IfG0kC737OlIlVmrzY1bzPd3Mejrjha5hAdmb0Wp0VzlECreey7CfBEOceh1tNmLpEVM
         Gr9bqvfUYjP9vYFIDXE7hIHbA+dHYzLsoq3E2TCVFqNapX5XV9K8RTeUJ1KY70b6ivb1
         5k7Q==
X-Gm-Message-State: AC+VfDyj+i7V2cE0ZVKWXa1ScLr3eZ51wUe8fyX4CGZ4nBNVo5U/SxKQ
        ts+8GRyOooiLkpDD4JF/F/3eZjoyqbIQcHAgGyo=
X-Google-Smtp-Source: ACHHUZ7ooN5VmH1972850+wB54FS/Bu/din4JqZ1CLAqns3NfpzaHikXKxtcqobYc3FYlpnnDI1l+FHL7E6rvk4AXmE=
X-Received: by 2002:a37:c16:0:b0:75b:23a1:d846 with SMTP id
 22-20020a370c16000000b0075b23a1d846mr167656qkm.8.1684753714014; Mon, 22 May
 2023 04:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
 <20230520190856.34720-5-boerge.struempfel@gmail.com> <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
 <CAEktqcv3NEZKmxBdCjf29JbSbFfTzZB9p0yXF+btVrNYO5XU4w@mail.gmail.com>
 <CAHp75Vf37xb=yMeUM6exPaZDvrzQzwD53MGU2uR4aC0rPeTzAw@mail.gmail.com> <CAEktqcuuM=P7p-Y4k9Z+721SCA6i1QiCebWZL3BMqh6Q7jX+4A@mail.gmail.com>
In-Reply-To: <CAEktqcuuM=P7p-Y4k9Z+721SCA6i1QiCebWZL3BMqh6Q7jX+4A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 14:07:58 +0300
Message-ID: <CAHp75VdpPDEg3aPJgSU6bKpdR=eHo=155h9qUDgXO5VQfvjjmg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
To:     =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Mon, May 22, 2023 at 10:23=E2=80=AFAM B=C3=B6rge Str=C3=BCmpfel
<boerge.struempfel@gmail.com> wrote:
> Am So., 21. Mai 2023 um 21:26 Uhr schrieb Andy Shevchenko
> <andy.shevchenko@gmail.com>:
> > On Sun, May 21, 2023 at 2:35=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
> > <boerge.struempfel@gmail.com> wrote:
> > > Am So., 21. Mai 2023 um 11:00 Uhr schrieb Andy Shevchenko
> > > <andy.shevchenko@gmail.com>:

...

> > > Thanks for the suggestion. I tried coming up with a logical way of
> > > ordering, but I am having some difficulties deciding. What do you
> > > think of the following order?
> > >
> > > general device settings
> > > " -D --device device to use (default /dev/spidev1.1)\n"
> > > " -s --speed max speed (Hz)\n"
> > > " -d --delay delay (usec)\n"
> > > " -l --loop loopback\n"
> > >
> > > spi mode
> > > " -H --cpha clock phase\n"
> > > " -O --cpol clock polarity\n"
> > > " -F --rx-cpha-flip flip CPHA on Rx only xfer\n"
> > >
> > > number of wires for transmission
> > > " -2 --dual dual transfer\n"
> > > " -4 --quad quad transfer\n"
> > > " -8 --octal octal transfer\n"
> > > " -3 --3wire SI/SO signals shared\n"
> > > " -Z --3wire-hiz high impedance turnaround\n"
> > >
> > > additional parameters
> > > " -b --bpw bits per word\n"
> > > " -L --lsb least significant bit first\n"
> > > " -C --cs-high chip select active high\n"
> > > " -N --no-cs no chip select\n"
> > > " -R --ready slave pulls low to pause\n"
> > > " -M --mosi-idle-low leave mosi line low when idle\n"
> > >
> > > data
> > > " -i --input input data from a file (e.g. \"test.bin\")\n"
> > > " -o --output output data to a file (e.g. \"results.bin\")\n"
> > > " -p Send data (e.g. \"1234\\xde\\xad\")\n"
> > > " -S --size transfer size\n"
> > > " -I --iter iterations\n");
> > >
> > > misc
> > > " -v --verbose Verbose (show tx buffer)\n"
> >
> > Looks great to me, thank you for doing that!
> >
> You are welcome.
> Should I only reorder the flags, or actually introduce the
> "group"-headers to visibly distinguish the options?

Up to you. If you think it increases the usability I'm all for it.

--=20
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF99D6D246D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjCaPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:52:57 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606610F9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:52:56 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-177ca271cb8so23624186fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680277974; x=1682869974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phkVHe16TDNo/mX37Y8T31EgdpAkDmzETKve3hhAviM=;
        b=Fve7P/qYXC/HrfLkSZj+G3Uds4chWvBxLzsj1eTDEmkxMZmd1XXkMFCEToLITu9o5Z
         amt+H8CblbRNPRl2/P5i3PZdhb2vBohFe8hvjR2i+VXZ6S0WUGAhvV0Xxx2l3qRGjuGG
         6F/Cj635XMkR2rF/mhlVsrWUiSeNZl/O7YJ5shbHjK/krbe6da/sg5rWIy55ezCz00JC
         lqinThr0MJ2hoAd1cBcEqqQ4iDTdwtwvWf8/Nw80xdSh69qmTaotlDLZxGahpcnpU4T/
         0cZwAWOPNYgKcjrcQltiD5f7E46oyy0duAIBlFaYqn/Qmv1BBztNjdSBgUN6xMko93Vh
         EEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277974; x=1682869974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phkVHe16TDNo/mX37Y8T31EgdpAkDmzETKve3hhAviM=;
        b=vx6paJW7zffN8aAwACTYZx80wMqO52vxjGMPcpvEa/ihKHCl8PdH71wwTeyLF5YbBF
         dnaJH/wZMFBY7YPq4VEDa490fdfDlQmDzojcJJL6MsL5InDk85ckonmRYZ9w20YYNlOq
         svt92ACkVdN6LhcjfynUFYDv0kDBi4PGFHU+asPKiItH3LtCgQJa/CU287E+YEZjPDD+
         Ftgt2Ney4keHHZopOwqgL2S/IJMvOrHOePhKEN/xtmvcwqx6VRPZK/gzjc6+h5Jsg3xe
         pzAyovjVvAzOnKcO/6mS751Ip/Vvs1Te6l7O9+twBxewuNBlGIt4oGQtFptjssxFEqhK
         6IMA==
X-Gm-Message-State: AAQBX9eZl6dHNbjTLs/5L8fpFqyeoNZahNvP5RSsXZsW1joG3K73ZvUm
        9c3CIJY20JKSZnbGAq4+lshH1VYDnB47SzPyqpK3Vw==
X-Google-Smtp-Source: AKy350YXeG2GpSUZG2S0ZIEKLkufoCoN61SYeoKozd/CuYj4kIm7nH0RvDoFKHBAVK3axbCR2vDfKHvRHQIbWPuIM8A=
X-Received: by 2002:a05:6871:b196:b0:17e:69a2:91a7 with SMTP id
 an22-20020a056871b19600b0017e69a291a7mr7069056oac.6.1680277974109; Fri, 31
 Mar 2023 08:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230320152319.665592-1-loic.poulain@linaro.org>
 <20230330114242.GC434339@google.com> <242a5400-b5e6-4707-af88-1d695e114f78@app.fastmail.com>
 <CAMZdPi8ZMfLTHaEn2LbXvuen=Rb68KrWJmgbq9Miou_RDi=Btg@mail.gmail.com> <900066e4-fd5c-4645-bf04-9c27561516a9@app.fastmail.com>
In-Reply-To: <900066e4-fd5c-4645-bf04-9c27561516a9@app.fastmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 31 Mar 2023 17:52:18 +0200
Message-ID: <CAMZdPi8pym6tgtQrKD3_zVAenyvhutFtQHSBRPnkCa1iNv5RZQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 at 15:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 30, 2023, at 15:22, Loic Poulain wrote:
> > On Thu, 30 Mar 2023 at 14:45, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Mar 30, 2023, at 13:42, Lee Jones wrote:
> >> > On Mon, 20 Mar 2023, Loic Poulain wrote:
> >>
> >> Thanks for pinging me. I would indeed expect this to cause
> >> problems, as syscon mappings are likely to be used in a way
> >> that is not entirely clean, with other devices defining
> >> overlapping ranges.
> >
> > Isn't syscon exactly here to address that collision/overlapping issue?
> > From a syscon perspective, it seems to be handled correctly at least
> > since the mapping is only setup once, with the first user device (in
> > syscon_node_to_regmap). Or are you thinking about non syscon devices
> > overlapping the syscon area?
>
> I meant them overlapping with other devices. Ideally this should
> not exist, but most likely we have to deal with dtb files where
> some other device does overlap with a syscon.

Ok in that case, this is indeed a no-go, but my main concern is about
CONFIG_IO_STRICT_DEVMEM which is supposed to restrict userspace access
to *idle* io-memory only, i.e. not in-use by a driver. In our case the
range is obviously in-use by one or even several drivers, but because
the range is not requested and marked busy, we fail to prevent such
access. It's kind of a security concern since syscon is widely adopted
in devicetree, sometimes for sensitive controllers such as OTP,
platform-reset, etc.

There are some alternatives, that may not be entirely satisfying:
- Introduce a new syscon 'exclusive' devicetree property, for
enforcing range request while keeping compatibility with 'bad'
overlapping dtb.
- Use range requests only when CONFIG_IO_STRICT_DEVMEM is enabled,
ensuring security, but possibly breaking some devices.
- Introduce a new 'IORESOURCE_SHARED' flag for syscon resources,
allowing the resource framework to allocate overlapping
IORESOURCE_BUSY regions while preventing userspace access/mapping.

Regards,
Loic

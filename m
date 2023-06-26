Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4473EBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjFZUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:24:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863D1718
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:23:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a1c0so19687795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687811037; x=1690403037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lasz/qKngW4lMmpl2lE8l+hYjZ3mHvX+CfGihTTx5+o=;
        b=iCwJoSYTHlW0zCpqwE8yKZtirDPczXu03PXvaU9pcbRIbjCqgw4fqnQaB5u1cEEl5H
         uBtJitUtvuWtTBTrW4rBmn98i9Hv0n+LXicZsEbe8HoPyqRjN2RcD4D1x2jjI5FpdoGn
         W97r0HYJ86/jONhXsk46YmYZBOX/9e5ppMz/7z4nAHlFkqcuOrbHUplPH2GLqt63c1lI
         xUMtI0pzpiZ1Cwnzh4rx4MZgZLbKzLuGXxKVgFz7eyzEoGjy47yG3uNfpAfQ5HeEuEKH
         VYAZu9eD8LrlHp4vCrjwsnbvGFGIhzqRWXiLjrf7LbdKHG4Y7uLSwuiu3LOftMkyh5x/
         Ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687811037; x=1690403037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lasz/qKngW4lMmpl2lE8l+hYjZ3mHvX+CfGihTTx5+o=;
        b=gW+UhnBCrLgGhdqD9VorbCFCZK5GqBR8I4Lnr96RmIKTJ7Bi5Vkdn3RPlDDHtCTnQR
         /C4zHBFMSCsiwNhEsTWhn5GTVAA9KdVK/lklde8tcZeWMXjs3x9jbsLAYSiP3kRFrQFu
         STh6wWMzUC+FRVMuPoFf95SedGJrVaxFQj+dE5F6TKgWMTXlKat3IV12DMyfiNEWdxi5
         J1weQF0PZcEFYphbsCjHIsIqN5MEx5ZDzqbmLK9Ja/KWwAZZKSm4BSwXcgvvxGsp33rh
         fPnXmgKe/6181sdv144IL9HCjJzEMIwomNkKIaa9Lk7G/dVpVwRTKHgrIicXl17FNbHI
         1/2Q==
X-Gm-Message-State: AC+VfDxikLdNXI8RO2JnEFh2oeI8TyZ53q2NMC9pWTBSancVmw4/Gn8M
        REkuHoRkSjWAn/p3moNplJbVQIp8OQM1Q4zYtC3z/Q==
X-Google-Smtp-Source: ACHHUZ70yDzYF18APb9OxxhguJUWqnd+j8MmzQnBlyexso7xncsmKGTFu0IblX1vM50Hbd0Mix21rJHNyoQ0zu0EqJ0=
X-Received: by 2002:a5d:414b:0:b0:313:f9ab:2c04 with SMTP id
 c11-20020a5d414b000000b00313f9ab2c04mr644226wrq.8.1687811036484; Mon, 26 Jun
 2023 13:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620202824.380313-1-russell.h.weight@intel.com>
 <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050> <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
In-Reply-To: <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
From:   Jim Wylder <jwylder@google.com>
Date:   Mon, 26 Jun 2023 15:23:45 -0500
Message-ID: <CAEP57O-EsrW0KgSDDnDDEYrvL-SEtO-Ji6oShNzvP3y0o9AqCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
To:     Mark Brown <broonie@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com
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

On Mon, Jun 26, 2023 at 2:47=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Sun, Jun 25, 2023 at 12:26:31PM +0800, Xu Yilun wrote:
>
> > IIUC, max_raw_write/read is the max batch *DATA* size that could be
> > handled by the receiver. reg addr bytes are not counted in. I'm not 100=
%
> > sure this is obeyed by all drivers. But see several examples:
>
> There's clearly been some confusion in a bunch of drivers, those you've
> identified below need fixing too for the new code from the looks of it.
> I'm frankly unclear why some of the drivers you're pointing at are even
> implementing raw buses.
>
> > So I'm not sure if commit 3981514180c9 is actually necessary.
>
> That's "regmap: Account for register length when chunking".  It's
> certainly a bit unclear now I go do another survey, though it's also
> clear that things like the handling of padding are intermittent at best.
> We probably would be safe reverting that.
>
> Jim, where were you seeing the issue here?

Hope I am answering your question.

The issue I experienced is that if a bus (in my case a limited i2c controll=
er)
defines a quirk with max_raw_write, then the chunking algorithm would
divide the data into max_raw_write chunks.  The i2c bus would then
prepend the address values to the chunk which would
always get rejected because it was at least one byte too large.

My original fix, that I posted was to add a special flag (reg_in_write)
that a bus could set to choose the to have the register accounted
for in the chunking algorithm.  This was admittedly inelegant.

After reviews, we thought using the reg_bytes would be a better
solution and that padding should be accounted for.

I had not seen an issue with padding for this algorithm.  Only
the case specified above with i2c with prepending the address.

Would it be possible to reconsider adding a flag or argument to
regmap_bus to guard this chunking behavior?

>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

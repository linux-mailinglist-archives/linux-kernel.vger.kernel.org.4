Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19AC6BDA00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCPUR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCPUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:17:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89F28E9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:17:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so2643443wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678997874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcUGlWscPfoOjQ2/RY+CqDxREFzJPUhNCx1vWMcBYac=;
        b=ZFCJt4LIFO5SGWn9ik6rwm/ZX4j+oBw2GhsisckUFkKA3eckrfLY3lYSg6cyMii5dg
         6lJUEGjHHjrCLqRX2gDtUU3w/M5eT/HVcg/2pBB4cwGRpfmoA6dBFLuiehCEtRukKFHU
         sniWDefQLaAGhUXBF9nQym0G7ob/ik1uU1QXyFrNig3tyZQqVpdMWZzpV6CVFHqkZNZr
         bvZla/MKSHwL5/cEluhqZhtr79zLfofrxyl+GC8FPyjRxDBJFj2xBZW3iBaeyWKpPmka
         RIOhisz+cfvytyfGZg+DKWXXawOXySgLqV7gJt48fPv6Wyraj9nLkeN9j0OEXdViFGmz
         0bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcUGlWscPfoOjQ2/RY+CqDxREFzJPUhNCx1vWMcBYac=;
        b=HQqrug6kaza9s6VPjwkhbj4g0NUq9j6hRCTvNKFH99FCzv6O/t84EG01IWFaDTakTm
         W1aR2IUYBWYIqLIrRpoqetY4piD1kGS6eG1aRmiN2U2tNUgRoIMMwVi91M9MC6Ig6ck5
         8thKNQSPqi4Lrrt30knEYG0pa3xHhskSSBTc8+Uwldg6mqkrSuRdMfKrt/Vtoaq4nPYu
         uDjJG4dOJqdIE0xMM5C6INZOz7xsbzfXF0rUWQ2iYAtNhmyloZhFJCal3Kdfju/Poce+
         oIXzyF6kMjXI3HeIOqBt4dKh7uiiNppr3tdybudojt+rjKDYWRsKZKni3ZtlFhshiLAj
         zkFg==
X-Gm-Message-State: AO0yUKWbspU6bukzW0EZoxTpxTTkN74gYgRKEfDhR9riTflGfjpIhAOY
        aMEkEVKrXBCsuDVoRqnQgRI=
X-Google-Smtp-Source: AK7set95gtQqKGisnnc9p+bce+T2xGH3fsL5Ivj13Q9P9Pwq3tFiJ+B9qtMDaikhN+ERi6hqOOyREw==
X-Received: by 2002:a5d:4586:0:b0:2cf:e65a:a5fc with SMTP id p6-20020a5d4586000000b002cfe65aa5fcmr5430408wrq.8.1678997874048;
        Thu, 16 Mar 2023 13:17:54 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdb88000000b002cff06039d7sm271611wri.39.2023.03.16.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:17:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 21:17:52 +0100
Message-ID: <3531852.LM0AJKV5NW@suse>
In-Reply-To: <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine> <2162728.C4sosBPzcN@suse>
 <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 16 marzo 2023 19:35:09 CET Khadija Kamran wrote:
> On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:

[snip]

> > When you are done with build, install, and final reboot to test if your
> > module can "modprobe" or "insmod" (i.e. link with the running custom=20
kernel
> > you built, installed and boot), try to compare the output of the follow=
ing
> > commands:
> >=20
> > # uname -a
> > Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 U=
TC
> > 2023 (44ca817) x86_64 x86_64 x86_64 GNU/Linux
>=20
> The above command works
>=20
> > AND
> >=20
> > # modinfo <name of the module you are testing here>
>=20
> On running 'modinfo axis-fifo' I get error saying module axis-fifo not
> found.

I built axis-fifo with your changes and then I ran "make install=20
modules_install" in a QEMU/KVM x86_32 VM that I use on a Linux host for=20
testing my patches (Linux on Linux).

tweed32:~ # uname -a
Linux tweed32 6.3.0-rc2-x86-32-debug+ #32 SMP PREEMPT_DYNAMIC Thu Mar 16=20
18:09:49 CET 2023 i686 athlon i386 GNU/Linux

tweed32:~ # modinfo axis-fifo=20
filename:       /lib/modules/6.3.0-rc2-x86-32-debug+/kernel/drivers/staging/
axis-fifo/axis-fifo.ko
description:    Xilinx AXI-Stream FIFO v4.1 IP core driver
author:         Jacob Feder <jacobsfeder@gmail.com>
license:        GPL
srcversion:     EBF46AD6851EAAE67D1000B
alias:          of:N*T*Cxlnx,axi-fifo-mm-s-4.1C*
alias:          of:N*T*Cxlnx,axi-fifo-mm-s-4.1
depends:       =20
staging:        Y
retpoline:      Y
intree:         Y
name:           axis_fifo
vermagic:       6.3.0-rc2-x86-32-debug+ SMP preempt mod_unload modversions =
K7=20
parm:           read_timeout:ms to wait before blocking read() timing out; =
set=20
to -1 for no timeout (long)
parm:           write_timeout:ms to wait before blocking write() timing out=
;=20
set to -1 for no timeout (long)

Do you see the "parm" lines? What's the type of read and write_timeout?

=46abio



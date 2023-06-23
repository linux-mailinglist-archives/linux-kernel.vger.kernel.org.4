Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783A73B36C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFWJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFWJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:24:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407481FC2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:24:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668842bc50dso59129b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1687512249; x=1690104249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnToz1IZL5GBj4fgh3BY14k0jbKw0aTmg+ER3wMA0wY=;
        b=CRpLsqXmFFdpkvSb4lHmleXQ458WNVV181189yDl4vSPPYOFuNZDBp5IuGAYZa9REL
         sgavWXCaVtJhSk0JSWwT5hJHJmyCk2CAS81wP9XKg3kk3u6NNyDpxDhDLr2Crg/yx0KB
         9gr/Uzz121jzcCOKJJm53MDVyMuAY4+SO1eJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687512249; x=1690104249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnToz1IZL5GBj4fgh3BY14k0jbKw0aTmg+ER3wMA0wY=;
        b=eG0wVdB1DsU8Vl8JtIsjfyJukcxsuC3q1THOcXdPhgisTN/TtQ7W0XFGqeyaxVyG29
         z/ldQCuVxm+0J2XpE4mRGjJfAQMEVmfbsLxfB26sbtM8FPBZ6nJjOOMCl00fPbUZ1UoM
         r8NM2Zw3TjHlcisGNcKaiSdBZmL6XC5CBTBAYf0MysetwQqdTepr7ioopbAY1sJm8lJu
         JAZ8cO2C4sPoF2lLprLK9g1q4Az/23lmfr8vzg7lRXNKPsq7qtj2xo/LT+VS1R9J4zF5
         FZKJQwAA4D5RFczsmzI2QQI5R9CT9kLIbEf60EwH54+Kt1Rtum5EPOOAwZbm1yIKilgO
         M1Vg==
X-Gm-Message-State: AC+VfDzYUjLX8igv6yTTp6fVefnUlf6iCylchqOlMj+uprPnBAFQ1R+Q
        JRDgtcYBgiql5b3cFqtMmdpfDqBWXkADcC2bDVZP4A==
X-Google-Smtp-Source: ACHHUZ72QSZObfuvlTdeYWEzJMe3xeAH+OOZFrhbQdKa/Iz7ostejHZoPRNxUAUIesn2ttWGG3OiKFVjaLlkCiKNF5g=
X-Received: by 2002:a05:6a20:9190:b0:123:3ec2:360d with SMTP id
 v16-20020a056a20919000b001233ec2360dmr8082518pzd.5.1687512248690; Fri, 23 Jun
 2023 02:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
 <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
In-Reply-To: <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Fri, 23 Jun 2023 11:23:57 +0200
Message-ID: <CAJqdLrrVfQx4fWJjpf0Nz7AdiNshdFi7xgXis_iO1jgU0YeGXw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:34=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> On Fri, Jun 23, 2023 at 12:28=E2=80=AFAM Von Dentz, Luiz
> <luiz.von.dentz@intel.com> wrote:
> >
> > Hi Stephen, Alexander,
>
> Dear friends,
>
> >
> > Looks like we have a similar problem as to:
> >
> > https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
> >
> > That said for unix socket it was decided to not allow it to be build as=
 module, which is something I don't think we are willing to do for bluetoot=
h, so we have to find a way to get around pidfd_prepare, which seems to be =
called due to the use of scm_recv (it is also used by netlink btw).
>
> Ugh, yep. That's bad and we can't workaround it like we did for unix sock=
ets.
>
> Originally, Christian had objections against exporting the
> pidfd_prepare function [1]
>
> [1] https://lore.kernel.org/all/20230523-flechten-ortsschild-e5724ecc4ed0=
@brauner/
>
> +cc Christian

Idea. (-: We can introduce a new function like "scm_recv_light" that
will be just an old version of "scm_recv" without using pidfd,
if this feature with SCM_PIDFD is not important for hci sockets.

Forgot to add Jakub to CC.
+cc Jakub

>
> Kind regards,
> Alex
>
> >
> >
> > ________________________________ From: Stephen Rothwell
> > Sent: Monday, June 12, 2023 8:02 PM
> > To: Marcel Holtmann; Johan Hedberg
> > Cc: Von Dentz, Luiz; Linux Kernel Mailing List; Linux Next Mailing List
> > Subject: linux-next: build failure after merge of the bluetooth tree
> >
> > Hi all,
> >
> > After merging the bluetooth tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!
> >
> > Caused by commit
> >
> >   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> >
> > I have reverted that commit for today.
> >
> > --
> > Cheers,
> > Stephen Rothwell

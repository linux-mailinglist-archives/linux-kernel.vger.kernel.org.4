Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A8741DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjF2B7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2B7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:59:04 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jun 2023 18:59:01 PDT
Received: from mx5.ucr.edu (unknown [138.23.62.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607972681
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688003942; x=1719539942;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
  b=sh76aNU//FSXh/8Siz++l+feKuI+/ggXfEuIZ7DrQOYzDCAN3lLGo9IJ
   rUc+bWVyUkOY6rzSG428DgRXSYOpy8DRa3Ot/WdxInRHuNVWHTRQszokh
   btR5BIVJXDmbzdWWdJZNkkyegTpCGSWoxQxXVUPA4c/BJEp/PLmqvEpPI
   UqSksnIpB5Xhb+NFNrb6d3s22Ds6+DGgcC+ZahA+AOAhiTPcXvyyX7mMM
   v6tuPAjhP1RQJLV7C2cLALZgR2k90GRir/W9P8ty8YmKZMU73VjcfAFeL
   qUduV1e+h/dspX185VBf9OVJmtq7H5jcVex9zP2fDjhNPg2FcLvWcuILw
   w==;
Received: from mail-wr1-f69.google.com ([209.85.221.69])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2023 18:58:00 -0700
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso79764f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688003878; x=1690595878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
        b=VFkawkT4irTE5sIF+gsnj7bJs7eIR08hSU7dK4LdxEsh08HQmbnpeKrOycV34L3fOY
         j6E1gcT79LHbD95tV+xo5fG1a6EqAAExDRJDkPt6t5BNks3SYoM6iL6qy6TwYEK+26zu
         W6wfV0vMe1Yrwog+wtydo9HFVBv9YK5tiZpL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688003878; x=1690595878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
        b=M38jfY/96tT+yzXgo9g0mCr7X+sZde4iUyW5f+U4+opFpzG0JMG8h9u8JzHs4wlXo6
         XmeB7Il0+Y4q/gWB5aXTYLjHrC0kDmZJbr2ElHXwTBqvLEtlVImrpR/YqeSDVHGYQupa
         UkUmVRoNPrDHH2Q1MXmkuc1Wo4Tk9Ivg3MOQW6L9f2ynoeyYfor/UPbS67jODHeiGQXm
         tMr6COPJZXY28zNa2LC0XpKekTcThRjBouxExqmdRAYuMv08fIgWTjLwL3f7k7SSBXuU
         1O1JviKDPwy9ebYxajC7ell/jE5wINL3QlQzRYK8hkT1T049GYw0URKqdaKXOJIBggmx
         Dnqw==
X-Gm-Message-State: ABy/qLZSGFcAnq/bXu7jaLD9svFWQsWXs2V/HGfAkVNMd5kQaS3eQPL/
        KqC+LRDonLLwd1p3ofAHKF/D2Y160Jlfiul+NVgMW5G2uJiZeHIhFsffN7+pzEa7cmexEhH0eHQ
        r/OjX77N6P0/TJwoFUJY2R+v7qka9rlJu4CeM7IHh2w==
X-Received: by 2002:adf:f2c7:0:b0:314:13da:39a4 with SMTP id d7-20020adff2c7000000b0031413da39a4mr743209wrp.66.1688003878301;
        Wed, 28 Jun 2023 18:57:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOF/6OWGWZTemvPXak6D95jENYjn5TNXI25OqnTNh53Sx8ZHggcEwCmrswHwElG9FHDlCm3+xlThuhf23SAes=
X-Received: by 2002:adf:f2c7:0:b0:314:13da:39a4 with SMTP id
 d7-20020adff2c7000000b0031413da39a4mr743200wrp.66.1688003878052; Wed, 28 Jun
 2023 18:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230628150140.GU21539@linux-l9pv.suse>
In-Reply-To: <20230628150140.GU21539@linux-l9pv.suse>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Wed, 28 Jun 2023 18:57:47 -0700
Message-ID: <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
Subject: Re: How to reproduce the BUG general protection fault in hci_uart_tty_ioctl?
To:     Weiteng Chen <wchen130@ucr.edu>
Cc:     joeyli <jlee@suse.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiteng,

Could you give more info about the bug, e.g., kernel configuration,
qemu arguments.

Thanks.
Yu Hao
Ph.D. student
Department of Computer Science & Engineering
University of California, Riverside

On Wed, Jun 28, 2023 at 8:02=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>
> Hi Yu Hao,
>
> I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl=
":
>
> https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBP=
DeCO2g@mail.gmail.com/
>
> I am trying the C reproducer in your URL, but it is not success yet:
> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
>
> I am using v6.2 mainline kernel to run the C reproducer.
>
> Could you please provide suggestions for how to reproduce this issue?
> And what is your qemu environment for reproducing issue?
>
> Thanks a lot!
> Joey Lee

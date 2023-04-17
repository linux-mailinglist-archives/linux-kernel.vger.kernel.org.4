Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCE6E3E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDQDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDQD3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:29:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F53AA1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:29:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w1so1395525plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681702152; x=1684294152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i439ByrCwwyeW71ZoBXBy3yEzqs8Vnj9PSWAYBsoXlE=;
        b=CZIhzjCN+vEVTWpW65Yup+aopwZLg+7s8FT92h4UGxiUCXwnDrLdzodkMn46t1WRCm
         EHa/z84VHl6kq5BEgCJLxRGlBfwJHvYCpu/CBrFbDGLig4OyIE7DnNKIhFWklYg9172M
         CatswHGFSeNeVaSfXEnW7sKMUDbv+A0MeLWoxrvQvkLOYBLWea1N2qlCLY6avBPl9kMK
         OkDwwnFgqmIZaWymXf7qbmnB+aGhWu+V+R3PMlmfONx5I46r0j9g+xJcwHxMdTvqdm0k
         f7aJSZbC+2zgtMIm/30mDPfKm737OeHamS1xzjDztETJei2pDxbLPbBHSN9WlrjBQ6IL
         9muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681702152; x=1684294152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i439ByrCwwyeW71ZoBXBy3yEzqs8Vnj9PSWAYBsoXlE=;
        b=GujSfKu61CH+U0kwPCMa/SeKWyL9Ur2AT3j+FsEr9wHyHs4cgxYAVUDdrpmvVi7Uz1
         WniiGa/COxntIRERNtEyBreMlv/vQgDNwkOdER6u8MxaV0Tt14Gbffl0okdVjIHlC0MS
         yU8G/lSwlpPt+H7jH64K9h/pzSroILfBTWB5TwUl+Q7cSNDumrF7hnBqq70JbVqE9u6F
         VSky5IlCet2lGizXctLpSvRbZKZHdwZzw/LtsD7UXX1r4dturBgf4oSXLIiP3nPQparr
         5a/Nk1G4OhLx0KuuQNFSG+IPdixwZfAytkdiRElmhwRKwEaNDlxB4jaDJ5vAfPMCDEk4
         qhHA==
X-Gm-Message-State: AAQBX9dxiki3wgLIiWF2RheuEYCxQ6e9tD4cbX5K08p5tsw8E4wE1EBb
        yuP9wZXAP36cDQZUDI8/+fEngQ==
X-Google-Smtp-Source: AKy350YJJdcM66yr8j9/kPzcnVKnGuU1IZcC++IHyi8cKOk9L52nS3dy7qY5Jtqe1FbMnc6AHgOYtw==
X-Received: by 2002:a17:902:c947:b0:1a6:7ea8:9f47 with SMTP id i7-20020a170902c94700b001a67ea89f47mr12982890pla.66.1681702152044;
        Sun, 16 Apr 2023 20:29:12 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm6525445plo.42.2023.04.16.20.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2023 20:29:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
Date:   Mon, 17 Apr 2023 11:31:08 +0800
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5745886-81C6-4BB3-848C-D4A7E47E720A@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
 <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
 <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8816=E6=97=A5 =E4=B8=8A=E5=8D=885:06=EF=BC=8CDavid =
Laight <David.Laight@ACULAB.COM> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Li Feng
>> Sent: 14 April 2023 10:35
>>>=20
>>> On 4/13/23 15:29, Li Feng wrote:
>>>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>>>> to N-1. However, some cpus are busy for other jobs, then the =
nvme-tcp will
>>>> have a bad performance.
>>>>=20
>>>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
>>>> socket worker threads.  The parameter is a comma separated list of =
CPU
>>>> numbers.  The list is parsed and the resulting cpumask is used to =
set the
>>>> affinity of the socket worker threads.  If the list is empty or the
>>>> parsing fails, the default affinity is used.
>>>>=20
> ...
>>> I am not in favour of this.
>>> NVMe-over-Fabrics has _virtual_ queues, which really have no
>>> relationship to the underlying hardware.
>>> So trying to be clever here by tacking queues to CPUs sort of works =
if
>>> you have one subsystem to talk to, but if you have several where =
each
>>> exposes a _different_ number of queues you end up with a quite
>>> suboptimal setting (ie you rely on the resulting cpu sets to =
overlap,
>>> but there is no guarantee that they do).
>>=20
>> Thanks for your comment.
>> The current io-queues/cpu map method is not optimal.
>> It is stupid, and just starts from 0 to the last CPU, which is not =
configurable.
>=20
> Module parameters suck, and passing the buck to the user
> when you can't decide how to do something isn't a good idea either.
>=20
> If the system is busy pinning threads to cpus is very hard to
> get right.
>=20
> It can be better to set the threads to run at the lowest RT
> priority - so they have priority over all 'normal' threads
> and also have a very sticky (but not fixed) cpu affinity so
> that all such threads tends to get spread out by the scheduler.
> This all works best if the number of RT threads isn't greater
> than the number of physical cpu.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, =
MK1 1PT, UK
> Registration No: 1397386 (Wales)

Hi David,

RT priority can=E2=80=99t solve the cross numa access issue.
If the user doesn=E2=80=99t know how to configure this affinity, just =
keep it default.

Cross numa is not a obvious issue on X86{_64}, but it=E2=80=99s a =
significant issue
on aarch64 with multiple numa nodes.

Thanks.


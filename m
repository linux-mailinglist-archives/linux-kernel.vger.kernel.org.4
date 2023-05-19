Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28145709A53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjESOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjESOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB318C2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684507606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSlH9yed2+egztC1235eRiYpBNaIcoimkdcsVGFGI0o=;
        b=ORXElE425COH1r8J/0IRwlGRwon6vcnakJzOOHRx1ZMkP5dZFG956pbM4qwd+iLTy68zwC
        mg5ZXZErDr1U+KHBXPPnEMkxFJsItebJTY4mANgvh1m9OJW03W8cekNEt8FGXt7fXPXRRj
        MVVz3ktTVkW1zofFAZKtRd5kaCVQX74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-WSCmofTKPDmBcItrXgwKLQ-1; Fri, 19 May 2023 10:46:45 -0400
X-MC-Unique: WSCmofTKPDmBcItrXgwKLQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f508c2b301so3469995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507604; x=1687099604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSlH9yed2+egztC1235eRiYpBNaIcoimkdcsVGFGI0o=;
        b=ZiP0qC1xr3zukLKO4dU+vUMhpRx4M0HLKZIKk1XwNRzG8op38GuDYHhm83EsLIlfGI
         y1BDAcHoQ0VmazveuFliZI83j2JoRsR+4V4qMdyJRmuQQjA61WUJD3ntcGVGrDpfxHW5
         Lo24BmOT40XACz14oyaeZ3ixHDOseDJY7NC3a3XsIKhvGBpTjK6QYAahgJk9a965/0Gy
         zfxSExMJZ/X5uBZOwmCOb7LQkyVEH+do+Lnq4WOOLPNb+QU63Z/ee/ILdVOuBFB7wZ6E
         3vj7zISFgnz3lyanp+NzLrQRofqcNXEptE5Hqf0D1hU/IJ2VWcJzzm5bU9PdRVhsc81T
         3Owg==
X-Gm-Message-State: AC+VfDyP4GncFwiTKmCfuTGuUspZKKpNbBeRV0c6a1MCw4TnCfb9JQxe
        a6Q3Yt5LqPkW3NZYMzMcQIXt57zAhRm4A/R223UQurpiPTB57vEFKpYg35Y8+WhjWqm0AnezV3d
        wHa+HLCV/rXMTj+wbz3Yc/fm9
X-Received: by 2002:a5d:4b4a:0:b0:307:5561:5eec with SMTP id w10-20020a5d4b4a000000b0030755615eecmr1603020wrs.0.1684507604325;
        Fri, 19 May 2023 07:46:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C903d6ahLAiz8d0kKQA1HiJ8aJs3uxoW70pAdOmb9Ign7FpFP2GnVquoogPSXHNEO9bUbaA==
X-Received: by 2002:a5d:4b4a:0:b0:307:5561:5eec with SMTP id w10-20020a5d4b4a000000b0030755615eecmr1603008wrs.0.1684507604009;
        Fri, 19 May 2023 07:46:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-104.dyn.eolo.it. [146.241.235.104])
        by smtp.gmail.com with ESMTPSA id n6-20020adff086000000b002f6176cc6desm5423908wro.110.2023.05.19.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:46:43 -0700 (PDT)
Message-ID: <7f189d22226841168eb46b7be8939e2d06fa476c.camel@redhat.com>
Subject: Re: memory leak in ipv6_sock_ac_join
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?UTF-8?Q?=E8=8C=83=E4=BF=8A=E6=9D=B0?= <junjie2020@iscas.ac.cn>,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com
Date:   Fri, 19 May 2023 16:46:42 +0200
In-Reply-To: <13e257b8.6869.18833286427.Coremail.junjie2020@iscas.ac.cn>
References: <13e257b8.6869.18833286427.Coremail.junjie2020@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Please use plain-text when sending messages to a kernel devel mailing
list.

On Fri, 2023-05-19 at 16:37 +0800, =E8=8C=83=E4=BF=8A=E6=9D=B0 wrote:
> Our modified=C2=A0tool found a new bug=C2=A0BUG: unable to handle kernel =
NULL
> pointer dereference in scsi_queue_rq=C2=A0

What you mention above is different from what you actually reports
below.

> in=C2=A0Kernel=C2=A0commit v5.14.=C2=A0

That is not exactly new.

> The report is as below and this bug don't have a repro C program
> until now.=C2=A0Please inform me if you confirm this is a=C2=A0reproducib=
le
> bug.

I think the above expectation is quite beyond what you could get. When
you reports a bug _you_ are supposed to try to reproduce it.

> =C2=A0---
> =C2=A0BUG: memory leak
> unreferenced object 0xffff8ad4e16c5760 (size 32):
> =C2=A0 comm "syz-executor.2", pid 17137, jiffies 4295510146 (age 7.862s)
> =C2=A0 hex dump (first 32 bytes):
> =C2=A0 =C2=A0 fe 80 00 00 00 00 00 00 00 00 00 00 00 00 00 bb=C2=A0 .....=
...........
> =C2=A0 =C2=A0 01 00 00 00 d4 8a ff ff 00 00 00 00 00 00 00 00=C2=A0 .....=
...........
> =C2=A0 backtrace:
> =C2=A0 =C2=A0 [<00000000033cd1b4>] kmalloc include/linux/slab.h:605 [inli=
ne]
> =C2=A0 =C2=A0 [<00000000033cd1b4>] sock_kmalloc+0x48/0x80 net/core/sock.c=
:2563
> =C2=A0 =C2=A0 [<00000000724962dc>] ipv6_sock_ac_join+0xf0/0x2d0
> net/ipv6/anycast.c:86
> =C2=A0 =C2=A0 [<0000000027291f90>] do_ipv6_setsockopt.isra.14+0x1e23/0x21=
a0
> net/ipv6/ipv6_sockglue.c:868
> =C2=A0 =C2=A0 [<00000000bb6b5160>] ipv6_setsockopt+0xa9/0xf0
> net/ipv6/ipv6_sockglue.c:1021
> =C2=A0 =C2=A0 [<0000000057fe6cc3>] udpv6_setsockopt+0x53/0xa0
> net/ipv6/udp.c:1652
> =C2=A0 =C2=A0 [<0000000023dcd6bb>] __sys_setsockopt+0xb6/0x160
> net/socket.c:2259
> =C2=A0 =C2=A0 [<0000000081a16a2e>] __do_sys_setsockopt net/socket.c:2270
> [inline]
> =C2=A0 =C2=A0 [<0000000081a16a2e>] __se_sys_setsockopt net/socket.c:2267
> [inline]
> =C2=A0 =C2=A0 [<0000000081a16a2e>] __x64_sys_setsockopt+0x22/0x30
> net/socket.c:2267
> =C2=A0 =C2=A0 [<0000000075aec224>] do_syscall_x64 arch/x86/entry/common.c=
:50
> [inline]
> =C2=A0 =C2=A0 [<0000000075aec224>] do_syscall_64+0x37/0x80
> arch/x86/entry/common.c:80
> =C2=A0 =C2=A0 [<000000006cd4d12f>] entry_SYSCALL_64_after_hwframe+0x46/0x=
b0
>=20
> BUG: leak checking failed

This was probably addressed by:

8c0de6e96c97 ("ipv6: fix memory leaks on IPV6_ADDRFORM path")=C2=A0


Cheers,

Paolo


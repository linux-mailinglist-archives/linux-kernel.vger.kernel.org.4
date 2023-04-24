Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34106ED79F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjDXWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDXWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:13:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB25B90;
        Mon, 24 Apr 2023 15:13:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4811964a12.1;
        Mon, 24 Apr 2023 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374394; x=1684966394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9rvKKuJVj1CnXeKwNCCdeFPzJf6ElUXCptJ/Xncu1o=;
        b=lgW/07YTzPgxutnXZ8yZ9NDI2sbzEYZRwHOtg5AvLIGZaO42Hme6ZIPkRlXSGKXu4L
         tSsp1nw+IYnBdrFXuEqruxS15GqiOnl2olmJwMx1T2EIizWecMs43X5AvjAQFchtsZhX
         Uc3vILp44cAhwxN3xMRwpQPkuMRAxD4/iyKkPDuOJoClMQ6jTM41zvFrpsRbu7CCpq7N
         OhpBgr5rEwrEdi45ul8uj517SM+wEyjtp6Llk6aV5P3GoaSo7caowbk3fDg4JIpqkJig
         J41g5iMu/sp3yTwV3tCJI3ftaUZvtmq2t8zNs+oOr4EIKq5XmlYWq6Vx6FKKAQtPeRYT
         qTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374394; x=1684966394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9rvKKuJVj1CnXeKwNCCdeFPzJf6ElUXCptJ/Xncu1o=;
        b=W7WbHcYG39gsoJBVd7Om2MNmDzUc7Z0pdf4I08jT9Ob0GQ71lj3DCH+7W3vDq7jnw7
         Rl/t4IVFKyPmCVMxYpbTrgyiK753DLQzbe3imUh4TczDC6d2dRlgw0g/MN+urs4KVpfR
         mIIy3Bs9hraQn2G6Aq2tER02VaxFaRXDUh7t5h2GYYUaJS8rXVyQQ3DSemUif6u1l4k+
         B0LvXHbKwH0FPG2sKb4kF05saGxwnO2L/EXfwvD4jzo+GNOu+lMAVGtnPb5dhrTEcrI6
         XxACMKD12WoKI+0Alw8scpQ4h1OzGmiXvaeX6rEYa7VqoHEREH+xONhXvmkfBEprZaLY
         2UHQ==
X-Gm-Message-State: AC+VfDywYiGRg7p4YX3pHFtn5TL6CpmquUL6XsqcRfle4rGFGJ4Sj9nB
        UhabhgL3Dqmucm5T3z5IUz5Txpi0WqZ2fw+ddUU=
X-Google-Smtp-Source: ACHHUZ7NDc8ftZgKp3D6+xjLBB5r4jOIbLW9ESTjJBqzh7b7RRVFRxjd4F4qyRKzKqNsTXfebgAdu1O2qNo8hfgzOKg=
X-Received: by 2002:a17:90b:a49:b0:24b:d66c:523c with SMTP id
 gw9-20020a17090b0a4900b0024bd66c523cmr1346155pjb.9.1682374394571; Mon, 24 Apr
 2023 15:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <87cz3tylwx.fsf@mail.concordia>
In-Reply-To: <87cz3tylwx.fsf@mail.concordia>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 25 Apr 2023 06:13:03 +0800
Message-ID: <CAABZP2zk2kpgocnGk_on3r3awyQcVyEtBQsby=brW=ciFSCYjA@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 6:07=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> > Dear PowerPC and RCU developers:
> > During the RCU torture test on mainline (on the VM of Opensource Lab
> > of Oregon State University), SRCU-P failed with __stack_chk_fail:
> ...
> > by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> > but if there is a context-switch before c000000000226edc, a false
> > positive will be reported.
> >
> > [1] http://154.220.3.115/logs/0422/configformainline.txt
>
> Says:
>
> CONFIG_CC_VERSION_TEXT=3D"powerpc64le-linux-gnu-gcc-10 (Ubuntu 10.4.0-4ub=
untu1~22.04) 10.4.0"
>
> Do you see the same issue with a newer GCC?
I would like to try that in the newest GCC ;-), please give me about a
day's time because I am going to compile the gcc ;-)
>
> There's 12.2.0 here:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/12=
.2.0/
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ppc64le/1=
2.2.0/
>
> Or if you can build in a Fedora 38 system or container, it has GCC 13.
OK, I will try it or similar

This is a very learningful process for me, thank you all ;-)

Cheers
>
> cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794AA6CCB27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC1UBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjC1UBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:01:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70240D3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:00:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so16674488ybu.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680033602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyZf9+UJUfqCnRIlslbdqTbbosh6eMQPs6SnpxPb5CM=;
        b=B1Lv9Cpzqq0MwAVYWee4B/SMgpHkR9rorpdv15HtT5fi6svGF8Xbq1BCeO+G38+18j
         VgEZKdj0wayKVDhEEIQvgieAKccVMrsIfeWG/oHjGi3BqIxi/I47GiyLsbph/TuahZYN
         mIQ29nZNruWmeNT0YnW06HhJVNUaIHMBFaLAe0VNLUgZW6DDkXTYLWvGZfjUZp4HTxr3
         pnqIsaIJ8GrCojH2E0ViK3ZXihUfils7sYYMhYn6lbvjaSC14oCfOQWQSigYaytiu7Bk
         qooGpjNwrozPXyRlXHaaLMHUnbZDDjPXuLo3p+uJAYVbuoCFuEQkNkJ9D8plHgdhyVpy
         17dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyZf9+UJUfqCnRIlslbdqTbbosh6eMQPs6SnpxPb5CM=;
        b=1TZl8qoeRs7WhMRHpdk1iFhiA4k/xF5D0MmCJahEdYtdQfQxJt6PchbOaPzAliw4a9
         KgU9oHyIBSbSf+tC+ZUpDkAF77xsVuk19LSVfCgbh3hFG8WyXTMTZz7mN+OXXN1QOB4W
         4vNm7wNPlmiENRk/b+kBFH5QzamAtwdiwl1MwqjjT2vzwmzN7IZWG6Sy9QTA0ZeKmHE0
         FPhqpnnHYD3meEQqbuwOi8fmDVe518bgmHk0rONHFCA/VzVeK4WXpd/R3BKI+VmXCjbR
         IhOeiCyqHQwuVKUDEUXd0cfuae4QcAp+Excfve/AvPrJ0QzyTJN0mvZLtLgGATAct++w
         GZ7A==
X-Gm-Message-State: AAQBX9cwRDFfuU4olQDHfW47quvh+nTIQVScAvjTnx+V7JNh83E8huv9
        qSxxO50PYgh1mikh3at05pItBlDzysZfAVUCLqdL
X-Google-Smtp-Source: AKy350biWaC8N7ijdohCMbaHzL5yhuFYIlbMY5hI7o/mw+AcRdJwIXeJMk+loAOOPVUZPOfEk7o+aTjx7vgfjgck5s0=
X-Received: by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr8804150ybt.3.1680033602328; Tue, 28 Mar
 2023 13:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de> <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
 <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com> <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de>
In-Reply-To: <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Mar 2023 15:59:51 -0400
Message-ID: <CAHC9VhQfiNd_4uWBmKCC81UnOJb7Y=UFCDMXuqz3=UPr8QtqNw@mail.gmail.com>
Subject: Re: selinux: Adjust implementation of security_get_bools()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>,
        Ruiqi Gong <ruiqi.gong@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 3:30=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> >>>  security/selinux/ss/services.c | 52 ++++++++++++++------------------=
--
> =E2=80=A6
> > Given the fairly extensive refactoring here,
> =E2=80=A6
> > If nothing else it will make the function easier to read,
> > and I think it will simplify the code a bit too.
>
> I am curious which change possibilities will finally be picked up.

It's hard to extract out the various changes due to the way the diff
was generated, however, looking at the changes in your commit
description, the only change I can saw with any certainty that I would
merge would be your item #2:

> 2. Replace the statement =E2=80=9Cgoto out;=E2=80=9D by =E2=80=9Creturn -=
ENOMEM;=E2=80=9D.

Agreed, gotos that jump straight to a return can be replaced.

> > I would probably also keep the combined @names/@values cleanup under
> > one jump label; this function isn't complicated enough to warrant that
> > many jump labels for error conditions.
>
> I got an other impression for the affected function implementation.
>
> Would you like to take advice from another information source
> better into account?

In this case, I prefer what I suggested.

--=20
paul-moore.com

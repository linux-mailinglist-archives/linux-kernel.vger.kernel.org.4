Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE36C7299
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCWVvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCWVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:51:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48021EBEC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:51:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so684496ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679608295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9tjYpRfGyQ0DWCdxSWns8C9usJ6/6Y+ugnz5Vzrwjo=;
        b=J4wHRsgSNxdEFohPGGD/N2T8lvaduJlaGU0d4KTn73o7459Sw3xLGjKoDLSEBP7Aic
         W+4ILEs4ilbQ4y7NA3IRevPoEMlsT/gvpeROdFxVC4wwYJskbk6mbouh83ABOMpBOEaj
         zbnHPK68MHL2iLk98KpvdNa/CbPghhZZR4iuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679608295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9tjYpRfGyQ0DWCdxSWns8C9usJ6/6Y+ugnz5Vzrwjo=;
        b=NqZ0CRnr6amKQFRGo4QruMIbSr9sbNwa1uTV7LoE0+XbMHiZMXcjYkypC7UYKc8hWp
         Ox+rpjGe90Y9Jy7wIDe04X8hTqNkshtIAWGw1wqGb71Tpj8ywG5UbceA0+4M8Th9nN7G
         MGTmqSqgwKzzxp3BY/2m1VrJq0EpeiEXGbN7HmGLU/fmDDC2SeqgWZ/cvN/8u9F2yJu/
         qMg6X50nM6vQEAiX0H7ylGSYfFXETr4VUEHsCGve7ZRnspunWz9tb/LhbhaCC6pNtWpW
         p72Xp9jHS04kHbO9E/A5XnCy8nobzEs/r583QkeBrm/8GwmCfb6GiF7cBsq1hsCgSy+S
         AdXg==
X-Gm-Message-State: AAQBX9dD5gMuriRiuz23o22hgBewAnA2ylUHMtam57eXMb5LXCLSR5Hb
        PbjwemEAMmqsiqISRszc3T0xXhqxdTjlIBLawyVixg==
X-Google-Smtp-Source: AKy350ZeY6vnMgPfnlIdW5Q2fXVoqnBS5c/dnvZMimX5b4BsALx7rr45APENfXnyh7jDPRjApBMHgQ==
X-Received: by 2002:a17:906:a0d1:b0:93d:d396:8e1 with SMTP id bh17-20020a170906a0d100b0093dd39608e1mr435272ejb.73.1679608294808;
        Thu, 23 Mar 2023 14:51:34 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906195a00b00930a4e5b46bsm9161066eje.211.2023.03.23.14.51.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 14:51:34 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id ek18so721947edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:51:34 -0700 (PDT)
X-Received: by 2002:a17:907:2c66:b0:931:faf0:3db1 with SMTP id
 ib6-20020a1709072c6600b00931faf03db1mr4152130ejc.4.1679608293841; Thu, 23 Mar
 2023 14:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230323184537.749868-1-agruenba@redhat.com>
In-Reply-To: <20230323184537.749868-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2023 14:51:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whms=0Cvmk946a0Pebv1YLWiuYCjyVy6yNeBp55+R8sMw@mail.gmail.com>
Message-ID: <CAHk-=whms=0Cvmk946a0Pebv1YLWiuYCjyVy6yNeBp55+R8sMw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix for v6.3-rc4
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:45=E2=80=AFAM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>

Wat?

>   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs2-=
v6.3-rc3-fix

-ENOSUCHTAG

> for you to fetch changes up to 260595b439776c473cc248f0de63fe78d964d849:

.. and no such commit available in any other tag or branch either.

Did you forget to push out?

                    Linus

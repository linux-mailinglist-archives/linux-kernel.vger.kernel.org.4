Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D070E932
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjEWWlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjEWWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:41:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658483
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:41:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso845240a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684881708; x=1687473708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifpOcrk0dnFQvX+gTUm82nSRdqd7ZH4Wq+ze4WxqeuE=;
        b=XROk+kdGbO8BnEEy5xmHH6mdhMmVynUxazY5lULeccGHJtCswlb3+L9JEtmrtfX1m1
         BCZKJaPehCmj+O3vhkDtk6ySYZ7BdfrPNaWbB4K0lRoNGTs+cqwmopSK2zSNDNcf8h4r
         Tka+FIoq0R4Ia50P2Ler9dmGOwglSm+x14P/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684881708; x=1687473708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifpOcrk0dnFQvX+gTUm82nSRdqd7ZH4Wq+ze4WxqeuE=;
        b=WmBvkLMLqGMUq4sjXO6jDpvoBfgTHuCRTc75aWdObCk/w3Z75ASW9MAvLu3YUpL4Jb
         8Sw7s9jS9vAT1FYZOmCldYIJJ/Dtjr6IYCs1vC2om3j/+Lpl4oJFSh3jjBrXV38GMqt6
         ecfOBim+Pdygf0n6L0CvO8aBbJ2pcP/69kXtR4o3LCEKmPtz5yT/q89czgsHb78C8AjY
         AXj/nkUF+TfTeX6lnas43b2e5o4XpD87TJ0Ld/4JuoLJE0Zo7OKvFRPzuFPa4TDgxq/U
         J5pX06TGJinPaEPoTbia3pFYxMCW+mVaPmisC6gW79nqM85bZ0km2IamsZ48jmLK4TlM
         C+aQ==
X-Gm-Message-State: AC+VfDw3oCk2Ijp2H6W70oR/d45x8cI/n4U9opmf1AWYwoOUCj2wAQZw
        4PB4UMOoIxx0+ainljVbosKnlz0jQw668nKUPfNosQ==
X-Google-Smtp-Source: ACHHUZ5kRXSla0tC8gV+ZspgFmTGS/YQ5fE/DfXEXe6fCkRsgrDUX1eRWmrDHEo9KSq1OJnJ+hGhzA==
X-Received: by 2002:aa7:d9ce:0:b0:50b:5dbe:e0f6 with SMTP id v14-20020aa7d9ce000000b0050b5dbee0f6mr385679eds.25.1684881708149;
        Tue, 23 May 2023 15:41:48 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm4356145edt.18.2023.05.23.15.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 15:41:47 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-513fea21228so824270a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:41:47 -0700 (PDT)
X-Received: by 2002:a17:907:3605:b0:973:7252:1779 with SMTP id
 bk5-20020a170907360500b0097372521779mr1128578ejc.8.1684881707170; Tue, 23 May
 2023 15:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
In-Reply-To: <20230523204131.1898839-1-jcmvbkbc@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 May 2023 15:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxoT4Soph5qg6zbGkumnVHaBKA4DWwAkM4-au2e0fmHw@mail.gmail.com>
Message-ID: <CAHk-=wjxoT4Soph5qg6zbGkumnVHaBKA4DWwAkM4-au2e0fmHw@mail.gmail.com>
Subject: Re: [PULL 0/2] Xtensa fixes for v6.4
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 1:41=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com> w=
rote:
>
> - add __bswap{si,di}2 helpers

That assembly is funky. I had to look up what the "src" instruction
did because it looked so crazy.

                 Linus

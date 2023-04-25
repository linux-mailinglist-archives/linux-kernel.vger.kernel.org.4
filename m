Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB26EE83B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjDYT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjDYT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:28:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723792D70
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:27:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-95678d891d6so1101263666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682450859; x=1685042859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiAll7RfuduP0I53YTER9ohVBuZInpNAgveNMxgNuT8=;
        b=eikwr/vjGm0/7viBcsrJMjWqPjw51ykPahnc3BBTgRc3WG4WxE3HpbmooFpsLb2ifk
         qVLu0pRFZfoNs2LGxNXGUBhPW7q8f6BcPBGxskWk5uruNIzkFgcVrzgWcVJfzkRaKTPd
         N6f0beUvTDuTUCMp3W2nkeHOlkuDZ5N0/gRjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450859; x=1685042859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiAll7RfuduP0I53YTER9ohVBuZInpNAgveNMxgNuT8=;
        b=cZSrmL0Hb9HigiCXxQZke8PNAvi4gtN+Jo6jZSkOZVWNAbTAaQ9obwOBKWKo0XijeG
         hgoAHGIS1yGIyJ3Y7uK+Ex6nLRWyGTlk6AWIMUAngUebz2Q1isUXcMkVpz1tdT7djF07
         yaWsaSu1PK4tLPXKMtqdXu2IpKgTi1wYjYKYZZ+71sJTTih3pQC2JhQNceQZP/p5IJPy
         q1K+Wcj7QhBkHeQNFeMT9ohxbkvuZRD7bnW0HLrJDyAH85Naf4diOGNEqPoSLcLXCvxA
         F1Y+V4vdufhXSvu8Fy2S00e/jo6+yK9iMUqkwjE75rfvH3rQJB+RtCBMdJNDUhTXJXwg
         OEDA==
X-Gm-Message-State: AAQBX9cVeKZJ3bSo6HHkla2lLouqC9AGt8Snlj0wJXnahQ0AKsqE5y8R
        /P1oYTnHNnG9HbfNtW+JD3ebO0/uR1FrZKCeKPFwAw==
X-Google-Smtp-Source: AKy350YUxCZYFpD8I721AxFVqAE2bEo+nXxPSiqb4qd60w7NtbttcRKix/yIqmejmFteoHkDjpRnbA==
X-Received: by 2002:a17:906:63d1:b0:94f:cee:56f2 with SMTP id u17-20020a17090663d100b0094f0cee56f2mr13121914ejk.4.1682450859740;
        Tue, 25 Apr 2023 12:27:39 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id oz15-20020a1709077d8f00b0095850aef138sm4308002ejc.6.2023.04.25.12.27.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:27:38 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-95678d891d6so1101257866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:27:38 -0700 (PDT)
X-Received: by 2002:a17:906:b6d1:b0:94e:4c8f:759 with SMTP id
 ec17-20020a170906b6d100b0094e4c8f0759mr14744661ejb.38.1682450858375; Tue, 25
 Apr 2023 12:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
In-Reply-To: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 12:27:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
Message-ID: <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Huth <thuth@redhat.com>
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

On Mon, Apr 24, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> These are various cleanups, fixing a number of uapi header files to no
> longer reference CONFIG_* symbols, and one patch that introduces the
> new CONFIG_HAS_IOPORT symbol for architectures that provide working
> inb()/outb() macros

Strange. I was sure we had this, but you're right, we only had HAS_IOMEM.

And then we had that HAS_IOPORT_MAP which was kind of related.

Anyway, the new HAS_IOPORT looks like something we should always had
had, I have no complaints, I was just expressing surprise that it
wasn't already there ;)

          Linus

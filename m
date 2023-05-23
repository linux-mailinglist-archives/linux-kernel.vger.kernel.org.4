Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE170DEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjEWOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjEWOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:12:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0EA132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:23 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-335394455ecso6404985ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684851140; x=1687443140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi1zl47x5ifvhANMjd4DmAyV5RXAPenwL8pPYNaAVjM=;
        b=A1Dc97TtFeQjG10Dq0AfjP6qq8AZlrt3kfpJPaSxM6/BRutIqWG2if0GiG4oce78a0
         2DM2gqPXLqS34DuG6rKUc+51NED+ARhl4nG09FmDYbmH4Ks8Nkj2MRDYGkeZYX6dVhsD
         aRYnVYAGOnxRO90T9vbmudonecOK+p+sUiq7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851140; x=1687443140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi1zl47x5ifvhANMjd4DmAyV5RXAPenwL8pPYNaAVjM=;
        b=IEUjGycRPZjfShM/beCCF3Tr5cbdYaI2eAOyGEcmVW0QTzymmRozj/gRsuFnR90gEc
         wAtzjUy8vqOYE2nfVuwEYN+B1qEn+s9gvcVaz6/JLTZroOV0dFPdYjTECVMX1zZy4IiV
         VHK0tnHczL5Ng+AgDGz670s65tMUJ3N4cjHBfYSwOhOiIYnZQjrrP/cIWwdSYNR6Jo05
         CQryfMGx1zqWQvP/b5cVDTkBr8Wds9QzeGuLP1bpVyudyhG1ii+3WisQo8vCAtxrwNB4
         ZZT1EK64DHXK7xR+ExWLHrPdz8qlxOhI6WTvBHre54UOUCtLEgiw0KH++Nlg4Kvw01e0
         vvWg==
X-Gm-Message-State: AC+VfDzpIhXv8ctWdzNkHr5zWpt7giLKQR1hESSLcprOpcMGsDuardIT
        nf/R9xtOVTL8XfSi0rcliVhidY+19BfxHF0WJaI=
X-Google-Smtp-Source: ACHHUZ6i0+zWOYrgf9jxMzZ/T1MBNr0hQxRsD0/nq77kqT6L5VCbM4XS7bpSsRInXCR7zLM3K4YD6w==
X-Received: by 2002:a92:c947:0:b0:338:b798:75b2 with SMTP id i7-20020a92c947000000b00338b79875b2mr8549521ilq.26.1684851140572;
        Tue, 23 May 2023 07:12:20 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id b59-20020a0295c1000000b00418507eef02sm2392694jai.31.2023.05.23.07.12.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:12:19 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33828a86ee2so175235ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:12:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:b2f:b0:32b:7232:dac6 with SMTP id
 e15-20020a056e020b2f00b0032b7232dac6mr290460ilu.18.1684851139139; Tue, 23 May
 2023 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230523122324.1668396-1-trix@redhat.com>
In-Reply-To: <20230523122324.1668396-1-trix@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 May 2023 07:12:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5HrBFakvoX-cQ5G=4xV1upkFPZ6aSR8me+d+aCpirgg@mail.gmail.com>
Message-ID: <CAD=FV=W5HrBFakvoX-cQ5G=4xV1upkFPZ6aSR8me+d+aCpirgg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: set variables watchdog_soft,hardlockup_user_enabled
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 23, 2023 at 5:23=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports
> kernel/watchdog.c:40:19: warning: symbol
>   'watchdog_hardlockup_user_enabled' was not declared. Should it be stati=
c?
> kernel/watchdog.c:41:19: warning: symbol
>   'watchdog_softlockup_user_enabled' was not declared. Should it be stati=
c?
>
> These variabled are only used in their defining file, so it should be sta=
tic.

s/variabled/variables

>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/watchdog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

While your fix is valid (thanks!), it's only half the fix.

I wondered why smatch would have suddenly noticed this since the
change that touched this variable recently was only a rename. When I
dug deeper, I realized that the old names actually _were_ referenced
outside this file and my rename missed them. The reason I missed them
is that the only reference is an "extern" reference in
`include/linux/nmi.h`. The references in `include/linux/nmi.h`
probably should have been removed in commit dd0693fdf054 ("watchdog:
move watchdog sysctl interface to watchdog.c")

...so a more complete fix would also remove references to the old
names (nmi_watchdog_user_enabled and soft_watchdog_user_enabled) in
`include/linux/nmi.h`.

-Doug

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA17061B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjEQHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEQHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:49:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898A4EF5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:49:40 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB4C83F4D8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684309778;
        bh=am/lQy0gekRHp1bKvU7D62NT+HZ4SISHKlUFomkzByY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=d6ArQtNGPFaws6l+mHV9b953tU5tusPzlwTdPa8r2THDUKe84glEDS+844drWKpnb
         5mChVH7Ur8RL/IzaOE9NZTXmTxjpWrQefEfZNsaC1M+9dH78MME0gLaF5JyFOyboU2
         AurBazLuydvbC03G3D5Wd0IM/TSvmM/wuNh8e1VEjgs6c7kwqgf67xgdBC1g2sWymD
         aNTJwSuIr+9vujSzGgWCuHDa9rpgAMYPoe/LEG+gP63Kx+buPFLV7wO5OhQ0pAw5oR
         OrSZ5GTRqBGQZnAkjXSW9sK6aHIzbE0yo1b14mTh6VsLIht7521TeR0QUBKPIA5ZJr
         6cKmSD0rJy9Uw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-644c382a49aso301571b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309777; x=1686901777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am/lQy0gekRHp1bKvU7D62NT+HZ4SISHKlUFomkzByY=;
        b=AaRaZKCZV5GiyjYVeOj5M2a/u4GND3sUv55IEp7nKBS/nQsCzoTCd0phmTFrlt3kxJ
         LvNMqAyxUl2Mgu3ACnuZlX8Up4qqVBf6yyFHa/vUXqxYpiE3dvqOKjLtX0N7qsXOWiCU
         p1C2RHqDUqfUvBViS6ekopSAGb3vqMuejvkVF8tzLyBD0Jtu9NdHjbzJjGeZfCOtypsm
         w1EUW/pwJx8MhfsOR13dkIMJMrR1UnTLk5t1SNJ7NOnOfZywDW1Ly1Bqwk4K2cHf4v0z
         LIxdUw8T2C7sj7/xynGqMzmOXfJqGYOYFAHdlWEYZVN78i03H7nIzXpYt1lJluM7SOEe
         DXpw==
X-Gm-Message-State: AC+VfDwoFmJue+whhwL2J9nBjTY1nb5KPMQs/AttANv7XC/lWqbjfngv
        AYplyA8v/a9pXaZpTIKc/PRrge8slpNYSLrWlVxgGJblx8xCmXLf72lw8u5ADw5ZKVIQku/T1ME
        8+UqKDxATM6ju7ZAK9n35jTCRslcmorhh3K3ImwSiGMDHlyRsp9U2bqm4hI/anq2tK5tK
X-Received: by 2002:a05:6a00:2408:b0:643:aa2:4dd9 with SMTP id z8-20020a056a00240800b006430aa24dd9mr49908576pfh.7.1684309777267;
        Wed, 17 May 2023 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VvAJDWc7mpXAm9F4cxKWCYX288vkxp71onlGSpaChEKBiCed2TETAdWOjbBwVhXLzWgYKJ/0NljXX+RUgGnM=
X-Received: by 2002:a05:6a00:2408:b0:643:aa2:4dd9 with SMTP id
 z8-20020a056a00240800b006430aa24dd9mr49908562pfh.7.1684309776997; Wed, 17 May
 2023 00:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 May 2023 15:49:25 +0800
Message-ID: <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
Subject: Re: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is absent
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 1:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> >> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962,
> > > BIOS U61 Ver. 01.01.15 04/19/2023
>
>
> >> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, th=
erefore
>
> > Looked like a buggy BIOS/hw that didn't set the mtr register.
> >
> > 1. Did you print the mtr register whose value was 0xffffffff?
> > 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabled=
?
> > 3. What was the CPU? Please take the output of "lscpu".
> > 4. Did you verify your patch that the issue was fixed on your systems?
>
> I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff ret=
urn is
> the standard PCI response for reading a non-existent register. But that d=
oesn't
> quite make sense with having a "dimm present" bit in the MTR register. If
> the register only exists if the DIMM is present, then there is no need fo=
r
> a "dimm present" bit.

I wonder if the "non-existent register" read is intended?

>
> Some "lspci" output may also be useful.

lspci can be found in [1]:

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453

Kai-Heng

>
> -Tony

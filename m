Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549E6F1C81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbjD1QUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbjD1QUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:20:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E535BD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:20:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-95316faa3a8so1933999366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682698828; x=1685290828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r3+Q951qW+5Zp+jfP21B0X2Vqy1oBdvEig1isGyoXM=;
        b=C/i2OXqS7mrVG5jjrivJ7jKDESNoQhx3ATj/2LlpzMPMKjt9oU+GZKFyveYbBrdpRo
         ibSc/Yol1tY+qepjR6IhE7J2rADZ0qlKCoIOskmKJuwT8BhjSPptzcGAOgoc1utmBEg1
         lqnR+6HpHz1kMQ/rzPXv28KStrmAMVtlNKy18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698828; x=1685290828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r3+Q951qW+5Zp+jfP21B0X2Vqy1oBdvEig1isGyoXM=;
        b=PTL2TmHWW8Cd5IV3y4MSA4XevupMil8DWy4iqumITH2MTL2y3Ll+F4Lx387pacxnH0
         q2fwdBZ9Iz7LsMvI6+EMgUfq7v1XMplYystHrWHRxwmgDRooPnNBM0RITigvjLkzM5Kl
         vBdahCV6zM+Kc1WxQ1SXFD+zKkj5Wu8h22ounDJcVLDKV5Wm40jhSmovZNAQkRQCicoR
         zT77ZSE//80VuqEHMK+IcUYd46v4dv4Kh7rVwSijw2hYEK3kcmsCD2OsPZ99JHhNX6CC
         Yi2UioTkWeX6At2Ev3mBrval066zCsCaIxjML4EdoDHlxGX6gY4DEzT6A5TR0SCa7Sz/
         3Gtg==
X-Gm-Message-State: AC+VfDy/ZQ/HGxrfgRLkbHwUmlz2CBMQMsPKYEvXkcAT0lN1TlWW1Us4
        X9jxR6sneTgYElbgXFon2V1TOBsPY8UcrGiLZxiJ2A==
X-Google-Smtp-Source: ACHHUZ7TjHWCpdgVYzTpMMzBXl8pDkPREhj24llvBummT4LSHSmSTwOYbihB+3hY9hK8fFRUHpqvvw==
X-Received: by 2002:a17:907:d8a:b0:95f:2065:83c0 with SMTP id go10-20020a1709070d8a00b0095f206583c0mr6264513ejc.62.1682698828344;
        Fri, 28 Apr 2023 09:20:28 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id t39-20020a170906c3a700b009353066595csm11457585ejz.136.2023.04.28.09.20.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 09:20:27 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso17874329a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:20:26 -0700 (PDT)
X-Received: by 2002:aa7:d941:0:b0:504:8c15:a132 with SMTP id
 l1-20020aa7d941000000b005048c15a132mr4371919eds.7.1682698826625; Fri, 28 Apr
 2023 09:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
 <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
 <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
 <CAHk-=wg0SyFDp_sdcEH-D+LNxuzL_dWA1vZEowUN16n_+yRHPQ@mail.gmail.com>
 <CAJuCfpHouhrEtomhPe2sf+p0oG4pGFKb3xidhOXP6BN-PydY-Q@mail.gmail.com> <CAJuCfpGcnJiJyU78v1r548W3bZ2LyfaYpr5huKKG8-WaiRHFHA@mail.gmail.com>
In-Reply-To: <CAJuCfpGcnJiJyU78v1r548W3bZ2LyfaYpr5huKKG8-WaiRHFHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 09:20:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjj7tM9ER57Ed3LAOaxMLM3t5nkA=dYSyN-nKPFbOmAZw@mail.gmail.com>
Message-ID: <CAHk-=wjj7tM9ER57Ed3LAOaxMLM3t5nkA=dYSyN-nKPFbOmAZw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Fri, Apr 28, 2023 at 9:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Should I send a replacement patch for "mm: introduce per-VMA lock
> statistics" or a followup patch fixing it?

I've merged the MM pull request, so it's all in the kernel now, but
I'd like to see a follow-up patch with more of a help text and that
'default n'.

                  Linus

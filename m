Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3674429F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjF3TOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3TOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:14:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3B3C38
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:14:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992ca792065so177044166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688152459; x=1690744459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFSZt7xSvjgnwowljwfaSL0KYBrFwIuNSlq3FmFfoLk=;
        b=L1lUeXrgKTQWTiHX++f/o0dPzCF+QreuDM+I/RZo99sUZ95IJTAYUk5gUC7Krs37f7
         RH50oaRldEJ8bd5UW7KySkT1XeRwF0mPSLP6QX1n/L0YRt3WYK//4gEBncxMZG5sfec+
         g1gXtnMzJQ+vAE1oUGrZNPhcM4snJ8wX1T6jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152459; x=1690744459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFSZt7xSvjgnwowljwfaSL0KYBrFwIuNSlq3FmFfoLk=;
        b=Z6144dGE43U07sAuCrFF38q2IdTcw3fFW7uaeTuE3tDr7DwX0n664AP2nwPt2XAnoO
         Ret7OXHVJDsDUjy9aBD2WikRb0OFVmoHxe4QeuiOukqEx3m1TD7PNtV10X6utweT8ZsU
         LPMYCsJbM/GOtAF/O+3rNlXbRLQtfXFr/xtwHG6EHYqx7Sd1wR+QTlOqsNtg8E8lOEuY
         shu78E3Ld2eJ/S0fddhrQjNzxW0euuFnKSK17Mi2jfA5afPfVyMlhsx2c1lxeETLZPG/
         zM3PeCSaltQaip6M+9Zy7IkPUdyirV8mgJzcrcvG0UczT3g56eCfW9CgnKXro248eI5X
         CevA==
X-Gm-Message-State: ABy/qLaJcI/K5lMHMrgAb4Tz5vyWuaE5kWZnBJQ3X9uD+tP/eDmAgxp+
        KnDZivxJFdtwk6Wm3eh5aEUUcwzfMxOLJB+DvIYRNwDT
X-Google-Smtp-Source: APBJJlF6uDGc1WGRAsn+ZoXdf+weNLqlAHAcw4NeCn/bB1LetdB2dDY6ilvCaeFlXFAteSPUhX8Zug==
X-Received: by 2002:a17:906:aad4:b0:982:9dc1:a434 with SMTP id kt20-20020a170906aad400b009829dc1a434mr2650923ejb.19.1688152459098;
        Fri, 30 Jun 2023 12:14:19 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id jo19-20020a170906f6d300b00992d70f8078sm1278487ejb.106.2023.06.30.12.14.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 12:14:18 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so2455802a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:14:18 -0700 (PDT)
X-Received: by 2002:a05:6402:b16:b0:51d:8100:863c with SMTP id
 bm22-20020a0564020b1600b0051d8100863cmr2317798edb.25.1688152457976; Fri, 30
 Jun 2023 12:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
In-Reply-To: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 12:14:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
Message-ID: <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 05:48, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>    We have a couple of major core changes impacting other
> systems: Command Duration Limits, which spills into block and ATA and
> block level Persistent Reservation Operations, which touches block,
> nvme, target and dm (both of which are added with merge commits
> containing a cover letter explaining what's going on).

Random side note - as an outsider that then sees a trivial conflict
due to the split of the nmve side into a file called 'pr.c', I can
only say that my reaction to that was "what a horrible filename".

Maybe it makes sense to people that are very into nvme, but honestly,
considering it's a new special thing, I kind of doubt it.

We really don't lack the disk-space to use more descriptive names for
files. "pr.c" really is pretty horrid.

It's not like that file even had a comment at the top about what it was.

And yes, while I was looking around, I realized that we've had that
<linux/pr.h> header file forever. So this inscrutable naming isn't
new.

We have a few other horrors here. Quickly, without looking at them,
what is 'rv.h' of 'nd.h'?

But three old wrongs don't make a right.

              Linus

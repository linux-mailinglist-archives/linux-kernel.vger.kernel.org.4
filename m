Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29E6F20B2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbjD1WHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1WHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:07:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBA422E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:07:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f0dd117dcso44161966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682719669; x=1685311669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRoBBar8E2JJYtfPk9TIhfuEqjogVCwVQEdTJpuJHEA=;
        b=SZXqnYZ0hMhjj4JmFsIOfK1s4bRP/JhyNGzzN4kUgBX14TYqUHwAqpI/N/XVETNZpx
         0Md5uNyy9EOa/fRBRjdQj73kRm1abAYkeaXe49BWXy3/cyrCSAFiFi5+QUzPvaCwhVz0
         3d0L3M2wAW26qUXJLmonwYicNDlJRyDXIwFKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719669; x=1685311669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRoBBar8E2JJYtfPk9TIhfuEqjogVCwVQEdTJpuJHEA=;
        b=WPCcPERykOBV6znUJiYsXfyiQILIUXA8KUjnE2Dyn0pSNMfFuw4Be/SShwWh2K58Ve
         vZgOVoUWRvKEb02nwOyS7lwTM1ciu/d+0i+uvFCgSzeu6lYXfrZj/NdkmFkAQ0v0cyBu
         9AkhifH0UmI5npVZwgS33g+64160ALH4kOyabDEFyFvJ4Bo49KenAPviR9zEnp2BPQCM
         xkXA9MJpqzyoTlLBLRfKWtlLbdsAlZipGbx7kjlJTrqPdSpVDuH3yovaoXlxejF4CIim
         m0gyUOVhSPJY++aExqWlXahJ0cKNNPpZEt+SLWEFsXUHaGs6ETsunOmY8IoRj6NEKlKn
         C0aQ==
X-Gm-Message-State: AC+VfDyk17II73zdWbUVvLSDCcXWNZ+wu0cAzdgoi71OruswXM7jKMZa
        3zWtGHRUx46QLaNKpfsRl3EOxJqBRoZSiqElDzd2tg==
X-Google-Smtp-Source: ACHHUZ4XIxyi1WefFelFX059Tq/w5VZmjD68IRX9NTqgKdviVGsLzC7tucdQm6qI0DK5AuIKSBoxuQ==
X-Received: by 2002:a17:907:94c2:b0:94e:dd30:54b5 with SMTP id dn2-20020a17090794c200b0094edd3054b5mr7684535ejc.6.1682719669029;
        Fri, 28 Apr 2023 15:07:49 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id my24-20020a1709065a5800b0094a8115e148sm11783237ejc.87.2023.04.28.15.07.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:07:47 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50674656309so344113a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:07:47 -0700 (PDT)
X-Received: by 2002:aa7:cd13:0:b0:508:39e3:58b with SMTP id
 b19-20020aa7cd13000000b0050839e3058bmr255067edw.35.1682719666969; Fri, 28 Apr
 2023 15:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZErkdNBn7OLkQZWC@gmail.com>
In-Reply-To: <ZErkdNBn7OLkQZWC@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 15:07:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfTLDYqHtTi3Z62FRuAJw09aOuFOup5LPxmYeXTAf6Rg@mail.gmail.com>
Message-ID: <CAHk-=whfTLDYqHtTi3Z62FRuAJw09aOuFOup5LPxmYeXTAf6Rg@mail.gmail.com>
Subject: Re: [GIT PULL] SMP cross-call changes for v6.4
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Thu, Apr 27, 2023 at 2:09=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
> SMP cross-CPU function-call updates for v6.4:
>
>  - Remove diagnostics and adjust config for CSD lock diagnostics

Thank you.

It's rare that this kind of "old debugging that isn't really relevant
any more" gets removed.

It's good that it happens.

               Linus

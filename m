Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD46BA4C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCOBfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCOBft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:35:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F52068D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:35:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so40147811edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678844125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35vGKLGR1JUXAuQzC+rBQHV5IucojsXPTjHtSL0PFvw=;
        b=BIL1vWwoip52yMRwSgpqE269G/l0XvwPO+YsDDxdwisNVrvnl3gGT9gyYiGT+Ky4lN
         ekKjzSq8gruIL2FkLPh3Ahs0hezSkPnmqsSnDLOImRFbUjxYqoILqcxF0fXKWzf1ubUu
         t/T0GMcMe3LDJKYbjjl6I1Yxjg+6JV4ImE7sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678844125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35vGKLGR1JUXAuQzC+rBQHV5IucojsXPTjHtSL0PFvw=;
        b=A6rnkGtvPdVSHxv7TW448areP/X7tnLER2kJBmrFfhoHFp4jNr2wZPVSlc5+/fFy0Z
         0/qZMmwv854d5nV9jw2rCvW5OY3Xs4i/g7U2NbjG+rJV+RmDQau13/duRuD/CI0DDobn
         EWAMQzp40H4uod2Wf9fgyAEn6zuC/Kdk101kPJdpzzc9+06eFp4owB2ep56Y4GgxZfEW
         xkGpe7aECj/0NseaaxjhTkPeUy/WWSnYV/04L7zRi+azokPIgW+eEcg6poQU8tdpfw8o
         yoP+eYV9zVcLICX3eQ7BPLRMARU751fq2OXYdumi3zyZdqYZPu8GP0XfGPCZbuAza94t
         kWKw==
X-Gm-Message-State: AO0yUKUP1dJEr65w+WtFTfzPXf6gwJbA+maOitNtzGejGrTgA3FeAe5d
        IGwVYtgfUtOP4+sgrHM15V9hyLomiK1zXcvSk+ATng==
X-Google-Smtp-Source: AK7set8/IhGc02V5VkXgICia3FhFGuevDH7M/LxEs9rUCMPew34UZ4RXbIWoMAAejLDp16VC+W/DGQ==
X-Received: by 2002:a17:906:4c86:b0:922:1826:8275 with SMTP id q6-20020a1709064c8600b0092218268275mr4096577eju.11.1678844124684;
        Tue, 14 Mar 2023 18:35:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id td10-20020a1709078c8a00b009256a5c3b2dsm1821505ejc.90.2023.03.14.18.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 18:35:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id x13so22264817edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:35:23 -0700 (PDT)
X-Received: by 2002:a50:d08e:0:b0:4fe:9251:d4fc with SMTP id
 v14-20020a50d08e000000b004fe9251d4fcmr495732edd.4.1678844123223; Tue, 14 Mar
 2023 18:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <7d026744-6bd6-6827-0471-b5e8eae0be3f@arm.com> <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
In-Reply-To: <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 18:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWPcj4QUTqORbT4X2fS+ZD4s5-38t+3=eyxMA_atXv+w@mail.gmail.com>
Message-ID: <CAHk-=whWPcj4QUTqORbT4X2fS+ZD4s5-38t+3=eyxMA_atXv+w@mail.gmail.com>
Subject: Re: [BUG] v6.3-rc2 regresses sched_getaffinity() for arm64
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 5:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The immediate fix for your issue is likely the attached patch, but I'm
> not particularly happy with it. I'd need to at the very least also fix
> the same issue in the compat code, but there might be other cases of
> this too, where people use the "allocation size" as the "valid bits
> size".

It does look like all other users of cpumask_size() get it right and
treat it as an allocation size (and will explicitly clear the cpumask
if they then also use the size-in-bytes later for other things)

So this does look  like purely a sched_getaffinity() thing (including
the compat handling for same).

And I can see why sched_getaffinity() uses cpumask_size(): we have no
other good helper for this.

It looks like we have never actually done a "what is the size of a
bitmap of X bits" helper function. We have that

        unsigned int len =3D BITS_TO_LONGS(nbits) * sizeof(unsigned long);

expanded many times by hand, but there is no simple helper for that
rather common expression.

We've got a few places that clearly got tired of not having said
helper, so drivers/md/dm-clone-metadata.c has that "bitmap_size()" as
an inline function, and lib/math/prime_numbers.c has it as a macro.

So I guess I can't blame the getaffinity() code for then using the
allocation size helper, since it was there and it worked until it
didn't. The setaffinity() code actually gets it right, and uses it
basically as a "this is the allocation size" thing, and then fills it
up correctly.

And the reason this hits mainly on arm64 is presumably that on x86-64,
people either use MAXSMP (ugh) or have smaller cpu masks, and you
really need to hit that "64 < NR_CPU <=3D 256" case to get the
problematic situation.

            Linus

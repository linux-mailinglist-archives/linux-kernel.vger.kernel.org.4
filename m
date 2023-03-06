Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCE6ACA68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCFRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCFRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:30:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B96700F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:29:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so41883048edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678123771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyTtB/4llIx7xJW4yBF6B/aJvNGYAxGhl43lVEfQF64=;
        b=FQsHP01JWW59RwAk38+Q/kxXTDHxilylSztx59oelvW6wAt5oVrlY5/SQnx7fQocXB
         CP8GDvujVsLUxEqmCJlRIrgc08LVXYP//hgawsxldM/X8Q+lGRcdMB+l4p9Z91BxxN86
         aOqcDoHeseNaW1vdtqMXYz1g6d+5R4vj32iXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyTtB/4llIx7xJW4yBF6B/aJvNGYAxGhl43lVEfQF64=;
        b=u5y9SkYP6wBJfvvMlRAnGU8Mr5DuqlBmbg5lMPLVzlFjmaHEZg0Z+cMHWZHPgH4DGi
         ZXlSug11hzJPxuVgDvUVqGKCr5eFGRZ4jYqAF+absByyOD8O1+Ssan/oS/fL2A24Rkpi
         3e+BPm/+UpSBYuw+BgO0i0+DuzRjMeslSpHhlE6SAf/D30WJUAIMukw9JVjbXUg/Pk40
         8yhXqki7aiFHk/ESzGNFYOFynoCVv6O5QJON4/HUiW9A4aPKORCRG48zr69ksnBa1B9Q
         54IlzQyYKhkEZvS3XA15NOJ1JcVJT1BH4nAUDE5Ex9qXHTc5OwMLKoWKDQ2QAeAMvMFf
         TW/g==
X-Gm-Message-State: AO0yUKXmJy59R7dNHo47ZVjqw01NIM1m7cOLNPZVw+xcPTNUf1BL7m6x
        17MMnXCQa5+hSFGVbZ/HzpJOq4RrrIJrj/1dwTirQw==
X-Google-Smtp-Source: AK7set+bGLR29eK5UhoZFXlKl6yQPJCjCzZVIbkP9C8X6Vwsh4TTQhqSoClstjHYoNjHS0wJCjY10A==
X-Received: by 2002:a05:6402:350:b0:4c0:eab4:af12 with SMTP id r16-20020a056402035000b004c0eab4af12mr10197979edw.12.1678123771284;
        Mon, 06 Mar 2023 09:29:31 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b009140707b475sm598429eji.33.2023.03.06.09.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:29:29 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id u9so41954201edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:29:28 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr5644673eju.0.1678123768103; Mon, 06 Mar
 2023 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-6-vernon2gm@gmail.com>
In-Reply-To: <20230306160651.2016767-6-vernon2gm@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 09:29:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
Message-ID: <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpumask: fix comment of cpumask_xxx
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     tytso@mit.edu, Jason@zx2c4.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, linux-kernel@vger.kernel.org,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 8:07=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com> wr=
ote:
>
> After commit 596ff4a09b89 ("cpumask: re-introduce constant-sized cpumask
> optimizations"), the cpumask size is divided into three different case,
> so fix comment of cpumask_xxx correctly.

No no.

Those three cases are meant to be entirely internal optimizations.
They are literally just "preferred sizes".

The correct thing to do is always that

   * Returns >=3D nr_cpu_ids if no cpus set.

because nr_cpu_ids is always the *smallest* of the access sizes.

That's exactly why it's a ">=3D". The CPU mask stuff has always
historically potentially used a different size than the actual
nr_cpu_ids, in that it could do word-sized scans even when the machine
might only have a smaller set of CPUs.

So the whole "small" vs "large" should be seen entirely internal to
cpumask.h. We should not expose it outside (sadly, that already
happened with "nr_cpumask_size", which also was that kind of thing.

So no, this patch is wrong. If anything, the comments should be strengthene=
d.

Of course, right now Guenter seems to be reporting a problem with that
optimization, so unless I figure out what is going on I'll just need
to revert it anyway.

                Linus

                Linus

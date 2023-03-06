Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70D96ACB3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCFRtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCFRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:48:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF18460A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:48:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so42023620edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678124873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHxMDJkAMxG+U7tsJ3okEl2/ScLLX/X7tonuUjq/u1I=;
        b=eTcMaQ8zfbRnsRGq30+UL/2Psfxl7DzTBEZoMDLtrCpeecfdi9O0v5NnHVZIpHQpuI
         sT3TApuodI8Po/PZ0EZ34Bzz+vtlxv2oXuL9sQisL8+jyNSSDzJpAJQ3Q1LHO9vuErmh
         usOxrZ2/EkcZSpM2MftITOOCUhhvHvOTsJYWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHxMDJkAMxG+U7tsJ3okEl2/ScLLX/X7tonuUjq/u1I=;
        b=z16bNu3SvL/5l2s52SnQKaVYDp7fAgNptHD9rzGJuZIh0+bo0LmiJBupm/bC+dXAv0
         Qo3lp7Cels9zB501NlUJ3fAvsiSUkr+Bx5bSTdvKyOgFFrJjSHfV1zCHhsWzVHT8b6iP
         fkwbuJCQuLA1y9RSpAEmOG3tdxENigVN4cJQCl/chYKjXxgdjg0kZd/c8t87bOmkmBtK
         36p2brlaBY/5xx8co2mRLPeK+0ZtA1e2t+y9cz73VmQSAPrk/GuJCri08pHQZKa7T1lH
         QC/rN2IkiZo6BB4arnU5mue+Iz1bimlnf0JVkuIdSE1fqqLFMy7PnO9lz6HP7MstmVOW
         AQ5w==
X-Gm-Message-State: AO0yUKXf4sQracMkCEcK8ra0UVZ1Wa1Jgs+6eiEsiVw6K/8X/3a8/Thv
        Ds+M4vM2TUMmKgY47N/KNhOYI7RmK3zMBUOImspt7w==
X-Google-Smtp-Source: AK7set+3yBlR6YGgSm/e9Zu1R6HwACEQfazXwPfkbDhdmVrbNRMGqDe5hQaSoKhtBnQejZMHqBfG5Q==
X-Received: by 2002:a17:907:8a06:b0:889:ed81:dff7 with SMTP id sc6-20020a1709078a0600b00889ed81dff7mr14803842ejc.9.1678124873135;
        Mon, 06 Mar 2023 09:47:53 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id oy10-20020a170907104a00b008f398f25beesm4825442ejb.189.2023.03.06.09.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:47:52 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id s11so42059875edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:47:51 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr5674931eju.0.1678124871381; Mon, 06 Mar
 2023 09:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-6-vernon2gm@gmail.com>
 <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
In-Reply-To: <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 09:47:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com>
Message-ID: <CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com>
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

On Mon, Mar 6, 2023 at 9:29=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The correct thing to do is always that
>
>    * Returns >=3D nr_cpu_ids if no cpus set.
>
> because nr_cpu_ids is always the *smallest* of the access sizes.
>
> Of course, right now Guenter seems to be reporting a problem with that
> optimization, so unless I figure out what is going on I'll just need
> to revert it anyway.

Ahh. And the reason is exactly that people do *not* follow that
"Returns >=3D nr_cpu_ids" rule.

The drivers/char/random.c code is very wrong, and does

             if (cpu =3D=3D nr_cpumask_bits)
                             cpu =3D cpumask_first(&timer_cpus);

which fails miserably exactly because it doesn't use ">=3D".

Oh well.

I'll have to look for more of this pattern, but basically all those
"xyz_cpumask_bits" things were supposed to always be just internal to
that header file implementation, which is *exactly* why you have to
check the result for ">=3D nr_cpu_ids".

       Linus

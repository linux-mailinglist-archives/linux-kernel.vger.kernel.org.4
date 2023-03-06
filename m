Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2926ACCD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCFSl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCFSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:41:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275CF6504B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:41:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s22so14029562lfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678128084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUkuyszYTAoQtNUlKsSSIkY0E3vOhynrc0QM2L0Yxu4=;
        b=etCiBEfgZawGnjosYu5u5CYWqtti69fHM//a3X0xbTO+QLfgNqYH+ZHBpa0iO+XnKI
         pbPt/mYYAoMgNIQsXeXN1sqjw0bfJ3wQ+3K03ywP+MC0e0ujSKrKbdSEVDrFqHFT74UT
         os2O2j1yhV5p0nLmz465ZCkeEdVwp36HMREHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUkuyszYTAoQtNUlKsSSIkY0E3vOhynrc0QM2L0Yxu4=;
        b=plzny+R2pPmrBQWfiYWKI1liRC30e4LhIyDUPgyQ+XlFibQfITFCcSpq5mk3wQJ83H
         d3H/aJeGuvlII76J3ATUpqhuJAwEorbIWDuiF2HgHfDT1R7L2FfV0I2lVtQjatVMJV2j
         9Oyf4/eUJ1Hk08Ze7QbO9qVPW/mqslMGkoL/dQ0zzg1AggQzeDrA9q4cbLTyA2WLqYJ2
         RD68Tku9Cjmd1Of+yAtZZGBhWE8F489l3Xt38EPPos6WECNBQIemVzyJW1j4PNZ6TQ3q
         JZ69uWitEa3kOI3wY5GlZSemyM2xsGTGKD3PS6/LDVD+ikJZPoCXsBztFKeFn4QD3W0T
         BCHA==
X-Gm-Message-State: AO0yUKU14WzkUKNev9Td6hi20qvLZfn/gT5AjxLiHsWo/XnRPlq1zFNE
        noepga0TmzFY17MZjathEOK818/tG3/kYQ7P53Q/nw==
X-Google-Smtp-Source: AK7set9E+9jJTEQ19jr1WQ0nBKW4vC3m9lUBRXMZjG+k4k5oWZeaBC6qREdHbF9I8hvvlehsHanXQQ==
X-Received: by 2002:ac2:53a5:0:b0:4cb:4371:f14d with SMTP id j5-20020ac253a5000000b004cb4371f14dmr3345709lfh.17.1678128084016;
        Mon, 06 Mar 2023 10:41:24 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b004db3bee9a32sm1738022lft.283.2023.03.06.10.41.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:41:23 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id h9so10717742ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:41:23 -0800 (PST)
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr6329093edb.5.1678127659323; Mon, 06 Mar
 2023 10:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-6-vernon2gm@gmail.com>
 <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com> <ZAYtRcbMeRUQFUw/@vernon-pc>
In-Reply-To: <ZAYtRcbMeRUQFUw/@vernon-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 10:34:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA2kEBk3ibg3mrxpuXOAJKdM_MC4MQ8gLmxerZ5URfvg@mail.gmail.com>
Message-ID: <CAHk-=whA2kEBk3ibg3mrxpuXOAJKdM_MC4MQ8gLmxerZ5URfvg@mail.gmail.com>
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

On Mon, Mar 6, 2023 at 10:13=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com> w=
rote:
>
> I also just see nr_cpumask_size exposed to outside, so...

Yeah, it's not great.

nr_cpumask_bits came out of the exact same "this is an internal value
that we use for optimized cpumask accesses", and existed exactly
because it *might* be the same as 'nr_cpu_ids', but it might also be a
simpler "small constant that is big enough" case.

It just depended on the exact kernel config which one was used.

But clearly that internal value then spread outside, and that then
caused problems when the internal implementation changed.

            Linus

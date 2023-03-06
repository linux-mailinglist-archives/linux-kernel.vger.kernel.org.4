Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA86ACCF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCFSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCFSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:48:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473452D141
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:48:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so23256529edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678128502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+AuRXdo16JeR9PnbP32vE+RmxUJH9KHyOeCFYJO9N8=;
        b=cfLBMhsxEmyjxzpNdu5x3WI0oXcOEnEr8VoAG5m38Cw4/kQTo9PWxpACKwcyjytSKD
         ydU9ygHtlfqv6Q6/ugWeApD883giDkCXBpD8NOvECUqwxj4akokkyUxVfHre/EMVa2oa
         4SHO37wicSka3vGgpwhCmiBzDQRvxlNbPRHeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+AuRXdo16JeR9PnbP32vE+RmxUJH9KHyOeCFYJO9N8=;
        b=DsNJF6AJ05Omc5gmkam9PPNQWo6JJBiOHJevZ6YyNTXRcivtpHH09EqY3lq4eIus7M
         Xz7t6Qcr+7BE/JFm1wQ5pDoauQYMi9wi2c8FTvNsKy2ZRKeac0S9N6G3aP3ge5Tai2xu
         7MzzmORDc2WiOAQTK9JllAqoAtmPlAqH9Y24+Nqte7cG4SMVqk1iFVe/LUQQb/H6BezL
         jNuLiMkqJ6g9zxXuK/7O+9P/9OqtOrIJ5t1PjU+EZRlDOgEnlovjgyk4VMJ958NeiFe0
         86+EzeayLOFzvg89djkX8U7O6oAHssmv+kwj+EjSl6ONDlFf2mqjNr8drSnAzhUDnLml
         /Mcw==
X-Gm-Message-State: AO0yUKVwQqx05elEV6zgxrn/W8z16bjZYMem6CqfICdEh1X8ac+iWlw9
        HHrSxt7OhucOLjG1hs7rN77T79sN4azDXAO13RB4Dg==
X-Google-Smtp-Source: AK7set/MBwseqtiWjI0jz+uA10o+I7aKcjp7Csll8aS9DFv6+5I887OoF3U7Y6QQs7agIWwm+uPeeQ==
X-Received: by 2002:a17:906:9382:b0:8e5:40d0:f831 with SMTP id l2-20020a170906938200b008e540d0f831mr11413878ejx.43.1678128502166;
        Mon, 06 Mar 2023 10:48:22 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b008e09deb6610sm4878200ejb.200.2023.03.06.10.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:48:21 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id k10so18876767edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:48:21 -0800 (PST)
X-Received: by 2002:a50:cd15:0:b0:4c1:1555:152f with SMTP id
 z21-20020a50cd15000000b004c11555152fmr6419391edi.5.1678128500729; Mon, 06 Mar
 2023 10:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-4-vernon2gm@gmail.com>
In-Reply-To: <20230306160651.2016767-4-vernon2gm@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 10:48:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj73=Os1p=W7D2va=Rd81ZKvjb35yWgXQNgn1hXNRpAbw@mail.gmail.com>
Message-ID: <CAHk-=wj73=Os1p=W7D2va=Rd81ZKvjb35yWgXQNgn1hXNRpAbw@mail.gmail.com>
Subject: Re: [PATCH 3/5] scsi: lpfc: fix lpfc_cpu_affinity_check() if no
 further cpus set
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
> -                               if (new_cpu =3D=3D nr_cpumask_bits)
> +                               if (new_cpu >=3D nr_cpumask_bits)

This all should use "nr_cpu_ids", not "nr_cpumask_bits".

But I really suspect that it should all be rewritten to not do that
thing over and over, but just use a helper function for it.

  int lpfc_next_present_cpu(int n, int alternate)
  {
        n =3D cpumask_next(n, cpu_present_mask);
        if (n >=3D nr_cpu_ids)
                n =3D alternate;
        return n;
  }

and then you could just use

        start_cpu =3D lpfc_next_present_cpu(new_cpu, first_cpu);

or similar.

              Linus

PS. We "kind of" already have a helper function for this:
cpumask_next_wrap(). But it's really meant for a different pattern
entirely, so let's not confuse things.

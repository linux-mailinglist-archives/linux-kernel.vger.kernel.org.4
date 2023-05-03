Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F86F5D58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjECRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:54:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78231708
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:54:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1053150566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683136497; x=1685728497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af2o5qnqMCwqTalPYr17vqDObiqD6tO8pD94nAo//yg=;
        b=O1qtBSRcPr7GjPKh+6lXdoKCRoYckSAQdUPlgyIUv/5EggO9NJILtbP2/bTuw7ickN
         Hzrg/Up3Xm3aoxA4MIcO+k+5HjtvcbvY2k/315hsxTdz6SpazkpBySaAwf4N9j3SS+K4
         D6yXAsWcHUP9UrdDzAwTXUGkzg2MYTOjEUEzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136497; x=1685728497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af2o5qnqMCwqTalPYr17vqDObiqD6tO8pD94nAo//yg=;
        b=Gxu6gNy9zvHncmBlXAqFVCEsbiru0xI9Nckn7GFnlPvJ9nCpO510M0m9Nl6sQPxzt+
         XTAZRqD0acWrF8N/508++UzCbzoyza8IeEVcgkdjr8lnjBxVKycs5r3Z5SkTTxbJu40e
         RE9e45eOG1UbWTatORpzsJC6FQ53XaoYkob9E5kFMkX5GhNolNJV3oK2R5HN+smyht0q
         1DAiIFVp8S4USm8NAiDOmdkTGnLKzw6nPLn5Cmjg6Bq/A+aG7wnUS98X5AhxLfCXFhhx
         EdRIfIiMYZNG5eEL4tyRwhSkMVE8eM/wMt6i9dz6YqMDlAVEss67LJLsSSsILnQp62Rz
         CiZA==
X-Gm-Message-State: AC+VfDwZvcVXlVjtZrI782Ucc0snIqGD82LjJ4yD0i/6EKVo3hAQaU5J
        YVGtxwfOnSRaTqp59TE9+x4PsE5MpYsPQit9NNHLlA==
X-Google-Smtp-Source: ACHHUZ4wH4SAsE5NQRKu2rZR4YC6NRyyvfvHWYa0TvAuxOu6EB4GQSoHYBa88jzue5LyhVALw+GbRg==
X-Received: by 2002:a17:907:3d8d:b0:94a:6b4b:6b52 with SMTP id he13-20020a1709073d8d00b0094a6b4b6b52mr3850422ejc.76.1683136496893;
        Wed, 03 May 2023 10:54:56 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b0094fa472a7c4sm17638142ejg.161.2023.05.03.10.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:54:56 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1053146566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:54:55 -0700 (PDT)
X-Received: by 2002:a17:906:da8a:b0:94f:553:6fd6 with SMTP id
 xh10-20020a170906da8a00b0094f05536fd6mr3895127ejb.24.1683136495726; Wed, 03
 May 2023 10:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
In-Reply-To: <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 10:54:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com>
Message-ID: <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, May 3, 2023 at 9:38=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'm going to just remove the 'sign' games entirely. They are
> completely broken in 'untagged_addr_remote()', they _used_ to be
> completely broken in 'untagged_addr()', and it looks like it's all
> unnecessary.

Ok, I've pushed out my changes to the 'x86-uaccess-cleanup' branch.

I think it's all good, but it would be really nice to hear it's been
tested on a setup that actually has LAM (simulator? or maybe there is
actual hw inside Intel)

And any other commentary is appreciated,

              Linus

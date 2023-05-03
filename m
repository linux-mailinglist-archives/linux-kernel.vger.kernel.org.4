Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9309F6F5F09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjECTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:19:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130B1BE2
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:19:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9505214c47fso1094553266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683141579; x=1685733579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MXPakPAEF8UGjP/T2E8WYioPTfUH/1Mb7t+Ee53GsY=;
        b=drsCn9oRpglhDQCPkXnoVw4BVH92nLDcSPEOU1StIdlmNsEswtafe+TlTF/y2Pt3Jv
         O98UcPPKnpiYR9ws8/RlVJj0LEcLIQh2G5jiwpDm7nu9mTXuc++V+1D4lAeimDjLD51G
         q7UPdlsgCTVaECUAJfSlRxTOv1wL7XTdZhJb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141579; x=1685733579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MXPakPAEF8UGjP/T2E8WYioPTfUH/1Mb7t+Ee53GsY=;
        b=hLAbTaMbSKMN1/KYVnf74K9krBnR1BXEJnd20vbjYK/xHQfMOPDI8NeJehi6qk+5Kr
         ZkZyx3nQeWSZYBiqeNaj7e28oimLlqiC5nz5oPHNMR9S6F73BXc43hHgO4/+zkTrOEgW
         kxa6iO+Q4LlPIHwiV3F9HqWsLfxDAZkxONaJ1xQCJKgSDAz1pOeJjKhYHr2fPjNiKZCw
         2tTEnlFF8uGvK5BNoUm0I9/x0v0LzhkN+eZj++oRmY/1Ff6eGHMA4ukveTO6S3wcdrfV
         x4IHzjqJYsRuO2CpacowSPnfHSOvKIGzLpRWL0kx19TQY5tO3dQzWJp5pGl6yW4rywxQ
         s/Bg==
X-Gm-Message-State: AC+VfDyqlqPAsTtQ9uxM5kTY2OJXbEviHNebekf4KNOmCLkj+J291y7F
        bzi1YaGElz8qbANPZ1QVWjbKUKFwAccxPCkHXe5xdA==
X-Google-Smtp-Source: ACHHUZ66ABRl+AcJy34H/o9uaylch046XDjYUmzhClfv7wzUIuC8G04NKrbzJyCIy7fwHDNuJmbdmQ==
X-Received: by 2002:a17:907:720e:b0:961:be96:b093 with SMTP id dr14-20020a170907720e00b00961be96b093mr4640889ejc.36.1683141579045;
        Wed, 03 May 2023 12:19:39 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o19-20020a1709062e9300b0094f281bd279sm17745696eji.198.2023.05.03.12.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 12:19:38 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso3644891a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:19:38 -0700 (PDT)
X-Received: by 2002:a17:907:8a01:b0:960:ddba:e5bb with SMTP id
 sc1-20020a1709078a0100b00960ddbae5bbmr4715901ejc.43.1683141578005; Wed, 03
 May 2023 12:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com> <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
In-Reply-To: <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 12:19:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwUEXwQqjbEnT2oKB4W7psF5rXuZWe9=y-uTr1vohspA@mail.gmail.com>
Message-ID: <CAHk-=wjwUEXwQqjbEnT2oKB4W7psF5rXuZWe9=y-uTr1vohspA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
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

On Wed, May 3, 2023 at 12:02=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> I suppose that's a very long winded way of saying, that yes, ofcourse 0
> is a positive number :-)

Well, I do consider it as such, but I guess I took all my math classes
when people still considered negative, zero and positive to be three
disjoint sets, and 'non-negative' was required for rigor.

Some googling around says that a lot of people still think that, and
that it might even be language-specific.

I think the commit commentary about "ok, strictly non-negative" might
still be relevant. At least to some people, and at least for
sticklers.

Also, I do consider 0 to be part of =E2=84=95, although I wouldn't consider
that to be an argument about "positive" at all.

The argument for 0 in =E2=84=95 would be that without it, you don't have an
identity element for addition, which would arguably make natural
numbers kind of broken as a set.

            Linus

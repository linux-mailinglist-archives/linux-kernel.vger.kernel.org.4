Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD936D81B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbjDEP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbjDEP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:26:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FF1701
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:26:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fi11so18532602edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680708398; x=1683300398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiNSMmn4P5V1jwJhNPZuiJRsbJQ57AhnJVTBbX8pgZo=;
        b=NSoOjhoaVJ30e5PphrSukeB/G2v7DuMPOO2t5SabWWaGhavl0xfhxz0DYH8NUGuXbq
         iMT3QA4D9glPde1jx+NRYc8+RO/WQk6HfomFOrKRPVeweDhkiix+sLVAHAWS3c75EQud
         OcT5h++l1ropGhkanYmM5XQ20yzWKHMTFH0CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708398; x=1683300398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiNSMmn4P5V1jwJhNPZuiJRsbJQ57AhnJVTBbX8pgZo=;
        b=p38ML2Q+zGvyA+qBWuAL/bNTBwcbZnlV25Di+C+kcjEaehaSwOpuhtvQp0wUglYQTg
         R6xqL0TI2Y0eg08T2mvJ26oAX33i6rdiMKAPknXcT4A7MVxJpHESVB2yvDfga9sroo0t
         HBtdvRIBN/WARgJHgklZsexIRh9KNFttpHzEkAidERkAV6PiX2XReo9Tx61altTj62vV
         ehJlCpV232F7DP+jAnOE/onLS1E1KwKF732awfwtUMLFxWQ2wy8wezr+KiVoHtiq/Hxi
         wFsOaSrxMEmrFcDVLOn4UdLCcL0RvItd4NWxcjCPfuBJ1SB3GGcN8+TCRkLQ3K5YVDwU
         oYDw==
X-Gm-Message-State: AAQBX9fo9uDFDioEziNtkpbMvBM8dKNY8aKgcMPWNmRu7OYwNISaSInW
        gZmyQXqovaTO/ogfJDlBJ1r8xyWBIB28nO7jpZ4oGQ==
X-Google-Smtp-Source: AKy350YYQEHQItFy+7w1Ec8L0bpVhyAcoHK+tYGYtHfjsS3mkr9dBUV+KkVqGekNviLSiY2Jx48jOg==
X-Received: by 2002:a17:906:eb01:b0:947:c201:df9b with SMTP id mb1-20020a170906eb0100b00947c201df9bmr3262797ejb.9.1680708398243;
        Wed, 05 Apr 2023 08:26:38 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id gx20-20020a1709068a5400b00931faf03db0sm7469017ejc.27.2023.04.05.08.26.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:26:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id er13so101030463edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:26:36 -0700 (PDT)
X-Received: by 2002:a17:907:2075:b0:947:72cd:9325 with SMTP id
 qp21-20020a170907207500b0094772cd9325mr1890350ejb.15.1680708395703; Wed, 05
 Apr 2023 08:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022702.753323-1-mcgrof@kernel.org> <20230405022702.753323-6-mcgrof@kernel.org>
In-Reply-To: <20230405022702.753323-6-mcgrof@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Apr 2023 08:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
Message-ID: <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for atomic64_t
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 7:27=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Sometimes you want to add debugfs entries for atomic counters which
> can be pretty large using atomic64_t. Add support for these.

So I realize why you use atomic64, but I really suspect you'd be
better off with just the regular "atomic_long".

This is not some debug stat that we care deeply about on 32-bit, and
"atomic64" is often really really nasty on 32-bit architectures.

For example, on x86, instead of being a single instruction, it ends up
being a cmpxchg loop. In fact, even a single atomic read is a cmpxchg
(admittedly without the need for looping).

And yeah, I realize that we don't have a "atomic_long" debugfs
interface either. But I think we could just use atomic_long for the
module code (avoiding all the horrors of 64-bit atomics on 32-bit
architectures), and then using just 'var->counter' for the value. It's
not like the debugfs stuff actually does any truly atomic updates.

So something like

        debugfs_create_ulong(... &val->counter ..);

instead of

        debugfs_create_atomic64(... &val ..);

Hmm?

I dunno. I just think this is not something that may be worth
introducing a new thing for, when it is *so* painful on 32-bit, and
doesn't seem worth it.

                   Linus

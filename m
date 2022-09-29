Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5320C5EFF50
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiI2VcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI2VcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:32:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAC14B866
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:32:00 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-131c8ccae75so3355270fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sqNlv/OW7Vbqc+J0WaON3nruQmYPrMCiY8oE33vRgo0=;
        b=WgvJ54039EW1s9ouY71PRlLjRB1AAPBaxK+LwSc9oBSBuBaQGbc1ZZJDQWfpYY+QFv
         oewQ8Emcvlzop7PkUdnxxoLk0x1WLrTMBM5nb291V2CVFW8y9g4r0VJO6fiOGVqJ4/IT
         oR15vgI9ORd7jixr/rCmTwDCitIcweh6MLPh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sqNlv/OW7Vbqc+J0WaON3nruQmYPrMCiY8oE33vRgo0=;
        b=hVu+udX759GBbCCAIV9UCIB9pScM1SuCsmV6Gji2ijVzYSzIUcUcpGRGqk5hzfl5yN
         ZML7UYb7PPkth1217mkxPFEXHcDk6dMq7tQYwxIxRUE7XGjkDZTnFZBgXLz2QlvufMMQ
         SeIj1mzVNp7anTAOXjDUhpJ97CfIxzucWdEL9YaWQvxLHCk94xtZP/p6eh/jeYYlDXvv
         iQPtp+3WkvegCCCRFROqBo2Dc0eo4yB7oxwE12+d4LxQRleJexjcuw4RgTlBwLl8rg3D
         lz38gQPuZzkvabfELnyn+0fCxFA479CLB9YpldbFIk2IGHI6GXO86FM1V0+Xgo5J0+NL
         7zmg==
X-Gm-Message-State: ACrzQf3LUHzJ5qDb2jPUrdretXVnZNoPXwTo1xWxxFcPGvkq7Ckx471i
        cGa/vFlhgF/o28vip0ickAzlERQwUZCGVA==
X-Google-Smtp-Source: AMsMyM6fA7PNrw76rdwSXORKVUlC8pph1hasLIMbwBzfyNdHjyHeNeTvCGS9f10/AeMe3fzYiGV5xw==
X-Received: by 2002:a05:6870:c59b:b0:131:8d2e:e808 with SMTP id ba27-20020a056870c59b00b001318d2ee808mr8244242oab.280.1664487119038;
        Thu, 29 Sep 2022 14:31:59 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id b17-20020a056870d1d100b00127a6357bd5sm206977oac.49.2022.09.29.14.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 14:31:58 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso999545ooq.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:31:57 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr2281262oti.176.1664487117634; Thu, 29
 Sep 2022 14:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
 <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
 <YzXo/DIwq65ypHNH@ZenIV> <YzXrOFpPStEwZH/O@ZenIV> <CAHk-=wjLgM06JrS21W4g2VquqCLab+qu_My67cv6xuH7NhgHpw@mail.gmail.com>
 <YzXzXNAgcJeJ3M0d@ZenIV> <CAHk-=wgiBBXeY9ioZ8GtsxAcd42c265zwN7bYVY=cir01OimzA@mail.gmail.com>
 <YzYMQDTAYCCax0WZ@ZenIV> <YzYNtzDPZH1YWflz@ZenIV>
In-Reply-To: <YzYNtzDPZH1YWflz@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 14:31:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2JKDawG44kpS-bbrATB6LDyRx64LwdXEzZk2RYwkzJg@mail.gmail.com>
Message-ID: <CAHk-=wi2JKDawG44kpS-bbrATB6LDyRx64LwdXEzZk2RYwkzJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] proc: Point /proc/net at /proc/thread-self/net
 instead of /proc/self/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 2:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Put it another way:
>
> David:
>         when I'm opening /proc/net/whatever, I want its contents to match
>         this thread's netns, not that of some other thread.
> dhclient+apparmor:
>         whatever you get from /proc/net/dev, it would better be at
>         /proc/<pid>/net/dev, no matter which thread you happen to be.

... which actually creates an opening for a truly disgusting solution:

 - when an outsider else opens /proc/<pid>/net, they get the thread leader netns

 - when a thread opens its *own* thread group /proc/<pid>/net, it gets
its own thread netns, not the thread leader one.

Disgusting.

            Linus

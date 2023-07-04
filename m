Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606B1747792
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGDRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGDRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:13:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8510CB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:13:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6a675743dso90327571fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688490814; x=1691082814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzyQSD/853Y9P4S63XLg/qiUIMnHBn6Z9RYTswB5rMY=;
        b=X+mzMB0BBDbDDoBoO5DgvNH3nR5y+/B2W5UP/FDfwnpp4whAu0ADBUxt7PAhU2FgD3
         0l3yUeJBIs3CGKIsqMjn/x7JOIEP9KF2wGUFWmtNA0cv1uYiQCJEjXN1XCjFe0k6DkGy
         5zRYoXLrUrBdnznDjik1xinm/NibrYoe0T1O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490814; x=1691082814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzyQSD/853Y9P4S63XLg/qiUIMnHBn6Z9RYTswB5rMY=;
        b=ZgV3yglOECiipEKD9rGsrUmlaFQjeVxlxySQ+8/Htzkrpj6p6TIvHC0PPNtd8ozEJm
         BRTdQDGt30fUcU9zmxMMtbHBlZM+0f/xSRgU+2y6f/U/Zd+SgxkIlh5m2rwuJRIfmOxi
         SvuQvnvMrnJx9R1+07A3W+hGuwWEHsmUjMWaI8GSMvBkS9k2wLgssTCm5N4Nv8gYCm0Y
         1p5oSqikZRd9HATbUPer1JBWyQxefYk8dfVD1hgzi8C1gvKp0RbgHjxregx1ea7pvERj
         KJ5xm6GRPeYiEYwnLeuXUc/PMLCH4dRUgUuJWCKqBs4FmW9uysateXwT1OvU4amnzvqa
         pGUg==
X-Gm-Message-State: ABy/qLY5jIC8SLXoZJ/H4QapJe+0TpZWYFzSyWbDiw6CLvdRjTwd41gU
        gpR3LR6kIxIDqvmW5wx+pYoB16BRni1m+cIsZffQiyx8
X-Google-Smtp-Source: APBJJlH2p8bvNAbsnS2M9+Kn/Gyqxm5UNZJwzVUnwJsFi9aTDOGs0BStixuzkOj+QP2YHf7j6EtRHQ==
X-Received: by 2002:a2e:95cc:0:b0:2b6:efc7:2af7 with SMTP id y12-20020a2e95cc000000b002b6efc72af7mr3793291ljh.44.1688490814434;
        Tue, 04 Jul 2023 10:13:34 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j12-20020a2e800c000000b002b1d6bfab5csm5873317ljg.22.2023.07.04.10.13.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 10:13:34 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb41682472so8847933e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:13:33 -0700 (PDT)
X-Received: by 2002:a05:6512:3487:b0:4f8:565e:f4ae with SMTP id
 v7-20020a056512348700b004f8565ef4aemr10130538lfr.39.1688490813644; Tue, 04
 Jul 2023 10:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b73abf05ffa60902@google.com> <20230704092451.72974b7a62ae08d48c077e10@linux-foundation.org>
 <CAHk-=whzthQy42SzYb1Bs_6tGyss5=SoiOppSE6onjUWDwA=aw@mail.gmail.com> <20230704170144.GB1851@sol.localdomain>
In-Reply-To: <20230704170144.GB1851@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 10:13:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvVRv7yfsAYyRigSWxKyeMb42yzB3hj2U9J1u59MyvUg@mail.gmail.com>
Message-ID: <CAHk-=wjvVRv7yfsAYyRigSWxKyeMb42yzB3hj2U9J1u59MyvUg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in __gup_longterm_locked
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+6cf44e127903fdf9d929@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 10:01, Eric Biggers <ebiggers@kernel.org> wrote:
>
> syzkaller just makes system calls.
>
> Unless you want to do the crazy thing of checking if current->comm begins with
> "syz", I don't think there is a way to distinguish.

Yeah, that's what I thought.

> In the past there's been some discussion of adding a kconfig option like
> CONFIG_FUZZ_TESTING that would be expected to be enabled in order to run a
> kernel fuzzer, and changing behavior in certain cases based on that.  Changing
> behavior in production vs. test is problematic, though...

Agreed. The whole point of a fuzzer is to check the real thing. This
test for GUP expansion really is a pretty specialized thing.

Maybe the WARN_ON_ONCE() could have been just a "pr_warn_once()", but
at the same time, *if* that condition ever happens in some real
situation, I'd really want to know just exactly *what* the app in
question is doing.

                 Linus

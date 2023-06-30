Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D37434DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjF3GQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjF3GQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:16:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C545268F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:16:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso2254154e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688105801; x=1690697801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=Gb0BtWhip4AWuCWTNkQJgWrt8U9ymldjUELdjEye0Qvvg6qDwzqxYluzUl/ENSVPl+
         O+NLj74Vv82tV56sIxDd5pF928YkwqGTPlkfGHPnw3ck9Ee26t+BlpejtmA5r33vz1Qp
         EDCJBnpO/u7hmQEGYGta0sWqe56Iv0Asvy+xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105801; x=1690697801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=Ko/SgtC8XAdjQ406m0vz3mEIyohVjbppD703zBitYe+eaCLW/fNztxquUYmBuWS76D
         zPGzLRUsMggKY0U78aO83VH9nVrMn2B1v3N05SQhxWXCYMsmCLnV6mu2uueDAz03Nxa1
         tQcSgUgnWMC3a/j/2NEQgtvlXH7VzDBcOv69WIwZezT6r09J7X3uJZZ/hPB2HItjahRT
         apFVTcOoWgjfnqQX1KZQMuquCPR5iJxnB2TEHsVUxd+8uwubMtpQakTTPBJiAERHHZcV
         D4zKPhIRbAcLy9Pu3HkLNW2h7nkpffd86HD3POZT67ziK046f7sVKAeXyy67MFjlOfCa
         h74A==
X-Gm-Message-State: ABy/qLZ8CYReBi4GJnCIfsz97XQqqgN2Id2Xbh15levbXqR+1v5GJIB+
        v8m8vwgJz7ChL6lOJKmB4+UUMPJlHrsUvSGHpWSLQ6Qk
X-Google-Smtp-Source: APBJJlEEwWKwrFiV8uaJ6jO21zhQ1lGtSTU49oTHZeHt9PRraL6ftvWC35dM7IBiEqPxIh4NTQRj3g==
X-Received: by 2002:a19:675a:0:b0:4f8:6d99:f4f3 with SMTP id e26-20020a19675a000000b004f86d99f4f3mr1303264lfj.52.1688105800931;
        Thu, 29 Jun 2023 23:16:40 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y24-20020ac24478000000b004f64fb058f7sm2592815lfl.225.2023.06.29.23.16.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b6985de215so24309791fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
X-Received: by 2002:a2e:870f:0:b0:2b6:99a3:c254 with SMTP id
 m15-20020a2e870f000000b002b699a3c254mr1390190lji.26.1688105798765; Thu, 29
 Jun 2023 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
In-Reply-To: <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:16:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
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

On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> arch/parisc/mm/fault.c: In function 'do_page_fault':
> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in this function)
>   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))

Bah. "prev" should be "prev_vma" here.

I've pushed out the fix. Greg, apologies. It's

   ea3f8272876f parisc: fix expand_stack() conversion

and Naresh already pointed to the similarly silly sparc32 fix.

             Linus

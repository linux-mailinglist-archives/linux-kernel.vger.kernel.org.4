Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876F639CD9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiK0Ugy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0Ugw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:36:52 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC5564EE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:36:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id z17so5973484qki.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/rAM9yo3azkhI65gwtB5B+mMamh15Wh4ROhrwvpbPvY=;
        b=Gfs9JRwp8lCE6YwObDXBSAZjLjSsVXButeeYg4hiQviVp/q88teVvyLQyGiYILz4yh
         G12moFm4o90DemCiIcXPQR7UTy1LUxaxqwQgLgeq/LHpGoRdbXOErooH1yrMULFnbAWj
         M+zstTA0zkZWkgbjT1caCL3ZS8efvhfU6Ea2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rAM9yo3azkhI65gwtB5B+mMamh15Wh4ROhrwvpbPvY=;
        b=zAUMZbPZhGkzJ3veAtLSij86pkcC6yeqtpToqF6+VtfM2gOH1CA87XuMLL3XjpdGRv
         vZdVC7qtFk84A3Sg2mSsMawMzmO0T72shdvkDSvsCeU9PEdhmnnMzEoMGQecPfCYieJ7
         kjhKghxmkgw5EYRgmFLOXtkpS7YfN42BGnB4qJmv4UnnzdYJ1KhThCn8sHpnGHuDpIPV
         2+NNUicwAk+lxrt0zuQKhjPWw1tAuZdpEX5pMIIpAb7yyKpVY+uEm3gmBmAEbBi7IN5C
         S2IC8oKVm3Gwk2farSfcNZXlj0A1j/zCMycXAnbMIfYhfhttZxCXcqNMaIr4R0Mx6KfH
         vhYQ==
X-Gm-Message-State: ANoB5plo1DBSqe4FgeWISEwNdYGeUeFitKuEmiJVBRVsMAT5QJiAkrDr
        B0RkzTn4jMowrZxq/YXBGAR6OFUYW3S1EQ==
X-Google-Smtp-Source: AA0mqf41d8MZGpEzdFqENIGL6mH4RZ063ECksR2sIUmfR3LlxQeBqTMjC0cucC1paJCKipetSm0Uiw==
X-Received: by 2002:a05:620a:1185:b0:6fa:4af5:701c with SMTP id b5-20020a05620a118500b006fa4af5701cmr30526242qkk.13.1669581410417;
        Sun, 27 Nov 2022 12:36:50 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id g14-20020ac8468e000000b003a54a19c550sm5766926qto.57.2022.11.27.12.36.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:36:49 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id d7so5991309qkk.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:36:49 -0800 (PST)
X-Received: by 2002:a05:620a:108c:b0:6cd:fd44:d83e with SMTP id
 g12-20020a05620a108c00b006cdfd44d83emr28932345qkk.594.1669581409441; Sun, 27
 Nov 2022 12:36:49 -0800 (PST)
MIME-Version: 1.0
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
In-Reply-To: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 12:36:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
Message-ID: <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
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

On Fri, Nov 25, 2022 at 7:00 AM David Laight <David.Laight@aculab.com> wrote:
>
> - Skip the type test if either argument is a positive 'int' constant.
>   Instead cast the constant to 'int', the compiler may promote it
>   back to 'unsigned int' when doing the test.

No. This looks very wrong to me.

Maybe I'm mis-reading something, but it looks like this makes a
"sizeof()" essentially be compatible with an "int" variable.

That is horrendously wrong. It should warn.

If you are doing a "min(i,sizeof(X))", and "i" is a signed integer,
then something is wrong. What does that code expect? It shouldn't
silently say "this is ok", because it most definitely isn't.

So maybe I'm  mis-reading this all and it doesn't actually do what I
think it does, but this seems to relax things *much* too much.

There's a reason we require types to be compatible, and you just
removed some of the important signedness checks.

                  Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442F73C4AD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFWXJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFWXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:08:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F31BF7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:08:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bdd67a306so1216226a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687561735; x=1690153735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpOCYdCz9+Zb2K6HO3OPqVtGOivHjfzSPtnfTxeBPM0=;
        b=U9PizGcM6/atGNPSZ2y3bZbO3TXUTI0Z2UbTJqRLWzCp9QmxydSnrmj+1TFShdS5RD
         f76wIKgnlxTQhgtCA1KAeSfUE8OP44tJ5eKZekFYLSde9fWImlBt454K1rxahMvPQ4KU
         YG8mHytbQzf8F4cYaVWz96SLl49SyFwA7EiWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561735; x=1690153735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpOCYdCz9+Zb2K6HO3OPqVtGOivHjfzSPtnfTxeBPM0=;
        b=e9YUhuOS1pq2us3PFlMpzNR/lT2L7hNgrpo8qP7GAMRz++S7Q5kI0RkWBpUnszhoMz
         02dVLDFJEwL91TLIcGY91dtUmhDYERLUcJw4995r6cuHbqfuHwoGuJO6OWd/oQiZvh/M
         MLg6ZAKt6uEhDEBaYEeBf8yGyJJ0A6ZC1ajmGPfLy/S010V/rHGbSg+QlYZjWNbwzeEH
         pIYOAHgXZ7b7AjDps1iyWTBfSjHHWcmPGBM83OrsjIslaSXyW6ipAl8sREsI1C3B7fXX
         QNBsOYC19JX6YiyEzN9nTERQAt1+EmB5HLmUiUdY8qiaQMFf8fKPOtiGjlIdUEBsjeiW
         xXtg==
X-Gm-Message-State: AC+VfDz8kow093sr+CrBY69oacY12TRfBGPi/MPkCUqXihXnyCojyfR5
        2BtPhUGjCsWi5jv1J5KyYxj18S/iDPyVDmNgft8Xbwlb
X-Google-Smtp-Source: ACHHUZ72zxjJu1zIRxSJhBlckJk8+NE6AAGNATSJfFH6+QAZ1scfp6zG9e5yJUEWvW8biUUZuC5lwQ==
X-Received: by 2002:a17:906:6a04:b0:988:a837:327e with SMTP id qw4-20020a1709066a0400b00988a837327emr13736437ejc.71.1687561735347;
        Fri, 23 Jun 2023 16:08:55 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906378f00b0098d482d9f2fsm182345ejc.69.2023.06.23.16.08.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:08:54 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51be4a42b9bso1226565a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:08:54 -0700 (PDT)
X-Received: by 2002:a05:6402:1210:b0:51b:e9f8:87ba with SMTP id
 c16-20020a056402121000b0051be9f887bamr4083864edw.32.1687561734420; Fri, 23
 Jun 2023 16:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <2730511.1687559668@warthog.procyon.org.uk> <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:08:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
Message-ID: <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
Subject: Re: [PATCH] pipe: Make a partially-satisfied blocking read wait for more
To:     David Howells <dhowells@redhat.com>
Cc:     Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 23 Jun 2023 at 15:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This patch seems actively wrong, in that now it's possibly waiting for
> data that won't come, even if it's nonblocking.

In fact, I'd expect that patch to fail immediately on a perfectly
normal program that passes a token around by doing a small write to a
pipe, and have the "token reader" do a bigger write.

Blocking on read(), waiting for more data, would be blocking forever.
The read already got the token, there isn't going to be anything else.

So I'm pretty sure that patch is completely wrong, and whatever
program is "fixed" by it is very very buggy.

Again - we do have the rule that regressions are regressions even for
buggy user space, but when it's been 3+ years and you don't even
mention the broken app, I am not impressed.

             Linus

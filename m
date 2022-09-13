Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880815B7AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIMTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIMTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:17:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45456AA1F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:17:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q11so6155992qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fVY7ApQzP95gFZZdtCOfQPsHwMuo++2zXYhTDqENKgs=;
        b=Y0pQdYnbry+4NLX6WgUFA2t4vEMzzbmAsbRDbjCI2RspM3k/jIT2OCIstjJVq4Fl3g
         +6S6fKSs66zOgLnAOjHrM5lOuw9G+dW1rK+6V0DXm9YkJi33INHWcPpOzwIRxK0WNFX+
         C3tvMUnu8JzTjwtL/Nq2h/tqztf14O+y+hX1OK6T7Hj3Nr3Z3Lr6BDTmVidKgiUWIG0a
         HltpnD6x+EjmV1/QgjdiErG92N5VMhQcAWjyBLaesfhNrGIwFv5Gi6fwdzGXlt5IgY9l
         OcW3H3EUr1g/3Xg/fi5nkhYrPxF0+DEQQcWJXd3V9vDKJGt5TfXR4YzklFoURrD8vrID
         K5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fVY7ApQzP95gFZZdtCOfQPsHwMuo++2zXYhTDqENKgs=;
        b=k1doYUrK3RpD2otFO5R6GE+F9H0doVRZVianD5L2V/ghYsQOUEA1T+oJ03YNm+uEvo
         IvqzcKc6dyAkQBjxyX2x0lzLvFYJdbROfPrBDpxQWriD6iwthOF+TrQJmzuoEFS2KDnu
         zgFTo8gAaRtKu6Isfx8DGTczoHg2vGL5hNSGI0DD72tLUWHmA7UIT5TirQvrMHAYPw7x
         w6d0PWEhs7jZfVjs4h2NWjdGK+ipuv7m40fUtxhkAtkYy4kUf/mi/i5jKNpMTQ9/ZcpV
         3P+7Twlkr6uBIFgPrkknoBFQsuneJrjcFztno89t4CiXCp0+j1q39YLyouLAH8zp4IRI
         IkcA==
X-Gm-Message-State: ACgBeo3KCW3qMCs7gyl62RpUjl9/Gw1B9OUMKTbWWJtQ2oNO1YqW6bp+
        etR9wB8VQkNObZSJXY6lN0aT6lLyZbo0smiF/S1GObNS3eIVjA==
X-Google-Smtp-Source: AA6agR6o9rYiyZzCDvEEcvClGbbt/MDrEFBHLm07/8qrZ/cfPEyMzW9YQsS5YlpQdScFmGT9lyi5GP3Ox+liXEvI1Fo=
X-Received: by 2002:a05:620a:29c9:b0:6ce:7681:19e9 with SMTP id
 s9-20020a05620a29c900b006ce768119e9mr2436233qkp.297.1663096660934; Tue, 13
 Sep 2022 12:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220912214548.929144-1-nhuck@google.com> <3b60a44b-2868-ba93-bb0c-d937a209f03e@gmail.com>
In-Reply-To: <3b60a44b-2868-ba93-bb0c-d937a209f03e@gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 13 Sep 2022 12:17:29 -0700
Message-ID: <CAJkfWY5O56kWhBa1XP4auMLEVJpn9OEi__p6oVQXSYw0ac2_7Q@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8192e: Fix return type of rtllib_xmit
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Felix Schlepper <f3sch.git@outlook.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this has already been fixed in commit
513d9a61156d79dd0979c4ad400c8587f52cbb9d

On Tue, Sep 13, 2022 at 11:48 AM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/12/22 23:45, Nathan Huckleberry wrote:
> > The ndo_start_xmit field in net_device_ops is expected to be of type
> > netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> >
> > The mismatched return type breaks forward edge kCFI since the underlying
> > function definition does not match the function hook definition.
> >
> > The return type of rtllib_xmit should be changed from int to
> > netdev_tx_t.
> >
> > Reported-by: Dan Carpenter<error27@gmail.com>
> > Link:https://github.com/ClangBuiltLinux/linux/issues/1703
> > Cc:llvm@lists.linux.dev
> > Signed-off-by: Nathan Huckleberry<nhuck@google.com>
> > ---
> >   drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> > index 42f81b23a144..1b665afd309e 100644
> > --- a/drivers/staging/rtl8192e/rtllib_tx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_tx.c
>
> Hi,
>
> I cannot apply your patch.
>
> Applying: Staging: rtl8192e: Fix return type of rtllib_xmit
> error: patch failed: drivers/staging/rtl8192e/rtllib_tx.c:962
> error: drivers/staging/rtl8192e/rtllib_tx.c: patch does not apply
> Patch failed at 0001 Staging: rtl8192e: Fix return type of rtllib_xmit
>
> git remote show origin
> * remote origin
>    Fetch URL:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> ...
> my branch: staging-testing
>
> Bye Philipp

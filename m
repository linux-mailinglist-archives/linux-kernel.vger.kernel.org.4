Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CB5B5126
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIKUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIKUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 16:43:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336C2317F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 13:43:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u6so10033626eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lSSgE6qKNsM5nRSZIZrwkAPBKl3L+uuKrmU0F7pD7HY=;
        b=JPDXpPqvckmhgM18iZ464Ra4GB/SbxdXoB7mEFnkbkwW0BRaAxrNtroPGl5mUT2WBd
         pvwfk74PBiUKM3805865m1rO90BYGGTb6OfQMgoWFTvGGKxz7e1J59pXHUMb90uqIGVq
         DvczbtudWRonTOXp0egQqyMlPi3QFxL2LC3I9HxD8oKSiT/VZByKkCnkKkwmDqdP/2lj
         jSI9jTQmMP8PcfjfMBcWc7SQ7xf+70+2cVLkZq9xRKkmN8oNLab6YKRdUP9uqKgEZWb+
         ueuuFbB+qY5K5T90Y7pJ7YbxEYirSPrYgAljQnXnSb1mbHnpaKONiixAd8OxhKnuaiWN
         DSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lSSgE6qKNsM5nRSZIZrwkAPBKl3L+uuKrmU0F7pD7HY=;
        b=etwBzW90wiKqxaJQ7EjZ+qNBhd94PmDcsrUNP4lnlMshLgv/O9/XrcoEwYPz94YpbA
         P5LXML0z/EZFYisfjq9GL/VAeaCyJVk+Yry9EL6ZJ2o0Ymbzm8ooZkaqcNDO3S6AY29T
         NX1OywpJYy3XsO0EzCWJa/GJpEahaAFWFtfurE4y7LPOJ1w1fvz7oKK2wqL0ONJdLAqf
         z6m+oFm5/hauym/ZBcEWlwHAMqJU7N8I1v63PncsiST0yeZJ3Hil3Z6lX8YbV8naiuN1
         UuSiQ4REG0w3aMOgG8gDB6tA7RFZdMT/Z5veQ1qccB8QABFkJp3m+ozD1Na5gBUjs/TZ
         ULoA==
X-Gm-Message-State: ACgBeo3LVUSXJ0gK7O/WL5+0njrIEms+wYzDrNwSnEoecP25GVgePPa5
        SyZYdVEd08CxntANFZ5t6JVv+n/yGa1+kA+aLGafcw==
X-Google-Smtp-Source: AA6agR6XNXb6iXZAgJVLktD2yTU+LhSGDNL4w1b9CIbVMQlDxN1dXvmNUnGzMKm9uOJ76P7qbjXjKF0Dd53Kd+70owY=
X-Received: by 2002:a05:6402:5249:b0:451:67ff:f02 with SMTP id
 t9-20020a056402524900b0045167ff0f02mr5735975edd.227.1662928990454; Sun, 11
 Sep 2022 13:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
 <20220911095923.3614387-3-pasha.tatashin@soleen.com> <Yx4IEvkmAlcTIP6v@casper.infradead.org>
In-Reply-To: <Yx4IEvkmAlcTIP6v@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 11 Sep 2022 16:42:34 -0400
Message-ID: <CA+CK2bD5ae0oUefiGMAzxun4-rJhqUdfJqbzcCkZM_Uek-KTxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/page_table_check: Do WARN_ON instead of BUG_ON by default
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 12:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Sep 11, 2022 at 09:59:22AM +0000, Pasha Tatashin wrote:
> > Currently, page_table_check when detects errors panics kernel. Instead,
> > print a warning, and panic only when specifically requested via kernel
> > parameter:
> >
> >       page_table_check=panic
>
> Why are the page table checks so special that they deserve their own
> command line parameter?  Why shouldn't this be controlled by the usual
> panic_on_warn option?

page_table_check can be used as a security feature preventing false
page sharing between address spaces. For example, at Google we want it
to keep enabled on production systems, yet we do not want to enable
panic_on_warn as it would cause panics for many other reasons which
are security unrelated.

Pasha

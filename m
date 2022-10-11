Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F845FB2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJKM7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJKM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:59:44 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB007E53
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:59:39 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id de14so8865035qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCdjWL21q88tuN2VrHSfcRWb8jbhJ1H4I8ctsaB17uI=;
        b=c7/OdfQhv1iSiy7GUPVDfGOmykRD3efFLQEwYl1kcGu8fva4REf1zeUaamXD6YxENv
         DPF0zmRku0kge2KG/0rKAyAqimQyI1R7XSIIzHWrMGp2sI2N3Zd2fV+YV9yF3qJnuap9
         fPzwApeXuD5mmWNIyWtJdbSJ0DW9MZpoheXG7Ctk21KAAz0XTzsBAaiDI0zdVR5q1hpl
         L7YlHBJOP7eC3rYRB5kStvd20g6u0UO84HtyUEhvYMmWMYg/NbkFLElMAa6AWZIV9RaD
         YMuNHMS0c84a5OmEDmysQGlmXYHgOab+/RdSYOSOvyCNtVr1EmPmirk378RMpoEyP7U/
         nCmA==
X-Gm-Message-State: ACrzQf2GwVO6dYs+r1TU2322iyvyKHpesWKvX1kr1UOOA/15ThKyRcks
        DI9gpq0YHM+7fl4mnRhObFYzwkoEfJx2hQ==
X-Google-Smtp-Source: AMsMyM7o8FxOZobqPTZ/qcCSeCEjMVSCnQBbovNg60GTuggovCjhhSrT2U9a6Ooku9YZhunct2AZ7Q==
X-Received: by 2002:a0c:a79a:0:b0:4b1:ca99:177 with SMTP id v26-20020a0ca79a000000b004b1ca990177mr18550561qva.34.1665493178527;
        Tue, 11 Oct 2022 05:59:38 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a404b00b006a5d2eb58b2sm13494571qko.33.2022.10.11.05.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:59:38 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id y205so16327020yby.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:59:37 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr21411387ybb.604.1665493177654; Tue, 11
 Oct 2022 05:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-8-Liam.Howlett@oracle.com> <alpine.DEB.2.22.394.2210111414020.303227@ramsan.of.borg>
 <Y0Vn7o4nmy2FNkLC@casper.infradead.org>
In-Reply-To: <Y0Vn7o4nmy2FNkLC@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 14:59:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWHzWxc-pq27+sdV9VeGvZYX+MXH1OZ06NVMuykDBpeMw@mail.gmail.com>
Message-ID: <CAMuHMdWHzWxc-pq27+sdV9VeGvZYX+MXH1OZ06NVMuykDBpeMw@mail.gmail.com>
Subject: Re: [PATCH v14 07/70] lib/test_maple_tree: add testing for maple tree
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Oct 11, 2022 at 2:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 11, 2022 at 02:16:02PM +0200, Geert Uytterhoeven wrote:
> > > lib/test_maple_tree.c             | 38307 ++++++++++++++++++++++++++++
> >
> > Does this test really belong under lib/?
> > All other test modules there can be compiled and run as part of the
> > kernel itself.
>
> So can this.  It's just like test_ida and test_xarray; it can be
> built as a module, or it can be extracted into userspace and run there.

How so? I can't seem to find the glue to do so, or the Kconfig symbol
to enable the test module.

It's different for test_ida and test_xarray:

    lib/Makefile:obj-$(CONFIG_TEST_IDA) += test_ida.o
    lib/Makefile:obj-$(CONFIG_TEST_XARRAY) += test_xarray.o

What am I missing?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

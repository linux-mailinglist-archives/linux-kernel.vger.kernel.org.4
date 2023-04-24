Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5F6ED2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjDXQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:57:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A84EDF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:57:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-76074d20a75so109956239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682355433; x=1684947433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpAVc8DWHD+kbIihYmiybWX4LCsF6lJLav4KsZanNyY=;
        b=agiIOhs0tvwlutZ4LxjPEsM4kCuz3uCMEp1Ybdh7LLbr5fgz6nP/IsyAFPKyB3I6bd
         sKYYwe1C3r38ocXF4peyLc/JZNGTKh5R28ecvhr28ErevDDooXasE5G0GFK9wQIG4EAk
         s8NGoKX+lnSJOfMwHk+c+q/06pe3nZXHoVFr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355433; x=1684947433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpAVc8DWHD+kbIihYmiybWX4LCsF6lJLav4KsZanNyY=;
        b=Eft1XMjzIj1kb1tT511ef98+sp63k73vMZCxNn7I7QmCYegywgbSMn+3Hr2haQkxxL
         KJsHeYONXXbMWuYNaQxihD/G5iUv70UGfGHnI+6dai+q8JM3KeDVStSnwum/VWGkMiq/
         35KNXdjl2xdN9lwaAX7saJvI50p5ArG+ebf2LMuEhGw1kAMdMOk9kZeddzaUafEp1Jzo
         8UqO16Qk09oV3C74KVSIDXxKA9QqQ6lcFTY/2cshu/BAOCxbW8ujep+OZVy1tnrBa+qS
         6FFJfLW1c85/7xnoY8sITG8/mmZKDAoFbfCnM8UWxMfv1NUsarCp+i1FHTc/UcvQqDYw
         4Z/A==
X-Gm-Message-State: AAQBX9fAmG3Qef723707GA8yfyt4RC4hTQ1ypxyEAqvo60Tp+VR4RpEz
        LmNSNqrlqsGjHsHPlY+ssdpWiEStoXh8U8gmknc=
X-Google-Smtp-Source: AKy350a2JG3lNwF7+gYfnXp/I51kUIY3vYUoZxygXgNNxXvmavYlQWF5cq487MP2vR3U9ueA5/QYuQ==
X-Received: by 2002:a6b:7b08:0:b0:74c:fe71:5808 with SMTP id l8-20020a6b7b08000000b0074cfe715808mr5932344iop.6.1682355433504;
        Mon, 24 Apr 2023 09:57:13 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id k26-20020a6b401a000000b00760c6c68d4asm3174746ioa.21.2023.04.24.09.57.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 09:57:12 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-316d901b2ecso1092435ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:57:12 -0700 (PDT)
X-Received: by 2002:a05:6e02:156d:b0:315:9823:1308 with SMTP id
 k13-20020a056e02156d00b0031598231308mr491306ilu.7.1682355432107; Mon, 24 Apr
 2023 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid> <20230422051858.1696-1-hdanton@sina.com>
In-Reply-To: <20230422051858.1696-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 09:56:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
Message-ID: <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 10:19=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On 21 Apr 2023 15:12:45 -0700 Douglas Anderson <dianders@chromium.org>
> > Add a variant of folio_lock() that can timeout. This is useful to
> > avoid unbounded waits for the page lock in kcompactd.
>
> Given no mutex_lock_timeout() (perhaps because timeout makes no sense for
> spinlock), I suspect your fix lies in the right layer.

I'm not 100% sure I understood the above comment, but I think you're
saying that the approach my patch takes seems OK.


> If waiting for
> page under IO causes trouble for you, another simpler option is make
> IO faster (perhaps all you can do) for instance.

Yeah, this gets into the discussion about whether our current squashfs
settings actually make sense. I suspect that they don't and that we
should look into EROFS like Gao suggested, or at least choose
different squashfs settings (smaller block sizes, ZSTD instead of
zlib). Unfortunately I believe that the current squashfs settings were
chosen because disk space is a concern.


> If kcompactd is waken
> up by kswapd, waiting for slow IO is the right thing to do.

I don't have enough intuition here, so I'm happy to take others'
advice here. I guess my thought was that kcompactd is explicitly not
using the full "sync" and instead choosing the "sync light". To me
that means we shouldn't block for _too_ long.

-Doug

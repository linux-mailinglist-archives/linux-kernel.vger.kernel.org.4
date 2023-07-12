Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC757503F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjGLJ6I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGLJ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:58:06 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0271720;
        Wed, 12 Jul 2023 02:58:05 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5768a7e3adbso8595087b3.0;
        Wed, 12 Jul 2023 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155884; x=1691747884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6MzudJP2Fu/sGdEnelPPluUqTi475Db7xeaDmuW9Sk=;
        b=LJrwQd7/GT/f6oIF/VO5++yTV31g4WJbSQ1fWlc/6aaAe0vQvJYr4kByUnVfNzoT7X
         3q3FGJZT/6Z6RHfymi63tAJPT1EY2iwRa75CXHjS3Ot25+fRu84WDKLN9xUi8pxJQluj
         PwGyOtMkZiK8HKdqp2iAgC0FDJFT+heoiVo5a8pdlw7A+EuipACA1m7X08NZYQuLg/OD
         4BH/kujvK/Db+8rFjpsFKMfyxPvqea1avTy6JQUB0jahhM9Itqqy49SgaLfGIPhGEnbL
         ljW/5yIUDSlUn4axOB9G4IApIlfDzHpZdHk/JMhE1rmohX36QxlmsHnsHGtr/7g1jdHD
         Kl4w==
X-Gm-Message-State: ABy/qLY/EwIOYS6AZrz2ivULfQAnXCA21K/X7hfKfuI+kiyLNdahXYQ4
        UHdcDF7kMwh4RmGN6+ZFK/Up2wQ6pmTPxA==
X-Google-Smtp-Source: APBJJlGYudo9gVR+Cou01gtan/TCm1WXI5ja4PeIWua5VW5I2pAP/ypMPtV4ncbiIL0wMtb9qlUwGw==
X-Received: by 2002:a0d:d616:0:b0:573:284d:6476 with SMTP id y22-20020a0dd616000000b00573284d6476mr1711934ywd.1.1689155884332;
        Wed, 12 Jul 2023 02:58:04 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id f67-20020a816a46000000b0057a93844c15sm1059234ywc.127.2023.07.12.02.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:58:03 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so198576276.0;
        Wed, 12 Jul 2023 02:58:03 -0700 (PDT)
X-Received: by 2002:a25:ae5d:0:b0:bd6:a97e:3597 with SMTP id
 g29-20020a25ae5d000000b00bd6a97e3597mr1632945ybe.30.1689155883328; Wed, 12
 Jul 2023 02:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org> <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org> <ZK30CR196rs-OWLq@slm.duckdns.org>
In-Reply-To: <ZK30CR196rs-OWLq@slm.duckdns.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 11:57:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCXPi+aS-7bR3qRetKF9T3W9jk_HKjvaXmfHv5SEeuFg@mail.gmail.com>
Message-ID: <CAMuHMdUCXPi+aS-7bR3qRetKF9T3W9jk_HKjvaXmfHv5SEeuFg@mail.gmail.com>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism)
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Jul 12, 2023 at 2:30 AM Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jul 11, 2023 at 11:39:17AM -1000, Tejun Heo wrote:
> > On Tue, Jul 11, 2023 at 04:06:22PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Jul 11, 2023 at 3:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> ...
> > > workqueue: neigh_managed_work hogged CPU for >10000us 4 times,
> > > consider switching to WQ_UNBOUND
> >
> > I wonder whether the right thing to do here is somehow scaling the threshold
> > according to the relative processing power. It's difficult to come up with a
> > threshold which works well across the latest & fastest and really tiny CPUs.
> > I'll think about it some more but if you have some ideas, please feel free
> > to suggest.
>
> Geert, do you mind posting the full kernel logs for the affected machines?

https://drive.google.com/file/d/1toDs7ugZJ2eXatpdvySY4yxSsNam9xAC
is an archive with boot and s2ram logs.  Note that my kernels do contain
local debug code, and may be noisy.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

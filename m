Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896855F7A95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJGPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:33:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35615118743;
        Fri,  7 Oct 2022 08:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E713FB8229E;
        Fri,  7 Oct 2022 15:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A72C433D6;
        Fri,  7 Oct 2022 15:32:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eKn4nF+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665156773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGyG/s3JlJVyhDWuuZIYCk22RBHdtHriCjT//4ElmeY=;
        b=eKn4nF+XLw9QUWiDT6M2jTqTquB7JKMBD3iliblTo4hqAN2xI1S0xd12OeMJ2C5UyryAtO
        8qAggbCfIDCfdFfZdo81e8eJtwsJLNKJrFBWI20KZ9IWP3X22w6XkFEfgTWyed5ZkHVwXb
        ZCRrw01W7EjrMiuZzKSEmIHS9YRvXIc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0dd9c5d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Oct 2022 15:32:53 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id 3so5380705vsh.5;
        Fri, 07 Oct 2022 08:32:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf3cMhLWE6FV7drweLNE602kchglHRMnMCdstu4Mj6T+0hU0OEHa
        ee6kpnOy5Hmn8IxXNjoxc2dEbI9BPJGr1vjBiGY=
X-Google-Smtp-Source: AMsMyM5GUUcprpoeQv1qzUEwWZPU/W15cOz46cgtY19IIuNNAFEGJvCw79B+i292aE+mrvSx7cb1712hSkk76bZTfaM=
X-Received: by 2002:a05:6102:2908:b0:398:ac40:d352 with SMTP id
 cz8-20020a056102290800b00398ac40d352mr2772827vsb.55.1665156771722; Fri, 07
 Oct 2022 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220930231050.749824-1-Jason@zx2c4.com> <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com> <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com> <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com> <Y0AxMObsOLfqEjLt@zx2c4.com> <Y0A97NrHvzkfaG0J@linutronix.de>
In-Reply-To: <Y0A97NrHvzkfaG0J@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 7 Oct 2022 09:32:40 -0600
X-Gmail-Original-Message-ID: <CAHmME9rhtZrwns_d7gQc8vrhWHKZqv6PkWi=JSQXsQOvvRr8UA@mail.gmail.com>
Message-ID: <CAHmME9rhtZrwns_d7gQc8vrhWHKZqv6PkWi=JSQXsQOvvRr8UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 8:55 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-10-07 08:01:20 [-0600], Jason A. Donenfeld wrote:
> > Here's a reproducer of this flow, which prints out:
> >
> >     [    4.157610] wireguard: Stack on cpu 1 is corrupt
>
> I understood Sultan's description. The end of story (after discussing
> this tglx) is that this will be documented since it can't be fixed for
> add_timer_on().

Right, that's about where I wound up too, which is why I just
abandoned the approach of this patchset. Calling del_timer_sync()
before each new add_timer_on() (but after !timer_pending()) seems
kinda ugly.

Jason

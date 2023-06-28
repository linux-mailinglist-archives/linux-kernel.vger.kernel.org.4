Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE30741BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjF1WH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjF1WH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:07:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B212110
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:07:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo402341fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687990072; x=1690582072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LafiJyNgbZmNNbdJGp4ZrkLO2f20OEreitolc2Mh/lo=;
        b=PomxwqaIy6aeq7DBIgY2sb7PAqKolGDUIHD3x9dj1dacOIyh0CSbgclEIJEmA1lvIl
         x32ck3Ce4ADhlFZkkwNqmAsPdevAKnIYHgWiyKhBDkhwdkmsf5h6R7LzByP0s9/oKdw6
         3w6ZG5ThvR5Je9Nc0fw5+W82iGNVOFNkIeJu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687990072; x=1690582072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LafiJyNgbZmNNbdJGp4ZrkLO2f20OEreitolc2Mh/lo=;
        b=USiYoS7fHG+vbryrztRgWIymeg43bjvZSVDCGjKbY5DkTly2L/2bF/ZN0is9PBnOSP
         eaeujsTzut+Xxq0ysyMc15GZ4w+Zj4dugf3pULJx5S3bXUYrsxAlAMZSZMM0NsWnPnb/
         NY9iXaymoT494nIN7HbMCwr7KrQi6uKkTMw28qyvYIRtM16H7I8HbHkmr0RG4dRzxP9x
         sYPLhqQeLVEatAqanGEtzx19NUXkkeisXMaweSfOJnhZ3ug3RA0IUz+B1YfjgZZGUk7n
         V98qN5pAufd4+PBONh24F7r0CBetgD3wiX6d1ubcigoxUf9CMSZqKRlDAPA+TBqa3gOR
         DZBA==
X-Gm-Message-State: AC+VfDw4pij3TTUNOBgv79GYdBiY905qZ1RPRLp3rCKqCcEs5Tl2g562
        pSU4RVCBuYVk9DkTC1TLy0cwP6GCH+TOCBAaNxYdUCek
X-Google-Smtp-Source: ACHHUZ4an7LWGVXIAy9iF0KII8WFsjRZvihKmFvJ4G2SWCfhgwbQ2S87tol6LB4mGXCk+7EYyiKfiQ==
X-Received: by 2002:a05:651c:14f:b0:2b6:a077:845 with SMTP id c15-20020a05651c014f00b002b6a0770845mr6791917ljd.5.1687990071870;
        Wed, 28 Jun 2023 15:07:51 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y12-20020a2e7d0c000000b002b4791745b6sm2296823ljc.109.2023.06.28.15.07.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 15:07:51 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso50665e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:07:50 -0700 (PDT)
X-Received: by 2002:aa7:c947:0:b0:51a:2c81:72ee with SMTP id
 h7-20020aa7c947000000b0051a2c8172eemr23606011edt.20.1687990050285; Wed, 28
 Jun 2023 15:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org> <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 15:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
Message-ID: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, song@kernel.org,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
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

On Wed, 28 Jun 2023 at 13:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other areas, I may send out patches, but I don't feel like I'm a
> maintainer, so I then think that "the real maintainer can decide if
> these patches are good or not".

Anyway, since I clearly didn't communicate clearly that I was throwing
the patch over to you, let me go and find it and just apply it myself.

           Linus

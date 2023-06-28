Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B684741960
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjF1UPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjF1UOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:14:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553281FF5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:14:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f96d680399so86334e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687983282; x=1690575282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbAy1A4hg8jKYhqwi5Dl7jA23U6AKUJrNF/g/KP9ftA=;
        b=SZgjdpk14oTFV1va1hxUQzM0gi4I0D8KcoyQtm3mh0LhZczx8c5LEaydLlRaoUIuCV
         +ytkAFRSH8ZrUDUMs093Y1ggCaliQn4k1QQw7ecszEAEmiq6z4IXvDgqMXxNLkxKLTql
         soYOORLu7B0pQwOEnWj5f5gTFtoccnD7IM17c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983282; x=1690575282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbAy1A4hg8jKYhqwi5Dl7jA23U6AKUJrNF/g/KP9ftA=;
        b=Gj3SW2tRND+Rj6L4tyzdZeLfVepWqc4ubVdSnKyjVQUK8n8SMXce9axurZSRnkFpML
         9KOdG4IxJ1mBDmi/THVB65fyEDX0bmfCdY2wBckrBhCxtnngrNEbtY/SIcT9XROgSvZM
         wD2KeLLTksa7g67PMc4le+mFkd0H//GUu8HlV04U2TH4MSTksbscv9YQEkylEvZgPBhO
         iXxtQmvrLd0UNC19JeT9Hz0qIloNR8Y9T+J6FMMTZC5LSzl3kNxODnqQysp1yuDQ1I7m
         9zhDjZ90EQwXxdia6Bysn4pGxjMUYxJPTzSiPwP7Y70ejyQNW/+0Pdt1OiXJ9VPu/7n8
         sP9w==
X-Gm-Message-State: AC+VfDzpSTeT3xq7LMgQugbg+OQGq9SI137qqGCPCCQSXN+l476ejwOl
        iUcb+km7LiuNatjq8oZ1gfuzoJnrj/YuiTdG2vyptZif
X-Google-Smtp-Source: ACHHUZ44/bkMnQCq/z7R3lznXYVZ7hjpzhnDsBrxbl/f9RU6PwxeIXW0JJe2gFwVeoK6x7mCS/gvQg==
X-Received: by 2002:a19:4354:0:b0:4f9:567a:7a59 with SMTP id m20-20020a194354000000b004f9567a7a59mr15021799lfj.30.1687983282323;
        Wed, 28 Jun 2023 13:14:42 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x28-20020ac259dc000000b004f73e290025sm2072781lfn.210.2023.06.28.13.14.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:14:41 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b69923a715so3831471fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:14:41 -0700 (PDT)
X-Received: by 2002:aa7:de11:0:b0:51b:ea1d:bc31 with SMTP id
 h17-20020aa7de11000000b0051bea1dbc31mr12411899edv.26.1687983261040; Wed, 28
 Jun 2023 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org>
In-Reply-To: <ZJyBhv6yrAfYvMh5@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 13:14:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
Message-ID: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
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

On Wed, 28 Jun 2023 at 11:52, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Linus, were you thinking of including these patches in for v6.5-rc1?

Heh, I don't even have them in my tree any more, I was assuming that
if they were good they'd be sent back to me...

I guess I can go fish them out from my old emails, but I actually was
expecting to just get them from you.

I do actually maintain my own branches for *some* things, and merge
them myself, but they tend to be for areas that I feel I'm
co-maintaining (ie notably vfs and mm that I still feel I'm involved
in).

In other areas, I may send out patches, but I don't feel like I'm a
maintainer, so I then think that "the real maintainer can decide if
these patches are good or not".

And I would very much hope that people don't take said patches _just_
because they come from me. They should be judged on their own merits,
and then occasionally people can mutter "Christ, what drugs is Linus
on _today_?" and just throw my patches in the garbage.

             Linus

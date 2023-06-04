Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B07217A6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjFDO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:26:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4ED3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 07:26:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-652699e72f7so1762385b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1685888785; x=1688480785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HA5YrIYH9MawD+4VRjcWbjHM//DpBE3FGKspT1TvJ+c=;
        b=CcQtwON+W3n7y7rA9m3IbuMZf1gq/6rWVzSIyiMZaJ9Vp4L7cwZl7Eptdo7f5/JYrH
         VY96BmCnZdcD+JuKrA0Kjp42bz0LLhrV3VQlkDWcACaWtSQ2lb+QUxFB38AQn87H3lTj
         U+n4Q9vvxFpFS30gxqxlMKuZ5R50iQVSLSHXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685888785; x=1688480785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HA5YrIYH9MawD+4VRjcWbjHM//DpBE3FGKspT1TvJ+c=;
        b=QMF+mrnWjjpdxLlkeSCm70d/Om0N5RhYN1aBuiYTh8UQeumhtNRxJ2ZME7s7Ldg0IM
         oMlkL39qLP0O0P6Co5OUgdyWkcM20OgzO9u7wCE/7cdsGxFOaouuolP+uk1OlDo3+XPr
         9MXsgVPGgoG/qtlCr3phOabdA7WGDCk1IDkTGoZ2t2FDwV9EgzePd6yu2Smaw3aqRR0e
         yt3iRbJeuUOS95g+tkGeEhdjBWCZyzGlBwNVrUjExZjP6bGkJII23H+TJuMH/nbebLiR
         qU3J2T1krN9Jog2NF5WzEssp7RhIuMjbbFcm1vownNqX5VlZ8Vq4zv6P0k/U2zKhLi6I
         Uwxw==
X-Gm-Message-State: AC+VfDy4+tzkNYON6LeB49hJaH4a3dyBgpNCaIbL71qlZzM9LGmxRevx
        UdxwA1pAnxIqSXLKEApBNSvd+Q==
X-Google-Smtp-Source: ACHHUZ5L7kPdWHNyYrkbAXFw/Ud0NVHz/4s8+yRhJJX2mlG+9wCBm0pRDUZD3gxZ8iMp5wqgAPDJQQ==
X-Received: by 2002:a05:6a20:158b:b0:10c:4c76:e909 with SMTP id h11-20020a056a20158b00b0010c4c76e909mr1573877pzj.8.1685888784842;
        Sun, 04 Jun 2023 07:26:24 -0700 (PDT)
Received: from 80e1dc6c40da ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b00637b0c719c5sm3657475pfn.201.2023.06.04.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 07:26:23 -0700 (PDT)
Date:   Sun, 4 Jun 2023 14:26:12 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net, imre.deak@intel.com
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHyfBLbZCE4cUMdV@80e1dc6c40da>
References: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:55:15PM -0400, Linus Torvalds wrote:
> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > I took a closer look at some of the modules that failed to load and
> > noticed a pattern in that they have dependencies that are needed by more
> > than one device.
> 
> Ok, this is a "maybe something like this" RFC series of two patches -
> one trivial one to re-organize things a bit so that we can then do the
> real one which uses a filter based on the inode pointer to return an
> "idempotent return value" for module loads that share the same inode.
> 
> It's entirely untested, and since I'm on the road I'm going to not
> really be able to test it. It compiles for me, and the code looks
> fairly straightforward, but it's probably buggy.

The updated patches fix the issue experienced with 6.4-rc4 where the Intel
NUC12 booted fine, but on media playback resulted in the video stuttering,
then freezing - and that audio was not coming though.

# diff modules-rc4 modules-rc4-patched
< snd_hda_codec_hdmi     77824  0
< snd_hda_codec_realtek   159744  0
---
> snd_hda_codec_hdmi     77824  1
> snd_hda_codec_realtek   159744  1

 Revert "module: error out early on concurrent load of the same module file"
 module: split up 'finit_module()' into init_module_from_file() helper
 modules: catch concurrent module loads, take two
 Johan's fix:
  -static struct spinlock idem_lock;
  +static DEFINE_SPINLOCK(idem_lock);

Tested-by: Rudi Heitbaum <rudi@heitbaum..com>

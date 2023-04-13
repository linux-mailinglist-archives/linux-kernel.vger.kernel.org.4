Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB76E0743
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDMG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMG4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95B8A57
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681368910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtHuO00FJiC5lOLplpzGnRuAlZl/i1NIHOiXXk9MsdA=;
        b=dk+fTXJ4ghuCm19MHnfqebwOQO7686z5ZvklRhSS7eNQsVIQ6VjwsurPqHpAZf/jMOaze4
        v3TjVwvG3U29tIDFFVEKE98n759z3No8OXzlp8/fMq2VMiMgti6lcRyudwat+qVz6vl2OZ
        GsisbGacGtGiuV3KqrMj6x3cvHwtNUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-gop-xhCiOMWk3jt6_0Xfpg-1; Thu, 13 Apr 2023 02:55:01 -0400
X-MC-Unique: gop-xhCiOMWk3jt6_0Xfpg-1
Received: by mail-wm1-f70.google.com with SMTP id n11-20020a05600c3b8b00b003f04739b77aso17024867wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681368900; x=1683960900;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtHuO00FJiC5lOLplpzGnRuAlZl/i1NIHOiXXk9MsdA=;
        b=WKaS1ABf5wLypy+230IPliUOQeeHNBFkCHxkIQ49S32JARgTHBOwUksyv/axnzV3da
         Zd7ieVdXU99HG9L4H817Lb8AnPvN7x2dfgsswqbSOtv3dJF77QrigIgqCoytUxX+mIB/
         iffJUEkT6OYH4Pv+FMQSawlLtHgj6D3aQibkxET+ZCGl2O2H4CPy8eg1+9Fu6Y6pgD+Y
         OYPP8wD3Wvg1OoEZ/vtG+wkWC4IvfJo25d8HkEPn7+CiFsV9LpIhGRvBbiAC75BDDmyx
         lvRmV8d7/SnTqiSF/fqwUxw+EL0QHkTfKCk4Atu8m71hCW/x76sAO+Q32ytFyoqJ2vhz
         D9Jw==
X-Gm-Message-State: AAQBX9dYGo9cj0JOJAJJuceBfxLVGW1gnfF6H8lUdBHeyP4OpRnfaNKf
        lweL3LCVrZFMh9TPmrxxQ6xtwd4Asq5XWdaiHSgrH/Jkp4KaP36ZSVrLNJA2MC6bXZV5qSb7M/F
        7U4Ba9ZQFymk2ETiezFt2eXXF
X-Received: by 2002:a05:6000:1b8c:b0:2ef:bada:2f04 with SMTP id r12-20020a0560001b8c00b002efbada2f04mr517212wru.59.1681368900062;
        Wed, 12 Apr 2023 23:55:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z0EZAgpIJMAOpMZ9YL49SvFC6ZDtVmPWTNAfJenweN0E8xHCZ6+EAumcDzrno3Pk/W5NtMoQ==
X-Received: by 2002:a05:6000:1b8c:b0:2ef:bada:2f04 with SMTP id r12-20020a0560001b8c00b002efbada2f04mr517202wru.59.1681368899789;
        Wed, 12 Apr 2023 23:54:59 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4c90000000b002c7163660a9sm560860wrs.105.2023.04.12.23.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 23:54:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Pierre Asselin <pa@panix.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
 <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
 <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
 <87a5zcsqg8.fsf@minerva.mail-host-address-is-not-set>
 <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
Date:   Thu, 13 Apr 2023 08:54:58 +0200
Message-ID: <87r0souv99.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Pierre Asselin" <pa@panix.com> writes:

[...]

> [    3.343433] sysfb: si->rsvd_size 0 si->rsvd_pos 0

Thanks for confirming this. I was expected that as mentioned since it was
the only reasonable explanation for your problem.

[...]

> What if _depth is low but the rsvd_ are right ?
> Then _width and _linelength would be inconsistent with _depth but
> consistent with the recomputed bits_per_pixel ?  How many ways can the
> firmware lie ?
>

I don't know. But in your case the firmware is not reporting the mode
correctly since it is setting a framebuffer of 1024x768 and xRGB but
is not reporting si->rsvd_size=8 and si->rsvd_pos=24 as it should.

One option is to have a DMI match table similar to what we already have
for EFI machines in drivers/firmware/efi/sysfb_efi.c but also for BIOS.

The question then is if we can trust other systems to report a proper
rsvd_size and rsvd_pos...

> We need more testers, don't we ?
>

It's tricky, yes.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


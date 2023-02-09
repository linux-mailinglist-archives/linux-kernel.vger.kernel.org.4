Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B568FC03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBIAfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIAfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:35:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A6D20060
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:35:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so724537pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 16:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w3/tbsKAE6pHdBxaD3xoFp2iWmuueGZM8Ld1HBgpBx4=;
        b=TT7INl3UeTVm7i5ccOWOemNKA1TCJ56sZtnxxR4JLLKn1VTZ4dubReYPNA+0b1PIcP
         yJzQaguHkiTmZA3YRhyN7Q3ftZh1lXEGF6a5QoXz5S/I795cAFeBkusjPDLRiANeK06n
         0FnyMhzulVrIBw73CXW/Y3YLxIXrdHEfAZIPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3/tbsKAE6pHdBxaD3xoFp2iWmuueGZM8Ld1HBgpBx4=;
        b=YaJtlEza3/VEUN0y2DCcrrOVeYhIZesrlCTbVmFs8/e37VnOzLuTx0uVtCgqVQ2rFf
         fFPDa6csdbjD0jWMrbzDpNv5si4aw5tjWWPIALWx6xe4Vznspmo8qe2NO/VblI5MxmOS
         9zHK/9ApSw0Ot7mT6/6ljAs9/8PQPLkDzvzj/E4z0Dhq6oFHMrHVpIXiamvy79nCvr29
         2jYSh5O9XXZ1Oc6VNTC2pnYdOhPFNmohq5MKianLG5uQatN2waOHyp430nTL1HEkMsiE
         y99k8CGLkaflstwc7ATjGFxLANy2s/i6EG98Ktn7zkzskMxsz4ldqLMufV7+iiZ5Boe9
         wPRQ==
X-Gm-Message-State: AO0yUKU9nLg19f03EJZ3te7+ZqVgFhkwA3VokZom9xFpIxqq20kCM6eD
        vsLrRCV7IXcsPfUahRRbRqGQXg==
X-Google-Smtp-Source: AK7set+wKMq6T3qyb881FsIGkRTd5IAeXJrKAiit4gN6PbY0p0AdJjwp14n/PBLDuWVjxVDnkTuZSg==
X-Received: by 2002:a17:902:e841:b0:196:2bf1:b690 with SMTP id t1-20020a170902e84100b001962bf1b690mr11005685plg.13.1675902921336;
        Wed, 08 Feb 2023 16:35:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001743ba85d39sm64721plb.110.2023.02.08.16.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 16:35:20 -0800 (PST)
Message-ID: <63e43fc8.170a0220.954a3.026d@mx.google.com>
X-Google-Original-Message-ID: <202302081634.@keescook>
Date:   Wed, 8 Feb 2023 16:35:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>, concord@gentoo.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Revert "slub: force on no_hash_pointers when slub_debug
 is enabled"
References: <20230208194712.never.999-kees@kernel.org>
 <Y+Q2xVKiN9UdZGwA@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Q2xVKiN9UdZGwA@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:58:54PM +0000, Hyeonggon Yoo wrote:
> On Wed, Feb 08, 2023 at 11:47:17AM -0800, Kees Cook wrote:
> > This reverts commit 792702911f581f7793962fbeb99d5c3a1b28f4c3.
> > 
> > Linking no_hash_pointers() to slub_debug has had a chilling effect
> > on using slub_debug features for security hardening, since system
> > builders are forced to choose between redzoning and heap address location
> > exposures. Instead, just require that the "no_hash_pointers" boot param
> > needs to be used to expose pointers during slub_debug reports.
> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: concord@gentoo.org
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: linux-mm@kvack.org
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/202109200726.2EFEDC5@keescook/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> in the commit message:
> 
> > Obscuring the pointers that slub shows when debugging makes for some
> > confusing slub debug messages:
> >
> > Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> >
> > Those addresses are hashed for kernel security reasons. If we're trying
> > to be secure with slub_debug on the commandline we have some big
> > problems given that we dump whole chunks of kernel memory to the kernel
> > logs.
> 
> it dumps parts of kernel memory anyway and I'm not sure if slub_debug is
> supposed to be used for security hardening.
> 
> what about introducing new boot parameter like, slub_hardening,
> which does not print anything?

But it would be parsed for the same options? Redzoning, for example, is
the common thing used for folks interested in detecting memory corruption
attacks, etc.

-- 
Kees Cook

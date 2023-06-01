Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11171F126
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjFARxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFARxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:53:13 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570313D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:53:12 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685641990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gLsPpU09ZX1oPA5PFz5u/WQswLV/fVWR9RT9czI1/8=;
        b=otDvWmsVMNh/LcZg1i8pBTm80teDhhYpay+emHGlZNdXYjInOAyG/6aqM/EmTgw+/2nn/J
        qqn0XbzbQqp9jxBteAPeeODAmRERpmBSukfT2OjeINaCtgN+4bDT8XKl4xhFvIHexRpXSY
        tXiy23crK9BdqQtA4wJfHbbwRkhhmcM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, rppt@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <ZHjbBAnpkfw2oBCr@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <ZHTuBdlhSI0mmQGE@moria.home.lan>
 <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6hqzLuNhvkHFOmKTJdQm8A0JdUna=1iFdRC0y+kKmF4Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:48:51PM -0700, Song Liu wrote:
> On Mon, May 29, 2023 at 11:25 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > I don't think we are exposing architecture specific options to users.
> > > Some layer need to handle arch specifics. If the new allocator is
> > > built on top of module_alloc, module_alloc is handling that. If the new
> > > allocator is to replace module_alloc, it needs to handle arch specifics.
> >
> > Ok, I went back and read more thoroughly, I got this part wrong. The
> > actual interface is the mod_mem_type enum, not mod_alloc_params or
> > vmalloc_params.
> >
> > So this was my main complaint, but this actually looks ok now.
> >
> > It would be better to have those structs in a .c file, not the header
> > file - it looks like those are the public interface the way you have it.
> 
> Thanks for this suggestion. It makes a lot of sense. But I am not quite
> sure how we can avoid putting it in the header yet. I will take a closer
> look. OTOH, if we plan to use Mike's new allocator to replace vmalloc,
> we probably don't need this part.

The architectures previously exported constants that were used by
module_alloc(), why not stick with that?

> AFAICT, we don't have a global text_poke() API yet. I can take a look
> into it (if it makes sense).

Great

> Yeah, that's part of the goal to extend the scope from executable to all
> types.

Yeah it took me a bit to wrap my head around how this all makes sense -
it started out as just a better module_alloc(), then there was lots of
talk about hugepages.

I like it more now, looking forward to see how it fits together with
Mike's work :)

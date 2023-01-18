Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA0672B19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjARWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjARWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:10:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539B56309E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:10:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D516E61A30
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D299C433EF;
        Wed, 18 Jan 2023 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674079838;
        bh=ueXijbmlVWlIGrmmQBHyx5f7RsmjeluYmLaqFHXUtSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1wseDJaWiRCEW5j/92bmCxmg+D0Y02g3H9KMmX3ipF8BgSxn1AQewK+nrcIoqY/hh
         5YAyXeNk/IWkD35xe+vRqxqFX7GIGAmPFWE6vziQYexkLTD74qoj3ua3qDhGYrGtVv
         LUcyfTwMhC3vENTljiMSId6BwUXdifFzJvxaB168=
Date:   Wed, 18 Jan 2023 14:10:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Herton R. Krzesinski" <herton@redhat.com>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, jforbes@redhat.com,
        dzickus@redhat.com, scweaver@redhat.com
Subject: Re: [PATCH] tools/vm: allow users to provide additional
 cflags/ldflags
Message-Id: <20230118141037.3d5e6df707125353435bfbae@linux-foundation.org>
In-Reply-To: <Y8f4aUx7P45qHlpl@localhost.localdomain>
References: <20230116224921.4106324-1-herton@redhat.com>
        <20230117165326.3e693a12a45a1962ca0c40af@linux-foundation.org>
        <Y8f4aUx7P45qHlpl@localhost.localdomain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 10:47:21 -0300 "Herton R. Krzesinski" <herton@redhat.com> wrote:

> On Tue, Jan 17, 2023 at 04:53:26PM -0800, Andrew Morton wrote:
> > On Mon, 16 Jan 2023 19:49:21 -0300 "Herton R. Krzesinski" <herton@redhat.com> wrote:
> > 
> > > Right now there is no way to provide additional cflags/ldflags when
> > > building tools/vm binaries. And using eg. make CFLAGS=<options> will
> > > override the CFLAGS being set in the Makefile, making the build fail
> > > since it requires the include of the ../lib dir (for libapi).
> > > 
> > > This change then allows you to specify:
> > > CFLAGS=<options> LDFLAGS=<options> make V=1 -C tools/vm
> > > 
> > > And the options will be correctly appended as can be seen from the
> > > make output.
> > > 
> > > ...
> > >
> > > --- a/tools/vm/Makefile
> > > +++ b/tools/vm/Makefile
> > > @@ -8,8 +8,8 @@ TARGETS=page-types slabinfo page_owner_sort
> > >  LIB_DIR = ../lib/api
> > >  LIBS = $(LIB_DIR)/libapi.a
> > >  
> > > -CFLAGS = -Wall -Wextra -I../lib/
> > > -LDFLAGS = $(LIBS)
> > > +CFLAGS += -Wall -Wextra -I../lib/
> > > +LDFLAGS += $(LIBS)
> > >  
> > 
> > I think EXTRA_CFLAGS is more conventional?
> > 
> 
> I was looking and there is no standard under tools/
> 
> Some use it, some not. To given an example of what uses CFLAGS:
> tools/arch/x86/kcpuid/Makefile:override CFLAGS += -O2 -Wall -I../../../include
> tools/arch/x86/intel_sdsi/Makefile:override CFLAGS += -O2 -Wall
> tools/iio/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> tools/thermal/tmon/Makefile:override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
> tools/gpio/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> tools/pci/Makefile:CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> tools/spi/Makefile:CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> tools/wmi/Makefile:CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
> tools/io_uring/Makefile:CFLAGS += -Wall -Wextra -g -D_GNU_SOURCE
> tools/counter/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> 
> I can however use EXTRA_CFLAGS, not a problem, eg. doing instead:
> CFLAGS = -Wall -Wextra -I../lib/ $(EXTRA_CFLAGS)
> LDFLAGS = $(LIBS) $(EXTRA_LDFLAGS)
> 
> Let me know and I'll resend the patch using EXTRA_* instead.

Well drat, I was hoping you'd decide ;)

I'll grab it as-is, thanks.

(of course, we could always use both!)

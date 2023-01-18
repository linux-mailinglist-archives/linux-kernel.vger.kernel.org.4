Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB3671F17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjAROKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAROJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA64FC25
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674049648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EX/Tj/K8IZPZvmA1JVHcAukrm9j71qlU1wmRRs9hAGU=;
        b=Oiz49nBwd3BapkCgkCqm/WJXDM5cb2rt8iJWXV8BxXQHjtoHSBt0up0Or52rguK6g8ISJn
        WS88+MGNHchZR894jusbdRNb7HOkCVAr3PQCtVdfotVet/3Khs0tIA5BfL1QIRzp0kf+Oy
        zA6cVM/25lGS2WJF5GwoCY3Iy99+p7g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-SP44ch0FOlCNIFY0o2ZuYA-1; Wed, 18 Jan 2023 08:47:24 -0500
X-MC-Unique: SP44ch0FOlCNIFY0o2ZuYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51BE929AB44B;
        Wed, 18 Jan 2023 13:47:24 +0000 (UTC)
Received: from redhat.com (ovpn-116-89.gru2.redhat.com [10.97.116.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 904641121315;
        Wed, 18 Jan 2023 13:47:23 +0000 (UTC)
Date:   Wed, 18 Jan 2023 10:47:21 -0300
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, jforbes@redhat.com,
        dzickus@redhat.com, scweaver@redhat.com
Subject: Re: [PATCH] tools/vm: allow users to provide additional
 cflags/ldflags
Message-ID: <Y8f4aUx7P45qHlpl@localhost.localdomain>
References: <20230116224921.4106324-1-herton@redhat.com>
 <20230117165326.3e693a12a45a1962ca0c40af@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117165326.3e693a12a45a1962ca0c40af@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:53:26PM -0800, Andrew Morton wrote:
> On Mon, 16 Jan 2023 19:49:21 -0300 "Herton R. Krzesinski" <herton@redhat.com> wrote:
> 
> > Right now there is no way to provide additional cflags/ldflags when
> > building tools/vm binaries. And using eg. make CFLAGS=<options> will
> > override the CFLAGS being set in the Makefile, making the build fail
> > since it requires the include of the ../lib dir (for libapi).
> > 
> > This change then allows you to specify:
> > CFLAGS=<options> LDFLAGS=<options> make V=1 -C tools/vm
> > 
> > And the options will be correctly appended as can be seen from the
> > make output.
> > 
> > ...
> >
> > --- a/tools/vm/Makefile
> > +++ b/tools/vm/Makefile
> > @@ -8,8 +8,8 @@ TARGETS=page-types slabinfo page_owner_sort
> >  LIB_DIR = ../lib/api
> >  LIBS = $(LIB_DIR)/libapi.a
> >  
> > -CFLAGS = -Wall -Wextra -I../lib/
> > -LDFLAGS = $(LIBS)
> > +CFLAGS += -Wall -Wextra -I../lib/
> > +LDFLAGS += $(LIBS)
> >  
> 
> I think EXTRA_CFLAGS is more conventional?
> 

I was looking and there is no standard under tools/

Some use it, some not. To given an example of what uses CFLAGS:
tools/arch/x86/kcpuid/Makefile:override CFLAGS += -O2 -Wall -I../../../include
tools/arch/x86/intel_sdsi/Makefile:override CFLAGS += -O2 -Wall
tools/iio/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
tools/thermal/tmon/Makefile:override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
tools/gpio/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
tools/pci/Makefile:CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
tools/spi/Makefile:CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
tools/wmi/Makefile:CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
tools/io_uring/Makefile:CFLAGS += -Wall -Wextra -g -D_GNU_SOURCE
tools/counter/Makefile:override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

I can however use EXTRA_CFLAGS, not a problem, eg. doing instead:
CFLAGS = -Wall -Wextra -I../lib/ $(EXTRA_CFLAGS)
LDFLAGS = $(LIBS) $(EXTRA_LDFLAGS)

Let me know and I'll resend the patch using EXTRA_* instead.

-- 
[]'s
Herton


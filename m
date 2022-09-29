Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003D05F0194
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiI2X5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiI2X5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:57:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE688DB950
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:57:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b23so2159715iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aiDUyBH1ZRWoqYo/myx5Xqc1EMJMJyiJNQQ67922YM4=;
        b=NEkdGmgClQANPACHL/Pfae3t0/Pp2NW/DzYQbaBUXyqRjYttk30hVGqn/Wr6373Xc/
         m3yOyxh7QFDBVX/bGBaEcDSkYjA/qtQ+taF5sEHgwJZqmQ3SneEX1WsLeo6h+Ok1jPi2
         IUqmsUHL0ayKMtZf8GnG5l4JXD1nZ543+/8SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aiDUyBH1ZRWoqYo/myx5Xqc1EMJMJyiJNQQ67922YM4=;
        b=WHIeFZ4ffPe9N6PxBnngAftzGIqmoSgybMhqwJi3QAgUbdJ9BFvvHkcVq2xZPoybnQ
         XmorgdQZIL3UsWLczqqmt/+y5aRsS6TdnB6ktvmQ+wwPZVGcMfWVgPQxzKX86MZ4GDHJ
         oZK/9TsWCl5SYhM11lhLwmbK5/IodLu0xLJRkPqNZS2iNKhCJlUi7/vY67sj4S7zzbgw
         EFj+/UMimgE/3czBzcBi4/g8aMS6QNmv/0B7yo+1s5tvS0P/bk4CiBLdNRDmYXerKxJk
         HOu0fmsuYdf8jTU14CsvXGQ1Otg4QzG8jk2ClBfJJwINLtSyUb6nF2U5GfckcasICszJ
         rV+g==
X-Gm-Message-State: ACrzQf2XYocOpCmzphF7cENZykmcLZDoeXu9ramyaOsHvzr4oCuGVovz
        vfj7+D3AyBth1LnqSEYogqextQ==
X-Google-Smtp-Source: AMsMyM4Rb3tSTavy6HFIehL5hYhigKK/n1m6to4Nas985baqnRK9zT5764cO4bjtGq1huS7rUJzxgA==
X-Received: by 2002:a05:6638:3791:b0:35a:22c3:4cc9 with SMTP id w17-20020a056638379100b0035a22c34cc9mr3470937jal.114.1664495825229;
        Thu, 29 Sep 2022 16:57:05 -0700 (PDT)
Received: from chromium.org (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id c18-20020a056e020cd200b002f47787f44asm420937ilj.13.2022.09.29.16.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:57:04 -0700 (PDT)
Date:   Thu, 29 Sep 2022 17:57:03 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [RESEND PATCH v10] firmware: google: Implement cbmem in sysfs
 driver
Message-ID: <YzYwz8puWz+zcaF/@chromium.org>
References: <20220927205551.2017473-1-jrosenth@chromium.org>
 <YzPmKF6LRwXVua3X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPmKF6LRwXVua3X@kroah.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 at 08:14 +0200, Greg KH wrote:
> Why is this a RESEND?
> 
> I don't remember seeing any of the 10 previous versions, but hey, I
> can't remember much...

I sent the last 10 versions (including just v10) to the mailing lists
without including you.  Realizing I should include you, I resent.  Sorry
about that.

> Why is "coreboot" needed here?

I just did this for more heiarchy, and it's not necessary.  This is just
/sys/firmware/cbmem in the latest patchset.

> Will this work for all coreboot implementations?

Yes, CBMEM has existed in coreboot since 2009, so it'll work with any
non-antique version.

> Raw memory addresses?  Why?

Two reasons:

(1) It's useful information while debugging changes you've made to
coreboot (e.g., if you were adding a new data structure to cbmem).

(2) The "cbmem" command line tool exposes this information, and it would
be nice to entirely replace it's current /dev/mem interface with this
sysfs interface once it's widely available.

> Nothing is being "stored" here, it is being read.

Right, fixed in v11, thanks.

> Why doesn't mmap work?

Coreboot won't guarantee page alignment.  I updated this text in v11 to
mention that.

> What's the security implications of exposing all of this information?

Nothing really.  These are data structures from firmware such as the
nvram, boot log, flash layout, etc.  It's not something that would
contain secret information.

The biggest consideration is that we allow access to memory regions.
Since the coreboot table may be a CBMEM region itself, we just make sure
to copy the entry's size from the coreboot table before it's available
in sysfs so manipulation of the coreboot table won't allow arbitrary
memory access.

> Please use an attribute group so that this all happens automatically and
> you do not have to hand add and remove files.
> 
> That will make this logic much simpler and cleaner.

Thanks, v11 has it =)

> > +/* Corresponds to LB_TAG_CBMEM_ENTRY */
> > +struct lb_cbmem_entry {
> > +	u32 tag;
> > +	u32 size;
> > +
> > +	u64 address;
> > +	u32 entry_size;
> > +	u32 id;
> 
> As these cross the user/kernel boundry shouldn't they be __u32 and
> __u64?  Or is that not how coreboot works?

This data structure isn't exposed to user space in its raw format (we
give access to it via %x-encoded output from the sysfs files).

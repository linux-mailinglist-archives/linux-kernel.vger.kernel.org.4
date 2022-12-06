Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC78644D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLFUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLFUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:18:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC72837211
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TMwjK9EsMf2wtDKlLjpuqS+SXgC1WCzlDyNTz1y+Fc0=; b=a4OSv/EwBDYS+s7IxImt7+9qhR
        RMN4voFwPNwE1VQ0lOzHMyv9gHk/Yu7atJFiYbuEjTeUw8LhlT3RDNWsQa2GutcpqxydBQWth7cob
        79o8qCxAT3EwTdmb/BY73/f44ldBJDRdSdU6yTVVjo1P9SHk3jIc8Inbo1/JAbA3XusLmKZLdnKUR
        93CA4OXqFCC7aW+NXWYC5oNzNhLtu/ypMVUx69JNQdO04atkfY4E6VKCibFmAIqryXXygrFcIaIvs
        Dw5g2nSWXEEvk2xWvj5XCI0UtLIEF/H5JE3NNgQxBQod0LlJO/94GQGdExZzufjSJLZ2Z2WzvUwF1
        EBvhEtKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2eOy-004mOl-OS; Tue, 06 Dec 2022 20:18:52 +0000
Date:   Tue, 6 Dec 2022 20:18:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org>
 <Y49lxZMsKrXRciIg@kroah.com>
 <Y495XgCv+dhGA2Tg@casper.infradead.org>
 <Y4+OFzfAh7XqOoWv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+OFzfAh7XqOoWv@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:46:47PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 06, 2022 at 05:18:22PM +0000, Matthew Wilcox wrote:
> >  static inline struct external_name *external_name(struct dentry *dentry)
> >  {
> > -	return container_of(dentry->d_name.name, struct external_name, name[0]);
> > +	return container_of_not_const(dentry->d_name.name,
> > +				      struct external_name, name[0]);
> >  }
> 
> Will just:
> 	return container_of((unsigned char *)dentry->d_name.name, struct external_name, name[0]);
> work by casting away the "const" of the name?
> 
> Yeah it's ugly, I never considered the address of a const char * being
> used as a base to cast back from.  The vfs is fun :)

Yes, that also works.  This isn't particularly common in the VFS, it's
just the dcache.  And I understand why it's done like this; you don't
want rando filesystems modifying dentry names without also updating
the hash.

I feel like all the options here are kind of ugly.  Seeing casts in
the arguments to container_of should be a red flag!

Here's a bit of a weird option ...

+#define container_of_2(ptr, p_m, type, member)                         \
+       _Generic(ptr,                                                   \
+               const typeof(*(ptr)) *: (const type *)container_of(ptr->p_m, type, member), \
+               default: ((type *)container_of(ptr->p_m, type, member)))
+

 static inline struct external_name *external_name(struct dentry *dentry)
 {
-       return container_of(dentry->d_name.name, struct external_name, name[0]);
+       return container_of_2(dentry, d_name.name, struct external_name,
+                               name[0]);
 }

so we actually split the first argument into two -- the pointer which
isn't const, then the pointer member which might be const, but we don't
use it for the return result of container_of_2.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07DF5E6978
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiIVRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIVRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08C371AD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663867098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiSEFO+oBs7PFKlYaI+3DQcUZmNN5SuMUXjWPosGN3M=;
        b=IBueXbcEaISK/n0LVlJTk3ONaa0K2AZSecfxT6DLHDmBHTYWmLWX0QNZCT2/fprczx47+L
        L0c4HvNOevSUecedaPlCPcBBLW8L91wfm+uQKL7ZPlOTlXdjKf69v0qzUWQEl6UHW2ZQWT
        HuO+xdWLK6hQQLvGy6yqwfbLIM0IygM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-6AuJaag3M5OT3i-5z0GigA-1; Thu, 22 Sep 2022 13:18:15 -0400
X-MC-Unique: 6AuJaag3M5OT3i-5z0GigA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8A3F3C0E20E;
        Thu, 22 Sep 2022 17:18:14 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E0D5C15BA5;
        Thu, 22 Sep 2022 17:18:14 +0000 (UTC)
Date:   Thu, 22 Sep 2022 13:18:12 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <YyyY1LgHzQZpQkqM@lorien.usersys.redhat.com>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
 <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
 <20220922140504.GA58265@meh.true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922140504.GA58265@meh.true.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:05:04PM +0200 Petr Štetiar wrote:
> Phil Auld <pauld@redhat.com> [2022-09-22 09:18:47]:
> 
> Hi,
> 
> > I've seen the size cause problems for tools. Are we sure that it's the empty file and not
> > the size causing issues?  Maybe something is treating that as signed again for a count of
> > -1 bytes (which seems like it would be a bug anyway)?
> 
>   root@OpenWrt:/# strace cat /sys/devices/system/cpu/cpu1/topology/thread_siblings
>   ...snip...
>   openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
>   sendfile(1, 3, NULL, 16777216)          = 0
> 
>   root@OpenWrt:/# strace md5sum /sys/devices/system/cpu/cpu1/topology/thread_sibli
>   ...snip...
>   openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
>   read(3, "", 4096)                       = 0
> 
>   root@OpenWrt:/# strace head /sys/devices/system/cpu/cpu1/topology/thread_siblings
>   ...snip...
>   openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
>   read(3, "", 1024)                       = 0
>

I tried this with the latest upstream (which doesn't yet have the fix
for the size issue) and got the same results.

Then I applied the fix and the problem went away:

6.0.0-rc6.nr_cpus2+
# find /sys -name thread_siblings -exec cat \{\} \; 
2
1

Cheers,
Phil

> Cheers,
> 
> Petr
> 

-- 


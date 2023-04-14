Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF476E1CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNGgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0176F9B;
        Thu, 13 Apr 2023 23:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEC06445D;
        Fri, 14 Apr 2023 06:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DEFC433EF;
        Fri, 14 Apr 2023 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681454157;
        bh=+Yp7RZWfuDeZqFhwRrrTAzpa2PNfsGknk0RMVV2+zIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqnmZUG7Zox6U9sbFwAS1zMLed9wKPDZRUtXGdg2a24IJWiqmlO3aKqrvU8oYgfAd
         pdT3hmHcCPq1rH6MOidIq8tFOB1mYepA9j00Ascyd1Xt3K3nz5YNQcYRRJPst5N5vH
         puDsuKpLBUBrG4T4ZOeisfXrR9qmBdkZuO4HRtPA=
Date:   Fri, 14 Apr 2023 08:35:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC 2/2] kread: avoid duplicates
Message-ID: <ZDj0SVelrvh1xaEv@kroah.com>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414052840.1994456-3-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> With this we run into 0 wasted virtual memory bytes.

This changelog does not make any sense at all, sorry.  What are you
doing here and why?

> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/kernel_read_file.c | 150 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/module/main.c  |   6 +-
>  2 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 5d826274570c..209c56764442 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -4,6 +4,7 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/security.h>
>  #include <linux/vmalloc.h>
> +#include <linux/fdtable.h>
>  
>  /**
>   * kernel_read_file() - read file contents into a kernel buffer
> @@ -171,17 +172,166 @@ ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>  
> +DEFINE_MUTEX(kread_dup_mutex);

static?

I stopped reading here :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A8744501
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF3XFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3XFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:05:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4C12D60;
        Fri, 30 Jun 2023 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DtSZxw7+4s6UShYin9vBrjN/t0Voj99AVUvFJAAOEQg=; b=4Q/Qg6rZ+3w8f7fm5+6U2acLh1
        74nDEcRKAVFvcECGa8s7Uy4oOh4ZQyJn7U87AIzb9C/jwDQ+l89QwtHLuqVd1yE6p0JDhOAloQhDX
        wfDmnSy/N6NOnj7S76vOIHB3VSxDTQ8Go73vT9ozuT3s7hOShGslw5rOpZApBOrDikjJRLDxXEnVQ
        WY+NwyfOwvIajKLq3itECbaBCI/KTU2+UrXqMfTXGTKeCkkXAtfbsI6cRcj5BYv503O2wL4aFI5nY
        hM/R2OppsVjvqBAjiS4vvfkDRuG9ax4M8D41sq7UXsY7xVCD+gjAyAapTdhXPWuIvYCSVtzRUj1oh
        6AV8y2cQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qFNBF-004jS0-1J;
        Fri, 30 Jun 2023 23:05:33 +0000
Date:   Fri, 30 Jun 2023 16:05:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
References: <20230626123252.73dbc139@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626123252.73dbc139@endymion.delvare>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:32:52PM +0200, Jean Delvare wrote:
> If module_put() triggers a refcount error, include the culprit
> module name in the warning message, to easy further investigation of
> the issue.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/module/main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-6.3.orig/kernel/module/main.c
> +++ linux-6.3/kernel/module/main.c
> @@ -850,7 +850,9 @@ void module_put(struct module *module)
>  	if (module) {
>  		preempt_disable();
>  		ret = atomic_dec_if_positive(&module->refcnt);
> -		WARN_ON(ret < 0);	/* Failed to put refcount */
> +		WARN(ret < 0,
> +		     KERN_WARNING "Failed to put refcount for module %s\n",
> +		     module->name);
>  		trace_module_put(module, _RET_IP_);
>  		preempt_enable();
>  	}
> 

The mod struct ends up actually being allocated, we first read the ELF
passed by userspace and we end up allocating space for struct module
when reading the ELF section ".gnu.linkonce.this_module". We cache
the ELF section index in info->index.mod, we finally copy the module
into the allocated space with move_module().

In linux-next code this is much more clear now. 

What prevents us from racing to free the module and thus invalidating
the name?

For instance the system call to delete_module() could hammer and
so have tons of threads racing try_stop_module(), eventually one of
them could win and free_module() would kick in gear.

What prevents code from racing the free with a random module_put()
called by some other piece of code?

I realize this may implicate even the existing code seems racy.

  Luis

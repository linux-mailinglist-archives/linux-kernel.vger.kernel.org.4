Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7348740246
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF0Rfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjF0Rfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798A2D4E;
        Tue, 27 Jun 2023 10:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EFE4611E6;
        Tue, 27 Jun 2023 17:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50713C433C0;
        Tue, 27 Jun 2023 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687887334;
        bh=ncf+3DHJQ95GpM8t62nifU4EJo1rOC4FUIsqPbVo+zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAL9vSPkIAsAJNRAZzu7Lg5rusKu0UH5OSQ+F5hME4pfWRyRpHzAmxE5DzZ+MuVCe
         Uddt6SulAYdnGsnN2chlRQDORqOyfps2PpUvhmSPepMqp8NpM10326ig+KdzIkst2x
         /U5b1T16ftzJStR7mnxQ0LV1Zp/8xyys8k8wcCuI=
Date:   Tue, 27 Jun 2023 19:35:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     "yuxiaozh.zhang@gmail.com" <yuxiaozh.zhang@gmail.com>,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org,
        William Kennington <wak@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: support pmsg record size larger than kmalloc limitation
Message-ID: <2023062702-frosty-winking-9257@gregkh>
References: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
 <2023062715-eldercare-washed-3c29@gregkh>
 <CAOOoKeSxJzJEwX2aVsn_jcqK7gsgEVpB3VdhoKjJPCJgdNf9Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOoKeSxJzJEwX2aVsn_jcqK7gsgEVpB3VdhoKjJPCJgdNf9Mg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:05:04AM -0700, Yuxiao Zhang wrote:
>   kfree(record->priv);
>   kfree(record);
>   if (rc != -EEXIST || !quiet)
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66dbe5f39..296465b14fa9 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>  #include <linux/compiler.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/mm.h>
> 
>  #include "internal.h"
>  #include "ram_internal.h"
> @@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct
> pstore_record *record)
>   /* ECC correction notice */
>   record->ecc_notice_size = persistent_ram_ecc_string(prz, NULL, 0);
> 
> - record->buf = kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
> + record->buf = kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
>   if (record->buf == NULL) {
>   size = -ENOMEM;
>   goto out;

Please try emailing a patch to yourself and see if you can apply it
afterwards.  The kernel documentation has a section for how to handle
email clients, perhaps you should read it?

thanks,

greg k-h

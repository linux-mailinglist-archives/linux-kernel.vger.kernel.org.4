Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE4E616E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKBUFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:05:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45A325E5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 352F9B82469
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF43C433B5;
        Wed,  2 Nov 2022 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667419537;
        bh=xEV5xpbDuWSJh2LBaLO8ieVEq+GdSGwnx2U960MGeKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W63auvdtfqK0AB3MzIdoV6cdyUNN8RU+3vabwhIQA7SWaV8tHObr5D6IptqREl7nk
         VNPaG7iAVDPtoxZSLG3No2/2ArwFcBGsI3fvSIz8o3iDi+yfmpO7Vbcn2+lCwc8F37
         yrwP5T5TPGVDmXC5XHx/Ug7kjP97AF8Ll4Lq7Ssg=
Date:   Wed, 2 Nov 2022 13:05:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pankaj Gupta <pankaj.gupta@amd.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <thomas.lendacky@amd.com>
Subject: Re: [PATCH] mm/memremap.c: map FS_DAX device memory as decrypted
Message-Id: <20221102130536.96c487d341544b7482eed038@linux-foundation.org>
In-Reply-To: <20221102160728.3184016-1-pankaj.gupta@amd.com>
References: <20221102160728.3184016-1-pankaj.gupta@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 11:07:28 -0500 Pankaj Gupta <pankaj.gupta@amd.com> wrote:

> virtio_pmem use devm_memremap_pages() to map the device memory.
> By default this memory is mapped as encrypted with SEV. Guest
> reboot changes the current encryption key and guest no longer
> properly decrypts the FSDAX device meta data.
> 
> Mark the corresponding device memory region for FSDAX devices
> (mapped with memremap_pages) as decrypted to retain the persistent
> memory property.
> 
> ...
>
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -335,6 +335,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  			WARN(1, "File system DAX not supported\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> +		params.pgprot = pgprot_decrypted(params.pgprot);
>  		break;
>  	case MEMORY_DEVICE_GENERIC:
>  		break;

Should this be backported into earlier kernels?

Is b7b3c01b19159 a suitable Fixes: target?

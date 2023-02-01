Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465B685C82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBABCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBABCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:02:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD645887
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:01:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id pj3so2988329pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpBWoDp/3flZl8bPy43i9040zDcEsLFVYFfMuUc2+Es=;
        b=Kb9SK73S5T1u0sxTpP5FA4YPRwnBawwGTQQOZEo5Q6ShIX6BUDTe5C6pZ8HbEX/e5R
         lFk7DRZ4x3EuEWcediPIoTGVHRq3GEhMMSYLDvSD5ydDkTJZo9Eqz7i/P5IjgRibdOsc
         D25ed0YfFzYPYSVHjdsLvL0FUYp9h2hBB7Rcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpBWoDp/3flZl8bPy43i9040zDcEsLFVYFfMuUc2+Es=;
        b=nlyT/YzPTN2JKgh+TS/tbW+se1pDfX1xX5w+H70OfTNBHa9KugxgRmSH8NrHQqjkNn
         Ze3FwyP14w4RpSfZDkN0ynBSv9a4fUpQwWMH10qRK4+nc4WLFFuDD6KZ1MiHU0QWbozI
         XlkfmxInY/S5gB6sC5jCTo02f8dkK9He7cTuOujpOvSEk+rMnLDknOXCG0ngjgpZUbPI
         6YHzwUDtDbyht/uhfMniqD0XjdWOaZUjrHmIcLNG/VI0WCJWAcs86wllPdF6gVn9ukgw
         4X0uZMbkaFARVVxJFI5TqHLnY7EPhDbHgGms4h8vq0nCt59iK7pI3sSmBsQ+kyPXGGCz
         UeOg==
X-Gm-Message-State: AO0yUKUojOlW0MiUacuCeGz0urSNQ2lICsPNhVj8v9L30p9oWhRm9mrC
        K64aywQdbLOw06mKTPsFxj6ppg==
X-Google-Smtp-Source: AK7set+EpJZI8wxe7gBZSV5g7iNUu4Xv7xovIlQqaZFU/RH1CWjrTCKVYa7BL+XQ13E1jef0Ze20qg==
X-Received: by 2002:a05:6a20:1446:b0:be:93c7:4f69 with SMTP id a6-20020a056a20144600b000be93c74f69mr668274pzi.52.1675213317724;
        Tue, 31 Jan 2023 17:01:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b00189a50d2a3esm10380584plb.241.2023.01.31.17.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:01:57 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:01:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <202301271824.851168A@keescook>
References: <20230127223816.never.413-kees@kernel.org>
 <Y9RwpuVyEi2SBmdQ@ziepe.ca>
 <202301271655.A51DC1CF@keescook>
 <Y9R2u7VrJB7pkY26@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9R2u7VrJB7pkY26@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:13:31PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 27, 2023 at 04:57:26PM -0800, Kees Cook wrote:
> > On Fri, Jan 27, 2023 at 08:47:34PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> > > > While the op->size assignments are already bounds-checked at static
> > > > initializer time, these limits aren't aggregated and tracked when doing
> > > > later variable range checking under -Warray-bounds. Help the compiler
> > > > see that we know what we're talking about, and we'll never ask to
> > > > write more that sizeof(ucmd.cmd) bytes during the memset() inside
> > > > copy_struct_from_user(). Seen under GCC 13:
> > > > 
> > > > In function 'copy_struct_from_user',
> > > >     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> > > > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
> > > >    59 | #define __underlying_memset     __builtin_memset
> > > 
> > > This seems strange to me
> > > 
> > > I thought the way gcc handled this was if it knew the value must be in
> > > a certain range then it would check it
> > > 
> > > If it couldn't figure out any ranges it would not make a warning.
> > > 
> > > So why did it decide "rest" was in that really weird range?
> > 
> > It's because it got bounds-checked at the lower end (for the minimum
> > size test).
> 
> Where? There is no sizeof(ucmd.ubuffer) in this code.

memset() is internally doing that via __builtin_object_size(dst + size, 1).

> There are no statically computable constants at all.

I think it's some logic that excludes a range based on ucmd.user_size
internally to the additional checks in copy_struct_from_user().

Regardless, I think the correct fix should be with
copy_struct_from_user(), so please disregard this patch. :)

-- 
Kees Cook

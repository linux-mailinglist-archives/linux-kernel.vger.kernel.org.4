Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C567F39D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjA1BNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjA1BNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:13:49 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2273D2C661
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:13:34 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h24so5579450qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfyPzg1htA6VzdjdZzG5GcKQRyF+45Usw+FSqBgLOmE=;
        b=UwuBU7iViSp0Lw07MPAQZEV3PkDUIWEB26o7W1q1NmaCWdr4l99EkD+C+U9Qre/slM
         IwrIXhWo7qGuDv7W9g+iMK7b/GkhQK9pdinlYROx+yauYx5bmNm2lKMDuX9ZWArzhBlv
         lTGIYrkGaMpG+wzT3hsgelokPWPpK0iFkmBoCHgTtZpD7+MMQM/orENAG4usjYMp63LW
         Vi6m0UpA7aL9T50Gy+PVF8AfZe9zSJMxbK/0NynMeY6mgTYZYksCcG5/DEqrhh90JX+2
         B88UkJrbQwWSQV/qro2jHcrSh1lXulnJ1llYQViLmqGYyyDAVZY9yisg8I1kUe5NsIkp
         OXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfyPzg1htA6VzdjdZzG5GcKQRyF+45Usw+FSqBgLOmE=;
        b=kzsWy6/ZfzWWU0j5z3yIuIiWfoiMfcWaCDafngbxbjxKJe42lR6wtwU0IKF7zQyyxM
         6kXdVYFtcy4p3UEfoSXL56Ca7nQSAaMkXqcMOCqJCqZwrYg/NhIyQDs1xhuYVZQ2Ycof
         +jpXqlZ5ZvMXcgav1c6nxAuNGgcXl6bh1+RIUhflSwX3NdQ2U0N3GT8KkGTAktzm7J17
         fsWsxWUfeSH1hPQEjrNlQR1xxdmubObwzYDnHKNEMvUMrbezxQiwKI8KbvI4L9KLmE8o
         ooTkY7Z3OY9SYpkA7sDwuYbrH7ljCOBABYRki+R48gqV0LmckGn+hrBmgmRLIASakeAP
         0keg==
X-Gm-Message-State: AFqh2kpHDD63Bv4YhLGXjX4pykrZvvc9mNzF3Qf+DefVPbVBCwXM1/eZ
        wY1x9jIdAEtA+m5mpfx/M+p1dQ==
X-Google-Smtp-Source: AMrXdXuS7m9o1iHKfe2vBNIfFZru2ML5MnHi9xXszZi8wvHkrGG1etOfVLCmytEtYxwiLdpo8Xzpbw==
X-Received: by 2002:ac8:6b02:0:b0:3a9:2478:2d70 with SMTP id w2-20020ac86b02000000b003a924782d70mr57634285qts.24.1674868413254;
        Fri, 27 Jan 2023 17:13:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm3671183qtg.33.2023.01.27.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:13:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pLZmd-000StO-Ui;
        Fri, 27 Jan 2023 21:13:31 -0400
Date:   Fri, 27 Jan 2023 21:13:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <Y9R2u7VrJB7pkY26@ziepe.ca>
References: <20230127223816.never.413-kees@kernel.org>
 <Y9RwpuVyEi2SBmdQ@ziepe.ca>
 <202301271655.A51DC1CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301271655.A51DC1CF@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:57:26PM -0800, Kees Cook wrote:
> On Fri, Jan 27, 2023 at 08:47:34PM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> > > While the op->size assignments are already bounds-checked at static
> > > initializer time, these limits aren't aggregated and tracked when doing
> > > later variable range checking under -Warray-bounds. Help the compiler
> > > see that we know what we're talking about, and we'll never ask to
> > > write more that sizeof(ucmd.cmd) bytes during the memset() inside
> > > copy_struct_from_user(). Seen under GCC 13:
> > > 
> > > In function 'copy_struct_from_user',
> > >     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> > > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
> > >    59 | #define __underlying_memset     __builtin_memset
> > 
> > This seems strange to me
> > 
> > I thought the way gcc handled this was if it knew the value must be in
> > a certain range then it would check it
> > 
> > If it couldn't figure out any ranges it would not make a warning.
> > 
> > So why did it decide "rest" was in that really weird range?
> 
> It's because it got bounds-checked at the lower end (for the minimum
> size test).

Where? There is no sizeof(ucmd.ubuffer) in this code.

There are no statically computable constants at all.

The minimum size test loads from a struct:

	if (ucmd.user_size < op->min_size)
		return -EINVAL;

So, either gcc can't see through that and thus has no idea what the
bound check is

Or, gcc has figured out that struct iommufd_ioctl_op::min_size has a
finite set of values

If the latter, why doesn't it also know that iommufd_ioctl_op::size
has finite set too?

Combined with the weird report that the upper end of that range is -2
(not UINT_MAX), something very strange is going on inside gcc.

Jason

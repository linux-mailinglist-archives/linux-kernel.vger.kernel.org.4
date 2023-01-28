Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421A67F364
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjA1A5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjA1A53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:57:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED67C716
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:57:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m11so6234461pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt7riAo5IZBBNRUJXz8pkp6XLTWUB7DMintBQ4mnJ+w=;
        b=Sq13TwL2JvleGsf86UiBkqxxqQvlrn+9JqKhbgZya6YonVrMlwpl9H7V+w46KzX9gU
         XwtvFHc9MH103QXuWyqPeBIM+fap2Pn5mv1AVcStBkuR5SFqlWG7SO52BDCawpXKIqGC
         DC9qIjbacFWuEMHWWUq9xpWei55rvNP66T/eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt7riAo5IZBBNRUJXz8pkp6XLTWUB7DMintBQ4mnJ+w=;
        b=5RNuoOOWd7DOSZrYG/hMAobQ96ZwzdfCxZRi+ue0j4BX2zdzr7etQ61YL4O+Smumm3
         HNRoA+VCSwF6xey6CHVluhz5aq6VExQnsrZgwO0QbsZ0y52mUcblW3sELDfSan0p491r
         qSPFXeDbYd15pPVauyBhuudl88Wca8Phi6noDbJvr/2RqJA2+dPg/xrC9mK/WfepIlRo
         T9TSMZC0jvFUWjrE4OMiy3Y9PIYWoGps0N2WmzKIGiYIMR6/KMI0bwCzKuN5eqx0NhB7
         lgYdXtph/ZWBrblz1SrUt8Oc75oxLJrgaeoasakLBFXyT/nclJho4cyQ5t4v6t6siso2
         9diA==
X-Gm-Message-State: AFqh2kpYqbb9xJtVrldXqAhnOf0KXUKbI8V2ZNTTobblzxu1G/Pu8Ogc
        pTUikKtkzLs0Lelqe3h8jGwr0g==
X-Google-Smtp-Source: AMrXdXsGqzy4vwJ6nXgO7LJDjvy6Wk/X1EG3VvmKvq0e98qtLO69306EqidXqDBkwJxu6pgTQQeNrg==
X-Received: by 2002:a17:90b:3b87:b0:22b:afe2:2bb4 with SMTP id pc7-20020a17090b3b8700b0022bafe22bb4mr30492573pjb.8.1674867447456;
        Fri, 27 Jan 2023 16:57:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a6b4900b00228c8aa7916sm5553751pjl.38.2023.01.27.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:57:26 -0800 (PST)
Date:   Fri, 27 Jan 2023 16:57:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <202301271655.A51DC1CF@keescook>
References: <20230127223816.never.413-kees@kernel.org>
 <Y9RwpuVyEi2SBmdQ@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9RwpuVyEi2SBmdQ@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:47:34PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> > While the op->size assignments are already bounds-checked at static
> > initializer time, these limits aren't aggregated and tracked when doing
> > later variable range checking under -Warray-bounds. Help the compiler
> > see that we know what we're talking about, and we'll never ask to
> > write more that sizeof(ucmd.cmd) bytes during the memset() inside
> > copy_struct_from_user(). Seen under GCC 13:
> > 
> > In function 'copy_struct_from_user',
> >     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
> >    59 | #define __underlying_memset     __builtin_memset
> 
> This seems strange to me
> 
> I thought the way gcc handled this was if it knew the value must be in
> a certain range then it would check it
> 
> If it couldn't figure out any ranges it would not make a warning.
> 
> So why did it decide "rest" was in that really weird range?

It's because it got bounds-checked at the lower end (for the minimum
size test).

> 
> Is this just a compiler bug?

I don't think so. This just keeps the bounds within the buffer size now.

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233F67F345
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjA1Ark (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjA1Ari (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:47:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385A7D2AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:47:37 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o5so5551917qtr.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=NfU4J/gQoigubTQ+wI8tbZjlh1VQ6Sh8pVgcNDND8azysAP3ohXu76hvEuMeua8cPT
         +5skO7lpbqKQoPaNgf/d/koiIk3yzRO/sIHL4Oux6vJw/LSpiPvA9+9Fmmo9bDF7gU/S
         Z6nFB+d7YfMbDtSu1UiBnLFdNeF9eV74VK7luz8sM7s6kFR3bjucW2hwUwPNSrlKGcAY
         GbnGO2rSp7JioimHkLZIry/2g8E+uNcAYE9iX3ZBpbpF+0ZxV2NVDtUC/LTMC2/3NtEX
         06gi8pyEUdFS7xqGuqBovSwxQDdnHpZ/M2WPAktJdsE/b+7PUpI2JrMZvznL8SIgdwyM
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=JD2zG8cnLJ31SSmG6SCHT7/WIANAfROJFMPT224iT2bK6MiSUcY+Qty+tkvGYQI0u3
         hlxQ9x1Kq5SSupfMFnWvnXhz6x0/C0JS4CQl5DTpMrDWtMbp6NbwzY4UZqLPSyobCUuz
         MP4sTkslALddcTD5kxt+6kI+L8JagSIK/nOtYaHjdvIXg3wPeziMYTZMD9EjkmOD5Oec
         4RMuUZM06OtbAXoyCGzPXcq5SA2VxjOv0S57+COVGyKhdiqdf7LsbVFwQ0tEsCDIikhq
         zMaWGfhn6d66RyAPUrMaTfGp40czhkP7DA1zJv+nvbCjeKu/j9ERbzItKJKp81yLEz0t
         79Sg==
X-Gm-Message-State: AFqh2kqKon0ywu2BDacoDjVoR3DC+pZMLg55mXiPDc22hbj03dyW94/W
        WPwnS0z5zGL7PX0fJ6rllPTTzw==
X-Google-Smtp-Source: AMrXdXsUvUmJhsOS2hBs3r3WYshjPAj7VpqIhNt/slphm3NSivGdXET/Mduy+M/QnEHVnaDE6g/nsw==
X-Received: by 2002:a05:622a:1e1b:b0:3b5:87db:f950 with SMTP id br27-20020a05622a1e1b00b003b587dbf950mr57889488qtb.27.1674866856248;
        Fri, 27 Jan 2023 16:47:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id d10-20020ac800ca000000b003b0b903720esm3677194qtg.13.2023.01.27.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:47:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pLZNW-000SMV-II;
        Fri, 27 Jan 2023 20:47:34 -0400
Date:   Fri, 27 Jan 2023 20:47:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <Y9RwpuVyEi2SBmdQ@ziepe.ca>
References: <20230127223816.never.413-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223816.never.413-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> While the op->size assignments are already bounds-checked at static
> initializer time, these limits aren't aggregated and tracked when doing
> later variable range checking under -Warray-bounds. Help the compiler
> see that we know what we're talking about, and we'll never ask to
> write more that sizeof(ucmd.cmd) bytes during the memset() inside
> copy_struct_from_user(). Seen under GCC 13:
> 
> In function 'copy_struct_from_user',
>     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
>    59 | #define __underlying_memset     __builtin_memset

This seems strange to me

I thought the way gcc handled this was if it knew the value must be in
a certain range then it would check it

If it couldn't figure out any ranges it would not make a warning.

So why did it decide "rest" was in that really weird range?

Is this just a compiler bug?

Jason

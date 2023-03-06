Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C226ABAAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCFKFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:05:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0928EB6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:05:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so12618536pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678097106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZMN6CbP136S2WMVSasou4M9/SE+Pibn91kNnrQcbOM=;
        b=U3erHKYpOBTgDX4e3XbIqYXnFmJFz6j6t29Iqj5AlsLTwDL1sA6+LUYa7AMgDzn7OE
         4tgXb/V6FESJ2rR5XZP0VnXK0asCU79NsXKRyNnSPCYYPZszSUI4ACY+LMYJulMNFiyG
         RCOhKmyDrNl2CjE+z0+oKvlFu4qBRhMRipqABwM77ObUAwSqjkOQUI3Q8AQrMM9kytJu
         RtwYnjhng89joIlnoCwYx9BwdXcsMlPj+tcho77HUZziYYEW09IkgNrnz3u/LqP1ymIE
         CeQ1nTRo6d1+Fem46TA+7gkYubob5Auj4kG9yX2ObgG5X0XfRXaB7vRIvcECZjLyr7OR
         hgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZMN6CbP136S2WMVSasou4M9/SE+Pibn91kNnrQcbOM=;
        b=zD7Y6WQWnic9V6gVfUEmInU20Jf+EF4L8fg+JWyxJMYg9UZwwZOf9WIBZ9O/Xx1ZWx
         5RmU2QcJULBz8wZCoy7TiV6LzoAZo17QMHO1XOfoh5BWD5JCL0qEBMUWQgXnBUWA1L4z
         fO02DAaRT9yZn4OZ7G/63PHR20Jf8HPQvGx/kvij3f5jfjeKHhJyJ5sZ4KGM0+9lYEa+
         fznvgq4Ax+vzmPnLNBT+FS1D3py4d9MPvDwJDoQ4i6fYzeu+wgYfu0pv/hTRhPIxP8Eu
         bP7hDCnoDS23+oUjyTjPjl0b+ut30770JCvMNOCv7FTGz0f2C/mNi84vgOw7p+tc9pC1
         mzeg==
X-Gm-Message-State: AO0yUKUXTgkw/rtBeR64nCAADy3IaKtuEMIKvwYkWma4EysZ83VdCTup
        w/eG6unFJxZwPqRQavcDfxA=
X-Google-Smtp-Source: AK7set/NEtbw7EySARdGqsZEPY91ywSOdsomWYy9tiDixtv/jz6Rn/Dpt06GV+9FgWg2Iw3iwPrVUg==
X-Received: by 2002:a17:90b:4b89:b0:234:68d:b8ea with SMTP id lr9-20020a17090b4b8900b00234068db8eamr10773731pjb.39.1678097106111;
        Mon, 06 Mar 2023 02:05:06 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id lx3-20020a17090b4b0300b00233bc4edb77sm7571465pjb.25.2023.03.06.02.05.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Mar 2023 02:05:05 -0800 (PST)
Date:   Mon, 6 Mar 2023 18:11:23 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com
Subject: Re: [PATCH v5 0/2] erofs: set block size to the on-disk block size
Message-ID: <20230306181123.000012ac.zbestahu@gmail.com>
In-Reply-To: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
References: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Mar 2023 18:01:58 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> changes since v4:
> - patch 1: convert several remained call sites of sb->s_blocksize_bits
>   to erofs_blknr() and erofs_pos() (Yue Hu)
> - patch 2: revise comment for blkszbits and dirblkbits (Yue Hu)
> 
> changes since v3:
> - patch 1: remove redundant newline when printing messages (Gao Xiang)
> - patch 2: introduce dirblkbits in on-disk superblock and disable this
>   feature for now, so that the current kernel won't break with the image
>   with this feature enabled later (Gao Xiang)
> 
> 
> v1: https://lore.kernel.org/all/20230216094745.47868-1-jefflexu@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20230217055016.71462-2-jefflexu@linux.alibaba.com/
> v3: https://lore.kernel.org/all/20230220025046.103777-1-jefflexu@linux.alibaba.com/
> v4: https://lore.kernel.org/all/20230302143915.111739-1-jefflexu@linux.alibaba.com/
> 
> 
> 
> Jingbo Xu (2):
>   erofs: avoid hardcoded blocksize for subpage block support
>   erofs: set block size to the on-disk block size
> 
>  fs/erofs/data.c              | 50 ++++++++++++++------------
>  fs/erofs/decompressor.c      |  6 ++--
>  fs/erofs/decompressor_lzma.c |  4 +--
>  fs/erofs/dir.c               | 22 ++++++------
>  fs/erofs/erofs_fs.h          |  5 +--
>  fs/erofs/fscache.c           |  5 +--
>  fs/erofs/inode.c             | 23 ++++++------
>  fs/erofs/internal.h          | 29 +++++----------
>  fs/erofs/namei.c             | 14 ++++----
>  fs/erofs/super.c             | 70 ++++++++++++++++++++++--------------
>  fs/erofs/xattr.c             | 40 ++++++++++-----------
>  fs/erofs/xattr.h             | 10 +++---
>  fs/erofs/zdata.c             | 18 +++++-----
>  fs/erofs/zmap.c              | 29 +++++++--------
>  include/trace/events/erofs.h |  4 +--
>  15 files changed, 170 insertions(+), 159 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>

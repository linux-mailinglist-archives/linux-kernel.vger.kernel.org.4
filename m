Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3E6CB468
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjC1C6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC1C6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:58:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637CE2715
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:58:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so9578509pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679972293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLyr4+am2V6lTxnJ8lU/XXtylgWPWBoWpTubGjemSVQ=;
        b=kmDKU3gH92RhdilP0wGx1LLk9gbqJfyl3gqvqUqlbrmn20ntkJNvBrQGFm6f4lBZYg
         cM9JO2XR2Geh7dy2LXv0AAuie7zc9tegJ1y9sDZf69TvmRqw6z3b2xLcgf1yZ1WdoWmT
         nYTNQVjIiSwPQCDP+UOj/Rl33mUVo9VJFIvXl1DnWt5WZdjDcecayQrnpdkWDTB98EHw
         7ReeVUrj0Ih2stNsmEU0h9e5LslOc2jCuCRCVA1mnBuSk4XHigKIOBsqyxcgNGrff4U2
         UCSoTt5fr1i74hcrVfjvVCww8u6KQGYrueDnomWZhk+jwy5TqbQ0ifKTahln9k0gjfrg
         ssAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLyr4+am2V6lTxnJ8lU/XXtylgWPWBoWpTubGjemSVQ=;
        b=kIj2hjbZLaWnBnUDK3jPVF/hVKaZTTE+/QU0+ES0az+8QdcXS6GQENxF/F7kC5LS44
         1shHHkm5dmGkhZv/GguwQ4dckhbfr76IO6ONEpf0xIR5WDkuw7VZc0AdLPPJoZhlwYHE
         X7KAZJ2CnyyeIeuvoDYr1vf33X/Ky8nwJZ2kp2elv1kcd8Ubrhnw5NJwyaA5VBem2IMU
         KrUPjNdNRf/Qa19xYr00uc9Z1Vs3tiXwU1LpoM52BcT3NM4CLgkeV/X/iExJBYzgx5+l
         8W2BvezNNhIfT6u5xffl74lxrG9p4hyNI5YY1mY4d1IMm72xmN6NKLjDVvvsutFQa5NY
         LsrQ==
X-Gm-Message-State: AAQBX9e4mDuoro3wnLKdZEW64eihml7ye5/GRRbs7T8x2/ifsXP1YoPD
        jCLkiNQZsuDGYeWkh7mdNjARyA==
X-Google-Smtp-Source: AKy350boePZL/k+e/5zgAUJHntZnkIfcpGxyEqAU4SoJTANNN1+CWs53DamuoB1Xse9ssD99/kivLA==
X-Received: by 2002:a17:902:d2ce:b0:19c:e664:5e64 with SMTP id n14-20020a170902d2ce00b0019ce6645e64mr18220668plc.2.1679972292889;
        Mon, 27 Mar 2023 19:58:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b0019ee0ad15b4sm19719243plb.191.2023.03.27.19.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:58:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pgzXF-00E0yH-R0; Tue, 28 Mar 2023 13:58:09 +1100
Date:   Tue, 28 Mar 2023 13:58:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yebin (H)" <yebin10@huawei.com>, Ye Bin <yebin@huaweicloud.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <20230328025809.GC3223426@dread.disaster.area>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
 <20230327151524.GC16180@frogsfrogsfrogs>
 <64224406.5090106@huawei.com>
 <20230328014328.GG16180@frogsfrogsfrogs>
 <ZCJHSsqk4SJEDOTC@infradead.org>
 <20230328020341.GH16180@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328020341.GH16180@frogsfrogsfrogs>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:03:41PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 27, 2023 at 06:47:54PM -0700, Christoph Hellwig wrote:
> > On Mon, Mar 27, 2023 at 06:43:28PM -0700, Darrick J. Wong wrote:
> > > <shrug> Seeing as the data fork mappings can change the instant the
> > > ILOCK drops, I'm not /that/ worried about users seeing a delalloc
> > > mapping even if the user requested a flush.  The results are already
> > > obsolete when they get to userspace, unless the application software has
> > > found another means to lock out access to the file.
> > 
> > That is true, but then again the users asked to not see delalloc
> > mappings, so we really shouldn't report one, right?
> 
> Yeah, I suppose so.  I wonder how many programs there are out there that
> don't pass in BMV_IF_DELALLOC /and/ can't handle that?  But I suppose
> taking MMAP_EXCL is good enough to shut up the obvious assertion vector.

Why not just skip it? Take the flush completion as being a
point-in-time snapshot where there are no delalloc extents, and if
any new ones have been created racily, just skip them as being
"after" the flush and so don't get reported...

> The COW implementation probably ought to be doing the flush too.

Yup, and then just skip any delalloc extents found after that, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

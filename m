Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122006FC030
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjEIHLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjEIHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:10:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69172AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:10:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so5252592a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683616256; x=1686208256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD3vC44u/JrX7UZU0G86FxBlR+SBjPWE0ROlIx+IJIE=;
        b=FLHiOAoe0smn7K67HbKp6fRUgNgCB30KutCREjN24an2Kp06DnitpwwBBCQHFRpEgW
         fSl/XBWjgAjYlm46nnvSn1FGoTk1Fe5oJOmBb0NNdfGwPcWbU/w8IPxBJshYO4X78KKb
         vdGhRDApbyvBRJGD3/ssL/39jjFwC6ge0Wzi6CJKgBsIBYDVCHEpUXrqHQrB5MJ0iJoE
         1ztodMxlTcFZ3/I3OJujfKI40F/D4XfWbxQLsb78nYpYU4AheiYq+6QpT0AvpBJvEe6A
         zSL/XRZRUlrfedKUW6YH9CH/45wIVj43pq2fH4TQIq1ATCdHxldkH4Q04O4Gchw9wa0y
         6xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683616256; x=1686208256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD3vC44u/JrX7UZU0G86FxBlR+SBjPWE0ROlIx+IJIE=;
        b=TLySrpjojIGMT5eNRjszYap8vIJim59GSN32+S8THPmuenb+F2RiTvLVdQLTNlPdu2
         9qMpsvPJ3Q2M9mjPol0AaIR7sxIHVnTP1y3yqD7rZifJvibe++3gMBK4DNrhaiPTbo0r
         QowEea+GHTh0FqKi4ZAjotFkkYYfUQE9yga0wLHTPyv2WsbffDvbdKCClXi4M/hbmw2m
         V02dWtUx5kqcJwjW4JQk6DmJl09SSxTLcuNy/hy25r/mzaSKFTXUCxufkSQOxJPEGTyZ
         MAl+SGdZ35X6Byu/nX53dSFwxJBZh3+IBvU6oBx4N8TdZnVcrkth+W1zzYaXyyXrMxft
         fNaw==
X-Gm-Message-State: AC+VfDzDrfBrpjOXhWUF1QEo3spKQZ7f9vGl9QsHKke5IHpStr+869cx
        9T0Px+CsxlQjPfGmyKx5pWsFNQ==
X-Google-Smtp-Source: ACHHUZ5LPq6vbiUiGn8QucrxfCUTAIA2DuQwFde7Y5Ilh0P5usC+N7y1yI4KbGRdKXEjFLumzQfXTg==
X-Received: by 2002:a17:90b:1296:b0:24e:596:624f with SMTP id fw22-20020a17090b129600b0024e0596624fmr13309175pjb.22.1683616256482;
        Tue, 09 May 2023 00:10:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090ac91800b0024df90a4c58sm11023412pjt.36.2023.05.09.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:10:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pwHUr-00D8HE-7l; Tue, 09 May 2023 17:10:53 +1000
Date:   Tue, 9 May 2023 17:10:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [xfs]  2edf06a50f:  fsmark.files_per_sec -5.7%
 regression
Message-ID: <20230509071053.GE2651828@dread.disaster.area>
References: <202305090905.aff4e0e6-oliver.sang@intel.com>
 <20230509065433.GT3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509065433.GT3223426@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 04:54:33PM +1000, Dave Chinner wrote:
> On Tue, May 09, 2023 at 10:13:19AM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -5.7% regression of fsmark.files_per_sec on:
> > 
> > 
> > commit: 2edf06a50f5bbe664283f3c55c480fc013221d70 ("xfs: factor xfs_alloc_vextent_this_ag() for  _iterate_ags()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> This is just a refactoring patch and doesn't change any logic.
> Hence I'm sceptical that it actually resulted in a performance
> regression. Indeed, the profile indicates a significant change of
> behaviour in the allocator and I can't see how the commit above
> would cause anything like that.
> 
> Was this a result of a bisect? If so, what were the original kernel
> versions where the regression was detected?

Oh, CONFIG_XFS_DEBUG=y, which means:

static int
xfs_alloc_ag_vextent_lastblock(
        struct xfs_alloc_arg    *args,
        struct xfs_alloc_cur    *acur,
        xfs_agblock_t           *bno,
        xfs_extlen_t            *len,
        bool                    *allocated)
{
        int                     error;
        int                     i;

#ifdef DEBUG
        /* Randomly don't execute the first algorithm. */
        if (get_random_u32_below(2))
                return 0;
#endif

We randomly chose a near block allocation strategy to use to improve
code coverage, not the optimal one for IO performance. Hence the CPU
usage and allocation patterns that impact IO performance are simply
not predictable or reproducable from run to run. So, yeah, trying to
bisect a minor difference in performance as a result of this
randomness will not be reliable....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

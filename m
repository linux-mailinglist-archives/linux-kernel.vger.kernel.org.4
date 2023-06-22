Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F6739E74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFVKV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFVKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:21:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF0129
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:20:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b44b5adfd3so5402752a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687429254; x=1690021254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2qD8QXeW1O1s2cMX0TkIRyFuX9czqXlwvZZFZHoQDY=;
        b=yqVQLcwzGNpgScZWKwZ2oxMUR1L394NPzJZ9pS8bQoNaFmQPpbx/RADmMjKSptUuJt
         dMAKIwucw9mb+b39kaa6uMxwGHYIi8sMdClIWV4319i9APynEn+EAQVzDlX8M8t4g4zJ
         /RYbpIi4bIiOLjQrZiMx6fnOH7zpcNtfqTZHvpqog4MCq9+iRuN7/ch1M7zWK84XaU7s
         rw6pXihH1kCaDeawfmT79p2raM7v8ADLStFRVHst9kaKjrLAU87mLCp9BI8d/qPwWr4k
         zWHSVk36IH/y/UHsUmv+o3crPzwixco9ARo6bnIx4zUN+rm8gi2CnLMT87TNrNhOcrA0
         IoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687429254; x=1690021254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2qD8QXeW1O1s2cMX0TkIRyFuX9czqXlwvZZFZHoQDY=;
        b=b/sjycLc5NZI7h1SnWTXE6ab/+KWmVZyBDFzhynLq7h9vYXhCXmOffRRhU4/VD1bx/
         XriLHS6IEJa0ao4wU/1Z1vn7XWkvzoAphds++LXn1ngFL0gASSDL8sV+mnQNYFCrmABT
         qGPEtkjTg/gTGpe99ry1SLQ+wjTEXAOfDh1Dt3vNGbso+kKCMEngpi6mENL8aYxY8AGY
         rpJS82Vz2PS8l6gzayNcSkLaFdEJoppAZbD7xecHwirATToxioybW/GrQ/FI1ywIW4eZ
         6mWQEvaDnRfL5jbOBIrA76Pej+KQGzAGJO6w+RBlM+HBwtCCAsTx7eVdjOT2+84ybCMf
         V42w==
X-Gm-Message-State: AC+VfDxP1JsQbBk6sOpVp+yx5qoL/K8IGwr3jbXlMo6vgxw692UOEIqb
        OlERgnS7uR72+x/2nxB+i+72wQ==
X-Google-Smtp-Source: ACHHUZ7JbXlk1XHbh8Wgd/RM+ZqC1mNu0PVTcfaGw8H4IWQRxyldxnTIxSbk3oCd5H7E5JmFF6GYfw==
X-Received: by 2002:a05:6358:f0e:b0:12b:ed05:18bb with SMTP id b14-20020a0563580f0e00b0012bed0518bbmr12781423rwj.27.1687429254013;
        Thu, 22 Jun 2023 03:20:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id o2-20020a63e342000000b0053fb37fb626sm4594800pgj.43.2023.06.22.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:20:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCHQo-00EoCh-0Y;
        Thu, 22 Jun 2023 20:20:50 +1000
Date:   Thu, 22 Jun 2023 20:20:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] minimum folio order support in filemap
Message-ID: <ZJQggr3ymd7eXgA4@dread.disaster.area>
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
 <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
 <ZJN0pvgA2TqOQ9BC@dread.disaster.area>
 <4270b5c7-04b4-28e0-6181-ef98d1f5130c@suse.de>
 <94d9e935-c8a4-896a-13ac-263831a78dd5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d9e935-c8a4-896a-13ac-263831a78dd5@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:50:06AM +0200, Hannes Reinecke wrote:
> On 6/22/23 07:51, Hannes Reinecke wrote:
> > On 6/22/23 00:07, Dave Chinner wrote:
> > > On Wed, Jun 21, 2023 at 11:00:24AM +0200, Hannes Reinecke wrote:
> > > > On 6/21/23 10:38, Pankaj Raghav wrote:
> > > > Hmm. Most unfortunate; I've just finished my own patchset
> > > > (duplicating much
> > > > of this work) to get 'brd' running with large folios.
> > > > And it even works this time, 'fsx' from the xfstest suite runs
> > > > happily on
> > > > that.
> > > 
> > > So you've converted a filesystem to use bs > ps, too? Or is the
> > > filesystem that fsx is running on just using normal 4kB block size?
> > > If the latter, then fsx is not actually testing the large folio page
> > > cache support, it's mostly just doing 4kB aligned IO to brd....
> > > 
> > I have been running fsx on an xfs with bs=16k, and it worked like a charm.
> > I'll try to run the xfstest suite once I'm finished with merging
> > Pankajs patches into my patchset.
> > Well, would've been too easy.
> 'fsx' bails out at test 27 (collapse), with:
> 
> XFS (ram0): Corruption detected. Unmount and run xfs_repair
> XFS (ram0): Internal error isnullstartblock(got.br_startblock) at line 5787
> of file fs/xfs/libxfs/xfs_bmap.c.  Caller
> xfs_bmap_collapse_extents+0x2d9/0x320 [xfs]
> 
> Guess some more work needs to be done here.

Yup, start by trying to get the fstests that run fsx through cleanly
first. That'll get you through the first 100,000 or so test ops
in a few different run configs. Those canned tests are:

tests/generic/075
tests/generic/112
tests/generic/127
tests/generic/231
tests/generic/455
tests/generic/457

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

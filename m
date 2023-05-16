Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8970421C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjEPAMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjEPAMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:12:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937259EE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:12:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52079a12451so9671467a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684195960; x=1686787960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhZD+S4Cl7e+VqOfVQosoh3FjffnZ5bTRB87Tzv8qdU=;
        b=zn+7XHf0UfKbo+MZSwEWLY2d5Ln07rhjDzklMt41Dqt6OFD2UZhAebLLFMrFG9JOBD
         XTYKe272lsz3LGz4eO8dnfEOobiK7kN+4/HR+KteXaqLb0CFVUSN+HKqmzkIojpOxTmh
         t3XN9IF28kEr9H02qN/g9Vq9Iji9x7elsY8hYj4tsP/kFROa95VmIycVSDXojfQZwccB
         K31Nywb3kpyHRjxFucGfdKGdT40tn9F0+7T+xlo4aVzYUOMo6l1jYwKPC2DGhbvFbFaY
         QdDMRMRtAGy4DyJTMCWK7oXeBT2I+9eb42AgVK/rqjT//CYrrBvFwWwUi2mrC/7DCCSy
         4B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195960; x=1686787960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhZD+S4Cl7e+VqOfVQosoh3FjffnZ5bTRB87Tzv8qdU=;
        b=PYQKUBtivxXr2HUZ2pMCHgikr6IsrAP6coHaKzwvyM9DICjQJlPL9ovEKnl5z7/JYx
         iy3u2UtpfwjiUZrQ8RmmWtU56QeK2lbvobEmwr0EILYg0cOdyFjdYg424Pk6ZekuZXuC
         NDkrKmeqUAYHiXTJzUrBTTlwGUZJ/i4M0QGZ/oGZCFJ3NpKOiMEw87+FcPXNPTBhYFrM
         KPZAQHa+LM+VMUaiGRwzHHZTdegEAUgeDynFiLwU5YSm953fqyX45uPO+8f3UH3IYfjl
         1bIoXpgLiGuxU8A98o9wJtD9j9mDocwXEyYu2p9H6HHIUDPcXnC+LZ16Wcas4pBei4//
         wmZQ==
X-Gm-Message-State: AC+VfDwXrIknWUxOB3nk0XNUzFwbkPlr0GSllwKxsuyTnH4s+pxdC3hj
        BG9lL4fv5v/LaktHZIwX9Rtk5q8sfe/ZMHUAuvI=
X-Google-Smtp-Source: ACHHUZ4jVwGfnJLycZMDeAaSoLv7/12mwkfW24mdvkw5GcuFYob9C0AWNVqa/wAvIB55HuNgURYT+g==
X-Received: by 2002:a05:6a20:938d:b0:105:b4e:ed71 with SMTP id x13-20020a056a20938d00b001050b4eed71mr12275557pzh.32.1684195959875;
        Mon, 15 May 2023 17:12:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id w10-20020a65534a000000b005307501cfe4sm8062102pgr.44.2023.05.15.17.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 17:12:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pyiIu-00FmDJ-B8; Tue, 16 May 2023 10:12:36 +1000
Date:   Tue, 16 May 2023 10:12:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <20230516001236.GJ2651828@dread.disaster.area>
References: <20230511151702.14704-1-tycho@tycho.pizza>
 <20230512000724.GH858799@frogsfrogsfrogs>
 <ZF5X/8RQSzGMn3aZ@tycho.pizza>
 <20230512225414.GE3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512225414.GE3223426@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 08:54:14AM +1000, Dave Chinner wrote:
> On Fri, May 12, 2023 at 09:15:11AM -0600, Tycho Andersen wrote:
> I also recently found evidence of another AGI -> inode buffer -> AGF
> -> inode buffer deadlock issue debugging another hang from a machine
> making heavy use of O_TMPFILEs via OVL.  Without a kernel code to
> examine in intricate detail, I can't say if this is what you are
> seeing.
> 
> I also don't have a fix for that yet because, well, it's complex and
> I can really only accomodate one complex high priority bug at a time
> in my head and it hasn't been my highiest priority. As it is, I
> don't think the fix for it will be trivially backportable to 5.15,
> either....

Just FYI: Having paged this back into my brain looking at this
issue, it occurred to me yesterday that there is a relatively simple
fix for this issue: using ->iop_precommit() to move adding the inode
to the inode cluster buffer from xfs_trans_log_inode() to inside
xfs_trans_commit(). This ensures the inode cluster buffers don't get
locked until xfs_trans_commit() is called, as we already do with the
xfs_iunlink_item processing for unlinked list operations.

I've just written the patch to do this, but it also isn't a 5.15
backport candidate because the infrastructure and xfs_iunlink_item
processing wasn't introduced until 5.19....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

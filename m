Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218766FFEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjELCA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbjELCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:00:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD19EFA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:00:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b33c72686so6295777a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683856813; x=1686448813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xELGEY8IXSpWeQUKKMdARzXY/pecI/5/unvVeZAhPpw=;
        b=Mwo/QneMyQCAN6dEpHelsLRnaGULbpgN6A0o8TiIDfzGK42DO0VWfkDBLMGf1zIPKy
         0B94AjlQYFQtysGcl2/O19xG4b1j4MOzDk0U7VEHxTSiRWfGTaoDPz/fs4eO2DfJTInU
         5c2OH5LpDscjbPEn3/9DkAbcwi9KmIv0dFKRluw1afzYpzf3+kifkphcIxQ/oWHJluw0
         Lmdr6h+GEeJpiZQkXFwmyqzaNLcjUendjx2Kp1AZTfZME1sy+TSySB2IyIpN29nHw8vK
         hKKRqN/XDQMTPV9GoZDR46f/J114BVBDklufBFsWcDoQqs6VzdX6QHMDKm5cstlTTCMw
         d8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683856813; x=1686448813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xELGEY8IXSpWeQUKKMdARzXY/pecI/5/unvVeZAhPpw=;
        b=O+p9nZppoLOwLcMIfgKRLXXDyo3VG4kVuubsTfLe0PM90Qht+SJ9Vb3nNnU1z44nSE
         lSMEVknsg5WaSQYZ3HOkBohxnEVF1iBGUQeMEDOcg1KmJA2dGmqvGGvm6t/VuRNqVPCZ
         7BEw3O0dKz78T64/wyy6QLmpvC7UmRu+7LpP3lgnExQXhiaorzYGEMPVvYj5wTUKpOLY
         MBVnqxUyi9AyJsGy2vPRDaIZ17uvgPoLTWjL9RYnIIQuW76Es9xQXVQnoz1JhqcJaSN1
         V7k/YgJBVX6modkqPFPuSFCiKQ0qNbxvxwMJ0EJHzptPR8ADv3iL/XxWoGuGOCcoD0VX
         1rbA==
X-Gm-Message-State: AC+VfDwlUIfTkbz2U5u/N6ER9UH5nJlD2pXVGgZJ24o6mp4cuaGinKc5
        PynNbmCqIHFogDVZL0KGA+AbpA==
X-Google-Smtp-Source: ACHHUZ7+jymGxpxEEaGBYQaGd5TvZmCv5F0x1Krs2vrUaGzjrhBmhm6WegLxgC3GvqwlN4zVCPZUlg==
X-Received: by 2002:a17:903:185:b0:1aa:db0f:1aba with SMTP id z5-20020a170903018500b001aadb0f1abamr28693543plg.47.1683856813072;
        Thu, 11 May 2023 19:00:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001ac896ff65fsm6585831pll.129.2023.05.11.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 19:00:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pxI4n-00EEZE-QV; Fri, 12 May 2023 12:00:09 +1000
Date:   Fri, 12 May 2023 12:00:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     renlei1@chinatelecom.cn, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: xfs_nfs_get_inode support zero generation
Message-ID: <20230512020009.GB3223426@dread.disaster.area>
References: <1683800241-14488-1-git-send-email-renlei1@chinatelecom.cn>
 <20230511232206.GG858799@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511232206.GG858799@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:22:06PM -0700, Darrick J. Wong wrote:
> On Thu, May 11, 2023 at 06:17:21PM +0800, renlei1@chinatelecom.cn wrote:
> > From: Ren Lei <renlei1@chinatelecom.cn>
> > 
> > If generation is zero, bypass the verification of generation number
> > to avoid stale file error. (Be consistent with other fs, such as
> > ext4, fat, jfs, etc.)
> 
> What code is affected by the gen==0 handles being rejected?  Is there a
> user program or test case where this is required?

A generation number of 0 is perfectly valid in XFS. We've been
creating them in XFS filesystems since 1993 and never had a problem
with filehandle verification. Indeed, every root inode in every XFS
filesystem ever made will have a generation number of 0.

Yup, a random XFS filesystem recently made from a current xfsprogs:

# xfs_db /dev/vdc
xfs_db> sb 0
xfs_db> a rootino
xfs_db> p core.gen
core.gen = 0
xfs_db> 

-Dave.
-- 
Dave Chinner
david@fromorbit.com

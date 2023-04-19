Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A996E8534
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjDSWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDSWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:48:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518C1701
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:48:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso351862276.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681944513; x=1684536513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZrPULhZIKJV34C2bhX8PcgMIHgEG0C+dg13xBQhh0w=;
        b=F7GBcIivSB+Wmf1Z3p+w8J2Hxy7qQC9L7nY8DL7VWPSIqtwXlT7rQ6MXwmgVnYlL5f
         14pS4WOOw+pNUXRuJquc9qeBx+2OWkWTDKtjmqazGEEOO+qP3GqDj9zs+eDm6BBEovQB
         GV/lhy0lCWiCr8uS+leAHiHC8/UV5CSx85lJjrcD41rjgjh+8UymqtYI58nq9rN7pIhK
         6VPG1Q+FNT5/92jZjwfcg+uSRYozJWDlWIZPfIcfIdfbleWzElHTYbO6L024eP+Ea7WQ
         1f3htZG5zLtvdcvSGCEfqWToaG7t2fAScHdNORg8bPhOkYmiUF81lwpyAf/7X6YVJP3s
         s7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944513; x=1684536513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZrPULhZIKJV34C2bhX8PcgMIHgEG0C+dg13xBQhh0w=;
        b=OdSfHm+AiJDsD0do9T0EJM3aeTlNuNDiz9YxDQ95QvL4gtHXDDgyZ7xc2k7v2HDXZ5
         XIJHjr27Z+XrDU5hVmIMSS3ZIEjMMiM0g4819Hm/YfJw4KtrA+sa2Iy7UvypFD0noV+t
         pJExoZsdFtQzBDgAyLh/DDYG0KLEgYvF3j6lqQIcLsz4BIw8NvlqtbHPIDLjyEBBxQ9t
         LQKj6LZbdyEPoxj+okoJTIcNFUtSX9diB7VMQhkltQANPtbwteo9/76fpZoemta1mL8P
         s10fY8uoNl/SH05ElM+V5RKcTDdN4jwLW8PaBGaWvihY5O6VPvZLIebMCWyuJGmjbIEf
         WA1A==
X-Gm-Message-State: AAQBX9dIODjaNATYTRZUHDVMx/grqfeN1xFQJG5j4nRXLIzFldbLbbSe
        ARQVUDcnj023fwHL/gVshYWIcksGiMCuU6Yo1Wc=
X-Google-Smtp-Source: AKy350Yn+z+rdiDG8ySW4WCMw+0zQ/ws73YT2f1f1XxWKOrSMbU2byidZa3yVOwPBeUzkNz7+7uMJA==
X-Received: by 2002:a17:902:654a:b0:1a8:1c9a:f68 with SMTP id d10-20020a170902654a00b001a81c9a0f68mr3322962pln.36.1681942790785;
        Wed, 19 Apr 2023 15:19:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001a4ee6ec809sm11964287plb.46.2023.04.19.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ppG9T-005QFi-2w; Thu, 20 Apr 2023 08:19:47 +1000
Date:   Thu, 20 Apr 2023 08:19:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux XFS Development <linux-xfs@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: xfs: Extend table marker on deprecated
 mount options table
Message-ID: <20230419221947.GU3223426@dread.disaster.area>
References: <20230419094921.27279-1-bagasdotme@gmail.com>
 <20230419151536.GM360895@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419151536.GM360895@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 08:15:36AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 19, 2023 at 04:49:21PM +0700, Bagas Sanjaya wrote:
> > Sphinx reports htmldocs warning on deprecated mount options table:
> > 
> > /home/bagas/repo/linux-kernel/Documentation/admin-guide/xfs.rst:243: WARNING: Malformed table.
> > Text in column margin in table line 5.
> > 
> > ===========================     ================
> >   Name                          Removal Schedule
> > ===========================     ================
> > Mounting with V4 filesystem     September 2030
> > Mounting ascii-ci filesystem    September 2030
> > ikeep/noikeep                   September 2025
> > attr2/noattr2                   September 2025
> > ===========================     ================
> > 
> > Extend the table markers to take account of the second name entry
> > ("Mounting ascii-ci filesystem"), which is now the widest and
> > to fix the above warning.
> > 
> > Fixes: 7ba83850ca2691 ("xfs: deprecate the ascii-ci feature")
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Looks good.  Dave, could you take this through the xfs tree whenever you
> push the duplicate #include fixes, please?
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Applied.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

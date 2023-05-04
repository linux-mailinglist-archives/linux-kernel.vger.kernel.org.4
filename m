Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267DD6F793B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEDWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEDWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:40:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65433A5CC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:40:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaea43def7so7345245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683240038; x=1685832038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSBn9yOinBU8m0yQLrSvbl7PKYZlBg3YhOgvbxEMud0=;
        b=V2OWoWuBY9/BxFN6ZMrayZSPn34VUIMFwLKD1syjt3URVOHsk6eRCzBjJxyS/sTaxh
         0ODMUc6Lrrs3v8zH3Sx/5e/PKEpsPzqFVGY4QckBPaQkZZfaM7pnBgEofNkOYx2I3eMh
         /CUnaPOJFUPSRWZdnUNxTe8x2snVD8PtGIxSGOLogmkrfrhkWite1HB1ZWG+3fFJST9O
         CMCv7TFFrBn2cKtBOmOLW8XQUBS/fB7r1lrmQ3GM1O5nbWEdOmtFcfUJmeIAnUxIbWpn
         3ror2ojs9ATMDgL9RR5K3X4TvFjtnscejsS+p0QkHUHUt2WEuhfGkKNuQs/O+d5WTYRo
         HM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240038; x=1685832038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSBn9yOinBU8m0yQLrSvbl7PKYZlBg3YhOgvbxEMud0=;
        b=KeJYin+SVsrYobwf9XcxTYpfSLCfyVbXQPwxstQGSE/F35XzACZXQDaN/UUtmH9RpG
         AaA/d7frf7znTnalTL8ZVsMPASAjG2pYICEERFB+H1stvc252xQABgb/QDsZN4d+KSqc
         ukyp/QeppBJxOK17K/CaYBlXYLWuE8HaE3Trxbj4nmK+RmHcBdNJAx0p8mKA/Xoote/r
         GcOP3eXqre5nmanpOuR75Ly8cdufP0lrbIoh485Jq0suMmH2LSNjDJMM4wYvTuqnVic4
         P4DrZ1K7RWyNgk/mJaEhQr3iL9G9jzGoQUH0c9UqcwuPxYpe8intXOexNGw8dEcy8yEY
         8yMw==
X-Gm-Message-State: AC+VfDw44F14U6AVoATCiOzeIiN+3r00MH37nyQk4Lc+I9Xxir81RhwD
        oy7V3xhIVDWMLG3Ad7+b5/dR4A==
X-Google-Smtp-Source: ACHHUZ4sldKILzM05M5JtvE1zkTm8BdFnY+an0qc3+Zw6AS4jJ2XEp42XVgNkYwu+sP102Df03J4uQ==
X-Received: by 2002:a17:903:48e:b0:1a6:cb66:681f with SMTP id jj14-20020a170903048e00b001a6cb66681fmr4825434plb.46.1683240037873;
        Thu, 04 May 2023 15:40:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001ab0159b9edsm27390plb.250.2023.05.04.15.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:40:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puhcn-00BPr0-UX; Fri, 05 May 2023 08:40:33 +1000
Date:   Fri, 5 May 2023 08:40:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20230504224033.GJ3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
 <20230503215846.GE3223426@dread.disaster.area>
 <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:45:50AM +0100, John Garry wrote:
> On 03/05/2023 22:58, Dave Chinner wrote:
> > Is there a statx() man
> > page update for this addition?
> 
> No, not yet. Is it normally expected to provide a proposed man page update
> in parallel? Or somewhat later, when the kernel API change has some
> appreciable level of agreement?

Normally we ask for man page updates to be presented at the same
time, as the man page defines the user interface that is being
implemented. In this case, we need updates for the pwritev2() man
page to document RWF_ATOMIC semantics, and the statx() man page to
document what the variables being exposed mean w.r.t. RWF_ATOMIC.

The pwritev2() man page is probably the most important one right now
- it needs to explain the guarantees that RWF_ATOMIC is supposed to
provide w.r.t. data integrity, IO ordering, persistence, etc.
Indeed, it will need to explain exactly how this "multi-atomic-unit
mulit-bio non-atomic RWF_ATOMIC" IO thing can be used safely and
reliably, especially w.r.t. IO ordering and persistence guarantees
in the face of crashes and power failures. Not to mention
documenting error conditions specific to RWF_ATOMIC...

It's all well and good to have some implementation, but without
actually defining and documenting the *guarantees* that RWF_ATOMIC
provides userspace it is completely useless for application
developers. And from the perspective of a reviewer, without the
documentation stating what the infrastructure actually guarantees
applications, we can't determine if the implementation being
presented is fit for purpose....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

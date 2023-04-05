Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C656D8AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjDEXEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDEXEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:04:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007161BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:04:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so35563793pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680735860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrKOMt3UyE7cKr4ReAMcPC7o/oJjZhoBrpSamEnzwcU=;
        b=iBasCSC6te0W78R7Bld/4KqgYzDWUZzqACRfp85/HVPjnIURY/CCvj/MiI6rm+++ti
         gqpugla/+KDIYJg63rR+HSbATePR4WT4ESQqUSZbNXhXwDsDekOQI3dc/hhfGsX4ZmQH
         ecTKCtm9wkF//A0omDOb3qG1mFeJtK6feClVFbSUVOuk+pMTKJePNaAaUzd151jRcXcN
         DByT2oDMO7+9+lh1FRHXVJeLQZdjpwBHrNdyfejgPhOeMKO+SfFKXC+BSv2ILVK7l638
         6WjxIUoe58jT0iOyh0VhO3qcTR60vFv7HyGZ3OdUkrwxLi3TmR49uTk80nkqRXSgT7Hb
         bdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680735860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrKOMt3UyE7cKr4ReAMcPC7o/oJjZhoBrpSamEnzwcU=;
        b=zEMSYmwHbfbKbGWt8rGM8IpZVvkxUoeD00q4tgqKLpL5Mc+kfAcpwEWcPfDXDyTa0y
         fUbi39W8/axMdljb6/yiPmBbSrYaA7KFKVtD4/CpEA2eQkyGLO4V8+y/lkpgJxxxRKuT
         EJmC/2uwSb7hjprN1u8cfHhcK0ssiPFUAa7gs4D8IpNr2oezAArAsMFrA5kl6SPMmOL7
         QhPaX53w+KMbKDarJYPIlAQw+543v6uG6Y0I8KhIBMvjsGU6OZIFtaTfswRyvFBLLhls
         Sv2aGm3Z9HcFgApoFMnHkcFQUnm1KrZ5Pl9lxuJ311GKp9lUy8rhZPhr7tjZCXE3zRuh
         VMBQ==
X-Gm-Message-State: AAQBX9eq3RdFfCkkZ+kWNsMp/kMfr7hd3f1LEIgMLmmsICk9bMp3OxiC
        nZEbnJfZI3bFXpf8yofZAdFTtOlG+Zm4C7FGFBY=
X-Google-Smtp-Source: AKy350b+42w1smjir37jF3mpwW0jtsgJwT9OCuZ/HHxaFRTXRFnztFkwSl+Lgm5digRUYn3uj9z7oA==
X-Received: by 2002:a17:902:f152:b0:199:1b8a:42a8 with SMTP id d18-20020a170902f15200b001991b8a42a8mr6304205plb.6.1680735859685;
        Wed, 05 Apr 2023 16:04:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id b18-20020a63e712000000b005038291e5cbsm9739867pgi.35.2023.04.05.16.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:04:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pkCAp-00HVND-O9; Thu, 06 Apr 2023 09:04:15 +1000
Date:   Thu, 6 Apr 2023 09:04:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
Message-ID: <20230405230415.GT3223426@dread.disaster.area>
References: <20230404084701.2791683-1-ryasuoka@redhat.com>
 <20230405010403.GO3223426@dread.disaster.area>
 <CAHpthZoWRWS2bXFDQrB+iOz7AA_ZLGJKmytHjN582VaWQ_TRwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpthZoWRWS2bXFDQrB+iOz7AA_ZLGJKmytHjN582VaWQ_TRwg@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 05:04:14PM +0900, Ryosuke Yasuoka wrote:
> Dave,
> 
> Thank you for reviewing my requests.
> 
> > > for_each_perag_wrap() doesn't expect 0 as 2nd arg.
> > > To iterate all the available AGs, just use for_each_perag() instead.
> >
> > Thanks, Ryosuke-san. IIUC, this is a fix for the recent sysbot
> > reported filestreams oops regression?
> >
> > Can you include the context of the failure it reported (i.e. the
> > trace from the oops), and the 'reported-by' tag for the syzbot
> > report?
> >
> > It should probably also include a 'Fixes: bd4f5d09cc93 ("xfs:
> > refactor the filestreams allocator pick functions")' tag as well.
> 
> No. my request is in the same code area where syzbot bug was reported,
> but it might not be relevant. A kernel applying my patch got the same Oops.
> 
> I'm indeed checking the syzbot's bug and I realized that this small bug fix
> is not related to it based on my tests. Thus I sent the patch
> as a separate one.
> 
> > While this will definitely avoid the oops, I don't think it is quite
> > right. If we want to iterate all AGs, then we should be starting the
> > iteration at AG 0, not start_agno. i.e.
> >
> > +                       for_each_perag(args->mp, 0, args->pag)
> 
> I agree with your proposal because it is more direct.
> However, as the current for_each_perag() macro always assigns 0 to (agno),
> it will cause compilation errors.

Yup, I didn't compile test my suggestion - i just quickly wrote it
down to demonstrate what I was thinking. I expect that you have
understood that using for_each_perag() was what I was suggesting is
used, not that the sample code I wrote is exactly correct. IOWs,

		for_each_perag(args->mp, start_agno, args->pag)

would have worked, even though the code does not do what it looks
like it should from the context of start_agno. Which means this
would be better:

		start_agno = 0;
		for_each_perag_from(args->mp, start_agno, args->pag)

because it directly documents the value we are iterating from.

> Although I haven't checked other callers deeply, we should modify
> the macro as follows:
> 
>  #define for_each_perag(mp, agno, pag) \
> -   (agno) = 0; \
>   for_each_perag_from((mp), (agno), (pag))

That is not correct, either. agno needs to be a variable - it is
the loop agno counter that tracks the iteration.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

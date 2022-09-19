Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865E5BC9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiISKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiISKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:41:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC432B95
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:24:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u132so27605865pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=E1VSL0pjCixdyG4RV1ICMYhJ+r2n7useqdWsaGeETVY=;
        b=oUZxygDJmOjyp2cM0o/4C+wL2ZcYG96F5yhOgZQ7joJlqMHNQH+/Z9cotgy9hCmuKQ
         k7BG+KNj1mDzTrqGNMpAY4ky8U8NXg2RQTIT93CpribCcOvPbnqDQZWKU+JZVnxlGv1S
         2Zew4gaLIXaSrpfBo0AYbOHjkjkzbolqx5gL0DAuYdTGMTA4bgFlr7BANjL4doBRdLZF
         hDD7WuYw8yLu+W5PJ3bDNK738WPMfFHiCU5vnLW81hDyk8lCCn98YA10LrsEsfrjZ2RU
         Bbl7zQyaPo3QWxApYw08FmkHqIl7FwZBDGvefOObKFg9VOc4dvun+4SqAjqmkN8/bwAm
         dYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E1VSL0pjCixdyG4RV1ICMYhJ+r2n7useqdWsaGeETVY=;
        b=iUZYxxekv4wGwgs0bwgjbSZ8oZ6Yb7BqB5zIhDTcRc5bwqxGziYWa3lFhpKF7bF0PU
         6HlzSBoqKCa26DMamqp9EJzf/tQg+0C70CGzmtoECGdv5QG+M7cQELcg73j/yhRmPMKX
         PG1NIHyEf42YfASZXJaYS9yLDd1q+S+jGLOQg1/UeGMosnq+1FnGpemJAQN8qxtNVuqI
         gaJBDdIy64CZaE3GLM7PgAsrgISf/u5tCCfTv+NMR2vG++t9V+sUjs2vEqEBAPrzFIVg
         dugXraqHCim9EoXyzJLjP0CiufimLL9M4tU5VeE8Xb+t8bjCFQXxnzl0kpA4sa4K4VmV
         1tlQ==
X-Gm-Message-State: ACrzQf3BhERkE2sdV651/2X/G8H8J2FGqm1BibWIQjbreKYzkxzO0RmO
        1gJUr+8EHLGOjyig4THOxzw=
X-Google-Smtp-Source: AMsMyM5NQhLG4ApaioumSc6tzRValxQyety/W/Fur8WUtL7l6eqQK9x+vMF+x6d/F4UW0blAsthyJA==
X-Received: by 2002:a62:ea04:0:b0:547:50c0:c5ef with SMTP id t4-20020a62ea04000000b0054750c0c5efmr17307983pfh.15.1663582978104;
        Mon, 19 Sep 2022 03:22:58 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id rj9-20020a17090b3e8900b002008a85bac1sm6301718pjb.49.2022.09.19.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:22:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 03:22:51 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkundrak@v3.sk, linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux@dominikbrodowski.net
Subject: Re: [PATCH v4] char: pcmcia: scr24x_cs: Fix use-after-free in
 scr24x_fops
Message-ID: <20220919102251.GA314226@ubuntu>
References: <20220919093801.GA307492@ubuntu>
 <Yyg6N+yS9YyAepFk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyg6N+yS9YyAepFk@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:45:27AM +0200, Greg KH wrote:
> On Mon, Sep 19, 2022 at 02:38:01AM -0700, Hyunwoo Kim wrote:
> > A race condition may occur if the user physically removes the
> > pcmcia device while calling open() for this char device node.
> > 
> > This is a race condition between the scr24x_open() function and
> > the scr24x_remove() function, which may eventually result in UAF.
> > 
> > So, add a mutex to the scr24x_open() and scr24x_remove() functions
> > to avoid race contidion of krefs.
> > 
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> The robot did not report this original problem :(
> 
> > ---
> >  drivers/char/pcmcia/scr24x_cs.c | 73 +++++++++++++++++++++++----------
> >  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> You failed to put below the --- line what changed from previous versions
> as the documentation asks for.

thank you for telling me.

I submitted a fixed v5 patch.


Regards,
Hyunwoo Kim.

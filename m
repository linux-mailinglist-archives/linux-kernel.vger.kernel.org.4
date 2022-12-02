Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBAD63FD3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiLBAqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLBAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:46:15 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D5A1A07
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:46:14 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h16so3259959qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg48tuWS75RG4EGpWvYE/NpwbAAmMt5D2QrvouYOgx8=;
        b=Qzp+wvhFcilhPxXoaEEGw8EFjQNcZ7TaAMDrAcZbyaJ6aamI4z372SBxTcPc2Ce6nu
         KFUdSKFRXGWtX+SJvbHjZoAuGIoEWAy/6oJSYzZ8tGYvKY+uq7VRpTjrLHsyQD/psQ8e
         xvGZB6+dTz3slpQ4cS8bXXp/mHCVf9BrxyOO+hHDtL91o3AZYb8vWfB8iLr3LszXtUFU
         lnE7pwjO/ZVjQMNpT3h/Nhse7JDKC4h+3hC78cUBxna2f8p1HSi+rFlnYSUL2T9WevOe
         cvrmRBmtmfSYfJWu5nrjzgR5NLrnrgXnpWLRbVJtL1TBWQhzq8VMTN7vkeORt9MpeN5I
         BKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg48tuWS75RG4EGpWvYE/NpwbAAmMt5D2QrvouYOgx8=;
        b=QsEVFOR0UgoztohXnzy/OocX8CyWC11Q8Y6BRbHFpp4S5A2PYEmgJ9PEEpWJ/Kow8R
         lLEY/OypNBKqGfmbU4Q2AM8j+ERfAOkMbdS0z/OFJ+GLcIWGP/t5bspBTcGqfvW8sLxr
         rFDqNVvhZDuobmPzy0ps2hEhRCVArGwnMca9obQHxWX8Kc7XcZ1sDkSCtj5od+9cAfua
         MBlUL589HGtVUA22lR6w6i5t2kskKKhHq4LY5YwrTJJ1VIug2h1EMZvPg38CZNgnW//s
         idmAuWWQtwQFk5YcjuFNMEL4bo4Yj2lCuExmXcHe4SydHbjKpVLKhverlKmV7UsAv7ji
         ZQXA==
X-Gm-Message-State: ANoB5pkJDixU/zqOOtwljdJ/mwAUXBimE88STeufZuIZghnUfd43T3iT
        dOTeYt+1lbnsQkfsZ/VzmbRPvg==
X-Google-Smtp-Source: AA0mqf7n/gdqwPAOFiIWaSFo9Bw4Uc7np/iVzzHE0mMwoYc8nZDUL759lXTL1/pcepigGT0jlZ7HCA==
X-Received: by 2002:ae9:dd46:0:b0:6ce:4868:2fd6 with SMTP id r67-20020ae9dd46000000b006ce48682fd6mr45382812qkf.491.1669941973890;
        Thu, 01 Dec 2022 16:46:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006eea4b5abcesm4765861qkp.89.2022.12.01.16.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:46:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p0uBw-001yp6-1e;
        Thu, 01 Dec 2022 20:46:12 -0400
Date:   Thu, 1 Dec 2022 20:46:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4lK1LbEaI0LqtJW@ziepe.ca>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <Y4kvne/Vv+H5pjzW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4kvne/Vv+H5pjzW@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:50:05AM +0200, Andy Shevchenko wrote:
> On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> > container_of does not preserve the const-ness of a pointer that is
> > passed into it, which can cause C code that passes in a const pointer to
> > get a pointer back that is not const and then scribble all over the data
> > in it.  To prevent this, container_of_const() will preserve the const
> > status of the pointer passed into it using the newly available _Generic()
> > method.
> > 
> > Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> 
> I believe this tag requires SoB of the co-develper.

Sure, Greg you can add whatever tags are required

Did you look at possibly just calling this "container_of" ?

Thanks,
Jason

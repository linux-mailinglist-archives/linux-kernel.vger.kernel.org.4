Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C246949EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBMPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjBMPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:03:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E81E28F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:02:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so12528704wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrIWlN9SzGtQvTkFnbkqGUpxqiX7C83QwGj4QjMs49I=;
        b=BJR4zhwkO/XVpa3q2KGY9OgATce/Uwq7Q8Bwvzw8st0yT+M3PdzCLAqF2uyZNigFgm
         +mO69gEVvP/nJJ4Y1eHMQfWFA8w+hrwZr0Hyvvw6s7Bq6JaMolyWiuO6pNzY5z3Y66b1
         GpsS0BkGxmmiLW2BLI/bn9Auo4P8PNUBUeyU/28djTajo4KBKPzWfIqBuzivmqLOMQwA
         8wxZJ165S8F+HOrkY6mJDDCZU79DK9EEmbNNWuXjLNrrf3FbbfWGbyJwbokng9MDhQKi
         VKSQ5isl3XKL91ivGqQxWTj4znnnM6MCy13ItJGK+DEg3hUy8ZcHzg4wvaAWxGGJLwMa
         UJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrIWlN9SzGtQvTkFnbkqGUpxqiX7C83QwGj4QjMs49I=;
        b=P6WiIk6+hrs6DpMfeUYL/H0Nye/Z3d9jUVS7Y2SY6m56cvF5sSM2KdbxCdACXy34rm
         1zFoiULzb/FBW70LOW7TuE7nKJYk8xrdJmzWCYkQiMGV1f5cDECTP+7TQ15n/OQb5dpd
         DvD11X53N4n5JgtMiezdYhmeuc0/T2SC6fU3vqJ/qhMfsMDyi4UDGT0poT16AhDqs1Sn
         yYXdLQ8JHCLBe7uKHEyGrdIBcbP/6M2Eqa5RqZ4ECMePy35oDwvQ4V71UTCsitdUv5n/
         Nijibi3wsDsFpnpfL+5TQSGRwae+p+dCjzoGjTA6ThmUrwytHYTjxIl0dpNru+JYbqT9
         rz9g==
X-Gm-Message-State: AO0yUKXJ8vd5Ulv8MkXYvV6L5/JcLgigfZs9QC2F3vHv66cC5k3mQfld
        IhSpkU00wnExPtvO+xm5Z3Q8+ayT0FWoCCCfjzEKEw==
X-Google-Smtp-Source: AK7set8C6DGeOvd8zXL3C1BRZP9oZVxj1DQDE7d5k1SeZfhtNGAP9Xly49LBVDn1Dn+XEdZ/hpRt47JKKOx4nYUktSk=
X-Received: by 2002:a5d:65c8:0:b0:2c5:52ef:71c0 with SMTP id
 e8-20020a5d65c8000000b002c552ef71c0mr136669wrw.103.1676300565696; Mon, 13 Feb
 2023 07:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
 <63e279f730612_104ce22946f@iweiny-mobl.notmuch> <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
In-Reply-To: <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 13 Feb 2023 16:02:34 +0100
Message-ID: <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Fri, Feb 10, 2023 at 9:28 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> Ira Weiny wrote:
> > Sumit Garg wrote:
> > > On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> > > >
> > > > Sumit,
> > > >
> > > > I did not see a follow up on this series per your last email.[1]  I'd like to
> > > > move forward with getting rid of kmap_to_page().  So Hopefully this can land
> > > > and you can build on this rather than the other way around?
> > >
> > > Apologies Ira for keeping you waiting. Actually I was fully involved
> > > with other high priority work with my upstream review backlog
> > > increasing. So I wasn't able to devote time to this work. Sure I will
> > > rebase my work on top of your changes.
> >
> > No problem on my end.  I just wanted to ensure that I did not miss
> > something.
>
> Andrew, can I get an ack on patches 1 and 4 for this series?  I realized
> that perhaps I was not clear on my expectations of this series.  I was
> thinking this would be easiest to go through the tee subsystem tree.
>
> Sumit or Jens, is that ok with you all?

Sure, I'll take it. The timing is a bit unfortunate, it's likely too
close to the merge window to be included there. However, I'll pick it
up and add it to linux-next so it's ready for the 6.4 merge window.

Thanks,
Jens

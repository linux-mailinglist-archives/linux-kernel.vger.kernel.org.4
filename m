Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B670C22E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjEVPTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjEVPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937011F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684768726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCRifPgQ2KYM1J/18zl2ESD1bx71iYRRYD+tXDWwgtQ=;
        b=EJHhEdRq4aEvbQQkbJiWrTkJA5H1kZH4qaR4eMyV+GJDf/HXNla+BtrTtEVkeGPJke+AlF
        wONhLBVzCe45NC7+MffyF3/TlYMTl7xGzhbtvuK0vpmyH9DFRrR+q6TOJvcuywh2GPYTUp
        S9JAKv3g1f2lKj7uwJ0HzIWHw6TYNXg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-srrg8MA7P_K9cB9CN1ZFCw-1; Mon, 22 May 2023 11:18:44 -0400
X-MC-Unique: srrg8MA7P_K9cB9CN1ZFCw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f687fcbf8bso30991021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768724; x=1687360724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCRifPgQ2KYM1J/18zl2ESD1bx71iYRRYD+tXDWwgtQ=;
        b=I6o2GBgqvOoiCBwbqIPGf2Ko9oDD239xYOfbYQzSkoc9trklhqDNjrchvha5gH2ObE
         fkmVR6hnMgA4Ys3961+juf+BNqg3MWLd/DYa04k3wN4/J7gvea/r2tSOR7TEZKJUG7SE
         tK2M47MRoSnuoFS6iaSQOvGD8dqo9YkbPdZzVCDLqUTvLTFNeUuJoVeWW0tivbQvHCsY
         +acvfdO4i227EQY1cPUwpmoPqlsazj/7xN+ENNZ0XYb+6wE82mfbzh81GvrceZu6lFIJ
         K2ITwOeueAYMX4JTfoc6jcKDEvrDbGcakRcgcEl/UTwXzzJYnvWvk0scoUO3yrf7bWGc
         y35g==
X-Gm-Message-State: AC+VfDwPqlSOoXYOI8lOM6XM2imM5slrhFrAIAEkUJGsRQvyAa2UCvOA
        m8mwcnqW51298rDxC0kmLmL4zZPqWcIuvoy8XLzcDgXZeKJExWSwHZ2QoC+eWq0eqfWYjyRJNhe
        fpgb9ogO3OeayMJOHj+K2N0sV
X-Received: by 2002:ac8:5b11:0:b0:3f5:20f8:cb1b with SMTP id m17-20020ac85b11000000b003f520f8cb1bmr20135847qtw.40.1684768723831;
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50YWBRe2ct39WOCe02vsONTePZ0aJIbdLOkLzSIeZn4rAQ6LyYuaac/4K7iAAEND9jg00abg==
X-Received: by 2002:ac8:5b11:0:b0:3f5:20f8:cb1b with SMTP id m17-20020ac85b11000000b003f520f8cb1bmr20135827qtw.40.1684768723607;
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id dy3-20020ad44e83000000b005dd8b9345besm2000938qvb.86.2023.05.22.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
Date:   Mon, 22 May 2023 08:18:41 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Message-ID: <vxxh3laqaavyxx3f2c65k7zui6wkahm6fspy6hvwpofsxtialo@ne7za5hvlgk2>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
 <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
 <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
 <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com>
 <ZGuDGftmxsF35C9P@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuDGftmxsF35C9P@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:58:33PM +0200, Joerg Roedel wrote:
> Hi,
> 
> On Fri, Apr 28, 2023 at 11:14:54AM +0530, Vasant Hegde wrote:
> > Ping. Any suggestion on below proposal (schedule work on each CPU to free iova)?
> 
> Optimizing the flush-timeout path seems to be working on the symptoms
> rather than the cause. The main question to look into first is why are
> so many CPUs competing for the IOVA allocator lock.
> 
> That is a situation which the flush-queue code is there to avoid,
> obviously it does not scale to the workloads tested here. Any chance to
> check why?
> 
> My guess is that the allocations are too big and not covered by the
> allocation sizes supported by the flush-queue code. But maybe this is
> something that can be fixed. Or the flush-queue code could even be
> changed to auto-adapt to allocation patterns of the device driver?
> 
> Regards,
> 
> 	Joerg

In the case I know of it involved some proprietary test suites
(Hazard I/O, and Medusa?), and the lpfc driver. I was able to force
the condition using fio with a number of jobs running. I'll play
around and see if I can figure out a point where it starts to become
an issue.

I mentioned what the nvme driver did to the Broadcom folks for the max
dma size, but I haven't had a chance to go looking at it myself yet to
see if there is somewhere in the lpfc code to fix up.

Regards,
Jerry


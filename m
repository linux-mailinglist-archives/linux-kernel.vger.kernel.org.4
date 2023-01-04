Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D865D731
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjADPVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbjADPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:21:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A741D4E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672845512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oxfz6EhZocx3G6fE49e6Qs3NUMuCUPxRP9Iod/SdZ9I=;
        b=N+CvU3bk/qvYmtlSM1yV5866dDDrQaUaA2JDo2fvEtIFZWPQG+565bcmbPx1QScZcCS972
        PMiB3OUqEb1L7rc7INrsfHOf/Vq82Ri13/SF7BVjU4qQ839j/E89ms9hSc2ohQMU56Le/5
        /wK8Iq4IA/yuUc4iumIm3LgUQd4nbFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-Z7Stbs5CM7eBrB9WkPX0DA-1; Wed, 04 Jan 2023 10:18:31 -0500
X-MC-Unique: Z7Stbs5CM7eBrB9WkPX0DA-1
Received: by mail-wm1-f69.google.com with SMTP id w8-20020a1cf608000000b003d9bb726833so1451644wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 07:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxfz6EhZocx3G6fE49e6Qs3NUMuCUPxRP9Iod/SdZ9I=;
        b=7czQ0arQj2AI41eCgHgQqSurWM3FGCjoq5YO4DSsDC5e/BaHkYxDnz/mHaJJceXcBg
         PyJtS2G7vt5pysZ6G1o2hknJ6mIj2yzY/X7Z/8t5T8zmfAZrSjdD12qBGM1tJH0s9iHu
         SO/y2GHZ4042CPPk8kBPR/d+dN972viFLdFSSFAdJvDeDLEfDr+cbh/r5f7ISRYBTDED
         Ei42HNp3mnKOP07TrV6exvvIp65/o30NntOkN7xU/DV8tKpMQjq+hX5XxX1KpDykQPvf
         IJ165KwGqjD+CalB7n2HombiI68tJ3E4lfp8MKOG9BgquCgV3bNK4+2bmz9KiRtoJgSB
         1ahQ==
X-Gm-Message-State: AFqh2koadxzLYo5y6Cwfl3cwZ/RmWdAkzH43Vz6czatxF/Dem7TnpnL5
        lo8ChtZUS1/YK4VK6OBYH4sAkC4y+t/7Y3mXDQP80gu74hC37eTCTcSDEcJUA7vgi3xNPtQ8bv+
        6kapBbyAf7kRsluYsQ1wryO/E
X-Received: by 2002:adf:fe44:0:b0:27a:b72a:819c with SMTP id m4-20020adffe44000000b0027ab72a819cmr21717106wrs.58.1672845510302;
        Wed, 04 Jan 2023 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXue8bZ/xYiBM3ApJcVGTAae49bu2m91DgXeka06lAG4JzOIsCkrHQBAgy7fy2nQ18MRn4yCaA==
X-Received: by 2002:adf:fe44:0:b0:27a:b72a:819c with SMTP id m4-20020adffe44000000b0027ab72a819cmr21717096wrs.58.1672845510094;
        Wed, 04 Jan 2023 07:18:30 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm38279954wrs.82.2023.01.04.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:18:29 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:18:27 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Baoquan He <bhe@redhat.com>, pbonzini@redhat.com,
        mlevitsk@redhat.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y7WYw0YH27hdsD11@work-vm>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
 <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Gsz4mqnZCtC9rn@MiWiFi-R3L-srv>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Baoquan He (bhe@redhat.com) wrote:
> On 12/20/22 at 12:38pm, Peter Zijlstra wrote:
> > On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> > > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> > > 
> > > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > > Implement IPI shorthands support") can fix it.
> > > 
> > > The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> > > cmdline.
> > 
> > And the root cause for this is... ? Does the kvm x2apic emulation
> > somehow get upset when we shorthand CPUs that haven't been initialized?
> 
> Thanks for checking.
> 
> I haven't figure out the root cause. I haven't read the apic code for
> long time, and not familiar with the kvm code. So raise the issue to
> upstream.
> 
> I can do testing if any suggestion.
> 
> Add our virt dev Dr. David Alan Gilbert to CC.

Hmm I don't know that code well enough; cc'ing Paolo and Maxim.

Dave
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


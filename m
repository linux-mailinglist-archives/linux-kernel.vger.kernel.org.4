Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB176A8B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCBWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCBWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C75D762
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677794497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNPJ7wFmL9Bjmsbmp9sfS53qgtUQl6YCPNnALnAdSXo=;
        b=fRD7N+I2Qi7GrNCkp+Xtl6V/4xxyiHpwnXv3PMoNLDX+KX2eOr1+kfEGxd2nIwTt3Q4sbA
        9gHi4K53DIxVHD4OMoDjeCvko81glzj30sSBMcIN6hbnizxu+2EC+rK4TYC2BR4evNaD/L
        Dw9M1TdabNksRL3Y33oa5+YBlnPHFKc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-2v2oBapxPSyOBMz5BUaxZg-1; Thu, 02 Mar 2023 16:30:43 -0500
X-MC-Unique: 2v2oBapxPSyOBMz5BUaxZg-1
Received: by mail-qk1-f198.google.com with SMTP id ea22-20020a05620a489600b00742cec04043so220615qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677792643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNPJ7wFmL9Bjmsbmp9sfS53qgtUQl6YCPNnALnAdSXo=;
        b=KQk8jQV3sV+iObfH1/zYvM01YO057i3pBSmvbdPC61JJJrpwOHGOuDYP22B8mAKURu
         +MpnEoEnVbSIFkTy4+VPV9MZfnmyh6VDttKLwyvpwn67oAAM9uHuGalqhm/P7D61ufHP
         VqJoih5r4Dpoxz0hgwR8wfNGi76+oBrEHpdPz4FvT1Tz/UGcSMH+rHttrwVBkMbAzS6/
         cIuibvblkrqw8ySD11iJXP10kRQvr1nbqrNQk7Qm9wKN/J10N7OIzo+IEsixOj8GFssY
         xtWq5TnhOv+JIglMW4cxfLqM87/5xsBK5O0rEsp9VDBTHxV36R/HCveC7qx+uE25GM9h
         c2gA==
X-Gm-Message-State: AO0yUKW8Up6DFHzAUYhept5rfPsWTdSqmEOej3NzSwzbJZuhwvsw0QJ8
        RYBLtl6lyRljKArXFLz7jSpk4hALk2PBlPmGOVqV0GUSHm9qU3+SZsTuAI9CTqgGyUl8LgKPdVZ
        ngYZy8sHPZlKSw+ZeFbBBbv4vCO2+hw==
X-Received: by 2002:a05:622a:1896:b0:3bd:1c0f:74f3 with SMTP id v22-20020a05622a189600b003bd1c0f74f3mr23306190qtc.2.1677792643043;
        Thu, 02 Mar 2023 13:30:43 -0800 (PST)
X-Google-Smtp-Source: AK7set95CLuUQKexyjQ3U1S1wxyvTeP0rp/DQhoJgHiGd+bfzFi75dfCI1NKl6jxyl4NPK8spqjF+Q==
X-Received: by 2002:a05:622a:1896:b0:3bd:1c0f:74f3 with SMTP id v22-20020a05622a189600b003bd1c0f74f3mr23306159qtc.2.1677792642751;
        Thu, 02 Mar 2023 13:30:42 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id n190-20020a37bdc7000000b0071a291f0a4asm453257qkf.27.2023.03.02.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:30:42 -0800 (PST)
Date:   Thu, 2 Mar 2023 16:30:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/11] mm/vmstat: switch vmstat shepherd to flush
 per-CPU counters remotely
Message-ID: <ZAEVge3W3bL+GNtx@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.901518530@redhat.com>
 <ZAEOk7GdJ0c8NS+y@x1n>
 <ZAESOs/EeMCNp7YX@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAESOs/EeMCNp7YX@tpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:16:42PM -0300, Marcelo Tosatti wrote:
> On Thu, Mar 02, 2023 at 04:01:07PM -0500, Peter Xu wrote:
> > On Thu, Feb 09, 2023 at 12:02:00PM -0300, Marcelo Tosatti wrote:
> > > +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > > +/* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
> > > +static void vmstat_shepherd(struct work_struct *w)
> > > +{
> > > +	int cpu;
> > > +
> > > +	cpus_read_lock();
> > > +	for_each_online_cpu(cpu) {
> > > +		cpu_vm_stats_fold(cpu);
> > 
> > Nitpick: IIUC this line is the only change with CONFIG_HAVE_CMPXCHG_LOCAL
> > to replace the queuing.  Would it be cleaner to move the ifdef into
> > vmstat_shepherd, then, and keep the common logic?
> 
> https://lore.kernel.org/lkml/20221223144150.GA79369@lothringen/

:-)

[...]

> So it seems the current separation is quite readable
> (unless you have a suggestion).

No, feel free to ignore any of my nitpicks when you don't think proper. :)
Keeping it is fine to me.

-- 
Peter Xu


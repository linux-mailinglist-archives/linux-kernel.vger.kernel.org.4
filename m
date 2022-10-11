Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117FF5FB757
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJKPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJKPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C910B7B9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665501635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KCuFp3jrifWyK2sqLjqh/Wy4NtoZKT4LCqwl1/miSQ=;
        b=AiNvDlkcZY60aGtJMvywDSfHSlD565d9Ur6Mrh2bHQBml7lps6awjkpgnkKd61VX3bgUs1
        xNpeyUhjoRJtV6RsW9xcZpSGxamnzWXtdjUegfeUT2X56fNRm6il+l1Ytzp4tGJSzYFMQ5
        R4K8EvOn/K9i2mNsz08QLhmRzKSYQAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-DjhkgqcpOHC9gPiA4EyAyA-1; Tue, 11 Oct 2022 11:20:34 -0400
X-MC-Unique: DjhkgqcpOHC9gPiA4EyAyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88D88101E148;
        Tue, 11 Oct 2022 15:20:33 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3621C4A9256;
        Tue, 11 Oct 2022 15:20:33 +0000 (UTC)
Date:   Tue, 11 Oct 2022 10:20:31 -0500
From:   David Teigland <teigland@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <20221011152031.GA11089@redhat.com>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
 <202210082044.51106145BD@keescook>
 <20221010210039.GA30273@redhat.com>
 <202210101534.BA51029@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210101534.BA51029@keescook>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 03:35:24PM -0700, Kees Cook wrote:
> On Mon, Oct 10, 2022 at 04:00:39PM -0500, David Teigland wrote:
> > On Sat, Oct 08, 2022 at 09:03:28PM -0700, Kees Cook wrote:
> > > On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> > > > On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > > > > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> > > > 
> > > > That's true. I agree that leaving "+ 1" would work and produce a
> > > > no-binary-changes patch due to the existing padding that the structure
> > > > has. OTOH, I thought that relying on that space could bite us in the
> > > > future if anyone tweaks the struct again...so my reaction was to ensure 
> > > > that the NUL-terminator space was always guaranteed to be there.
> > > > Hence, the change on c693 (objdump above).
> > > > 
> > > > What do you think? Should we keep or leave the above
> > > > "+ 1" after the rationale above?
> > > 
> > > I think it depends on what's expected from this allocation. Christine or
> > > David, can you speak to this?
> > 
> > Hi, thanks for picking through that.  Most likely the intention was to
> > allow up to 64 (DLM_LOCKSPACE_LEN) character names, and then use the
> > ls_name[1] for the terminating byte.  I'd be happy to take the patch
> 
> Should this just use:
> 
> 	char			ls_name[DLM_LOCKSPACE_LEN + 1];
> 
> instead, or is the byte savings worth keeping it dynamically sized?

Yes, I think that's the best option.
Dave


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA05D69FBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBVTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVTWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:22:31 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F53C7B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:22:29 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ks17so9455397qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJWYEAAsYNz+CjPq0GlL9zUnfQnB8A7P/QP84KCSNwY=;
        b=sqJ32RifrlWeoIMvFm2CCDN5Ubwhfnij9NOlKQtXmSuwFgR4ek1qWC6VC0HpIBzPiW
         9QhLxHISdA9CtLJ3vBwIevz760Xv1kRjTI5fDVeMgFI9y+LUfp0QmJZfS80SFpsjAgdM
         yYQreO2aksWfZFS2Y2hWoK4NBRD36gK1FNuF6kiRaxh4qBQkwtG4V0UQrczA8rlcx7N1
         9BvJyalK7yYljMBU2U0MVgqEbEaMycTtcBujW4J93VqPHHIk2USVPWTQJanvJ8DmcA8i
         Hj1Ej4vNAXwTuRmAhidvbOHLK10U18MQfMJ9q3wPF1zm9hnz6GT/7IaqINKvg34kHYIp
         hIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJWYEAAsYNz+CjPq0GlL9zUnfQnB8A7P/QP84KCSNwY=;
        b=6J5k+Uzu150SI38zOyHRjG4R67wTcFjU28opi2lxf5j8umAKiLo2e2rjGW9gdkAxCj
         +tFBmS44b9PRszD9IsdJtZXkqrTJ0LH5NEBLv75eC3eLlgizHYqJY9FpfSAlNXpTGLnm
         UhWALzqJcDPH/RT672+qoQOcXNVIUv4HBaNwVZRPmgB06g6Svcw5XGTAmb9YBzhBdBHF
         gTyunS96iCJ1lNZawcE81EC6GcPTBc7NdGPoSAyvEY/djK7RdoCTFyRLIVl6HBQCvkX9
         9vFrqYcpScAvQltB75O9pNGWeTg/IqSsjgDjZH4HhSgmw6bIfg7VkXp9W4clRio1A/nE
         lsAw==
X-Gm-Message-State: AO0yUKXcbJUQl8VZjWDprjrZG20ZUvqaxCqpopraHi7kgeEl91fdP4HH
        Y5ntVlTMxyrwNADT4WuyMTdRFQ==
X-Google-Smtp-Source: AK7set9cYkEvkHFxOBz6FdfILUmIQjk+AAn5rEGd6MznXpR1z8qxvIBtI3T8ya5Tdlkd9UzITmOdVQ==
X-Received: by 2002:a05:6214:4118:b0:56f:52ba:ccea with SMTP id kc24-20020a056214411800b0056f52bacceamr17150614qvb.20.1677093748368;
        Wed, 22 Feb 2023 11:22:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5e17])
        by smtp.gmail.com with ESMTPSA id 11-20020a37060b000000b00741921f3f60sm3748694qkg.42.2023.02.22.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:22:28 -0800 (PST)
Date:   Wed, 22 Feb 2023 14:22:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        David Stevens <stevensd@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
Message-ID: <Y/Zrc5QSKQWnu9WU@cmpxchg.org>
References: <20230221214344.609226-1-peterx@redhat.com>
 <Y/ZLjF9Xe1F6Mu76@cmpxchg.org>
 <Y/ZTHEACqwYUYGFP@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZTHEACqwYUYGFP@x1n>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:38:36PM -0500, Peter Xu wrote:
> On Wed, Feb 22, 2023 at 12:06:20PM -0500, Johannes Weiner wrote:
> > Hello,
> > 
> > On Tue, Feb 21, 2023 at 04:43:44PM -0500, Peter Xu wrote:
> > > If memory charge failed, the caller shouldn't call mem_cgroup_uncharge().
> > > Let alloc_charge_hpage() handle the error itself and clear hpage properly
> > > if mem charge fails.
> > 
> > I'm a bit confused by this patch.
> > 
> > There isn't anything wrong with calling mem_cgroup_uncharge() on an
> > uncharged page, functionally. It checks and bails out.
> 
> Indeed, I didn't really notice there's zero side effect of calling that,
> sorry.  In that case both "Fixes" and "Cc: stable" do not apply.
> 
> > 
> > It's an unnecessary call of course, but since it's an error path it's
> > also not a cost issue, either.
> > 
> > I could see an argument for improving the code, but this is actually
> > more code, and the caller still has the uncharge-and-put branch anyway
> > for when the collapse fails later on.
> > 
> > So I'm not sure I understand the benefit of this change.
> 
> Yes, the benefit is having a clear interface for alloc_charge_hpage() with
> no prone to leaking huge page.
> 
> The patch comes from a review for David's other patch here:
> 
> https://lore.kernel.org/all/Y%2FU9fBxVJdhxiZ1v@x1n/

Ah, that makes sense. Thanks for the context.

> From 0595acbd688b60ff7b2821a073c0fe857a4ae0ee Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 21 Feb 2023 16:43:44 -0500
> Subject: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem charge
>  errors
> 
> If memory charge failed, instead of returning the hpage but with an error,
> allow the function to cleanup the folio properly, which is normally what a
> function should do in this case - either return successfully, or return
> with no side effect of partial runs with an indicated error.
> 
> This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
> with either anon or shmem path (even if it's safe to do so).
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: David Stevens <stevensd@chromium.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

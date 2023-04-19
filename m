Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A386E7FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjDSQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjDSQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:32:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD42123
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:32:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a342f202cso127185966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681921942; x=1684513942;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjXbDQrMTlMveGgpzjaxOqJ4MX3Zc3PuAQFculrIp90=;
        b=Bzjp+BeQnrAKzIJWTEfUAa+W3pdspTEwqQF0Pa3tbP0lt3pW+mEMdyjsxr7XKzQxxM
         mIrFsanjX96nzba8usxtgUNN+uUHN5AaScdGV3qyXuEIojvImSDkRl/zXstTSqiLG9qS
         2jZ2SMzLHM11Ly9g09B0B0ONvetjkk3kMyy5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921942; x=1684513942;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjXbDQrMTlMveGgpzjaxOqJ4MX3Zc3PuAQFculrIp90=;
        b=WIAwyaxZ+Sh8K1pqFjTraTju9I7EMjAzgiIbxmc6vtdyrth32kVrmTqmF9a/8Qgrjz
         uGXqBp0+e9n/AGby6aXCTnMhSv5y8k7C5EPtBkMRC/GlKyEfeVesXmYnMLg1lFVK60bK
         w+f5KhIRL0ylEaKVigKJ9oYBJqgin6FJZRBtyDBS7vncgcdBfm6KC/kVX1HZdnijf4wx
         b38zDIgDhiMFk7snRCDpYh9qxHcy3F6uGlMB37iwyHIWo0G6m2xFyR1xThZB4zhjTTGQ
         TAmdEyZivniNmSRU2AszQ9tkkAxU+9AhVUNQqp9rKbl4vHqL3AdWvOtQOcxhoPaqgXJM
         +3rg==
X-Gm-Message-State: AAQBX9fSM+S+DrGKtM7b+hD9xXWNPkZRqabRRnFjOLR3SliUXw78kMAJ
        rtOo4HJDGlTza5LNmQj/w78Qh9JB+YbQTzUVKuk=
X-Google-Smtp-Source: AKy350aENGpODhst1P2SnjiQJvzhoC9GSkVgTOh9e3yM/mzLGea3xasoYck5TN1My/5JEkEvmKDOSQ==
X-Received: by 2002:a17:906:5d:b0:94e:d688:fc92 with SMTP id 29-20020a170906005d00b0094ed688fc92mr16825594ejg.0.1681921942431;
        Wed, 19 Apr 2023 09:32:22 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id t16-20020a170906269000b00932ba722482sm9754722ejc.149.2023.04.19.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:32:22 -0700 (PDT)
Date:   Wed, 19 Apr 2023 18:32:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Mark Brown <broonie@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <ZEAXlEeYrqvVejJj@phenom.ffwll.local>
Mail-Followup-To: Nathan Chancellor <nathan@kernel.org>,
        Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@gmail.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230414125913.851920-1-broonie@kernel.org>
 <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
 <8c90b4db-3075-4275-bea8-01f501b00885@sirena.org.uk>
 <ZEAVxeIEOny81EGY@phenom.ffwll.local>
 <20230419163011.GA1865368@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419163011.GA1865368@dev-arch.thelio-3990X>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:30:11AM -0700, Nathan Chancellor wrote:
> On Wed, Apr 19, 2023 at 06:24:37PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 18, 2023 at 07:34:44PM +0100, Mark Brown wrote:
> > > On Sun, Apr 16, 2023 at 09:58:50AM +0200, Daniel Vetter wrote:
> > > 
> > > > Note there was a ppc compile fail, which is why we pushed the ttm revert.
> > > > That /should/ be fixed now, but would be good if you can confirm?
> > > 
> > > According to Nathan (CCed) there's still issues with the interaction
> > > with the PowerPC tree.
> > 
> > So this revert was supposed to fix this: 56e51681246e ("drm/ttm: revert
> > "Reduce the number of used allocation orders for TTM pages"")
> > 
> > If there's anything left then I need to chase that asap since the merge
> > window will open soon.
> 
> I think we are talking about two different issues here. My issue is not
> a compilation failure, it is an incorrect merge resolution that is
> happening in -next because of two independent changes in the drm and
> powerpc tree, the thread below should have more information.
> 
> https://lore.kernel.org/20230413184725.GA3183133@dev-arch.thelio-3990X/
> 
> I do not think this is something that either tree can solve
> independently of each other, -next has to resolve the conflict correctly
> (which is what I point out in the message above) and a note of it should
> be passed along to Linus so it can be resolved correctly in mainline
> when the time comes.

Ah yes that's a different one. I think we have a note about this one
already, but I'll double-check with Dave Airlie.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

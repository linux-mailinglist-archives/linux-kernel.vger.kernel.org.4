Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B67386A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjFUOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFUOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:18:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F594
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:18:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668709767b1so2677515b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687357134; x=1689949134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMej/UrvmIg2gizD/pJRTNoHe0G4Jhk/5Y3L9fVhlFc=;
        b=OQYJ+zaY8pSr/jktybZtT0htfEhNu33853WltavdBCYxLKB2+ifS2Uh627kC/aFW/n
         QnP90SKAdMT++R2lYiVKL9E1ZVRZSsE0CMFSrCoMKTqwn7UTIs1pE8OzrHpwbIbfxkti
         EGIvco8phMQTAz04CGS0rg1smftSkZF2Rypxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687357134; x=1689949134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMej/UrvmIg2gizD/pJRTNoHe0G4Jhk/5Y3L9fVhlFc=;
        b=KQ/ixr8xzeirQwNgQU9Uu3ltM52YBT51DiuL7hJ5JJGxoJvrWclKMWHbbppb+pQkKx
         KDKfpRWiXziD/MXWzzABovwITRtjHE9vB8GEAqvXVfMqLi+TUZAD3vw4qyRDK14RNT+Y
         oTTGlnxw9BqHtnFzySj92mEa51cqYy2iFbpUvf3PTlHih5C+vrUdkz56wSVnsRzdfT1K
         qqHPeF9Zw0hNLnrlDUH3m8TBRxN3ZvtFD9/2CfAmEKX1sB9ZpJPAYqmpSnJWXyYDnwpf
         owxWTCd5VTgS3zaVHfGLMdQ6AJAot4NDdqNT6TGwXyhhDhw7h+yuNH4OcD1lSdjY99Te
         5ylQ==
X-Gm-Message-State: AC+VfDxADNCI+iAQUtn1vWiA3L2yt7jUBaR7RzgAcZz0azTPTo8KFHBN
        BByOsoAk8ECRytAAryQrkxVc90LyQADjMObQmqE=
X-Google-Smtp-Source: ACHHUZ5xG8hArk7RVBqPbdwEYsgopeyJyEV6AuYElV6nBVR81Z9VIWOuhYsMkzXmJkXcpC7njcrEVg==
X-Received: by 2002:a05:6a20:7da1:b0:123:9582:e9fb with SMTP id v33-20020a056a207da100b001239582e9fbmr209436pzj.50.1687357134314;
        Wed, 21 Jun 2023 07:18:54 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b0063f1a1e3003sm2980473pfv.166.2023.06.21.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:18:53 -0700 (PDT)
Date:   Wed, 21 Jun 2023 23:18:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Message-ID: <20230621141850.GE2934656@google.com>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
 <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
 <20230621131716.GC2934656@google.com>
 <20230621134130.tm2oucg5eskelwzr@cab-wsm-0029881>
 <20230621135518.GD2934656@google.com>
 <20230621135938.outx6qezuholc3hy@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621135938.outx6qezuholc3hy@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/21 13:59), Alexey Romanov wrote:
> On Wed, Jun 21, 2023 at 10:55:18PM +0900, Sergey Senozhatsky wrote:
> > On (23/06/21 13:41), Alexey Romanov wrote:
> > [..]
> > > > +static bool zspage_empty(struct zspage *zspage)
> > > > +{
> > > > +	return get_zspage_inuse(zspage) == 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
> > > >   * that hold objects of the provided size.
> > > > @@ -1787,6 +1792,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
> > > >  		obj_idx++;
> > > >  		record_obj(handle, free_obj);
> > > >  		obj_free(class->size, used_obj, NULL);
> > > > +
> > > > +		/* Stop if there are no more objects to migrate */
> > > > +		if (zspage_empty(get_zspage(s_page)))
> > > > +			break;
> > > >  	}
> > > 
> > > Yes it seems my version is not as good as I thought. Looks bad for an
> > > architecturally dependent PAGE_SIZE. [..]
> > 
> > Well, we are looking for a solution that is both reasonable (perf wise)
> > and is maintainable.
> > 
> > > I can implement this option. I'll test this and send patch this week.
> > 
> > Either that or, if Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru>
> > is good enough for you, then I can send a series tonight or tomorrow (after
> > some testing). I have two more patches on top of that one.
> 
> Yeah, Suggested-by is OK. Let's send a patch. Thank you.

Got it.

Let's hear from Minchan first, just to make sure that Minchan is OK
with that.

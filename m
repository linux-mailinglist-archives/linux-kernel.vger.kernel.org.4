Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41E618F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKDEDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKDEDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:03:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB081E3C1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:03:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so3802700plc.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1loK7ln7Hij0cyr/UscwcFeEgvc2r7/YpHlh6hYwV0=;
        b=g6q7D/fZTjK71kCf1Zpq3gH90C7KTwReQbFPBMIl3dMGBsh3gM6ms2wcSp6Zr94wX3
         hh+JW+K7+l++Uuu14kBRKZkNcY/kG7Hcbcv+a32D/Ier9tOkVHKYUXy4SXqhkNOGKNy4
         7nM9Y/y7al3ydpjxZqG3J8eIR3e8QCmBlWNGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1loK7ln7Hij0cyr/UscwcFeEgvc2r7/YpHlh6hYwV0=;
        b=Y6RD4/Ckv5ywsM0MBBJx/6Hn80yVsAW+Xsy6Ec48fA8WEAomqjAKnHArpK2Qaod4Nh
         m4RNdbuWp/e9ThqPHkDhhGvK0BjS+TLK2inKVz2xKK09w/yw1hqQ50VyC4bDS+g1z0ep
         Rnf7NlZwbjvU2Hp1iIbBKC8sZxYKGh9VaDyasEv233/gZxgl8sNnYii7B7EV1SlaTj52
         VavLbjp/zW2FyfR9O+D+Ch4sSq/fvX15C/fvD2GL9eknDLaCARshLqm9lt0FU7vjA+PM
         15i8Z98JyUJm6qp8oLzzC3tcMWjYqtfUioqHZsS4SwsywfyrUFQEpZmGuhIJcYBDqaLv
         WQRw==
X-Gm-Message-State: ACrzQf2hFM3u3VspSk3eckikYD1URE+GYq9HnpuuiFpohQ/mRlUaZw+x
        Qod6dRESMP0C+0nUPhWZ0iwyPg==
X-Google-Smtp-Source: AMsMyM4V0UeLmQDFUWvKWnUjdFyJBMuOGsdUSkSqQJ1xqCIqojqCTcjDV2sZAoDSocwg0mrEkCC8FA==
X-Received: by 2002:a17:90b:1252:b0:213:beea:80c0 with SMTP id gx18-20020a17090b125200b00213beea80c0mr30981536pjb.169.1667534585374;
        Thu, 03 Nov 2022 21:03:05 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b00186acb14c4asm1492301pls.67.2022.11.03.21.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 21:03:04 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:02:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2SO80b+byMavdqd@google.com>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
 <Y2HuhiyorAHFO+Ss@google.com>
 <Y2PwQTk016ngDKhc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PwQTk016ngDKhc@cmpxchg.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 12:45), Johannes Weiner wrote:
> On Wed, Nov 02, 2022 at 01:13:58PM +0900, Sergey Senozhatsky wrote:
> > On (22/10/27 11:27), Nhat Pham wrote:
> > > +
> > > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> > > +			unsigned int *reclaimed)
> > > +{
> > > +	unsigned int total = 0;
> > > +	int ret = -EINVAL;
> > > +
> > > +	while (total < pages) {
> > > +		ret = zs_reclaim_page(pool, 8);
> > > +		if (ret < 0)
> > > +			break;
> > > +		total++;
> > > +	}
> > > +
> > > +	if (reclaimed)
> > > +		*reclaimed = total;
> > > +
> > > +	return ret;
> > > +}
> > 
> > The name collides with shrinker callbacks (compaction). That's a bit
> > confusing, took me some time.
> 
> Yeah this tripped us up too.
> 
> Unfortunately, this is inherited from the zpool API:

Yeah, sure. I don't ask to rename zpool API, that was just a personal
note that it took me sometime to figure out that now we have two different
shrinkers.

> > > @@ -482,6 +504,7 @@ static struct zpool_driver zs_zpool_driver = {
> > >  	.malloc_support_movable = true,
> > >  	.malloc =		  zs_zpool_malloc,
> > >  	.free =			  zs_zpool_free,
> > > +	.shrink =     zs_zpool_shrink,
> 
> There is another terminology collision around "compaction" and
> "migration": There is zs_page_migrate() which is called from physical
> page migration and compaction to switch out backing struct pages of
> the zspage. Then there is migrate_zspage() which is called from a
> *shrinker* through *zs_compact()*, and it consolidates the objects
> from partially used zspages into full ones.

Oh, yeah...

> We're collecting these issues and want to clean them up separately. It
> seems this codebase hasn't had a lot of TLC recently, which makes it
> harder to make needed changes :/ We try to clean up as we go, but some
> of these issues (like the .shrink callback) run through all backends,
> zpool and zswap, so they'd be better off in separate cleanup patches.

Totally agreed with the separate effort/patches.

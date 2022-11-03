Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75B618516
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiKCQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiKCQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:47:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C757711465
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:45:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v8so1492800qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKMy7vvG6YYF5wQMm1icsLnPedAtQwFXPokV8+4Z/ZY=;
        b=DoPOEida6LMHH/oOiunX8ZlYSM9Ag6JVBBT+cH03AOIBHPHSvwvIFUJxyY4Wm8k+rB
         epNUt009h7ImXwPJmq8qDnwGfcdSqu9ms1Dy+L3iFSNsMZ046dqeTCpOuzpvEk1Oiejw
         Wz1LHhNUGrOHBgm5ENt1Zku6YICthcN5SLgf4hqpZtHlff5C27EvIXeNxNk4IcqZSg0y
         3joiy0EwFc6iLhNp8cdZ5N6yxLBjUgku3uGs099KVn2ZVgIzpo3B2i4BtzDPdEVM7+Jn
         4LPRSqdBFRHM9i9w7lHT2SQPLk0Zi/zcIKpOMXFeZRPqRE62Rdrvrf8o49TLtciLTLmR
         zl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKMy7vvG6YYF5wQMm1icsLnPedAtQwFXPokV8+4Z/ZY=;
        b=vhiPXMQrw9LxXwvrITcVaspMtn8Va9ShUp2LBP4fWFQkqn4aT4mEDzBoT9PyQhwWNB
         wBgMtcm054T+nhxiDJKMjU7UeL5SQbj+rUpPmOZyazPGLxbOK6iKuDFh5Mbi4QI9U3AC
         bX34mqlGWfD74+SLLPyjfpwDb+70fI/bndszkt2FkcIzp0yKVUADjP59ID1v9pH2Kw6K
         lB0aWpLYCq6x8IWFnrg3cDu1XA09byDuVIE4LXCCtGwssO6a7kYpkDb7N/iANN0jEyBX
         y78hnSVFjK478oSDjqvqtY5/mA8L9bVUxLuHfEQGiCL0WTPh+6q40C+eL1ijZcZwCobE
         xnRA==
X-Gm-Message-State: ACrzQf0AWVAeV7m2G15eN5YdhZAQrzMpqDwY4fELTP/6LcE961Ndy/5o
        SygqQStsPXMHm6p+BtA47jgGQQ==
X-Google-Smtp-Source: AMsMyM56KZrea0ChiCMU96BUzboc1+CVBBe8qAsK5/QKtTIG02vtCiQnEQcLQByfZMV9Lx4vhwZ0CA==
X-Received: by 2002:ae9:f714:0:b0:6fa:43e5:4be0 with SMTP id s20-20020ae9f714000000b006fa43e54be0mr12684824qkg.243.1667493950999;
        Thu, 03 Nov 2022 09:45:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id k8-20020ac86048000000b0039a08c0a594sm778017qtm.82.2022.11.03.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:45:50 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:45:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2PwQTk016ngDKhc@cmpxchg.org>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
 <Y2HuhiyorAHFO+Ss@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2HuhiyorAHFO+Ss@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:13:58PM +0900, Sergey Senozhatsky wrote:
> On (22/10/27 11:27), Nhat Pham wrote:
> > +
> > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> > +			unsigned int *reclaimed)
> > +{
> > +	unsigned int total = 0;
> > +	int ret = -EINVAL;
> > +
> > +	while (total < pages) {
> > +		ret = zs_reclaim_page(pool, 8);
> > +		if (ret < 0)
> > +			break;
> > +		total++;
> > +	}
> > +
> > +	if (reclaimed)
> > +		*reclaimed = total;
> > +
> > +	return ret;
> > +}
> 
> The name collides with shrinker callbacks (compaction). That's a bit
> confusing, took me some time.

Yeah this tripped us up too.

Unfortunately, this is inherited from the zpool API:

> > @@ -482,6 +504,7 @@ static struct zpool_driver zs_zpool_driver = {
> >  	.malloc_support_movable = true,
> >  	.malloc =		  zs_zpool_malloc,
> >  	.free =			  zs_zpool_free,
> > +	.shrink =     zs_zpool_shrink,

There is another terminology collision around "compaction" and
"migration": There is zs_page_migrate() which is called from physical
page migration and compaction to switch out backing struct pages of
the zspage. Then there is migrate_zspage() which is called from a
*shrinker* through *zs_compact()*, and it consolidates the objects
from partially used zspages into full ones.

We're collecting these issues and want to clean them up separately. It
seems this codebase hasn't had a lot of TLC recently, which makes it
harder to make needed changes :/ We try to clean up as we go, but some
of these issues (like the .shrink callback) run through all backends,
zpool and zswap, so they'd be better off in separate cleanup patches.

The out-of-control locking complexity in zsmalloc is another one of
these issues that we hoped we could clean up along the way, as you
have noticed...

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10431672399
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjARQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjARQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:39:31 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E7956889
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:38:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 78so24917035pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Foz49HGFCuNsir/bxiiNZnzF4mHlFRDMp9orOynQD2c=;
        b=qk8/IW0hGH+8HaFRWI3/75oe5aOLizN/8ejXFtU8n8sLi6Ni2mk8APpY2epKLjK09A
         kLZF+ZHWKf4aeDJDKVzvU5UGbyDmDg+x+lTd5+xLdR1OEXBwnGPcQnxhfb+sa9+X56rL
         KAcLqv8mMIsG9QC2poZ1SzaPLuCI9ag6XoklcX+t9gZPKTEljLCAcr9GbK9bhQeKNCLh
         72Q5A2HlBwsYJw4HDWCyM1XkQvMvgn8oNECVgR788J5uF+Q/5mCmLeOgzkgxkxhQMaBT
         NRvQf2cBk9INh/pql/pCM/EtKWPChoGnDUbxHJ84jn9LNicXetJk10FASb+A56+KwizL
         BGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Foz49HGFCuNsir/bxiiNZnzF4mHlFRDMp9orOynQD2c=;
        b=q/8YWjIlkrFl6Oftq2/aiHKq9XfaZ28QLGZpcacdId7DyvXwRolbooV0Gh+kC79PUZ
         Y6pYYLjVpwl5Xlsel4YXqFKe8PRpW/RzH19J/kJURjNLD2sSyL/p3p3nKnwVg91U5iCu
         1QXcMvghklx9gxkki1Df/tZ/LQv48RbUQ9G2SpcQYFxjLwAReufWLDpDHxf1SFw7s1fD
         CmSx1Zp3AF5JBDYr2pbDIlR9AK1tsvqS1MIHLV+08wzYqMVXdbKfufSTH/MfNJeE+dY5
         c1T/82kCPUYbaxpumIP6F6DdREQ3/DAlESBrc/4qYyTWVJEXHVjGGc4Ler5yUZu5c7d+
         gQRw==
X-Gm-Message-State: AFqh2krpx9FGdnVCZFkli1IE/PhzqZGGwU4lkfK87CFqnAXOXGkJkTIO
        3J5zzFiT8SOAMc6ciIPDBfs=
X-Google-Smtp-Source: AMrXdXvWCg7JN5Z7b151tXJ3SqU+HuhzICftCxhXH8ZFDG+6cYmb9PRyBBJwbbmlYomImzCIj3vujw==
X-Received: by 2002:a05:6a00:4c85:b0:58d:dfb1:8023 with SMTP id eb5-20020a056a004c8500b0058ddfb18023mr5123180pfb.15.1674059914765;
        Wed, 18 Jan 2023 08:38:34 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a13-20020a62d40d000000b005893f281d43sm17638973pfh.27.2023.01.18.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:38:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 06:38:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Arnd Bergmann' <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
Message-ID: <Y8ggiF+7k0rViXcY@slm.duckdns.org>
References: <20230117164041.1207412-1-arnd@kernel.org>
 <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 18, 2023 at 09:31:18AM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 17 January 2023 16:41
> > 
> > In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
> > type on 32-bit architectures because the enum definition has both
> > negative numbers and numbers above LONG_MAX in it:
> > 
> ...
> >  	/* convenience constants */
> >  	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
> > -	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
> > +	WORK_STRUCT_WQ_DATA_MASK = (unsigned long)~WORK_STRUCT_FLAG_MASK,
> >  	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
> 
> How can that make any difference?
> You aren't changing the value or type (which makes no difference)
> of WORK_STRUCT_WQ_DATA_MASK.
> Indeed you require it to have the high bit set.
> 
> So if the enum contains a -1 somewhere gcc-13 will promote
> everything to s64.
> 
> Either declare gcc-13 as 'BROKEN' or change the:

I have a hard time understanding why gcc would change its behavior so that
there's no way to compile the same code in a consistent manner across two
adjacent compiler versions. The new behavior is fine but it makes no sense
to introduce it like this. If at all possible, marking gcc13 broken sounds
about right to me.

Thanks.

-- 
tejun

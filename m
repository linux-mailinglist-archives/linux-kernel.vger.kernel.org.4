Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37668CC45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBGBrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBGBrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:47:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B735260
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:47:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g9so9730281pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT2N/cNgYHeJTg3AnvqtHUtYbhomEZrsIqmnGNcfHCg=;
        b=lThdBjAnpO16dKQakceoxTO9O3emdVZ3d9CmFVBTY6PidwuzieqO6swkx6lsRYXOGu
         OGdKkvxqUr8FE7AF+Cly0Gh3MSV1+c7Rhp2ff1TwzE10qw8NCUrE2nkj+ebt9wR4x3Zn
         GPXA8Nt5o6K/v5TxIHduoEjvYpYZj7nMvzxXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT2N/cNgYHeJTg3AnvqtHUtYbhomEZrsIqmnGNcfHCg=;
        b=wytx/Euuo9qktOEGF+s49zscOAMIAYrZsSdeT3KVfFSH8f6tvMQDIWAxf1+uAsCKaM
         fCXbHl/ICuRukKarH7eYqztu67H2KKL8GR1gl2HsmQEyszffK54hF/1eLevtHeYw0i7s
         pXYX4f6VniJU/URmlC/0uXlyS2PxoQ9Hp8cEAgAUw5dXCEp05+RirGqdoZb5DNAsOJFF
         /q23shB2CGESeWIoghzcJ8aw07BFMkMHHvW1SHKzdiS3njfA4xapWDGBbK8qeEMJBAcR
         KmW1sw1dOEZfgOBF8xi42JXisUMqJGc1/SS62RJET8cMpt5de1B4kyQIIKzrx8z2Qhj/
         WSMw==
X-Gm-Message-State: AO0yUKWME0P5nTG2r+OH+lxtUQH7khZFhBW1vNzqWbTg2oiuthEzYdyg
        6qLb//ZCqfjBQSegABr/8YPGRg==
X-Google-Smtp-Source: AK7set9lQ9uyNxpo009dAjF+P5fdv8ArpSJXT+18At0hzWO5JcIIJxtkeejej2IxAt0IIoRVYrDXmw==
X-Received: by 2002:a62:384f:0:b0:590:6d2f:d23a with SMTP id f76-20020a62384f000000b005906d2fd23amr1624385pfa.10.1675734453061;
        Mon, 06 Feb 2023 17:47:33 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m20-20020aa78a14000000b005a77b030b5csm233041pfa.88.2023.02.06.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 17:47:32 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:47:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y+GtsM6vJge90LHe@google.com>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org>
 <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/06 17:02), Yosry Ahmed wrote:
[..]
> > A 1/10 difference in ratio between fullness groups is intentional
> > and critical for classes that have a high number of objs_per_zspage.
> > For instance, class-624 stores 59 objects per zspage. With a 1/10
> > ratio grouping, the difference in inuse values between the page
> > with the lowest and highest inuse in a single fullness group is
> > only 4 objects (2469 bytes), whereas a 1/5 ratio grouping would
> > result in a difference of 10 objects (6240 bytes).
> 
> 
> The memory extra overhead would be sizeof(list_head) * nr of classes *
> extra fullness groups = 16 * 255 * 6 = 24480 bytes ~= 24KB on a
> machine with 4096 page size. Sounds reasonable (although I wonder how
> it scales with PAGE_SIZE).

It should be slightly lower than that. We never have 255 classes,
because clases get merged. On a system with chain size of 10 we
have 141 classes, with chain size of 8 it's 119 and chain size of
16 gives us 192 size classes.

> >  enum fullness_group {
> > -       ZS_EMPTY,
> > -       ZS_ALMOST_EMPTY,
> > -       ZS_ALMOST_FULL,
> > -       ZS_FULL,
> > +       ZS_USAGE_0,
> > +       ZS_USAGE_10,
> > +       ZS_USAGE_20,
> > +       ZS_USAGE_30,
> > +       ZS_USAGE_40,
> > +       ZS_USAGE_50,
> > +       ZS_USAGE_60,
> > +       ZS_USAGE_70,
> > +       ZS_USAGE_80,
> > +       ZS_USAGE_90,
> > +       ZS_USAGE_99,
> > +       ZS_USAGE_100,
> >         NR_ZS_FULLNESS,
> >  };
> >
> 
> Is there a reason why this can't be done with something like #define
> FULLNESS_GROUPS 10? We can make sure during build that (100 %
> FULLNESS_GROUPS == 0) to make our lives easier. I feel like the code
> will be much more concise and easier to navigate, instead of multiple
> enums and static arrays.

I wanted to keep things the way they are to make reviews simpler.
We probably can do something more "disruptive" in a separate patch.

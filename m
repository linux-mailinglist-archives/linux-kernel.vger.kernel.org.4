Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2FE70E09A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjEWPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjEWPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:33:42 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE471AE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:33:33 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4effb818c37so8417752e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684855952; x=1687447952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IA+o4TYzj/wUc+bKRC5VylEuRukqJEtvNsD6FrfEKbI=;
        b=cwqo3MNBzGhzZAH/q9y2Torq7BU6ej3XDe25GqHo4ZTpcitBLrK4o+abJzqFs/yka4
         3trzSTSfZih1vWNe5PBVRb9qk0M7ZfyZdP911n5jfFYG6rR5gY9vWITNUjpMoHOIvADF
         OsYOKbxghZQfuzkdmrx3GGlGEgLdpis5K+SV3lNnbYohemoVAnqupFttSq2/TOHblf4k
         zyrNc74ie+s3j9lXG116zfwRUj/PYAHJDgfCS5HfZwfU94hJgb2PrQSCs1C4WF1aTmz+
         hri6fTVTZvYPSY3rTHtj/f70XFkXzXzZOowZWLnO5yEkyuZTq2xFH7g4Wsg4pP5UoHcm
         c/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855952; x=1687447952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA+o4TYzj/wUc+bKRC5VylEuRukqJEtvNsD6FrfEKbI=;
        b=XCeUE1SfbXxFaTrPAZgulhKHKB6Gr8CAUr19MOA39eR/6zqkUIg6gtV7mujSLp48Gm
         UAdlyVy6ehCA+a8X8j40k8x3PjQc9PLaJhLjnK1481UcSBa1l/nOOPnXrYitMKfmfBAA
         /Op43rN5RNkXt5Ps0zLUWJ46KaeeDO27m6SIWPFMtSxdOChvfsH3LqSffYa84oCCw8Ek
         3UYtOS8EuWeUc43xiyDEJKGewUzKzPEdAXHwTOgXOA2gPpoYmDOZFNPXED8ySNsfkLXv
         eFlIrk7J+gG3qgyhe7gD4LwZjFw7F/LjcWyNx5X0e9kyXsCGHjKcG+ifooWiwJNw/B10
         n7cg==
X-Gm-Message-State: AC+VfDy2y4RGMOv83MtpgGdxUuSBSVCLTxuO4CsiXGtYPl6Gndfrf3RT
        qWDkRyYGqr8gGgpBkw2omHI=
X-Google-Smtp-Source: ACHHUZ4qQXNc5zVZIoSn00zDoKQbllQw4NAyB1PI6m5/K4VTNEo/Mk/CgptF1aF1BQy5Kg1SKVgUFA==
X-Received: by 2002:ac2:491a:0:b0:4ef:ec33:9155 with SMTP id n26-20020ac2491a000000b004efec339155mr4417410lfi.28.1684855951824;
        Tue, 23 May 2023 08:32:31 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id t15-20020ac243af000000b004f3b4a9a60esm1374593lfl.106.2023.05.23.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:32:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 17:32:28 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/9] mm: vmalloc: Add a per-CPU-zone infrastructure
Message-ID: <ZGzcjDG2t1/zIUKR@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-5-urezki@gmail.com>
 <ZGxYZlLoADBWktT8@infradead.org>
 <ZGzTZWq/hAYCE3DA@pc636>
 <ZGzYK4x6+anak3Ew@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzYK4x6+anak3Ew@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:13:47AM -0700, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 04:53:25PM +0200, Uladzislau Rezki wrote:
> > > > +#define fbl_lock(z, i) spin_lock(&fbl(z, i, lock))
> > > > +#define fbl_unlock(z, i) spin_unlock(&fbl(z, i, lock))
> > > 
> > > Even if it is just temporary, I don't think adding these wrappers
> > > make much sense.
> > > 
> > If open-coded, it looks like:
> > 
> > spin_lock(&z->fbl[BUSY].lock);
> 
> Give the fbl structure a name and you can have a local variable for it,
> which will make all this a lot more readable.  And then unless there is
> a really good reason to iterate over this as an array just have three
> of these structs embedded named free, busy and lazy.
>
OK. I can go that way.

--
Uladzislau Rezki

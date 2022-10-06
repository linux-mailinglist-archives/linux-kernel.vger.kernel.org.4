Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6F5F60DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJFGGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:06:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0B80F6D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:06:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j71so1013909pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xCHI/r7UbHwyMZPNpnw09K/IltGzRjSwUGHvdJZJsaQ=;
        b=QkivrckY6BxtU90PHTS9urU/QFYuYV6A8No2pgvWCYaKaWnfwnXwXn9n9Hlu7rc9Gz
         PF8J38OvUjMTABPhNOzmwZgWrUsnHspOTYs8eCei5wKHxQqNFti1+zpKRMZ0xOnZ/jXn
         fYjN0fJmgkdlnGmDGws/L2QHaFAKvLplJIK50d4H2ahNtOCfFi7PlwQLTxuMdFWdoA7R
         eCPSAqvjtcvDcMzrUmpGdCR909NGPds6ePz7Me9zVz5d+nwjCEWE3doHTZyp2kzuqDVg
         BgvKey+ESWYQ0c78/6tDcnVY/ZhAygnzc8QpbZIeCSCrhvw0UWQ9xXJ2MP1WPNBamrF8
         R+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xCHI/r7UbHwyMZPNpnw09K/IltGzRjSwUGHvdJZJsaQ=;
        b=ypShaxuT1eZohE/cSmCeJlgo12Ot8abfL7bBrz6BUKLJejaZFxvGGLWSXoPSTfQvkE
         4RsHW9U+PZpddGYsTsVlbtO7+tdHVg7J41t24IdewLAPVii6t6yPtfhn0jesnkv6+qoN
         ZKjFooVvBAQOdICfGoFveo6x/oqY+F9ACGiGFd8eWYPIaYfAyjzDV0HK4BEW8n23qLX+
         Ir/Lp54t0zI4FnI/zlBMyd4szcFnG7ee7W4UgvZnuZdCQnY88taNGik9g+IN51AUvQEn
         uHMYag2vscZ3dTRQ53mblxmoPj2ZLx5ex4B2oil18mebzIywIX7C71mHJ1xUG/2On+HZ
         Gn2Q==
X-Gm-Message-State: ACrzQf3/z4N8u9x4RDHO5AWuzalf6IAanArjsv8F+mUkQ8LlkJg+KEwy
        K9Um+YbxeAnZRkPzKiaW69Q=
X-Google-Smtp-Source: AMsMyM5agK3pdJJ+CB5+aM16SGzZhNY7z2jpRBmI86Eu3yEmvdH1YWJ1IZj/IB7pOOcFUn0QFo4Crw==
X-Received: by 2002:a05:6a00:1304:b0:555:6d3f:1223 with SMTP id j4-20020a056a00130400b005556d3f1223mr3507945pfu.60.1665036397054;
        Wed, 05 Oct 2022 23:06:37 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00172fad607b3sm11589190plg.207.2022.10.05.23.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:06:35 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:06:30 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
Message-ID: <Yz5wZqREKPb3MYVr@hyeyoo>
References: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
 <Yzqary4Fi1sTHVSQ@hyeyoo>
 <fefe11f3-2d1f-36e0-2c3d-7f35df71c4b6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefe11f3-2d1f-36e0-2c3d-7f35df71c4b6@rasmusvillemoes.dk>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:25:26PM +0200, Rasmus Villemoes wrote:
> On 03/10/2022 10.17, Hyeonggon Yoo wrote:
> > On Fri, Sep 30, 2022 at 12:27:12PM +0200, Rasmus Villemoes wrote:
> >> Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
> >> is rather time-consuming; on my board it takes around 11ms. That's
> >> about 1% of the time budget I have from U-Boot letting go and until
> >> linux must assume responsibility of keeping the external watchdog
> >> happy.
> >>
> >> There's no particular reason this would need to run at device_initcall
> >> time, so instead make it a late_initcall to allow vital functionality
> >> to get started a bit sooner.
> >>
> >> This actually ends up winning more than just those 11ms, because the
> >> slab caches that get created during other device_initcalls (and before
> >> my watchdog device gets probed) now don't end up doing the somewhat
> >> expensive sysfs_slab_add() themselves. Some example lines (with
> >> initcall_debug set) before/after:
> >>
> >> initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
> >> initcall journal_init+0x0/0x138 returned 0 after 517 usecs
> >> initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs
> >>
> >> initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
> >> initcall journal_init+0x0/0x138 returned 0 after 32 usecs
> >> initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs
> >>
> >> Altogether, this means I now get to petting the watchdog around 17ms
> >> sooner. [Of course, the time the other initcalls save is instead spent
> >> in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
> >> overall change in boot time.]
> > 
> > This looks okay and just curious,
> > can you explain what kind of benefit does enabling watchdog early provides?
> 
> The watchdog is _always_ enabled, from power-on onwards. There's nothing
> one can do to disable it (short of using a soldering iron to modify the
> board...), and usually nothing one can do to program its timeout [if it
> is at all configurable, it's done during board design using appropriate
> resistor/capacitor values].
> 
> All the custom boards I've met, across the very different industries
> I've worked with, have always had such an external watchdog. Their
> timing requirements may vary; currently I'm working on a board which has
> a 1s margin, but I've also encountered something as low as (IIRC) 400ms.
> 
> While 10-20ms may not sound impressive, this is not the first nor the
> last patch I'm trying to get upstream (see e7cb072eb988 for another
> example, done in connection with another project) to gain as much margin
> as possible - we want to be able to continue to upgrade our kernels for
> the next 5, 10, 20 years, and undoubtedly the mainline kernel will grow
> features and overhead in that timespan which won't be offset by better
> compilers.
> 
> Rasmus

Thank you for such a detailed explanation.
Now I get your motivation for this.

To best of my knowledge 1) it is not increasing boot time significantly as
it is just postponing slab_sysfs_init(), and 2) it is still before init
process so some systemd scripts interacting with SLUB sysfs interface
ran just after boot won't be broken (and at least on my machine it didn't).

Thus..

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon

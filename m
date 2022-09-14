Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906085B8E93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiINSIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiINSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C603861DC;
        Wed, 14 Sep 2022 11:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F90461E6A;
        Wed, 14 Sep 2022 18:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF6FC43147;
        Wed, 14 Sep 2022 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663178880;
        bh=8QO6bezE+2K66FghJrVXTS5RtL94PMOZ3HUJaLfntwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HWyfrzoHehEIavhH0FSENC4JAl8tEfACVV0EcKmgJTzz5TmvQ2cnxAl5LY7uNl4mH
         qdPv4Mb6NFc2gUWo4Alk3cKLUKviK5+TbwHcf8yRMl9SeSndcJf3rI2h4Gqq5G09d+
         tkcML9ZrQS/FZ3M5vL3vUpIDA+zBy1/ts+GShucqdut5M28lSNmb8iUFoBgO1hnASQ
         /4A39HsAYbSQ6Xjj1f3WduoaOq0vL47e2QOFlZQIQ3r7dCgw9Qj7sUPyHYd3vtgril
         OwJ+wsy22o/ruYXmtJ2gRHucakBcnersIGClmLXVYJQTHVmx1AIlSF13n7u6pCqOoQ
         k7t8lnGj+bDgg==
Received: by mail-vk1-f176.google.com with SMTP id s192so7873704vkb.9;
        Wed, 14 Sep 2022 11:07:59 -0700 (PDT)
X-Gm-Message-State: ACgBeo2HZwkPuRd3ZApxc+0IV2gCJ/ZjfpBkS09ldmseCL81WIGeaPui
        3fmPYpONYux/4cyCM576PHjuPUkPh1dgva1OAg==
X-Google-Smtp-Source: AA6agR5e7YhAc50wVpbeL+nwFLR7EEXrTzSrB3+SbLjm7qzwukA3T8qMv8Q9XbVsrcu5TfJXz1WuSkUl1XpmcLAHTDs=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr11413773vke.15.1663178878750; Wed, 14
 Sep 2022 11:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220913195508.3511038-1-opendmb@gmail.com> <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
 <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
In-Reply-To: <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Sep 2022 13:07:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6+uYf=Pb82j3CWC3iD=-hbnf3nj_TsHoQAUcLK3mKbg@mail.gmail.com>
Message-ID: <CAL_JsqJ6+uYf=Pb82j3CWC3iD=-hbnf3nj_TsHoQAUcLK3mKbg@mail.gmail.com>
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:57 AM Doug Berger <opendmb@gmail.com> wrote:
>
> On 9/14/2022 6:21 AM, Rob Herring wrote:
> > On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
> >>
> >> MOTIVATION:
> >> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> >> controllers with each mapped in a different address range within
> >> a Uniform Memory Architecture. Some users of these systems have
> >> expressed the desire to locate ZONE_MOVABLE memory on each
> >> memory controller to allow user space intensive processing to
> >> make better use of the additional memory bandwidth.
> >> Unfortunately, the historical monotonic layout of zones would
> >> mean that if the lowest addressed memory controller contains
> >> ZONE_MOVABLE memory then all of the memory available from
> >> memory controllers at higher addresses must also be in the
> >> ZONE_MOVABLE zone. This would force all kernel memory accesses
> >> onto the lowest addressed memory controller and significantly
> >> reduce the amount of memory available for non-movable
> >> allocations.
> >
> > Why are you sending kernel patches to the Devicetree specification list?
> >
> > Rob
> My apologies if this is a problem. No offense was intended.

None taken. Just trying to keep a low traffic list low traffic.

> My process has been to run my patches through get_maintainers.pl to get
> the list of addresses to copy on submissions and my
> 0016-dt-bindings-reserved-memory-introduce-designated-mov.patch
> solicited the
> '- <devicetree-spec@vger.kernel.org>' address.

Yeah, I see that now. That needs to be a person for a specific
binding. The only bindings using the list should be targeting the
dtschema repo. (And even those are a person ideally.)

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F95B890A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiINNWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiINNVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:21:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD672B7C;
        Wed, 14 Sep 2022 06:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BCE0B81B54;
        Wed, 14 Sep 2022 13:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4369CC43151;
        Wed, 14 Sep 2022 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161698;
        bh=5eg3+MDl9mj9XaKfqXdunaBWCFhVKFc0lhc1VADdGlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=awke9ZXiGJAhz25PXRgSFckS8/SgyblY/V90V6y+T8HXt6Z74xy0aolItOKA+hCsi
         q1GGtin+Bukiq9wuTMFHvhTezXx7xPPFvKLpL7D2Y1klGJ4h6cfFkWEPlTFwWnNvtJ
         7iyZV6IfurOr3qmDtnl9u65/yDxU/93A6reINHOqyfzByJOxBy8RFjF29cTr/2YzjV
         87fAc8rJDae5roRDvHNChkGUh/M2HJX3RmxQwCjMOqa7KV9fTMU8e3+mitvB8ln1XD
         nmSwUGq350CRYLdI/1NMKJuWSsgY0FfGGvwFqOZKpTv4KADAuRG7TRwoS1ogZwajxA
         Al8UOngHVTLKQ==
Received: by mail-vs1-f46.google.com with SMTP id a129so15879295vsc.0;
        Wed, 14 Sep 2022 06:21:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo1NxFOU8xta+fiJad9sRgDEeZmkCGDNZG/oAWLvFnO/B7Y32NSl
        8rzU82VmtbIzwYvRGOxluzaQJziCxNrC8h/vJA==
X-Google-Smtp-Source: AA6agR56jMVfRX3RtWINn1f1vrMILDJRHWk9UzHiBvWRHbJ6w8oCSCG8tGKMh7eB+FbUCGbrLkT5kxjkTYjpwJ7X9+I=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr12924355vse.26.1663161697076; Wed, 14
 Sep 2022 06:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220913195508.3511038-1-opendmb@gmail.com>
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Sep 2022 08:21:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
Message-ID: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
>
> MOTIVATION:
> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> controllers with each mapped in a different address range within
> a Uniform Memory Architecture. Some users of these systems have
> expressed the desire to locate ZONE_MOVABLE memory on each
> memory controller to allow user space intensive processing to
> make better use of the additional memory bandwidth.
> Unfortunately, the historical monotonic layout of zones would
> mean that if the lowest addressed memory controller contains
> ZONE_MOVABLE memory then all of the memory available from
> memory controllers at higher addresses must also be in the
> ZONE_MOVABLE zone. This would force all kernel memory accesses
> onto the lowest addressed memory controller and significantly
> reduce the amount of memory available for non-movable
> allocations.

Why are you sending kernel patches to the Devicetree specification list?

Rob

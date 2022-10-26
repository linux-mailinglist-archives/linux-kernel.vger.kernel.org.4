Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C626760E024
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiJZMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJZMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:02:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9346DB4;
        Wed, 26 Oct 2022 05:02:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5150A2207D;
        Wed, 26 Oct 2022 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666785758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7e4B9MbvTUT94KALkUjhjJvQIZdQ+NZ1YEAmT1iPCak=;
        b=jBTiR2056OB5RGxD9Ep8aMTeGXS5/19j7BYWZI0qf+LmCe0xtKt55xiRpgEE2go33r73uC
        5eh7cB3vp1wG4kENaaylmSyX7DN1ZbZO8B3OEYEYi7EFk/0qGkY5ur7GwwdeWhPt3oBFJI
        gN00fCK1RtvMjhrBBXrL04kYq18Dd5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666785758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7e4B9MbvTUT94KALkUjhjJvQIZdQ+NZ1YEAmT1iPCak=;
        b=LCdWfDzVU66lhmR0RvgigsvxFNdO+VFt/FJY3rX/qAXyNZ6xS++brVDVFsdbKswA+qYVq9
        FwdjFLb226jabWCg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 279362C141;
        Wed, 26 Oct 2022 12:02:34 +0000 (UTC)
Date:   Wed, 26 Oct 2022 13:02:32 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Message-ID: <20221026120232.bbhfwjm32qq4mh57@suse.de>
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <20221026105500.n6ddzqqf5ozjswsp@suse.de>
 <b8a4cd98-8236-d6e4-ee36-550ae1c107ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b8a4cd98-8236-d6e4-ee36-550ae1c107ff@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:11:40PM +0200, David Hildenbrand wrote:
> > In the appliance case, it doesn't matter if the intent is that "all
> > application data should use high bandwidth memory where possible and
> > the application phase behaviour is predictable" and that may very well
> > work fine for the users of the Broadcom platforms with multiple memory
> > controllers. It does not work at all for the general where access must
> > be restricted to a subset of tasks in a general system that can only be
> > controlled with memory policies.
> > 
> > The high bandwidth memory should be representated as a NUMA node, optionally
> > to create that node as ZONE_MOVABLE and relying on the zonelists to select
> > the movable zone as the first preference.
> 
> ... that boils down to my remark to tiered memory and eventually using
> devdax to expose this memory to the system and letting the admin decide to
> online it to ZONE_MOVABLE. Of course, that's just one way of doing it.
> 

I don't see this approach being inherently bad as such, particularly in
the appliance space where it is known in advance what exactly is running
and what the requirements are. It's not automagical but it's not worse
than specifying something like movablecore=100M@2G,100M@3G,1G@1024G. In
either case, knowledge of the address ranges needing special treatment is
required with the difference being that access to the special memory can
be restricted by policies in the general case.

-- 
Mel Gorman
SUSE Labs

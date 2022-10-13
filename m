Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF625FD89A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJMLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJMLoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:44:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102DB3B0E;
        Thu, 13 Oct 2022 04:44:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE3D01F385;
        Thu, 13 Oct 2022 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665661470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMmSS4AY+rqawWn2v0MRI7PSJAdcG4hyfRiKwMa5Ogw=;
        b=DWT6zn20CotUlTzz2xVrLPR3wa2YHyYxf9oklHlkMjE8Ok84nJW7owpjekrewoYht9fQFR
        yp1FjzS2Df62DH6PlkG/sXwvdgM0FO+7X5PdW+p0elIiVAU7/F/9sA2iCAJpQtRqlj4IUv
        dGiACvcwo1AtxIcvNajqTHyWZrnsTpQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F9EC13AAA;
        Thu, 13 Oct 2022 11:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lYugJB76R2MZagAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Oct 2022 11:44:30 +0000
Date:   Thu, 13 Oct 2022 13:44:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/9] mm/vmstat: show start_pfn when zone spans pages
Message-ID: <Y0f6HZN8Z/AcP1+O@dhcp22.suse.cz>
References: <20220928223301.375229-1-opendmb@gmail.com>
 <20220928223301.375229-3-opendmb@gmail.com>
 <8e61d0f4-0c40-6c2d-da60-fa97e2ee7530@redhat.com>
 <b86d90fe-5d57-67ec-49b7-c477924f6438@gmail.com>
 <84ee3d9e-9579-d3f2-fe5a-ec6ec4a2710a@redhat.com>
 <0f038010-ed83-55bb-70a5-24f5c6d68666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f038010-ed83-55bb-70a5-24f5c6d68666@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 16:57:53, Doug Berger wrote:
[...]
> I was working from the notion that the classic 'movablecore' implementation
> keeps the ZONE_MOVABLE zone the last zone on System RAM so it always spans
> the last page on the node (i.e. 0x33ffff000). My implementation moves the
> start of ZONE_MOVABLE up to the lowest page of any defined DMBs on the node.

I wouldn't rely on movablecore specific implementation. ZONE_MOVABLE can
span any physical address range. ZONE_NORMAL usually covers any ranges
not covered by more specific zones like ZONE_DMA{32}. At least on most
architectures I am familiar with.
-- 
Michal Hocko
SUSE Labs

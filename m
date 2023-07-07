Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A874AC55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGGH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGGH5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:57:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7471B6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:57:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3521F1FE78;
        Fri,  7 Jul 2023 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688716630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oXGl2RHh2utP9BKE007mSj04cSpxSVlQJRSnyPwfww=;
        b=WYaR6N2ihFi/ZHF15scZpNz3dh5DqmBlK27ioXRU/7+XWRQexLVE0s7yg9okn+VVmSSAAD
        AgK9o+DJ6yZas752PSgB33VwAAHt8Il01N9tjeHswZzzn97ofZD7QXI2q1eXTwM51KWExu
        wzQbKSKrAySBjGOcH7avBeHPgpL0iMw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1905C139E0;
        Fri,  7 Jul 2023 07:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6P/HAlbFp2TYKwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 07 Jul 2023 07:57:10 +0000
Date:   Fri, 7 Jul 2023 09:57:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
Message-ID: <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-23 12:46:13, Zhongkun He wrote:
> This is a new solution to charge ZRAM objects,more simple than
> previous one[1],The compressed RAM is currently charged to
> kernel,not to any memory cgroup.
>
> As we know, zram can be used in two ways, direct and
> indirect, this patchset can charge memory in both cases.
> Direct zram usage by process within a cgroup will fail
> to charge if there is no memory. Indirect zram usage by
> process within a cgroup via swap in PF_MEMALLOC context,
> will charge successfully.

Please state the objective you are trying to achieve by this patchset.
It is always good to summarize the previous discussion and mention what
is done differently or how previous review feedback has been addressed
but the overall idea/purpose should be always explicit. 

Please elaborate more about both.
 
> [1]
> https://lore.kernel.org/all/20230615034830.1361853-1-hezhongkun.hzk@bytedance.com/
> 
> Zhongkun He (2):
>   memcg: Add support for zram object charge
>   zram: charge the compressed RAM to the page's memcgroup
> 
>  drivers/block/zram/zram_drv.c | 43 +++++++++++++++++++++++++++++++++++
>  drivers/block/zram/zram_drv.h |  1 +
>  include/linux/memcontrol.h    | 10 ++++++++
>  mm/memcontrol.c               | 23 +++++++++++++++++++
>  4 files changed, 77 insertions(+)
> 
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6186598A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiL3NVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiL3NVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:21:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E71ADBC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9263B81C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE49DC433EF;
        Fri, 30 Dec 2022 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672406495;
        bh=LqE9lGO8Ffb2OElWi6b389XL0OH0I74Q2AQefVosmI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THS0fZnVtjfLfCQHzNCAc6pECMpuUj89rW0AM2Z/cFZfM9e1uAoot+UF/PuK3pjDy
         5mN3bRt701/lD9nlTfxgBxQ8qdlUEpZTvs+sf4B83iiJOSBXesDac4Po1xGS5Knw4a
         CqohHqsBoCTPzufJvXaqJoujUbmwmBamvSjLR0dU7hDJx9z+AGpI0m2d8CgzUsYm9h
         GXIPeMGPCKitFCgifTpp3+KdDHWl0QyPn/TfhyNyTQYIysecm7O36Rn54g2JlSKH9w
         X8jBHpRrO8mWKSB4gQenha65v6lFBzkt9IkmcDd9AqmSIHx6xeQBZ0AUp0PkkRq3YI
         5WceaFQRtxyyw==
Date:   Fri, 30 Dec 2022 14:21:32 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@atomlin.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v12 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <20221230132132.GA186035@lothringen>
References: <20221227121137.102497574@redhat.com>
 <20221227121341.981235373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227121341.981235373@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 09:11:39AM -0300, Marcelo Tosatti wrote:
> @@ -606,6 +608,7 @@ static inline void mod_zone_state(struct
>  
>  	if (z)
>  		zone_page_state_add(z, zone, item);
> +	vmstat_mark_dirty();
>  }
>  
>  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> @@ -674,6 +677,7 @@ static inline void mod_node_state(struct
>  
>  	if (z)
>  		node_page_state_add(z, pgdat, item);
> +	vmstat_mark_dirty();

Looking at this further, about the two above chunks, there is a risk to
mark the wrong CPU dirty because those functions are preemptible and rely
on this_cpu_cmpxchg() to deal with preemption.

Thanks.

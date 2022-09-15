Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646E35B93BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIOExV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIOExT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:53:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CC92F66
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 21:53:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49B1C1FA8D;
        Thu, 15 Sep 2022 04:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663217597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp5m+Hr4qr576DrNyvsj++WSaXFTSF+h11ngNHuL2BQ=;
        b=U9tQsEykO643mz8CIF4D/QKjHaYSxvUbY7HdEx2WcICL35fHPsC7EAXDYeqK4xLbSGB1yE
        kAeSIUby5ut42I2vD3cCaihSrFQQj8mom0gIug9q3Avvyvu33dbSp9fyBJkYBaDn+VPLAw
        uge1cXgJrJpnSpJfT4qTTVDAZsULxE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663217597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp5m+Hr4qr576DrNyvsj++WSaXFTSF+h11ngNHuL2BQ=;
        b=4dgn8pcX5wftxBjmHtDN0caGySjEY6HnCta3HnPGzfxRParnxyd+WK0s0NiHAhmTy/2FHv
        tafEOTCmjkmi27Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E720E139B3;
        Thu, 15 Sep 2022 04:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dlKwNbyvImN5LQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 04:53:16 +0000
Date:   Thu, 15 Sep 2022 06:53:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] mm/page_alloc: fix freeing static percpu memory
Message-ID: <YyKvu17xGNgBwMLV@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-7-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:41PM +0800, Miaohe Lin wrote:
> The size of struct per_cpu_zonestat can be 0 on !SMP && !NUMA. In that
> case, zone->per_cpu_zonestats will always equal to boot_zonestats. But
> in zone_pcp_reset(), zone->per_cpu_zonestats is freed via free_percpu()
> directly without checking against boot_zonestats first. boot_zonestats
> will be released by free_percpu() unexpectedly.
> 
> Fixes: 28f836b6777b ("mm/page_alloc: split per cpu page lists and zone stats")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

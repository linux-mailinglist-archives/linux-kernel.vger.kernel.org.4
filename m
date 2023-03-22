Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E26C50C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCVQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCVQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:30:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7162FDC;
        Wed, 22 Mar 2023 09:30:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69FD833CFB;
        Wed, 22 Mar 2023 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679502625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UibS01Pfk6ASRJm2ju5xD7GWFCda3+C3KWJSo12Eptk=;
        b=cDEQKmw4rh2UoKJO2iBJpQcWPLG+Ut/wUkz7wEis2T1qWMhDsCVyd9A4Wrpb11kXCc5Pu8
        rDfdPRVCbZMC9joYoYmM5/n+aNPE33GMZCrCl+1FzGfePNHqrF5fjJUDPa6zkxTsZCiLJF
        rV4C8E2QdE1cu5Xo8bJ+CDNrciIy4Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679502625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UibS01Pfk6ASRJm2ju5xD7GWFCda3+C3KWJSo12Eptk=;
        b=Zk2ZELbv0Ibe+MEwHWUKG6eT36q7DjGAYreW5GTOhSgyk38wAMIX7cwfxP62yCUwb6iMRb
        YB9sDHNep3O1XxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4387D13416;
        Wed, 22 Mar 2023 16:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tJH2DyEtG2QMcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 16:30:25 +0000
Message-ID: <207101aa-4e4d-2229-fb16-10d3dae79167@suse.cz>
Date:   Wed, 22 Mar 2023 17:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/14] init,mm: fold late call to page_ext_init() to
 page_alloc_init_late()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-11-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-11-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 18:05, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> When deferred initialization of struct pages is enabled, page_ext_init()
> must be called after all the deferred initialization is done, but there
> is no point to keep it a separate call from kernel_init_freeable() right
> after page_alloc_init_late().
> 
> Fold the call to page_ext_init() into page_alloc_init_late() and
> localize deferred_struct_pages variable.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70986272FA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKMWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiKMWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9A3BF5A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668378837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2hoXnIfgvOzO3T+U/es9J0VUcpxguVgLPnnVOVorDE=;
        b=WGZYI9TOpdsXvMCJx1R1rOx/u5f4ixHCDoCEXIIqxniyRI0V2QgCvnLodpSJdmQSxwscC2
        3K6GW8fvt5Zj8HtrXAJRActfMkyp2Mutj7SoPz2zAcJc0tjSkYXHeGHNk2nfitRo5r0aXI
        V8DiPAFxqR7YOc+t/Q6qfd3wToK6sd4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-6i_QlRhwNCydeTzDZ0LiGA-1; Sun, 13 Nov 2022 17:33:55 -0500
X-MC-Unique: 6i_QlRhwNCydeTzDZ0LiGA-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso7485716qvr.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 14:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2hoXnIfgvOzO3T+U/es9J0VUcpxguVgLPnnVOVorDE=;
        b=Z5uKU8WlLs6yhRMS2CqBus3SymxBR7TY1eHlM4+OF9T7wKH9/akLtQiRD450ItAW2D
         Z7A8eHrmvqbhiNoS39Ad5/Wfcrzl5uJVrARJZ6bbbMtO7CbeFVHtS/Wsf2oS4SfcJoKm
         1qsAfAVcyOBuO7jWO8PQ9NhcExGQG5z9YwZI3tWfC5xCIKFE/tRILb+q1ocwD4fSK/gb
         7sugzVVbbNlRVGZwP8ISvte5vOiKXXyCQY16EunkNFFmB/SKSoIZYh2p+iRukyplcoOh
         rO6XndPHwdO801Rk+fvjtJSDeY69z1QEB2HP4094SoxaNLBreXCV/e3GpLjtgOy+r1Up
         RDlw==
X-Gm-Message-State: ANoB5pnrk1v/uMj3JBPBD8V6m6Z40X+jCynA/21+mjEN+u1xUqU0W7Al
        /NWVidTLzdAsEpOHoQooUZ49+lVKc/jkKQ1OUkhClvmFJhz9bODDWW+mzj1upFfIcLKgyaebaOa
        QiIbwAoJtvbtYzB90EcAgL3/m
X-Received: by 2002:a37:9343:0:b0:6ce:7d05:9f9e with SMTP id v64-20020a379343000000b006ce7d059f9emr8998648qkd.409.1668378835411;
        Sun, 13 Nov 2022 14:33:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eJQTFSP4CzAmOQbZu+GqM4Y5Eujvu4hcxKqkfEMsWacfjNBl7Li5FqqZNL/1wBRHLo8rusw==
X-Received: by 2002:a37:9343:0:b0:6ce:7d05:9f9e with SMTP id v64-20020a379343000000b006ce7d059f9emr8998637qkd.409.1668378835195;
        Sun, 13 Nov 2022 14:33:55 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id g26-20020ac8469a000000b003a5416da03csm4745644qto.96.2022.11.13.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 14:33:54 -0800 (PST)
Date:   Sun, 13 Nov 2022 17:33:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        oe-kbuild-all@lists.linux.dev,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] mm/uffd: Sanity check write bit for uffd-wp
 protected ptes
Message-ID: <Y3Fw0DcIr/rXLw3v@x1n>
References: <20221110203132.1498183-3-peterx@redhat.com>
 <202211120515.eqlTdrD3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211120515.eqlTdrD3-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 06:06:22AM +0800, kernel test robot wrote:
> vim +306 arch/x86/include/asm/pgtable.h
> 
>    290	
>    291	#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>    292	static inline int pte_uffd_wp(pte_t pte)
>    293	{
>    294		bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
>    295	
>    296		/*
>    297		 * Having write bit for wr-protect-marked present ptes is fatal,
>    298		 * because it means the uffd-wp bit will be ignored and write will
>    299		 * just go through.
>    300		 *
>    301		 * Use any chance of pgtable walking to verify this (e.g., when
>    302		 * page swapped out or being migrated for all purposes). It means
>    303		 * something is already wrong.  Tell the admin even before the
>    304		 * process crashes. We also nail it with wrong pgtable setup.
>    305		 */
>  > 306		VM_WARN_ON_ONCE(wp && pte_write(pte));

I just saw the comment in check_pgprot() right below:

	/* mmdebug.h can not be included here because of dependencies */
#ifdef CONFIG_DEBUG_VM
...
#endif

I'll repost, will be the same as v1 code-wise.

-- 
Peter Xu


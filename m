Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1664109A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiLBW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiLBW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:28:56 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308FCE2A86
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:28:55 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z14so2265485pfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mA7EbMY6jYQnBQ5a2EEJbPnWMt0mwJ2NvlH1bqAlVdY=;
        b=V060CW+9WaoNQd3JTJUfI6o9UkdRjdDPq8YkiSwizBRy26ilkRnNGJAXE7Vg9+lNlI
         2yoV5EBEzLEz03OO4J7or/HgCgJhox9GCPQSTfFmJl/8RH2WoDN4tpDIVB7c6tjjj1zw
         XpjdStemOWcnPqOer1QKZhSsCMKZ9rlqrOhavARkgcl9n0wfWmf1fpSwL9hSldz9SS2Q
         +S7s7eeJ4gTCgWzPJGljpfxS1WzJ/geX0nebjxdSA3dsEksaWk7t/oR7BC5dd7KrrXeT
         /mq07VibZtN+GbzY1ouUXHt/a9xxG1DhUAugzfWTojM3VFVZG3IlSe9RUyAoBjjhaMIa
         fEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA7EbMY6jYQnBQ5a2EEJbPnWMt0mwJ2NvlH1bqAlVdY=;
        b=HhdFNwxR5JZSDzoThdgqWDkGuFCBnRocJiFjJe2NHJu8skTw7HMdLtVByp/JMItptV
         InVlWe7kFTT8Vj+miavKBiKnwdRGDypPqGVUANeF+3iSv3ynONZHnbj3cji3ZYCkKFEN
         veaytIWUSSy6MJsc8dTR0+mMNzbplFAAhCm8Zapsg1u2oXUWbtQO6R0CLAErlJYiwLNV
         fJix3QbLOlScNiftI0yoIw/COwsbjSlNfgYINj9nV6dJtUPOrVpC2w1Lk0SWU+l++pEO
         p+z/qIZHp/S/3FRBT4Gh0rlQgeevMYHHeAuaq57rjrqma0YhgiEAm3Tb6yk5VL4ExjuD
         IppA==
X-Gm-Message-State: ANoB5plErMk+z+/fY78jII5F6qzdEkEDCXcXl+S3XIAKcBHX3dMreJyt
        1lu61HTHUItVHynJYswyhDrhyw==
X-Google-Smtp-Source: AA0mqf6uOp6LmsnTWIxJT0V0ir4lkWZqK0a+pL6GlLby9cQ/1qUsKnNUB7NKDQOcF0qmJT4HSWMCOw==
X-Received: by 2002:a63:e74a:0:b0:478:42f:5a3d with SMTP id j10-20020a63e74a000000b00478042f5a3dmr27833890pgk.3.1670020134604;
        Fri, 02 Dec 2022 14:28:54 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902710800b001891ad6eadasm5994649pll.251.2022.12.02.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:28:54 -0800 (PST)
Date:   Fri, 2 Dec 2022 22:28:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com
Subject: Re: [PATCH v2 05/18] x86/sgx: Track epc pages on reclaimable or
 unreclaimable lists
Message-ID: <Y4p8IuxyVLw2YPNy@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-6-kristen@linux.intel.com>
 <1dccd2ec-cad8-b9d2-d66b-aebad21cdb44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dccd2ec-cad8-b9d2-d66b-aebad21cdb44@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022, Dave Hansen wrote:
> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> > Replace functions sgx_mark_page_reclaimable() and
> > sgx_unmark_page_reclaimable() with sgx_record_epc_page() and
> > sgx_drop_epc_page(). sgx_record_epc_page() wil add the epc_page
> > to the correct "reclaimable" or "unreclaimable" list in the
> > sgx_epc_lru_lists struct. sgx_drop_epc_page() will delete the page
> > from the LRU list. Tracking pages that are not tracked by
> > the reclaimer in the sgx_epc_lru_lists "unreclaimable" list allows
> > an OOM event to cause all the pages in use by an enclave to be freed,
> > regardless of whether they were reclaimable pages or not.
> 
> This might be more a comment about Sean's stuff

Anything with a single space after a period wasn't written by me, I'm a devout
believer of two spaces :-)

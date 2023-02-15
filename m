Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591B698725
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBOVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBOVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:12:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17D5B8A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:12:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bx22so19503329pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eav0fiaseVs4SDSQHpahIhxgUvhBC0tlQhTpHFTiWO4=;
        b=MdIQ3AM+0L3PiKcCTqMh83LK5tq6yFDJy2B1wy6fF70k/2ImngbiEAPVJBjz3Yau64
         4LrwwSJ/YvKAbBGxin0ZbUFbKP1Kxttu5UdyMvcBfYOI82KSPV4FCBIf6hjYWECJOumL
         6RkF1BIOkVQKDA2K1tmL52cSQv5nxetaBeiM3eAIZMVrKytQKwja26xeikmjRdkroeo1
         fmTbByWkQ1Lxuvrbss7PjevHA5NpQxwy2c9HtnPLfS2cyFBBjABiuvFq9ApHCXWK35ip
         aJjK56boRbztovCcERs5QWtzca8QU4e5GuFSr4XVOD7DlTaw8WeatQQRFDng0Yi6wdJ1
         E/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eav0fiaseVs4SDSQHpahIhxgUvhBC0tlQhTpHFTiWO4=;
        b=1seNFZghK69epiU4pPbniY9NaHE5+A4+DP06PPA9v9kOt2bbtKbbhoq95QtpW+KhC1
         tHPywjOwK2lRbsckqhCV1Bsn1Aob0QDBgsEH8WnI1aNG6tcwBZ8daZpHBuzja+weJRxz
         k+hO1tzbyBtWvREUwCXFT3o6PxXgsEz5sQ5M9Y++xuHPM3H7oO2rZKActDwKDzCm+GZh
         WB9WY9ntgJiTKTB7d9P4fB1CVCkKW3wWI4dAWmA6HykNn57wFluxz8oWhK98zYrFm9xj
         xy5U6P5zMpVahD7WBLqh9z5YQD3oqzVGr75fqYop4JtcniBx2+/GQ8R3Mb10I5EAphka
         DEmA==
X-Gm-Message-State: AO0yUKVxUlt/TkJMW5oV+vWHE8W/JXiQSxSVmXR6DNWZonNsj6Izh4E9
        w9WyNssnoGH1NwKtgl8GFXGkQQ==
X-Google-Smtp-Source: AK7set97u9H84ursysruAo15IWHMQCQxucrBQNse1I8tXyREGYHUdOyTPK/3uJ0pj6DAq9HAyFDBJA==
X-Received: by 2002:a17:903:2886:b0:19a:ab73:2168 with SMTP id ku6-20020a170903288600b0019aab732168mr3225447plb.1.1676495537139;
        Wed, 15 Feb 2023 13:12:17 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902e8c500b0019a8283f272sm8883968plg.81.2023.02.15.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:12:16 -0800 (PST)
Date:   Wed, 15 Feb 2023 13:12:12 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 2/7] KVM: x86/mmu: Atomically clear SPTE dirty state
 in the clear-dirty-log flow
Message-ID: <Y+1KrHYEi1D4T14P@google.com>
References: <20230211014626.3659152-1-vipinsh@google.com>
 <20230211014626.3659152-3-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211014626.3659152-3-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 05:46:21PM -0800, Vipin Sharma wrote:
> Do atomic-AND to clear the dirty state of SPTEs. Optimize clear-dirty-log
> flow by avoiding to go through __handle_changed_spte() and directly call
> kvm_set_pfn_dirty() instead.
> 
> Atomic-AND allows to fetch the latest value in SPTE, clear only its
> dirty state and set the new SPTE value.  This optimization avoids
> executing unnecessary checks by not calling __handle_changed_spte().
> 
> With the removal of tdp_mmu_set_spte_no_dirty_log(), "record_dirty_log"
> parameter in __tdp_mmu_set_spte() is now obsolete. It will always be set
> to true by its caller. This dead code will be cleaned up in future
> commits.
> 
> Tested on a VM (160 vCPUs, 160 GB memory) and found that performance of clear
> dirty log stage improved by ~40% in dirty_log_perf_test
> 
> Before optimization:
> --------------------
> Iteration 1 clear dirty log time: 3.638543593s
> Iteration 2 clear dirty log time: 3.145032742s
> Iteration 3 clear dirty log time: 3.142340358s
> Clear dirty log over 3 iterations took 9.925916693s. (Avg 3.308638897s/iteration)
> 
> After optimization:
> -------------------
> Iteration 1 clear dirty log time: 2.318988110s
> Iteration 2 clear dirty log time: 1.794470164s
> Iteration 3 clear dirty log time: 1.791668628s
> Clear dirty log over 3 iterations took 5.905126902s. (Avg 1.968375634s/iteration)
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

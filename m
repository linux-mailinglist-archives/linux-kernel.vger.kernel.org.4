Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F969FC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjBVTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBVTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:31:57 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423944391D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:31:20 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s18so4712406pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sXW4q9EpLmN3ULY3ncrUN7CkV+kTTsNZ6c+/DibckI=;
        b=mH5jupgb0dU5Lzc0M29Umy6r1ACP4DRwXeP/4yF6Jq0tfVd7j5v6LPSNPjdt8inr4K
         BWEZb7gFLlx5Yp+9K2BVzU4wE/Qt7c2SY+Cx4XCVT+xnDNatFQzOnpHQGSYr/+wfgmfy
         za0f7NF+CJq6YlgZn1cv9AFAaS4udNZuVMWBzRRFGsW1WElfHlfrNIckQhNSUkT+5KwU
         L3dG3OAciVgQ3JYh7l86OMCfd7FIz9F0uG1ZX+1ICtaxIAxr61ZVEcdnRaMPZOtDDuE4
         sQZChY0qPhsz73Bkeo6OcHye3RKXRD46nbIdYh9eLOasKqCgZ7YK9JgfEGZMnzDMMEC/
         eFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sXW4q9EpLmN3ULY3ncrUN7CkV+kTTsNZ6c+/DibckI=;
        b=ZyiqHLXEc/iJbayoJGveeBRRX4o2oDDiNJSuXAgOnfakQi43wUIz3SOrur6kI2X6tQ
         omVBGWVqTC1fj7RIpZSAXfmLhLooMoFpMos1uoq0nfg22mD99DlIB/7ggxy78L4L3bIY
         HAf6tazno9z2gRJdK0B6WVCIZ/uEITdAYFmNyySCC+t2PK0L5HrJbYDUs1fCIvPCg8G8
         G1MIE+/FLVFqM92kT8Av80ncVV9PKG0KG/qYClVHOsoOutBm8ZA1v3fRsbNHRgmRGyt/
         R0yzmkoc2Q3JhswaUfW8E2YYps6qQY0oZAt8dXY60LRgLIC24zsJ1H1PzNHIYsxVrawp
         AyIg==
X-Gm-Message-State: AO0yUKVAdvLrxc47CdFDsSPHD/H73VVCk+rW7Si4KXFtEN/yhTSmvokO
        tknrzLqxwyYcgDKrYegEed66bvlVVcXngi7aJRk=
X-Google-Smtp-Source: AK7set84Ifyb7uDh1Kjx1qh6DhbE56VdeAITxITb2KO5Zwc5hRJuXbHRLoo+ei4a1YqmXOUpsubibA==
X-Received: by 2002:a62:cf45:0:b0:5a8:ecb1:bf1 with SMTP id b66-20020a62cf45000000b005a8ecb10bf1mr6774200pfg.19.1677094279038;
        Wed, 22 Feb 2023 11:31:19 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b005a8c92f7c27sm5321528pfu.212.2023.02.22.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:31:17 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:31:12 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 5/7] KVM: x86/mmu: Remove "record_acc_track" in
 __tdp_mmu_set_spte()
Message-ID: <Y/ZtgBA7lEdEVnnf@google.com>
References: <20230211014626.3659152-1-vipinsh@google.com>
 <20230211014626.3659152-6-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211014626.3659152-6-vipinsh@google.com>
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

On Fri, Feb 10, 2023 at 05:46:24PM -0800, Vipin Sharma wrote:
> Remove bool parameter "record_acc_track" from __tdp_mmu_set_spte() and
> refactor the code. This variable is always set to true by its caller.
> 
> Remove single and double underscore prefix from tdp_mmu_set_spte()

uber-nit: I find it helpful to use phrasing like "Opportunistically do
X" for opportunistic cleanups that are separate from the primary change.
Otherwise the commit message reads as if 2 totally independent changes
are being made.

> related APIs:
> 1. Change __tdp_mmu_set_spte() to tdp_mmu_set_spte()
> 2. Change _tdp_mmu_set_spte() to tdp_mmu_iter_set_spte()
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---

Reviewed-by: David Matlack <dmatlack@google.com>

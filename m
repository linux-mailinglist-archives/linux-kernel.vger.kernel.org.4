Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1F68CA67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBFXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBFXSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:18:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABF23DB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:18:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso5467335pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 15:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=urU0Sofh3PbV5Qio9IPapQ3to8ms6eN0CmjMqzS7Yis=;
        b=eBkcUdEO9PQ29+iKWs5IwDQSFUn+V6/rbfdkExyZLnkR+1bbdjTMhHz7lX3nraujk/
         ylRzNMaUIWQor3LZij6zbLalf9SR0L2aPOaTJxhwvJku2zb7ZArIX6OYTfg/abmUrmyU
         BGgSyulP1KwltBkr43JoKarGuCRI9hEVFNF1OtVInGpK3n/4bQJRFhxv6ibb1TyOWXlO
         GB+8dvGGXgRBL0Nil9hewBjcKQe2nwjqNiU17fy/IgVr1v4rznTanYB/x+1xiit8KxrN
         ABDLXtVNKB/2IPi+cjqEV0elt+yTu8llzdK7yM3d7oLYsDBFXw38Om3fUq615i+EBrgi
         RDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urU0Sofh3PbV5Qio9IPapQ3to8ms6eN0CmjMqzS7Yis=;
        b=1mbfccFWYUpc3QiSeuxYNhvLtnqWmTtTwoImvKvYTgmyWesxSC0EmHlD0E7PiBqSx2
         73aYRInQGW7Dn9VklVYt8W2k4t/+Y8qb3x0G6ZIp7Y/8UDIsTFv+UIkuVsvpogpIvomB
         GCfNO4HQBNkVIGWu3HzdTQOB/HaN3Yez4U3HphaIg6MS4egUVbKo6VJ73b7XxnOLsPXX
         C3rnxRftXRux0JdpKV/T+Anvd4fl6YGrvn71SPDhrFHzGOe/CWiJbr2168A2jMdteaIi
         TZOC1wtgjHyWD1i+H12qK9ldh/tXhoA1S3i41+hwLwb66JFFUThqjffxreR6KOX26jr3
         FeyQ==
X-Gm-Message-State: AO0yUKVlzfLMI4ix5RESEZNJrdJ2HmWJDDZiDf21ANohJ4d4ToyhZ5oW
        S4qxpJ0/ABIbgtLB09TxKl7EhQ==
X-Google-Smtp-Source: AK7set9GyQ83PRbvLNEFsclI7cGRfRLsfnq5/vZP4tPQl2Y1p3bXvu7nNWC1XK7EqmuyaFUk212nEA==
X-Received: by 2002:a17:90b:3a8b:b0:230:9b7b:20fd with SMTP id om11-20020a17090b3a8b00b002309b7b20fdmr1649050pjb.5.1675725480162;
        Mon, 06 Feb 2023 15:18:00 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id gz18-20020a17090b0ed200b0022c06124ad6sm10307652pjb.36.2023.02.06.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:17:59 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:17:55 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/5] KVM: x86/mmu: Make separate function to check for
 SPTEs atomic write conditions
Message-ID: <Y+GKo0tI2NeKiNDR@google.com>
References: <20230203192822.106773-1-vipinsh@google.com>
 <20230203192822.106773-2-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203192822.106773-2-vipinsh@google.com>
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

The shortlog is difficult to understand.

 - I think it's more common to use "Add" or "Introduce" when talking
   about adding a new function, rather than "Make".

 - "atomic write conditions" does not mirror the code naming, which
   checks for "volatile bits". e.g. The function is not called
   kvm_tdp_mmu_spte_need_atomic_write().

"volatile bits" is, at this point, pretty standard terminology in KVM
MMU to refer to "bits that can change outside the MMU lock". So I would
suggest leaning on that here.

So something like this:

  KVM: x86/mmu: Add helper function to check if an SPTE has volatile bits

On Fri, Feb 03, 2023 at 11:28:18AM -0800, Vipin Sharma wrote:
> Move condition checks in kvm_tdp_mmu_write_spte() for writing spte
> atomically in a separate function.

s/in a separate function/to a separate function/

> 
> New function will be used inc

nit: Use complete sentences. e.g. "This new function ..." or just state
the name directly, e.g. "kvm_tdp_mmu_spte_has_volatile_bits() will be
used in ...".

> future commits to clear bits in SPTE.

s/to clear bits in SPTE/to optimize clearing bits in SPTEs/

> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Code looks fine, just grammar/writing nits above.

Reviewed-by: David Matlack <dmatlack@google.com>

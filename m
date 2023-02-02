Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C307687307
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBBbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBBBbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:31:04 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97278ACF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:30:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z1so361439plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 17:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQFN0Hba8GKCQZ+8YRrT2Rwbcn3RAwlgxNWVZTQbFTw=;
        b=kGM90QC5SECzFBy4MEwi3Lhk8kucQq+ICv/2LPqtKDrBpQY4rVAxJ8fMroEFEDpfHg
         OmITLmjzcdmvMm6PcW3dr5cYk+1MJzWGMTGO6fulPnpvDbt4aZgq4yvq7YU5kBcD9xL1
         v0Xi5dOCcBiX+22ngDCScQihoJpEAFimokR5mTjtUDZh4r02qkmRFFPsD1u29dFbO/ZZ
         0O70cBh6/e8ybFZOnapsP8qBWXkrTXQVpbu0MS/ayxDlIczdSRePbyjRNru4VddRmzK7
         CMTvfBruTqjRq1tOhgdWI9BpW93bwQP4f0+z6mTiabTr/m4FnTwGagHt+U4WPQcQJ5Tn
         ci4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQFN0Hba8GKCQZ+8YRrT2Rwbcn3RAwlgxNWVZTQbFTw=;
        b=t72uS52rLGXLJ80yMoLvCAReLBjeyFnhs5hvMJWhtvEE63q6HjMbyhZTOaPr/JO2WQ
         E6Ym6JQ28c5u+TnZQ+7uSsTrGL8MOTHbidyW9Xc6DMprxpagfOp8Lfunzp7rv+eTxFW1
         4Glqv1YHK1AejmMi+uLQ2rrdDjm7acgbZHW/7YUJ+Ub6A9srEB9l02/elvQdt915qNWZ
         AfNpQzr54qndEve2x5g8zmMtgQ79JfhdiSfpGB9r5g2hb08NlFmu4oCL3m+YgsKQVixz
         CtK80ekRbkmVfBMPMTIFuqqkFRKWOSqne1imwj+nBa5h8hytJKID8XfNb3PMbOwKtaDR
         UIaA==
X-Gm-Message-State: AO0yUKVgtyTdgr2/Nd29h3tLIbnmIRdNuRpuZ0n6CWTXP274jB2CXsy2
        LRwi/DhXA22GNaP3jGYT7HkGHQ==
X-Google-Smtp-Source: AK7set8p9phbJpS88f4lPmz3cSTczRaYOPpHYZ2+eRwCuRjViotAwkZlbSvCIWIFvbr9B5e3sTjd9w==
X-Received: by 2002:a17:902:f7c9:b0:194:d5ff:3ae3 with SMTP id h9-20020a170902f7c900b00194d5ff3ae3mr163701plw.2.1675301445619;
        Wed, 01 Feb 2023 17:30:45 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id mm15-20020a17090b358f00b00217090ece49sm1991205pjb.31.2023.02.01.17.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:30:45 -0800 (PST)
Date:   Thu, 2 Feb 2023 01:30:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 6/7] kvm: x86/mmu: Remove FNAME(invlpg)
Message-ID: <Y9sSQfYPJCjBYh95@google.com>
References: <20230105095848.6061-1-jiangshanlai@gmail.com>
 <20230105095848.6061-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105095848.6061-7-jiangshanlai@gmail.com>
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

On Thu, Jan 05, 2023, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Replace it with FNAME(sync_spte).
> 
> FNAME(sync_spte) combined with the shadow pagetable walk meets the
> semantics of the instruction INVLPG.

Please call out the differences (I assume the two aren't perfectly identical),
and explain why those differences are benign.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556215F1544
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiI3Vzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3Vzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:55:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE296CD2E;
        Fri, 30 Sep 2022 14:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4764B829E2;
        Fri, 30 Sep 2022 21:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9EAC433C1;
        Fri, 30 Sep 2022 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574936;
        bh=npvB9opLg4Nzboa6nHFQ61VUy2QLxuMzGBt4Aa2MrQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/DElLj6xMf3bz7zX7ODdh22Ly15aejRwZXfI0ECMOPZHn4NtQ+KEM7g+xCeXSHio
         I5de5h5NrmjhDVCNtlMiQ+QNWTmfwaWEKN0byUHHk3Tt6wT8r32+hfnYw16afNtES8
         lp8mb0n6xY4HBGBynqTijJLB+STslcbLch54QksglZFpwNTrZYYdAjvJSwTWbDrxkh
         d/bUaBeHZ/dOXsFgQs3okdh+GfLGHTVzHPR9kGvbqwWsqQGZEDWIfSUGUmX1k+MQT2
         qV3l3QEVuOfYflY3Sh89dLz2OBOYi61FmXp9uCudCX9gT8ajMvOTaZakkHkdLyo/n3
         NuvWxoI/Xb/Rg==
Date:   Sat, 1 Oct 2022 00:55:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        ira.weiny@intel.com
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Yzdl1Ur72OI60Cre@kernel.org>
References: <20220929160647.362798-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929160647.362798-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:06:46AM -0700, Kristen Carlson Accardi wrote:
> It is not necessary to disable page faults or preemption when
> using kmap calls, so replace kmap_atomic() and kunmap_atomic()
> calls with more the more appropriate kmap_local_page() and
> kunmap_local() calls.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Missing "why". I believe you're right but since the existing code
is working, you should extend the reasoning just a bit.

BR, Jarkko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AAA5F79FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJGOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJGOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:53:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508A66846
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EzGtSuSCHS1gYWU/+mLmOZ85zhX26JcatsP1508YxTw=; b=Svvnpw2SavZ7UV/F+qT7fJhzwo
        ox6mJz9k4sQBnvLdZYNV6CL2MqjWzaV/Pm2QVozia8pg4ZWZJya9MjCMaGAUQZxIygxeZ6B13Dzfx
        KswWYWy7sfMcnKfnEChawCab9DvdfgN2hAAmNPtlUx2n1Ur3VbJ+uXEDj9nfPosAivipCUi2I/j6j
        x1m2oFcpbZhdT3crj6XWsBuf+1Ybjc8Yn5fw0qWgDM3maN0JbhRucU3ra3e7dAaz/uwaVVDAmu0Mu
        i+nyNonmkQZGPaMLEzEqLkb/YyjLWB6JT2jWQiOxQpaIegx0fmkgU8mgJCM9q27VqoEyNKvsliVJG
        AYP+JVFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogoiX-001xCr-Ei; Fri, 07 Oct 2022 14:52:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E822C30007E;
        Fri,  7 Oct 2022 16:52:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1B4D2C099DF1; Fri,  7 Oct 2022 16:52:44 +0200 (CEST)
Date:   Fri, 7 Oct 2022 16:52:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0A9PNIYkjdNjGrg@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006154041.13001-7-xin3.li@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:40:41AM -0700, Xin Li wrote:

> +#define LKGS_DI	_ASM_BYTES(0xf2,0x0f,0x00,0xf7)

This should come with a comment that states the binutils version that
understands: "lkgs %di" (or however that ends being).

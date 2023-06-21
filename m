Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1407D737CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFUHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjFUHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:41:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00671730;
        Wed, 21 Jun 2023 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVccEsCRdBl+DyRFyKD9+7GUkI4WQ8YmpzDSeZ8LLAU=; b=UBnRecR5iA9zqnqiBJcqz/55xX
        A3eIbAZ/GIqVk7aCdQreoS1qGWET767UVs912HwOcxufzXOO6gUWD1lYTvrGW7Q+fHkeUp2WRyI6b
        Czg6gAQuewKvft8SHyw6qZTWCNcab/QS9ZetefpYPqBSVS5pgLHgsFt1MligyngRxD/HNmVH+ScX2
        fEOd1fOg+ZxEKwm/K94SXpWKXJUas9bYQJ48cm1/pUj94sr6QTUt2j1j8sbAKuUkw7xrA3l1Rgrql
        zJjWxJwuMHLs1SMV/olYwiiBxyLDVYkMxk7yfgnMFm/IFtCt+2LEq63jT5hlAIRzGOM50+N3H5US0
        pFYuljTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBsSg-00HITA-0Z;
        Wed, 21 Jun 2023 07:41:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA29F300222;
        Wed, 21 Jun 2023 09:41:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9424D2BC73BD5; Wed, 21 Jun 2023 09:41:05 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:41:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 1/5] x86/speculation: Provide a debugfs file to dump
 SPEC_CTRL MSRs
Message-ID: <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140625.1001886-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:06:21AM -0400, Waiman Long wrote:
> Sometimes it is useful to know the states the SPEC_CTRL MSRs to see what
> mitigations are enabled at run time. Provide a new x86/spec_ctrl_msrs
> debugfs file to dump the cached versions of the current SPEC_CTRL MSRs.
> 

Pff, clearly I can't even read email anymore..

We don't do this for any of the other MSRs, so why start now?

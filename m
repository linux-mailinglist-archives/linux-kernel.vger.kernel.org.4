Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0537E7329A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbjFPIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjFPIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:22:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB62D58
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+dMlv4J1xRlgpvRpqQAxSAtw+C01A6qz1gs3blVCRI=; b=kGKr/VDYB8wmOoTJeQIl1fLdRA
        pqwEbH3dHZz+Kyy/FNlx7bOs4JqZUVqhw6Il+mjPSb2j6AmG/n6avhBkVAiXwcO9ePn04Yh075owh
        wSZasXBNLiFrtPdqS1FlO72MFyUI6EZfQ+1yCpgOodXTsc4tUiO0GCq3vyIp+SfaBjb91kNvgSiTP
        Tg8WfJbk0v+rMt16SEzf8gAhI0q0iDLhwtJ4+ThZBsmpdv2aKmkQpUz3Z2mItP2dsHoEwi7kSArrZ
        uCZulCtnbgHRrCVe+WojhKKxA4+ijqSms0HmPP6UQVIN/7Y9/k7L28uGtL9CNhec73HUiUi8lqN6t
        xlI4f7kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA4ip-00CrFY-1d;
        Fri, 16 Jun 2023 08:22:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8CD1300188;
        Fri, 16 Jun 2023 10:22:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BC0D2B5B5B43; Fri, 16 Jun 2023 10:22:18 +0200 (CEST)
Date:   Fri, 16 Jun 2023 10:22:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <20230616082218.GN38236@hirez.programming.kicks-ass.net>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
 <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:02:31AM +0200, Peter Zijlstra wrote:

> I can certainly give it a spin; it has IPMI serial-over-ethernet that
> works. Brilliant dev machine.

FWIW, I feel it should be illegal to sell a computer without working
IPMI support.

That Intel vPro shit is horrible. MeshCommander sorta works, but its
horrific crap.

</rant>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D8732C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjFPJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjFPJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:42:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145535AC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FjlqcYJGIQpM+LDDKrAWJRVmI0gvOSH4UoJ30kFsvvI=; b=mnf1nibw5F7DTpBYYfvqspdlcD
        NoZMDOIPaLNMMHFkLEzZ+tpa0f5JAkYX82AK5asqjHiIP6dZtg/A6GsR1A7Lo4wyRY610vZc+pJAu
        dy/V1eonVbW+gXlc7edYRkquqkHh7uDC3gCtKDyMzlSlRVfHOfqz+7tKAynjTz5YCm28BWJu87jVy
        tYbPA6/8paqciv9rVL25frQv7/vN8Q70uPbJoTaQY9mlzJmgZHH1YvPRzBlzEmc8V5g/Ge00KaMK3
        zD+H3sDMw5c5/sazkQliFhvMJ6GC8qFLNQtMH6T5lWvQr7vlN1eVTn0n+LDmOWcJZ/M2kesMH4Kyj
        ZGcSmX3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA5y2-00CsUh-0z;
        Fri, 16 Jun 2023 09:42:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97714300188;
        Fri, 16 Jun 2023 11:42:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 700C126A3BE87; Fri, 16 Jun 2023 11:42:05 +0200 (CEST)
Date:   Fri, 16 Jun 2023 11:42:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <20230616094205.GC4253@hirez.programming.kicks-ass.net>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
 <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
 <20230616081025.GM38236@hirez.programming.kicks-ass.net>
 <d100b30d381b9d28b6fceab5e9c5042c3ca79ba8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d100b30d381b9d28b6fceab5e9c5042c3ca79ba8.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:19:18AM +0000, Zhang, Rui wrote:

> According to the MADT, there are indeed 40 valid CPUs. And then 80 CPUs
> with 
> 
> APIC ID		: FF
> enabled		: 0
> Online capable	: 0
> 
> a dumb question, why are these CPUs added into the possible_mask?
> I can dig into this later but I just don't have a quick answer at the
> moment.

I really don't know.. I've not gotten around to reading that part of the
x86 code yet.



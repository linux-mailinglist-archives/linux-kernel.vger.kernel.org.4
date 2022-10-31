Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE0613660
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJaMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:31:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F516EF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e+kd2fdAGKzHpqmECAKuT9Ynw0jpWYWVIprY5i6lxQI=; b=kG9JMKjJP4zamsM1wMeYZHXvhi
        VpFKZszC5OYvnWPdWY6IF7psWZ/lzIpBOAut25aZ+4lDtNHEa1JzmvIAvWrhMxsJ3wsEFXB9dAwOX
        8iEflKRrGFGtp+OqLskmT26sJj4HTYXnU3IHa6VU8dlcP9DrwtQUmb8W9UHGKJX8nMPaZozxUYta3
        0XY6G+alTqR5alV0ef7BW/3upHYlLDS5UyeJIawes+62E0/OvVF2bpqj3Fka3JTmA21ojUVwwBYdl
        CSRCXVuGx3ns/gILxmrEJu9x9Kw4F+0W4helAnsYIBtpMO7aclG2h2L6u1GD2TrmBaQGtpb/PcKnq
        DFZS0Peg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opTwR-007rvW-BE; Mon, 31 Oct 2022 12:30:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9845330013F;
        Mon, 31 Oct 2022 13:30:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E8BE2C7598C3; Mon, 31 Oct 2022 13:30:57 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:30:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com,
        pbonzini@redhat.com, chenyi.qiang@intel.com,
        jithu.joseph@intel.com, alexs@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: fix undefined behavior in bit shift for
 intel_detect_tlb
Message-ID: <Y1/AAegYuyZPxH04@hirez.programming.kicks-ass.net>
References: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 07:43:40PM +0800, Gaosheng Cui wrote:
> Shifting signed 32-bit value by 31 bits is undefined, so changing
> significant bit to unsigned. The UBSAN warning calltrace like below:
> 
> UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/intel.c:948:21
> left shift of 1 by 31 places cannot be represented in type 'int'

Is it really? Shouldn't -fstrict-overflow define this case?

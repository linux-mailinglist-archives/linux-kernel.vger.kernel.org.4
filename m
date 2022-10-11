Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791D85FB2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJKNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJKNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:01:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5F1F9C6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cqF1zhh3Cd4kE+jKmets5c373eW81IGJnev/++iw3d0=; b=cG+C1ZDpVvDiCW2iYbmt+D5Ulx
        PKOe0VQodCIXnbfP0shUqLTlbutZX/0GMtcrzsll87OS9Oo1MtU0CBePLxx4lUm5UurGvSyjA2/2Z
        MlsI5X78gJYX52AnRdtzG1dRA+8sZbDodo3VJcvKWdmCjyhJ7zPUkGKaZtY2hZc7oJjkC8ClJIuJ9
        B0UKLJ1yp7FdtZ6shIbgDYVWSnEu7AaSqL/9T6McAlngeYhSqcyG4ffQ9nksrhb9cBb2MXQFtsR+A
        dB3zqCK3pOtipN4vByRanNAEOal03qYsnAP62sQgZ6ruebZ/FFhZJt81lHVjqIFvf0i64Z+Pa13v8
        0BjTYfjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiEsm-002a0y-Ji; Tue, 11 Oct 2022 13:01:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6150A3002C5;
        Tue, 11 Oct 2022 15:01:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF7629A0039D; Tue, 11 Oct 2022 15:01:15 +0200 (CEST)
Date:   Tue, 11 Oct 2022 15:01:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0VpG8POb4AL1g33@hirez.programming.kicks-ass.net>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
 <Y0TCOKc7n38341eJ@feng-clx>
 <Y0UgeUIJSFNR4mQB@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0UgeUIJSFNR4mQB@feng-clx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:51:21PM +0800, Feng Tang wrote:
> Th simple patch below is to have a dedicate CPU nodemask and set it in
> early SRAT CPU parsing, still it has problem when sub-numa is enabled
> in BIOS where there are more NUMA nodes in SRAT table. (also I'm
> not sure the change to amdtopology.c is right)

No; none of this has anything to do with nodes. This is about sockets.

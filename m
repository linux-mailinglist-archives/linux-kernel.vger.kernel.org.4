Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793575FDCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJMPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJMPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:08:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02324106926;
        Thu, 13 Oct 2022 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SswYpmvB2OLUSoe8a2kUq0K4LZAHWcSfAt98Az4nyVQ=; b=eQhOkI8Y0CZXQPzs/A39pWAw42
        ODLZAsliLnahtHS9RxeaE9y/L3YSQ7jIYVywvWrDbnjfe1m+6h8sM+MpPmoEUR2y1TkyvUY/+A9xP
        smDhD5pHaPFURmLc14rft8mTL7VSYHs4mT8Zric/uhvF85mhgZVwu6oiu8reTDUnRZs0vIDS6bgwj
        CNyyvk0rPoa73RvQ6DLoX0KWUZ7/X8GG/69zsy5rUmk3pt4Lew+mDmm7/tB65OKVB+6gahtuVF73k
        cVxVggQS/EFZQVOzg4hm8hW9Gan7mvq65T9gQ5HB26cUa0j8fOdrdm2FMYf6ozkKL+mIFQZ0EF1wl
        9JypgpcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oizo2-0038e6-R0; Thu, 13 Oct 2022 15:07:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F1E43001D6;
        Thu, 13 Oct 2022 17:07:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 275052BB878AD; Thu, 13 Oct 2022 17:07:29 +0200 (CEST)
Date:   Thu, 13 Oct 2022 17:07:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cody Yao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shyaololo@163.com
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Message-ID: <Y0gpsTiUqa/ZbvRh@hirez.programming.kicks-ass.net>
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:31:09AM +0800, Cody Yao-oc wrote:
> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> 
> Nano processor may not fully support rdpmc instruction, it works well
> for reading general pmc counter, but will lead to GP(general protection)
> when accessing fixed pmc counter. Futhermore, family/model information
> is same between Nano processor and ZX-C processor, it leads to zhaoxin
> pmu driver is wrongly loaded for Nano processor, which resulting boot
> kernal fail.
> 
> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.
> 
> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
> 
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>

*sigh*.. so this email address doesn't exist, as such I can't apply this
patch. Consider it dropped.

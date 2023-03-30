Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC26D0528
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjC3Mpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC3Mpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:45:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BEA6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uPhhIx08GhlnIjlGJ2MfiHnblN0h8M7s/nzawY2c5sk=; b=gnMmJKT0gJdl4tLaXnNpUkQI8x
        awuT+GcRgMg+cRklfwzYDtIUs870w44BmaX5H+QyiP7IcsKCqXw/3aV3buoEW01QAJsS/QsIK8ZG1
        XYUuEZFKfMLyEwch+zJ7jwnyI8OJbXqDT171CoIlvzCToVIkilDe28vxGGkFUjeAbZOBE19BBZil7
        HNUjOf4pzZuA3U+SOscobwuBOG8x8Tx3Zj27vH+2izsr+vHkCHz9Y7Nvg7nsSDiDcHZXb176Cm8ji
        D1G8quBqYbBDbbLOOAj/A0RoqOpb4ZqxfnXaOZZxM9rvUdiMv5agMjpo5LgPyx/6KsMeFQ/Fsi5io
        0Qx2H/3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phrev-00APZp-0b; Thu, 30 Mar 2023 12:45:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C372C300230;
        Thu, 30 Mar 2023 14:45:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C7A5203E4DD6; Thu, 30 Mar 2023 14:45:39 +0200 (CEST)
Date:   Thu, 30 Mar 2023 14:45:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, surenb@google.com,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Subject: Re: [PATCH v6 0/4] sched/psi: Allow unprivileged PSI polling
Message-ID: <20230330124539.GB124812@hirez.programming.kicks-ass.net>
References: <20230330105418.77061-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330105418.77061-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:54:14PM +0200, Domenico Cerasuolo wrote:
> Domenico Cerasuolo (4):
>   sched/psi: rearrange polling code in preparation
>   sched/psi: rename existing poll members in preparation
>   sched/psi: extract update_triggers side effect
>   sched/psi: allow unprivileged polling of N*2s period
> 
>  Documentation/accounting/psi.rst |   4 +
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |  43 +--
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 473 +++++++++++++++++--------------
>  5 files changed, 289 insertions(+), 235 deletions(-)

Thanks, I'll go queue this for tip/sched/core, and barring any robot
noise I'll push it out somewhere in the next few days.

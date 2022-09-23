Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600125E7519
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIWHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiIWHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:46:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFAA12BD87
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=evZaDFtdtHsJDb/M5fYGqalXlwIamZw9mGsSUWFy4wo=; b=MUiqJnC/4dy1x7qkB+6h9Lwsnw
        AmgSCEYlyjlgEY0gmqbs5e89Ortvx7CvgMzMrSySOrYqARxserV7oyR2PQyfK5LeJ8nJeC6NbN43a
        MknMvDQ7HrPdchPFDjI8UNu7NOKnELl2hOWiPsFd6z1GsIhETvt/a28nCKMp6rdNBInoFgWfgLlF7
        9DA7hw+JMMs6dN8WH9vkei/Xony9KMFt72exjA06dA49nPXUiFdtfh84tHqvePN7wlIZkNL/j0C/1
        oT375ffTMyDw+H4WVj34XzzlXGfSsMOBVYNqcv2fCghxw7NQNWZoYTgYZOEn2a2M7Rr4v7HVMdk7+
        lL5bFHWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obdN2-007Zdf-Cs; Fri, 23 Sep 2022 07:45:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 773CD300A72;
        Fri, 23 Sep 2022 09:45:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C9132BB8B0A3; Fri, 23 Sep 2022 09:45:08 +0200 (CEST)
Date:   Fri, 23 Sep 2022 09:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Use sample_flags for addr
Message-ID: <Yy1kBF1y+PtYn5Mp@hirez.programming.kicks-ass.net>
References: <20220921220032.2858517-1-namhyung@kernel.org>
 <Yyx1wv06cL0pkQ6H@hirez.programming.kicks-ass.net>
 <CAM9d7cgDTy96eeCAARufSKZJFMvAAo6QSLAoEQv_zUFD-Rf+Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgDTy96eeCAARufSKZJFMvAAo6QSLAoEQv_zUFD-Rf+Lw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:32:06AM -0700, Namhyung Kim wrote:

> Will send a patch to do the move on top of this, ok?

Yes, thanks!

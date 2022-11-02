Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D843616707
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKBQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKBQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:04:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B222CE30
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83527B82386
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197AAC433D6;
        Wed,  2 Nov 2022 16:03:40 +0000 (UTC)
Date:   Wed, 2 Nov 2022 12:03:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     postix@posteo.eu
Cc:     20221031144850.5522b036@rorschach.local.home,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tiwai@suse.de
Subject: Re: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
Message-ID: <20221102120338.254741f7@rorschach.local.home>
In-Reply-To: <25d7e982-f959-d86c-a6e7-5efd1db1e75c@posteo.de>
References: <e693eb6b-28d0-d091-3df3-60f2b591c0e7@posteo.de>
        <71829e56-a13f-0462-37a7-a4d64c16f561@posteo.de>
        <25d7e982-f959-d86c-a6e7-5efd1db1e75c@posteo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Nov 2022 15:57:56 +0000
postix@posteo.eu wrote:

> Hello everyone,
> 
> I have added lot's of debug printk's to see what's happening and I found 
> that the "cpu" counter, which is used to access the buffer's array 
> elements (cpu_buffer = buffer->buffers[cpu]) in the ring_buffer_wake_waiters
> function, exceeds the maximum number of total of total cores, namely in 
> my case 24, which means, it should only run from 0..23. However, upon 
> debugging, it runs up to 31, and thus causing a NULL pointer dereference 
> (&cpu_buffer->irq_work).
> 

Could you add this patch.

 https://lore.kernel.org/all/20221101191009.1e7378c8@rorschach.local.home/

Thanks,

-- Steve


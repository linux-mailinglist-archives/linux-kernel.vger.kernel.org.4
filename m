Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B52622155
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiKIB0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:26:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA05E9ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:26:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6FE61802
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749A6C433D6;
        Wed,  9 Nov 2022 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667957164;
        bh=ZdA9nnjgiqkULm/2CYWReaWHEj0W9yQeyo+RMreYUGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kiq6sejn72sdBNPL85xF6fLLHn94q0lxy4k59EKKTZt43x+t3BTnWnwdGM2kaebmX
         FfGslhJ8eso5egIgPk2/qhjlQtwpLeKFkRMajd61GsEZeWqXNx4ytKDIWKPNhEwEQ3
         h5+w7PW7QwZ0NZy+v8SZK4dM0HGZq/gXWGZjcnHM=
Date:   Tue, 8 Nov 2022 17:26:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] percpu_counter: add percpu_counter_sum_all interface
Message-Id: <20221108172603.8d547faa8f0cf0c340fd7150@linux-foundation.org>
In-Reply-To: <20221109012011.881058-1-shakeelb@google.com>
References: <20221109012011.881058-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 01:20:11 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> However there is a small race window between the online CPUs traversal
> of percpu_counter_sum and the CPU offline callback. The offline callback
> has to traverse all the percpu_counters on the system to flush the CPU
> local data which can be a lot. During that time, the CPU which is going
> offline has already been published as offline to all the readers. So, as
> the offline callback is running, percpu_counter_sum can be called for
> one counter which has some state on the CPU going offline. Since
> percpu_counter_sum only traverses online CPUs, it will skip that
> specific CPU and the offline callback might not have flushed the state
> for that specific percpu_counter on that offlined CPU.

LGTM.

What are the user-visible effects of this bug?  Should we cc:stable?  If
so, can you identify a suitable Fixes:?

Thanks.

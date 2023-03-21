Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097EA6C35F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCUPlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCUPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:41:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5322011
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1W0yEv2L9EaroT9MRj0YrOythcNd0CZtw7NCo2aZTA=; b=IRG1DxC+w8Fzg1pvXUHgP05wRm
        sQ2dLrx8SXeMSYVT4WsMQaaDjPNFLgrP6nQfM+PTwWmgv4bgcJYJoIm0+lwasA2G5WpTcokiFCQhl
        rT49CZueIzspHXf8dISuJqVUZoBog94MwAKzfANeSY/IKnbRth2KdOdVgpqROn257kVUOnQQ5A0q1
        qOs+o0RQCAoyyKM9vGaa6klA4RqpsFHaUaM7q0xSty3oM15Hricwiev9vKZ2yi5ODFBhfxdoZOpI2
        vL3IFlRCIQr8z2gnCGMEwDMNx4aRJtczTOdJa+rkUMuuy8ebnBMO8+Qda/I3HJ0FKI6t9lFfXBskJ
        K6cuQR1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pee6L-004Ife-1m;
        Tue, 21 Mar 2023 15:40:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3EFA30006D;
        Tue, 21 Mar 2023 16:40:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB1EA240D2A01; Tue, 21 Mar 2023 16:40:40 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:40:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230321154040.GC2272870@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> +static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
> +					 struct tmigr_group *child,
> +					 void *ptr)
> +{
> +	struct tmigr_remote_data *data = ptr;
> +	u32 childmask;
> +
> +	childmask = data->childmask;
> +
> +	/*
> +	 * Handle the group only if child is the migrator or if the group
> +	 * has no migrator. Otherwise the group is active and is handled by
> +	 * its own migrator.
> +	 */
> +	if (!tmigr_check_migrator(group, childmask))
> +		return true;
> +
> +	/*
> +	 * Racy lockless check for next_expiry
> +	 */
> +	if (data->now >= group->next_expiry) {

I'm not far enough along to tell; but on 32bit this can/will suffer from
split loads and basically turn into a random number generator. I'm
presuming the 'check = 1' thing here covers that case?

> +		data->check = 1;
> +		return true;
> +	}
> +
> +	/* Update of childmask for next level */
> +	data->childmask = group->childmask;
> +	return false;
> +}

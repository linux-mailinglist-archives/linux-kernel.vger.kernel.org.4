Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1C68F901
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBHUpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjBHUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:45:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A432202B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AmGnJ8xNNJ+BEDzHO7iM5KTJGtJrmT9NvgZevReB7FE=; b=FaIVyJofp0mGruajdBZJJOucVX
        1xg0aucuY0hZQExV++yBQob7ioDXLb7DFxHYCbxFF7qgk4a3QXM1CDNfrLiGAqW2cwgTeRpirxDtH
        JIciewJaJ4eE+K/isbaumUWn4P8k8d7Jd0txiB+zXd25wB8qS0FM9CxUQbwkMaUOSkGcMUNA705MI
        beAdxf3CgBCYdxaqgJ/xRfdQ8jhTwG2R2t37w7aNFyHaBLf6lIgtHMF3y9C2hbjHI3MNK5FiGxRZQ
        AjjT7P+z61a5ANudaDj48ZvHfCUAUGDONe4ug+BUc/3gYbqNMJtEqbNvRdAmj4gmjHDztN78SieIa
        VP5Ko6gw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPrJN-007aPp-0a;
        Wed, 08 Feb 2023 20:45:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83327300399;
        Wed,  8 Feb 2023 21:45:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73A7C2083586E; Wed,  8 Feb 2023 21:45:39 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:45:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QJ81i/QL+Cp1bf@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
 <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:44:04PM +0100, Peter Zijlstra wrote:
> GNU as seems to go to .nops 12. 13 gives me a single byte nop and a 12.
> That's also exactly the 3 prefix limit, after which some uarchs start
> taking heavy decode penalties.

Oh noes, counting hard. It maxes out at 11, not 12. Sadness.

Instead, lemme go figure out what those alternatives actually are.

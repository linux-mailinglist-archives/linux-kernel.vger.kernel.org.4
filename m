Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A965DCA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbjADTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbjADTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:20:30 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 11:20:28 PST
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9301C41E;
        Wed,  4 Jan 2023 11:20:28 -0800 (PST)
Received: from [172.17.203.2] (port=49315 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1pD9Dn-007RCJ-8t; Wed, 04 Jan 2023 19:14:43 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1pD9Dm-000OQS-RT; Wed, 04 Jan 2023 20:14:42 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH 05/30] selftests/rseq: Use ELF auxiliary vector for
 extensible rseq
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
        <20221122203932.231377-6-mathieu.desnoyers@efficios.com>
Date:   Wed, 04 Jan 2023 20:14:42 +0100
In-Reply-To: <20221122203932.231377-6-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Tue, 22 Nov 2022 15:39:07 -0500")
Message-ID: <87a62yun6l.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> +static
> +unsigned int get_rseq_feature_size(void)
> +{
> +	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
> +
> +	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
> +	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> +
> +	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
> +	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> +	if (auxv_rseq_feature_size)
> +		return auxv_rseq_feature_size;
> +	else
> +		return ORIG_RSEQ_FEATURE_SIZE;
> +}

Do you intend to use the auxiliary vector as the userspace handshake
for glibc-managed rseq, too?  I don't think it works if the kernel
overtakes glibc.  Or is there some other approach shown in the series
that I missed?

Maybe we should just skip the existing padding and use it only for
some vaguely kernel-internal purpose (say through a vDSO helper), so
that it is less of an issue how to communicate the presence of these
fields to userspace.

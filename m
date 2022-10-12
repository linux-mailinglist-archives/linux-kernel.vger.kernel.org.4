Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D65FC8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJLPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJLPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:50:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8113D15;
        Wed, 12 Oct 2022 08:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40E96CE1CBC;
        Wed, 12 Oct 2022 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D52C433C1;
        Wed, 12 Oct 2022 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665589819;
        bh=+gtutM/sDsmZtehVItKJH/vQ3u/GKRsWlIbIFKVnlqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA29ihYU6RyV6B4EjVtRg3DaUcmYNt2E3CtvlLD9SQ1SD0cU1dWoPy30tdgh/8Epk
         9K9DxCcvdXfPp6oVSwyH8ZtlrJDc3ua6IT+7MmYv6CXtklV1Wt1gMGfcWjZZ654A2C
         0ebBEh7ITOJqbgNlMsIe35McLh6oj+Kd3VKmQn9qc4vPBLl4am0QPDWmCogNqiBCiO
         33zis6V8emINQmxxNGJj9xpdM1KeOguPQa0+FA3NFYI6q1HGSJW4GBl7PyPzp7RbnD
         50NlxV7D5VDvtldTQcRpUh6Qm9b7+stTuqsbdxk9xpy/TvPWZ2hzDuDRxEPnNlKFkX
         PI5NqxPSKit5Q==
Date:   Wed, 12 Oct 2022 18:50:15 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y0biN3/JsZMa0yUr@kernel.org>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <Y0BEV+Xgkrln8xoh@iweiny-desk3>
 <Y0ZphugZZBhlv/vT@kernel.org>
 <711f8036-787a-571e-1c0d-1a258175ebb2@intel.com>
 <Y0bUK6krEQdnFlOg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bUK6krEQdnFlOg@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:50:19PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 12, 2022 at 07:13:26AM -0700, Dave Hansen wrote:
> > On 10/12/22 00:15, Jarkko Sakkinen wrote:
> > > There's no data to show that this change would be useful to do.
> > 
> > Jarkko, I think the overall transition to kmap_local_page() is a good
> > one.  It is a superior API and having it around will pave the way for
> > new features.  I don't think we should demand 'data' for each and every
> > one of these.
> > 
> > Please take a look around the tree and see how other maintainers are
> > handling these patches.  They're not limited to SGX.
> 
> Sure, I'll take a look for comparison.

Yeah, I think it is pretty solid idea.

Looking at the decription:

"It is not necessary to disable page faults or preemption when
using kmap calls, so replace kmap_atomic() and kunmap_atomic()
calls with more the more appropriate kmap_local_page() and
kunmap_local() calls."

We did not pick kmap_atomic() because it disables preeemption,
i.e. it was not a "design choice". I'd rather phrase this as
along the lines:

"Migrate to the newer kmap_local_page() interface from kmap_atomic()
in order to move away from per-CPU maps to pre-task_struct maps.
This in effect removes the need to disable preemption in the
local CPU while kmap is active, and thus vastly reduces overall
system latency."

Can be improved or written completely otherwise. I just wrote it
in the way that I had understood the whole deal in the first place.

BR, Jarkko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450E1738004
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjFUKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFUKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:47:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26281BDF;
        Wed, 21 Jun 2023 03:46:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qBvLf-0006WT-QB; Wed, 21 Jun 2023 12:46:03 +0200
Date:   Wed, 21 Jun 2023 12:46:03 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Igor A. Artemiev" <Igor.A.Artemiev@mcst.ru>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] netfilter: ebtables: remove unnecessary
 NULL check
Message-ID: <20230621104603.GA24035@breakpoint.cc>
References: <20230620152549.2109063-1-Igor.A.Artemiev@mcst.ru>
 <20230620163806.GB3799@breakpoint.cc>
 <f687fe6f-3330-a9c5-4760-f753638c7b03@mcst.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f687fe6f-3330-a9c5-4760-f753638c7b03@mcst.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor A. Artemiev <Igor.A.Artemiev@mcst.ru> wrote:
> On 6/20/23 19:38, Florian Westphal wrote:
> > Igor Artemiev <Igor.A.Artemiev@mcst.ru> wrote:
> > > In ebt_do_table() 'private->chainstack' cannot be NULL
> > > and the 'cs' pointer is dereferenced below, so it does not make
> > > sense to compare 'private->chainstack' with NULL.
> > ?  Why do you think that?
> > 
> The 'cs' pointer is dereferenced below without checking, as it is assumed to
> always be initialized with 'private->chainstack[smp_processor_id()]'.

No, its not.  The dereferencing is conditional, as is the allocation
of the chainstack.

No user defined chains, no chain stack.

With this change, "ebtables-legacy -A INPUT" causes kernel panic.

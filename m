Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5F6E5979
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDRGeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 02:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDRGeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:34:06 -0400
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4640C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:34:04 -0700 (PDT)
Received: from [2601:447:c680:c050::4033]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1poeqP-00AZE6-WD; Tue, 18 Apr 2023 01:29:38 -0500
Message-ID: <497c92b50103a4ba3469cd41edbd967ee9bfb291.camel@buserror.net>
From:   Crystal Wood <oss@buserror.net>
To:     Sean Anderson <sean.anderson@seco.com>,
        Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org, Roy Pledge <roy.pledge@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Madalin Bucur <madalin.bucur@nxp.com>
Date:   Tue, 18 Apr 2023 01:29:36 -0500
In-Reply-To: <3b707d1c-1120-274f-6cd6-b3283a334563@seco.com>
References: <20230404145557.2356894-1-sean.anderson@seco.com>
         <20230404145557.2356894-2-sean.anderson@seco.com>
         <48dacc58c7c04ba8a005d8edd56744c8455f007e.camel@buserror.net>
         <d4737c45-2bbf-d364-9768-20baa46f6af4@seco.com>
         <3b707d1c-1120-274f-6cd6-b3283a334563@seco.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2601:447:c680:c050::4033
X-SA-Exim-Rcpt-To: sean.anderson@seco.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, camelia.groza@nxp.com, linux-kernel@vger.kernel.org, roy.pledge@nxp.com, davem@davemloft.net, madalin.bucur@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v3 2/2] soc: fsl: qbman: Use raw spinlock for cgr_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-11 at 11:09 -0400, Sean Anderson wrote:
> Hi Crystal,
> 
> On 4/4/23 12:04, Sean Anderson wrote:
> > On 4/4/23 11:33, Crystal Wood wrote:
> > > On Tue, 2023-04-04 at 10:55 -0400, Sean Anderson wrote:
> > > 
> > > > @@ -1456,11 +1456,11 @@ static void tqm_congestion_task(struct
> > > > work_struct
> > > > *work)
> > > >         union qm_mc_result *mcr;
> > > >         struct qman_cgr *cgr;
> > > >  
> > > > -       spin_lock_irq(&p->cgr_lock);
> > > > +       raw_spin_lock_irq(&p->cgr_lock);
> > > >         qm_mc_start(&p->p);
> > > >         qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
> > > >         if (!qm_mc_result_timeout(&p->p, &mcr)) {
> > > > -               spin_unlock_irq(&p->cgr_lock);
> > > > +               raw_spin_unlock_irq(&p->cgr_lock);
> > > 
> > > qm_mc_result_timeout() spins with a timeout of 10 ms which is very
> > > inappropriate for a raw lock.  What is the actual expected upper bound?
> > 
> > Hm, maybe we can move this qm_mc stuff outside cgr_lock? In most other
> > places they're called without cgr_lock, which implies that its usage
> > here is meant to synchronize against some other function.
> 
> Do you have any suggestions here? I think this should really be handled
> in a follow-up patch. If you think this code is waiting too long in a raw
> spinlock, the existing code can wait just as long with IRQs disabled.
> This patch doesn't change existing system responsiveness.

Well, AFAICT it expands the situations in which it happens from configuration
codepaths to stuff like congestion handling.  The proper fix would probably be
to use some mechanism other than smp_call_function_single() to run code on the
target cpu so that it can run with irqs enabled (or get confirmation that the
actual worst case is short enough), but barring that I guess at least
acknowledge the situation in a comment?

-Crystal


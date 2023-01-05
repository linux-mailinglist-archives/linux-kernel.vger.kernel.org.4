Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BF65F06D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjAEPsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjAEPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:48:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414814BD53;
        Thu,  5 Jan 2023 07:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF12B8199B;
        Thu,  5 Jan 2023 15:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EEEC433D2;
        Thu,  5 Jan 2023 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672933710;
        bh=yCNCkr5VzIXt98C2D4zbMi7v5ISBOFLwXiuOYk5O40w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F1KtVeH4oiYy3MWCNN0ZTszzWywtawrffg+X9XnLB4Bm+U8OxBpJAkFjnxeJogxPb
         YKY7dftd4tUguJ4lmuVmb1VIMhzDowhUqhbu6CyzuSv2vg6THSV1bJpAbIPtwcokbM
         BXal/aFnPy/zhu7a/Q3fMiZqGeTgkiH3ludIxQvY74S/QfwjjeMM+R88FPe8znNiUB
         oQ2rGwET1w0au++btMG5GYJwAVgyLcxRfYoTpIkuwMVquDoex1r8UXhY+ESihadeWi
         QRkVjcptr2+XSU9ppAiqSi5ymZVjloZ9k6kYz0S7L3qIM/8KgtijDNfJXgOjrt20m5
         ijZ05Pocbs2Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50C575C029A; Thu,  5 Jan 2023 07:48:30 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:48:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Heiko Carstens <hca@linux.ibm.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, linux-block@vger.kernel.org
Subject: Re: [PATCH rcu 07/27] block: Remove "select SRCU"
Message-ID: <20230105154830.GW4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-7-paulmck@kernel.org>
 <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk>
 <Y7aE2zzdTyjNId6w@osiris>
 <20230105153314.GS4028633@paulmck-ThinkPad-P17-Gen-1>
 <f4dc3c65-c9e6-b961-cf94-f8058a67e256@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4dc3c65-c9e6-b961-cf94-f8058a67e256@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:36:43AM -0700, Jens Axboe wrote:
> On 1/5/23 8:33 AM, Paul E. McKenney wrote:
> > On Thu, Jan 05, 2023 at 09:05:47AM +0100, Heiko Carstens wrote:
> >> On Wed, Jan 04, 2023 at 05:43:07PM -0700, Jens Axboe wrote:
> >>> On 1/4/23 5:37 PM, Paul E. McKenney wrote:
> >>>> Now that the SRCU Kconfig option is unconditionally selected, there is
> >>>> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> >>>> Kconfig statements.
> >>>
> >>> I'm assuming something earlier made this true (only CC'ed on this patch,
> >>> not the cover letter or interesting btis...), then:
> >>
> >> I was wondering the same. But it is already unconditionally enabled
> >> since commit 0cd7e350abc4 ("rcu: Make SRCU mandatory").
> > 
> > Ah, apologies for the terseness!
> > 
> > I took the coward's way out by making CONFIG_SRCU unconditional during
> > the last merge window and removing all references during this merge
> > window.  ;-)
> 
> Are you intending for maintainers to pick up these patches, or are you
> collecting acks for sending the series separately? That part is also
> not clear :-)

Fair point!

Maintainer's choice.  By default, I collect acks and send it.  But if
(for example) this change is in a high-traffic area, the maintainer
might want to take it, in which case I drop it from my tree.

Either way works for me, as long as you let me know.  ;-)

							Thanx, Paul

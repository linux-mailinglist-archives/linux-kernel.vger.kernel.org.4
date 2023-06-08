Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FB728598
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFHQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjFHQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A539830FC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A43E64880
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D10C433EF;
        Thu,  8 Jun 2023 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242521;
        bh=m1N1l/2HWWsu4UzVEYLypRAvQZtVDPBjzEQjFx8T72M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i0VB+YT+02b48JnRon7m4XKT0cwRjIicOAvMqiYVA5uXBovLjUSJxRkLQLY1kvVTB
         ZCewXPZp6p8cvn1mWLyTSKGxuuCPzYLPcKl9vE0jv4CamGal9SN4zFMgJHDNE4mCNe
         EQ2m4Tn+wVQ9ar+PGjUBjhkq+jUIRBiLizDDzLDN3wLn/ahDDOr2EIeDpU/v0f/iTX
         bf78k/tolkYJmZbfsaK/deNzkmwASr8iYqfuY/oDO4SO3T6M18yCN3mko+iFOKWzvq
         USXrDdCQ6fOTQrLfaxiEZiHb/MF2MsGJb+6QirnSpzoySsKt/Oc3f0o6yhTiXIwomd
         NSvGbb0cUehvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3C274CE14DD; Thu,  8 Jun 2023 09:42:01 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:42:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Bainbridge <chris.bainbridge@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>, tglx@linutronix.de,
        sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <5c8bab43-e8c7-4dae-820a-4621a6472228@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
 <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx>
 <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
 <CAP-bSRZa9axG59E3knkVXy4=36irR9E7SXqT-QSikW7BoQueBw@mail.gmail.com>
 <41b91385-8f04-4498-9eeb-0b3a192b55cb@paulmck-laptop>
 <CAP-bSRYm7_aJH6-YwcY_pq8_igAXQR++YfQrfZJoKaD8mW=fyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-bSRYm7_aJH6-YwcY_pq8_igAXQR++YfQrfZJoKaD8mW=fyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:27:31PM +0100, Chris Bainbridge wrote:
> On Thu, 8 Jun 2023 at 17:25, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Very good, thank you!
> >
> > May I please apply your Tested-by?
> 
> Sure
> 
> Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Again, thank you!  I will apply this on my next rebase.

							Thanx, Paul

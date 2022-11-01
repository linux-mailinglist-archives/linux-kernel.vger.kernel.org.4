Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0724614B69
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKANMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKANMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:12:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C2E1A83A;
        Tue,  1 Nov 2022 06:12:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FA4B1FB;
        Tue,  1 Nov 2022 06:12:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A693F703;
        Tue,  1 Nov 2022 06:12:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:12:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Szabolcs Nagy' <szabolcs.nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux interprets an fcntl int arg as long
Message-ID: <Y2EbR6YnQcgK4B8T@FVFF77S0Q05N>
References: <Y1/DS6uoWP7OSkmd@arm.com>
 <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
 <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
 <Y2EGtE05hcVn3B3a@arm.com>
 <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:19:51PM +0000, David Laight wrote:
> From: 'Szabolcs Nagy' <szabolcs.nagy@arm.com>
> > Sent: 01 November 2022 11:45
> > 
> > The 11/01/2022 10:02, David Laight wrote:
> > > From: Szabolcs Nagy

> > kernel code:
> > ------------
> > SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> > {
> 
> That is just a wrapper and calls do_fcntl().
> which needs changing to be add:
> 	arg &= ~0U;
> before the switch(cmd) {

Just to check, do you mean the switch in do_fcntl(), or the switch within memfd_fcntl() ?

The former handles other APIs which do expect arg to be a long (e.g.
F_SET_RW_HINT and F_GET_RW_HINT expect it to hold a full 64-bit pointer), so
that'd break things.

The latter would work (as would casting arg to int when calling
memfd_add_seals()).

Mark.

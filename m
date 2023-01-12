Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB063666AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjALFOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjALFO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:14:27 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C940042E3C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:14:25 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30C5Dguk020122;
        Thu, 12 Jan 2023 06:13:42 +0100
Date:   Thu, 12 Jan 2023 06:13:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Arseniy Lesin <emptiedsoul@hardclanz.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC] SIGOOM Proposal
Message-ID: <20230112051342.GB19712@1wt.eu>
References: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 12, 2023 at 07:51:45AM +0300, Arseniy Lesin wrote:
> 2.1. The SIGOOM Signal
> ------------------
> 
> I propose the addition of new signal: SIGOOM (Out-Of-Memory SIGnal) 
> 
> This signal is intended to be sent to the most memory-hungry process(es)
> in order to give process a chance to release memory used for
> non-valuable data (for example, browser can unload tabs, that are
> currently not in use, assuming tabs are not separate processes) or to
> write down valuable data and exit gracefully (for example, some
> graphical editor).
> 
> Some applications can even set up a poll for OOM event by using signalfd
> 
> Default action: 	IGNORE
> Proposed senders: 	kernel- and user-space OOM-killers
> 
> The technical detail of this addition is a bit unpleasant: there is
> actually no room for new signals! 

Do this simpler, let userspace configure the signal it wants to
receive for this via a new prctl(PR_SET_OOMSIG) and this would allow
each process to voluntarily declare this intended behavior and the
associated signal at the same time. There are already other comparable
mechanisms existing there (signal to receive on parent's death, or on
memory error for example).

Willy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F496704923
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjEPJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjEPJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244C59EC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 770C8636F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3EDC433EF;
        Tue, 16 May 2023 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684229102;
        bh=+pabQntQs5wnhpRu5Y4UyExhIZfqYNzZqCn5O3LU9Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bijNI5i8oeK1xQifVY/LljPzxOceTkfZsZt94bemiIEo9A/dqFy3DC4v0yr6uXHWI
         psj/Uwv2vJ0q+twSEVlorzBUCOlXxVA/DuQv7eYt8w0mVfH2lvDa2ZQlvdUOzw2QEn
         +xCNquV6IYV6hHAI7B2Np2ahiyuf6ckL0xh+Dsv9JK8kGmSQ7c4Xe/PCoG9D3faVA/
         37El5FnfDuuXNa3iegpsn2qqNZPdYlous4LkBr+nxWc1TiT1iTEK7Voj65mDRTO+uL
         kL7VRQSHB8MjypTWTMEnNLsrlQBta/CZor2gb9lQgUuA3rBwmWoQQ1aCsd5WTH+PRP
         ZD1T5lnXI85sg==
Date:   Tue, 16 May 2023 11:24:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <ZGNL427cvjGQ-7dY@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
 <ZFty1fNMlnuLk4qF@localhost.localdomain>
 <20230515101936.3amAvw0T@linutronix.de>
 <398d7731-f5ca-a34-9e4-77da60c49d21@linutronix.de>
 <20230515124133.XkKOksjW@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515124133.XkKOksjW@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, May 15, 2023 at 02:41:33PM +0200, Sebastian Siewior a écrit :
> On 2023-05-15 12:50:25 [+0200], Anna-Maria Behnsen wrote:
> > As menitoned in the reply last week to Frederics objections regarding the
> > locking asymmetry, I would like to keep it to make the locking region of
> > timer base locks as small as possible and to prevent holding up to five
> > locks during the walk.
> 
> This looks okay. I wouldn't suggest to hold the timer_base::lock or
> tmigr_cpu::lock longer than needed. Both can be acquired independently
> cross CPU and have explicit locking order. So it is fine.


   LOCK(A)
   LOCK(B)
   UNLOCK(A)
   UNLOCK(B)


Cross rhymes aren't pretty in locking. They don't make the review smooth
but yeah it's not incorrect either. And since I don't have a better way to
propose...

> 
> > Thanks,
> > 
> > 	Anna-Maria
> 
> Sebastian

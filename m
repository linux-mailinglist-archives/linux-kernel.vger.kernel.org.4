Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30869235B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjBJQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjBJQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:33:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE6928852;
        Fri, 10 Feb 2023 08:33:22 -0800 (PST)
Date:   Fri, 10 Feb 2023 17:33:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676046800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyUp1WLGWuP1gbtu6LrGxboD7v5Hq+tpy02prCN1rpM=;
        b=b82i13c2Mmowe7dSEZ5qmeGCb8Gf9IaR9JUMWcZNYfS+mt1Z7g/NlCW5jOcFE6h/1pO6Jj
        1jSWfwHRJhSvJQ2sNvB2/H33ZxAmTwUTxLdoZuoexpUNVXHub1POUZgQt+u+NiVZnQyL9m
        2Nk08suuJ5uTSbKyqWSBpczEkvTdroCvPS+WJ6GJ3xSd4uwprp5jba0fxLOLYZNWowGg/c
        rahGpesQueEaEv48eevS6EyvCkIh99y2CuIIEI1Fly1xHT90wQL3Yb6ZgXIeK4llC8Nh93
        sL43J1zE6E7EuJrdP9ZwkDYz4DevMiLjFXeDrBlwd2GcROp3qrsBEizysmnQZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676046800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QyUp1WLGWuP1gbtu6LrGxboD7v5Hq+tpy02prCN1rpM=;
        b=+8t9GxRxMRccpUbAB4+rS6wICtpDoV1SjZsIh+6NibXpS1fWocjMjX8FO3T0pwerL6BnQt
        hZn3HcNrrivYgEBQ==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
Message-ID: <Y+Zxz0iPqnTRYHi1@linutronix.de>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
 <CAFzL-7sL6HVDyVbafaxiq7-KN1aDTFUx8az4h0EvxJmuO6SPog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFzL-7sL6HVDyVbafaxiq7-KN1aDTFUx8az4h0EvxJmuO6SPog@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-10 07:32:26 [-0800], Alison Chaiken wrote:
> 
> Should users of ktimers adopt Junxiao Chang's patch
> 
> https://lore.kernel.org/linux-rt-users/BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com/
> 
> from 20 Dec?   It appears to be a bug fix.

I know. I have a backlog. I looked at this a while ago but got
distracted. I hopefully get it done next week. Now that 6.1 is LTS I
need to bring it in shape before I can hand it over.

> Thanks,
> Alison Chaiken
> Aurora Innovation

Sebastian

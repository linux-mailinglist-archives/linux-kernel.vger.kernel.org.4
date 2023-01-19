Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CF673EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjASQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjASQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:36:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2446EA2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:36:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:36:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674146183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQh0swIanCssR3rlyr5cq60y9iMeZJZy8kioKjVR4fc=;
        b=EdWgIYtuPFXzFTmCN3Bfa+7uV+Bd5X3wJepa9+qR6M8gxf8KOJtOgAdL2ZrdOJBzj4RmV1
        HKv++sFDw5ER2lFUB/wYyAQmSZTe3wdrSW9NAviueW+qBiIsMFe99mNqrMPkQ6vvoFP8Eh
        ECqBFAMquJhMTewq4sjaLwZ9/J875gwuiN8rNneGut9DUkO9/hfasBlpHp4kkAkvEHjXiR
        5wrX/4dVBXaeieAkkT+i78+e5FTz1Y2vdcb4SXvpL9UjbsUFNtGB41l+4TsPv7Yl4Q4I/o
        jtGh33PAtEKC7nxzharBFN5lTikxP6T1A3O719MnAGFc/kgmSq6WLLI9G+xMBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674146183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQh0swIanCssR3rlyr5cq60y9iMeZJZy8kioKjVR4fc=;
        b=lDnycYeyyDavzYUGJ/HmjcwY0cx5LD16HSEhkQS1A9ldCvwkEes7qBE5mW53KGlb77V1Ad
        4vCJ1S+c3LT0IBAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8lxhkxNJuPHu3xG@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230119011538.3247-1-hdanton@sina.com>
 <20230119135903.3524-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119135903.3524-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 21:59:03 [+0800], Hillf Danton wrote:
> On Thu, 19 Jan 2023 09:32:22 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > As far as Mel's efforts go, I am satisfied so far.
> 
> If not because you can, could you specify why 4ms fails to cure starvation?

It does not fail to cure the starvation. I haven't tested it myself but
base on Mel's description and the patch it very much looks like it cures
the writer starvation.

If you don't like the 4ms, it could be 1ms or 40ms - it does not really
matter. The 4ms is aligned on the generic implementation which uses the
same value. Unless there is strong evidence to use something else I
don't see the need to diverse.

Sebastian

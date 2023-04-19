Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9264A6E7B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjDSOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDSOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:04:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF51A1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:04:53 -0700 (PDT)
Date:   Wed, 19 Apr 2023 16:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681913091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3ToMtv1p5g/f+BDHD3K2XqJZkDmy3YMJaEfRSy0A+Q=;
        b=HKo+ohu3tjOKTXO0BaE8zLdtG2t3+mVqYPuIKE9uZz5GKM4KoS27TyzLbiACufAdx3d9NT
        3OiDC4eRrJwhecTLdOMW21YtjqfO1POfyqKzt2IbLd/qB/sKOgCe7jbhyUJ0cmrPj/KCVU
        XBrYOS2X1PbQPrsnpiMnjx9L5DIoESuaTaD/+tq6SAigK+3yfDOxYtZeDE57BqjUbiuXR1
        wV+afuWO4nzfuVd8YXRGqkpMRlXLHRdy3ggFOb14TZTpiFWhjJOkOlryVDVMOqMxj/x8Lz
        bFPcAPu5h4un8AUI0frTi7aaP7UbiZE6FvE8FXTcZ4VZ6rOcb5Itm1ItqTjePQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681913091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3ToMtv1p5g/f+BDHD3K2XqJZkDmy3YMJaEfRSy0A+Q=;
        b=lE/zMbz++TsRxj47B9n3Y5SsWuQgwnTSbYstcPG8ZBNV1mrCV6XNjvuR+xf5uJXiNC8svt
        xQmNHB0vBnk+OCBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Crystal Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Flush the plug before entering the
 slowpath.
Message-ID: <20230419140450.qPX3cUl8@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
 <20230418151838.jNcnnDqL@linutronix.de>
 <e3f9c399a6ef26a145a9fcc53201bbd98d9428ee.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3f9c399a6ef26a145a9fcc53201bbd98d9428ee.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-18 18:43:48 [-0500], Crystal Wood wrote:
> Sorry, got distracted.  It does appear to make the asserts go away but I ran
> into other possibly related stalls when running rteval -- but if I remove
> both the asserts and your patch it hangs in a different way, so I need to
> investigate some more.

So all is fine with the patch or does it still hang?
I tried "make runit" runtime set to 1h and it passed. The filesystem is
XFS on a single SATA device in case it matters.

> -Crystal

Sebastian

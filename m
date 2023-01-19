Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF0672E67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjASBsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjASBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:41 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11FB86CCCA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:38:47 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 19 Jan 2023 10:38:46 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Jan 2023 10:38:46 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     hdanton@sina.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, max.byungchul.park@gmail.com
Subject: Re: [PATCH RFC v7 08/23] dept: Apply sdt_might_sleep_strong() to PG_{locked,writeback} wait
Date:   Thu, 19 Jan 2023 10:38:34 +0900
Message-Id: <1674092314-16409-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20230109113720.221-1-hdanton@sina.com>
References: <20230109113720.221-1-hdanton@sina.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf wrote:
> On 9 Jan 2023 12:33:36 +0900 Byungchul Park <byungchul.park@lge.com>
>> Makes Dept able to track dependencies by PG_{locked,writeback} waits.
>> 
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
> 
> Hey Byungchul 

+cc max.byungchul.park@gmail.com

Hi,

This email never reached to me.

> Is DEPT able to get deadlock reported for the syzbot report [1]?

DEPT can detect the case 100% *IF* the folio_trylock() is released
within the same context since DEPT tracks folio_trylock(), folio_lock()
and folio_unlock(), and it's definitely a deadlock.

But as we know, because folio_trylock() can be released by another
context like irq, it might be either just a severe slowdown of the
context triggering folio_unlock() or a literal deadlock where the
context is involved. I dunno which one is the case.

In short, DEPT can detect this case too *IF* it's a literal deadlock,
but it doesn't if it's just a slowdown. I'm planning to warn it even if
there is a slowdown tho, not for now.

Let me reproduce the following issue. I will share the result.

> Hillf
> 
> [1] https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/

	Byungchul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BB698109
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBOQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBOQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:38:52 -0500
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2196A79
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:38:27 -0800 (PST)
Received: from unknown (HELO mail3.hale) ([192.168.100.5])
  by gw.hale.at with ESMTP; 15 Feb 2023 17:38:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail3.hale (Postfix) with ESMTP id 67298BD58B;
        Wed, 15 Feb 2023 17:38:24 +0100 (CET)
Received: from mail3.hale ([127.0.0.1])
        by localhost (mail3.hale [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gbNbBL4CRE0T; Wed, 15 Feb 2023 17:38:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail3.hale (Postfix) with ESMTP id EFCDCBD594;
        Wed, 15 Feb 2023 17:38:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail3.hale
Received: from mail3.hale ([127.0.0.1])
        by localhost (mail3.hale [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yRnVNnW7y150; Wed, 15 Feb 2023 17:38:23 +0100 (CET)
Received: from mail3.hale (mail3.hale [192.168.100.5])
        by mail3.hale (Postfix) with ESMTP id D2EAEBD58B;
        Wed, 15 Feb 2023 17:38:23 +0100 (CET)
Date:   Wed, 15 Feb 2023 17:38:23 +0100 (CET)
From:   Michael Thalmeier <michael.thalmeier@hale.at>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        john ogness <john.ogness@linutronix.de>
Message-ID: <1831554214.546921.1676479103702.JavaMail.zimbra@hale.at>
In-Reply-To: <Y+ztReOGJwAbpv52@alley>
References: <20230214115921.399608-1-michael.thalmeier@hale.at> <Y+zEAA1hp+3guGxT@axis.com> <Y+ztReOGJwAbpv52@alley>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.100.5]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF109 (Linux)/8.8.15_GA_4007)
Thread-Topic: ttynull: implement console write
Thread-Index: JhxFv7VaxVUD/wX9fLFIujWwTi5T4g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

----- On 15 Feb, 2023, at 15:33, Petr Mladek pmladek@suse.com wrote:
> On Wed 2023-02-15 12:37:36, Vincent Whitchurch wrote:
>> + Cc: John, Petr
>> 
>> On Tue, Feb 14, 2023 at 12:59:21PM +0100, Michael Thalmeier wrote:
>> > Since commit a699449bb13b ("printk: refactor and rework printing logic"),
>> > con->write is called without checking if it is implemented in the console
>> > driver. This does make some sense, because for all "normal" consoles it
>> > is vital to have a write function.
>> > As the ttynull console driver does not need any console output the write
>> > function was not implemented. This caused a "unable to handle kernel NULL
>> > pointer dereference" when the write function is called now.
>> > 
>> > To fix this issue, implement an empty write function.
>> > 
>> > Fixes: a699449bb13b ("printk: refactor and rework printing logic")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
>> 
>> Looking at the referenced commit, the only place I see it calling
>> con->write() is from call_console_driver(), which is in turn only called
>> from console_emit_next_record().  And console_flush_all(), the only
>> caller of console_emit_next_record(), checks that con->write is not NULL
>> using console_is_usable() before calling console_emit_next_record().
> 
> I see the same. The refactoring moved the check of con->write from
> call_console_driver() to console_is_usable(). It detects the NULL
> pointer earlier in console_flush_all()...
> 
>> What am I missing?  Which code path in the referenced commit calls
>> con->write without checking for NULL?
> 
> Vincent, could you please provide log with the backtrace?
> 
> I wonder if the problem is in the RT-patchset where
> console_emit_next_record() is called also from the printk kthread.

You are right. I have encountered this problem with the RT-patchset.
We currently are using the latest v5.15-rt kernel which had this problem.
 
> That said, the current code is error-prone. The check for non-NULL
> con->write is too far from the caller.
> 
> I would prefer to make it more safe. For example, I would prevent
> registration of consoles without con->write callback in the first
> place. It would require, to implement the empty write() callback
> for ttynull console as done by this patch.
> 
> Anyway, I would like to understand if the "unable to handle kernel NULL
> pointer dereference" is a real problem in the current implementation.

Unfortunately I have not yet tested with the current RT or non-RT versions.

> 
> Best Regards,
> Petr

Regards, Michael

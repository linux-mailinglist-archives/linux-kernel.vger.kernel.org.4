Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFA6226E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKIJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKIJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:28:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE19140F2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:27:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667986076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBWd6rB3fdMHT6oEL/e7KMDZ3KQ02pRiVMTRw5/T4Fs=;
        b=FfJighKGc9u3FkH5JHCszV7Aco3v/VpYXSSQedDDZQ/lWpPTEGNV0hwEW8IQ/80zZVXDvl
        kBvNEpcMV7S5PSi5IJ/G/2KAkEp3aBCSpMUV8zdhwfNzbhPPXt1C7mjDrP/sNAcKsIB7ZC
        hJPjSKupEO9xf4Vq5DS3nMujR+RQ3ng8LuCMpKsp86TlCiCMTaMDWZl+VcLCmrajCHQaJN
        IZH/ME2QlxG9O6H1E7J7wZZCgYGssS9WCwlXvUQtMS3dzRklS/1nuTJawDWyXA+NhxUEFI
        z+XolyeeTTOPH80+LiRjGbxDvQpOzXLeS0RAgRbTqcFSoLM38nTX8BZek2gcFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667986076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBWd6rB3fdMHT6oEL/e7KMDZ3KQ02pRiVMTRw5/T4Fs=;
        b=Ga1lG42zkWBk2sHyLogpfBWSoJrf/w9HW93ZPvv5qxNV/asdr3AI5W4jEdErP5K0y8Mr36
        1U/NOcrx5dl7cGBg==
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v3 15/40] kdb: use srcu console list iterator
In-Reply-To: <20221109085325.wiub564iqnewvczb@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-16-john.ogness@linutronix.de>
 <20221109085325.wiub564iqnewvczb@ash.lan>
Date:   Wed, 09 Nov 2022 10:33:55 +0106
Message-ID: <87wn848okk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2022-11-09, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>> +	/*
>> +	 * The console_srcu_read_lock() only provides safe console list
>> +	 * traversal. The use of the ->write() callback relies on all other
>> +	 * CPUs being stopped at the moment and console drivers being able to
>> +	 * handle reentrance when @oops_in_progress is set. (Note that there
>> +	 * is no guarantee for either criteria.)
>> +	 */
>
> The debugger entry protocol does ensure that other CPUs are either
> stopped or unresponsive. In the case where the other CPU is unresponsive
> (e.g. timed out after being asked to stop) then there is a "real" printk()
> issued prior to any of the above interference with the console system to
> the developer driving the debugger gets as much clue as we can offer them
> about what is going on (typically this is emitted from regular interrupt
> context).
>
> Given this comment is part of the debugger code then for the
> oops_in_progress hack it might be more helpful to describe what
> the developer in front the debugger needs to do to have the most
> reliable debug session possible.
>
>   There is no guarantee that every console drivers can handle reentrance
>   in this way; the developer deploying the debugger is responsible for
>   ensuring that the console drivers they have selected handle reentrance
>   appropriately.

Thanks for the explanation. I will change the comment to:

	/*
	 * The console_srcu_read_lock() only provides safe console list
	 * traversal. The use of the ->write() callback relies on all other
	 * CPUs being stopped at the moment and console drivers being able to
	 * handle reentrance when @oops_in_progress is set.
	 *
	 * There is no guarantee that every console driver can handle
	 * reentrance in this way; the developer deploying the debugger
	 * is responsible for ensuring that the console drivers they
	 * have selected handle reentrance appropriately.
	 */

John

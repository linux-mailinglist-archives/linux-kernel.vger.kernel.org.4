Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF23366D6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjAQHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjAQHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:11:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545722A34;
        Mon, 16 Jan 2023 23:11:41 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673939498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srv2GPQhiE1Dhl1/auwiFRncHX4gfzvbGImsSJ79J+Q=;
        b=N5FXQDrJmNvq9K5ggT5Lt9nzMbnDCT/VdVzSOZIbLCYaYb+gYa9VaqMpUw3YzqV7TzgnHA
        r8KWDPwEoG7ily3qvyBoDmAadyA2ydG5pMy6hmnEDr/I6GxJ/WPyO87YVGNcaIfLDImxL/
        JL4blMYCNFLlqramv/HNX0+z8a43sB6GL+VUW741X0z3g0Vivj1e4/XCZqZJ7UmfqcFrrI
        Krpt64EXe0nIUotYaK943tghT2Lt3RmJK2rhyaF5D3+xk8JXS/qAeR6RhY40oRtNycMfga
        hmIISa9FYYViIah4oQSvydDaDpxF3ZMBJdyWDNXneI2TUK8xpKgW9xYl3S2btw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673939498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srv2GPQhiE1Dhl1/auwiFRncHX4gfzvbGImsSJ79J+Q=;
        b=7V/AMKwUnWmITUVAEK1EgSV2EPk4/wzTvqngjnqZt1nh5KIBBtk0NeplGwuOmIcIdvPLov
        Ubbb1qq5CThovzBg==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        coverity-bot <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
In-Reply-To: <Y8YRBo7ZmtzWT4J1@google.com>
References: <202301131544.D9E804CCD@keescook> <Y8KAhaiZQOWTcfyF@google.com>
 <Y8V8tqMJeB7t+rcJ@alley> <Y8YRBo7ZmtzWT4J1@google.com>
Date:   Tue, 17 Jan 2023 08:16:48 +0106
Message-ID: <877cxl3abr.fsf@jogness.linutronix.de>
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

On 2023-01-17, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (23/01/16 17:35), Petr Mladek wrote:
>> 	len = snprintf(scratchbuf, scratchbuf_sz,
>> 		       "** %lu printk messages dropped **\n", dropped);
>
> Wouldn't
>
> 	if (WARN_ON_ONCE(len + PRINTK_PREFIX_MAX >= outbuf_sz))
> 		return;
>
> prevent us from doing something harmful?

Sure. But @0len is supposed to contain the number of bytes in
@scratchbuf, which theoretically it does not. snprintf() is the wrong
function to use here, even if there is not real danger in this
situation.

John Ogness

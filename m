Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3487121E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbjEZIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjEZIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:12:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403FA3;
        Fri, 26 May 2023 01:12:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685088741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtescR9shMIV5nIat/0FWujD2xSXV22kmNIzHt3OegM=;
        b=FMzteAYf1g9DD9BOxrgkS9js64tjHnyqvLwGhosq5/gi7xl+mPCKGJuLWI0dKw+zPOZ79Y
        HqubqKov993BCePmpuiFDCbJ6Cu23wmaBt6TqtPrQT7kgT51qsQlyYmWfK+z05O6hk+0Yo
        Bd/kdMA1dN3wClL0zLqf7jOwRPIWbvIjkwjLT0aHLEASTHI5Or0E+6ToTYb/5uGeMKbe85
        lpGTb5rObYXIx4mRpShaF98rdytVm7oVxtA81W7Yv9zW2fHL7dZNwpvI4xvTmxSyZa9dBH
        +QgszvtlZp43Q+QSrV3PusqCVRahSBe92UcI3a3NfVuUPEQUeGIGeurHxWFBZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685088741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtescR9shMIV5nIat/0FWujD2xSXV22kmNIzHt3OegM=;
        b=oI3xy911JXEjOl0PbFStmcA09ktuAtD7/VPEKXTfQ1k6TD+u6dkWEW492IdbA/VmXw/LJ9
        qONcPQLAXbNW8JCg==
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v1 4/8] serial: core: lock port for start_rx() in
 uart_resume_port()
In-Reply-To: <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
 <20230525093159.223817-5-john.ogness@linutronix.de>
 <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
 <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
Date:   Fri, 26 May 2023 10:15:51 +0206
Message-ID: <875y8f1pkg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-25, Doug Anderson <dianders@chromium.org> wrote:
>> Seems right, but shouldn't you also fix the call to stop_rx() that
>> the same commit cfab87c2c271 ("serial: core: Introduce callback for
>> start_rx and do stop_rx in suspend only if this callback
>> implementation is present.") added? That one is also missing the
>> lock, right?
>
> Ah, I see. You did that in a separate patch and I wasn't CCed. I guess
> I would have just put the two in one patch, but I don't feel that
> strongly.

Actually stop_rx() was introduced in a different commit. The commit you
reference just changed it a bit. My other patch uses a different Fixes
tag.

Also, I was concerned about packing too much new spin locking in a
single commit in the hopes it will help with any bisecting issues.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

John

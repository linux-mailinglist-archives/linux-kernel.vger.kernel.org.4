Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056F62D9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiKQLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiKQLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:54:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EF632A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:54:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668686069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqTjUyk61qo670ba2YgIwexSBuri4lwqzxTw2esfEJU=;
        b=EGB07lko/R1OsOyXFrtCbq/6QA1irKQNX6XMfraI0MtCVFCvqc4dcBWx4gqx9VmeCRM7JD
        1B1oQ0ypbttO7J0VgoMWKbBOoK38k88OA2YTqku0AYycxBC+ucMPnVsnh6cVYfKN7gMEGp
        S/8s75yjN2wBBycEryl0TgYFp5mWG5zh74/4od4CpRk3PtrZIvd/6RWf2BfK5C9OGaUn2r
        m/DRNy0eIrl7797NWqDYbL0h7SX+QYvnXIaehHRrx3fymTMx5XW+Nsdcyz4v8MnvdKuvCs
        DB8pEAiE3bBvyB3D0P1S9AKX6tmsUHpBz+1eiYxPpK1r0xKRx7XcUnLi0MLCRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668686069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqTjUyk61qo670ba2YgIwexSBuri4lwqzxTw2esfEJU=;
        b=Ua0y898NOpzh5FCKfEFs8Fhj1ZvuNsqbNoRKaCzt4bIsXWUe2lPcJZPxvT53dH/nqPtBNT
        rL/8vW6aZVi+LPAg==
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
In-Reply-To: <20221117024511.3606-1-hdanton@sina.com>
References: <0000000000009d5daa05ed9815fa@google.com>
 <20221117024511.3606-1-hdanton@sina.com>
Date:   Thu, 17 Nov 2022 12:54:28 +0100
Message-ID: <87fsehn6dn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2022 at 10:45, Hillf Danton wrote:
> On 16 Nov 2022 19:29:27 +0100 Thomas Gleixner <tglx@linutronix.de>
>> 
>
> I doubt your fix helps in the domain of workqueue in general, and in this
> report if it is delayed work that triggered the warning.

Indeed. I misread the backtrace and my brain connected the wrong dots
here. It's a different bluethooth hickup.

> --- x/net/bluetooth/hci_sync.c
> +++ y/net/bluetooth/hci_sync.c
> @@ -4806,6 +4806,7 @@ int hci_dev_close_sync(struct hci_dev *h
>  	/* Avoid potential lockdep warnings from the *_flush() calls by
>  	 * ensuring the workqueue is empty up front.
>  	 */
> +	cancel_delayed_work_sync(&hdev->cmd_timer);
>  	drain_workqueue(hdev->workqueue);

The work has been canceled already before in the same function and there
are some more delayed works which can trigger this.

So no, this whole close_sync() function is prone to teardown races and
just slapping a single cancel here without deeper analysis does not cut
it.

Thanks,

        tglx

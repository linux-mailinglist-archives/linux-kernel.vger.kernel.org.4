Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA33463C167
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiK2Np7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2Np6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578281F9CB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669729501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlXgqzr1YlJyffb0kfUdxdiKnbkpAW53h4Ow+kGUHhA=;
        b=GvrpkjJ9cPaCGGd9vR/Dq2DMDQPCRyC/ZeA5yvNePAhNkvQDRZM/TKJIrA5+CbtaG3l3aD
        Uj11HtLspRnNcrjjLOEwXUfyE5lfScHwwSwzbvqZS65FPR9xOUYfl3sPdMoH63/vHGMtyO
        AbzsnooLvMoTMPgp2LZGkF5Mr5Gl24w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-was1dM1HP_Kgaik-HxG6Rg-1; Tue, 29 Nov 2022 08:44:56 -0500
X-MC-Unique: was1dM1HP_Kgaik-HxG6Rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D75F58339C5;
        Tue, 29 Nov 2022 13:44:55 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE1FC15BA4;
        Tue, 29 Nov 2022 13:44:54 +0000 (UTC)
Date:   Tue, 29 Nov 2022 14:44:50 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221129144450.75a7181e@rotkaeppchen>
In-Reply-To: <20221128114200.72b3e2fe@gandalf.local.home>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
        <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
        <20221117160650.16e06b37@rotkaeppchen>
        <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
        <20221121150948.6f7c1f1f@rotkaeppchen>
        <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
        <20221124124000.5af23cad@rotkaeppchen>
        <CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
        <20221124160115.23ae7928@rotkaeppchen>
        <20221128114200.72b3e2fe@gandalf.local.home>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, 28 Nov 2022 11:42:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 24 Nov 2022 16:01:15 +0100
> Philipp Rudo <prudo@redhat.com> wrote:
> 
> > No, I think the implementation is fine. I'm currently only struggling
> > to understand what problem kexec_reboot_disabled solves that cannot be
> > solved by kexec_load_disabled.  
> 
> Hi Philipp,
> 
> Thanks for working with us on this.
> 
> Let me try to explain our use case. We want kexec/kdump enabled, but we
> really do not want kexec used for any other purpose. We must have the kexec
> kernel loaded at boot up and not afterward.
> 
> Your recommendation of:
> 
>   kexec -p dump_kernel
>   echo 1 > /proc/sys/kernel/kexec_load_disabled
> 
> can work, and we will probably add it. But we are taking the paranoid
> approach, and what I learned in security 101 ;-) and that is, only open up
> the minimal attack surface as possible.

Well that's sort of my problem. When you go all in on paranoia I would
expect that you also restrict the crash kernel. Otherwise you keep most
of the attack surface. But disabling 'reboot' of the crash kernel is
quite intrusive and probably not what you want. That's why I think it
is better do the restriction on the 'load' rather than the 'reboot'
path.

One solution for that is the script above. But that pushes all the
responsibilities concerning syncing and error handling to the sysadmin.
Depending on your level of paranoia that might be too risky. Personally
I think it's fine as the kernel alone cannot fix all potential security
problems. In my opinion this has to be done in the layer that is
responsible for the task done. So when a security problem arises due to
ill syncing when starting different services it's the job of the init
system to fix the issue.

An alternative approach and sort of compromise I see is to convert
kexec_load_disabled from a simple on/off switch to a counter on how
often a kexec load can be made (in practice a tristate on/off/one-shot
should be sufficient). Ideally the reboot and panic path will
have separate counters. With that you could for example use
kexec_load_limit.reboot=0 and kexec_load_limit.panic=1 to disable the
load of images for reboot while still allow to load a crash kernel
once. With this you have the flexibility you need while also preventing
a race where an attacker overwrites your crash kernel before you can
toggle the switch. What do you think?

> Yes, it's highly unlikely that the above would crash. But as with most
> security vulnerabilities, it's not going to be an attacker that creates a
> new gadget here, but probably another script in the future that causes this
> to be delayed or something, and a new window of opportunity will arise for
> an attacker. Maybe, that new window only works for non panic kernels. Yes,
> this is a contrived scenario, but the work vs risk is very low in adding
> this feature.

True, but that problem is not limited to userspace. For example see
Ricardos other patch [1] where he treats the load of a crash kernel
just like a standard load. In my opinion he creates such a gadget in
that patch.

[1] https://lore.kernel.org/all/20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org/

Thanks
Philipp

> Perhaps the attack surface that a reboot kexec could be, is that the
> attacker gets the ability at boot up to load the kexec for reboot and not panic.
> Then the attack must wait for the victim to reboot their machine before
> they have access to the new kernel. Again, I admit this is contrived, but
> just because I can't think of a real situation that this could be a problem
> doesn't mean that one doesn't exist.
> 
> In other words, if we never want to allow a kexec reboot, why allow it at
> all from the beginning? The above allows it, until we don't. That alone
> makes us nervous. Whereas this patch is rather trivial and doesn't add
> complexity.
> 
> Thanks for your time, we appreciate it.
> 
> -- Steve
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


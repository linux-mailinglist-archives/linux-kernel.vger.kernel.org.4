Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033563AE05
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiK1QmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiK1QmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:42:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0F24F3F;
        Mon, 28 Nov 2022 08:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495616126E;
        Mon, 28 Nov 2022 16:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00CCC433D7;
        Mon, 28 Nov 2022 16:42:01 +0000 (UTC)
Date:   Mon, 28 Nov 2022 11:42:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221128114200.72b3e2fe@gandalf.local.home>
In-Reply-To: <20221124160115.23ae7928@rotkaeppchen>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
        <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
        <20221117160650.16e06b37@rotkaeppchen>
        <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
        <20221121150948.6f7c1f1f@rotkaeppchen>
        <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
        <20221124124000.5af23cad@rotkaeppchen>
        <CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
        <20221124160115.23ae7928@rotkaeppchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 16:01:15 +0100
Philipp Rudo <prudo@redhat.com> wrote:

> No, I think the implementation is fine. I'm currently only struggling
> to understand what problem kexec_reboot_disabled solves that cannot be
> solved by kexec_load_disabled.

Hi Philipp,

Thanks for working with us on this.

Let me try to explain our use case. We want kexec/kdump enabled, but we
really do not want kexec used for any other purpose. We must have the kexec
kernel loaded at boot up and not afterward.

Your recommendation of:

  kexec -p dump_kernel
  echo 1 > /proc/sys/kernel/kexec_load_disabled

can work, and we will probably add it. But we are taking the paranoid
approach, and what I learned in security 101 ;-) and that is, only open up
the minimal attack surface as possible.

Yes, it's highly unlikely that the above would crash. But as with most
security vulnerabilities, it's not going to be an attacker that creates a
new gadget here, but probably another script in the future that causes this
to be delayed or something, and a new window of opportunity will arise for
an attacker. Maybe, that new window only works for non panic kernels. Yes,
this is a contrived scenario, but the work vs risk is very low in adding
this feature.

Perhaps the attack surface that a reboot kexec could be, is that the
attacker gets the ability at boot up to load the kexec for reboot and not panic.
Then the attack must wait for the victim to reboot their machine before
they have access to the new kernel. Again, I admit this is contrived, but
just because I can't think of a real situation that this could be a problem
doesn't mean that one doesn't exist.

In other words, if we never want to allow a kexec reboot, why allow it at
all from the beginning? The above allows it, until we don't. That alone
makes us nervous. Whereas this patch is rather trivial and doesn't add
complexity.

Thanks for your time, we appreciate it.

-- Steve

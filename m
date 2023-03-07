Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4C6AD3B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCGBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:08:29 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA330B04;
        Mon,  6 Mar 2023 17:08:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 6FCD62012C;
        Tue,  7 Mar 2023 02:08:25 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPqUQ-mWdehP; Tue,  7 Mar 2023 02:08:25 +0100 (CET)
Received: from begin.home (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1360D200EE;
        Tue,  7 Mar 2023 02:08:25 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pZLoW-001GOs-1z;
        Tue, 07 Mar 2023 02:08:24 +0100
Date:   Tue, 7 Mar 2023 02:08:24 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
Message-ID: <20230307010824.foxfdlhvuqc43dex@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <0000000000001d1fb505f605c295@google.com>
 <64026f89.170a0220.7940.49ff@mx.google.com>
 <20230305175457.kp6b5lmwwdxw4ii6@begin>
 <CANp29Y4dNRuu1u8Dz+eXhi2NJ=MsN5wfCr1h9sJ73o25Of63Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4dNRuu1u8Dz+eXhi2NJ=MsN5wfCr1h9sJ73o25Of63Ww@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksandr Nogikh, le lun. 06 mars 2023 11:28:04 +0100, a ecrit:
> On Mon, Mar 6, 2023 at 8:36 AM Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> >
> > The patch below should be fixing it, could you check?
> >
> > I don't know how I am supposed to properly reference the syzbot report
> > etc., could somebody used to the process handle submitting the fix?
> 
> As Jiri Slaby correctly said above, you just need to add the
> `Reported-by` tag from the syzbot bug report to your patch so that the
> bot can recognize the fix later.
> 
> If you just want syzbot to check whether the reproducer still triggers
> the bug after your changes, you can send an email with the `syz test`
> command and the raw diff patch. Here are the instructions:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> and here are many examples:
> https://groups.google.com/g/syzkaller-bugs/search?q=%22%23syz%20test%22

Thanks! The patch does fix the reproducer case.

Samuel

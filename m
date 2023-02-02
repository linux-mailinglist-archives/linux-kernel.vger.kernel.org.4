Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFB6889AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBBW0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBBW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FDCC04
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675376717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8BHBNa+yNC4hDxX+kSVeo8iDcZfNEIlhda9yEMbHoc=;
        b=T0VJaApelDWowy8Isl9fqAbIKemmrDgRnNCMmrmlDj1grXv0L9ubz5tVXkMHoSew9IZqLX
        a84CDL/FrO7uyPNE96iOtcc0Cyu99udXaJfbs25vKFtDBUKXavVuFYRE3vsWpt7JBMqgF3
        sRphwikt4UIlQpVy65KUybtm1cZwNX4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-HGrorYAaO7OLHlOatt38WA-1; Thu, 02 Feb 2023 17:25:16 -0500
X-MC-Unique: HGrorYAaO7OLHlOatt38WA-1
Received: by mail-ej1-f72.google.com with SMTP id z2-20020a1709060be200b0088b579825f9so2443185ejg.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8BHBNa+yNC4hDxX+kSVeo8iDcZfNEIlhda9yEMbHoc=;
        b=P/KE5gR+3QLF/7KfjAhZU+hIHsLGwUMw0/WkmXjtQMSpckD+rNHnhqU6pevwGrISkH
         FW+DaDhMvn+3L3yCwOAIdxGkD/CwOdjQ7+v7+Ulx8SBFlWlp8T7f2pTFTQZmwxIsyRuE
         coSc8l/GJ1iNjcVvC66czATxVrM6L/kZyvAyfurP9C7JFBGwitRsRYsYnbf4RH3XlRxz
         5ZWmeW7QR9DItF3xA2WMraY/8/bkxtdU6MnHAumuy18Ynn+obqVvMhXNhW7F8TAf2QOO
         fWFf3iDJMvKentPlHvboG1+SD8w1n25ofU8SOndLEwqGmmIGHZphWhgdwzG94xtQgrZa
         FGVg==
X-Gm-Message-State: AO0yUKUQjWCobVeb8vKqtpVHKAKOL8vEHIfyHQgC9HIO2gcvPMkga/Ux
        voF9pdqJE1YDZd6SoKnaNhfrGReKZherR7gwBqOliNWoJICFf7Mau8ub8pSxM08rEsC39aeXtzL
        95Xi4I5Ls2THQxrvQP2HE+AUAgTrrltN9OzdOwPL5
X-Received: by 2002:a05:6402:360a:b0:499:cfee:8d96 with SMTP id el10-20020a056402360a00b00499cfee8d96mr2481751edb.21.1675376714505;
        Thu, 02 Feb 2023 14:25:14 -0800 (PST)
X-Google-Smtp-Source: AK7set/RS3nWD5I2qidy/TUBFe5KzmDNDoQo3pywjpkX7ZNqRxjHHFLYfFeOAyYKMUUZ3YPLVMy4JsWgYmPMR6yaBs0=
X-Received: by 2002:a05:6402:360a:b0:499:cfee:8d96 with SMTP id
 el10-20020a056402360a00b00499cfee8d96mr2481747edb.21.1675376714326; Thu, 02
 Feb 2023 14:25:14 -0800 (PST)
MIME-Version: 1.0
References: <6b008b94e3b295f572502abec8ae15da46133a64.1675351367.git.edwin.torok@cloud.com>
In-Reply-To: <6b008b94e3b295f572502abec8ae15da46133a64.1675351367.git.edwin.torok@cloud.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 2 Feb 2023 17:25:02 -0500
Message-ID: <CAK-6q+gJ_JOo1KXwGsYPc1fkKnYLM3vNSZXuxxVSrdZbROzYug@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH] DLM: increase socket backlog to avoid
 hangs with 16 nodes
To:     =?UTF-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 2, 2023 at 10:37 AM Edwin T=C3=B6r=C3=B6k <edvin.torok@citrix.c=
om> wrote:
>
> On a 16 node virtual cluster with e1000 NICs joining the 12th node prints
> SYN flood warnings for the DLM port:
> Dec 21 01:46:41 localhost kernel: [ 2146.516664] TCP: request_sock_TCP: P=
ossible SYN flooding on port 21064. Sending cookies.  Check SNMP counters.
>
> And then joining a DLM lockspace hangs:
> ```
> Dec 21 01:49:00 localhost kernel: [ 2285.780913] INFO: task xapi-clusterd=
:17638 blocked for more than 120 seconds.                                  =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.786476]       Not tainted 4.4.0+=
10 #1                                                                      =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.789043] "echo 0 > /proc/sys/kern=
el/hung_task_timeout_secs" disables this message.                          =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794611] xapi-clusterd   D ffff88=
001930bc58     0 17638      1 0x00000000                                   =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794615]  ffff88001930bc58 ffff88=
0025593800 ffff880022433800 ffff88001930c000                               =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794617]  ffff88000ef4a660 ffff88=
000ef4a658 ffff880022433800 ffff88000ef4a000                               =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794619]  ffff88001930bc70 ffffff=
ff8159f6b4 7fffffffffffffff ffff88001930bd10
> Dec 21 01:49:00 localhost kernel: [ 2285.794644]  [<ffffffff811570fe>] ? =
printk+0x4d/0x4f                                                           =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794647]  [<ffffffff810b1741>] ? =
__raw_callee_save___pv_queued_spin_unlock+0x11/0x20                        =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794649]  [<ffffffff815a085d>] wa=
it_for_completion+0x9d/0x110                                               =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794653]  [<ffffffff810979e0>] ? =
wake_up_q+0x80/0x80                                                        =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794661]  [<ffffffffa03fa4b8>] dl=
m_new_lockspace+0x908/0xac0 [dlm]                                          =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794665]  [<ffffffff810aaa60>] ? =
prepare_to_wait_event+0x100/0x100                                          =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794670]  [<ffffffffa0402e37>] de=
vice_write+0x497/0x6b0 [dlm]                                               =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794673]  [<ffffffff811834f0>] ? =
handle_mm_fault+0x7f0/0x13b0                                               =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794677]  [<ffffffff811b4438>] __=
vfs_write+0x28/0xd0                                                        =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794679]  [<ffffffff811b4b7f>] ? =
rw_verify_area+0x6f/0xd0                                                   =
                                   =E2=94=A4
> Dec 21 01:49:00 localhost kernel: [ 2285.794681]  [<ffffffff811b4dc1>] vf=
s_write+0xb1/0x190                                                         =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794686]  [<ffffffff8105ffc2>] ? =
__do_page_fault+0x302/0x420                                                =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794688]  [<ffffffff811b5986>] Sy=
S_write+0x46/0xa0                                                          =
                                   =E2=94=82
> Dec 21 01:49:00 localhost kernel: [ 2285.794690]  [<ffffffff815a31ae>] en=
try_SYSCALL_64_fastpath+0x12/0x71
> ```
>
> The previous limit of 5 seems like an arbitrary number, that doesn't matc=
h any
> known DLM cluster size upper bound limit.
>
> Signed-off-by: Edwin T=C3=B6r=C3=B6k <edvin.torok@citrix.com>
> Cc: Christine Caulfield <ccaulfie@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Cc: cluster-devel@redhat.com
> ---
> Notes from 2023:
>   This patch was initially developed on 21 Dec 2017, and in production us=
e ever since.
> I expected to drop out of our patchqueue at the next kernel upgrade, howe=
ver it
> hasn't, so I probably forgot to send it.
>
> I haven't noticed this bug again with the patch applied, and the previous=
 value
> of '5' seems like an arbitrary limit not matching any supported upper bou=
nds
> on DLM cluster sizes, so this patch has (unintentionally) had a 5 year te=
st
> cycle.

Correct, I guess the 128 coming from dlm_controld 128 max node
boundary [0] and I think it's okay to change it to 128, especially if
you start a cluster every "mostly" node wants to connect() at the same
time and the backlog of 5 could be not enough to handle them.
From my understanding the connect() will return -ECONNREFUSED in the
case of backlog is full. As I see the code of kernel v4.0 dlm at this
point will _not_ slow down a reattempt to run connect() again, see
[1].

>
> Although the join hanging forever like that may still be a bug, if the SY=
N cookies
> consistently trigger it lets try to avoid the bug by avoiding the SYN coo=
kies.

right, it should work even with 1 as a backlog... after digging into
the code. My guess is that [2] ran into the MAX_CONNECT_RETRIES
condition and we do _not_ reset con->retries to 0 if connect() [3]
fails. If this happens we are kind of stuck and we would not try to
connect() again. Means you run into the hung task situation, because
e.g. ping_members() will not succeed.

The current upstream code does not have any limitations of trying
retries and will always wait some time to try a connect() again if it
fails. It should retry to connect so long the cluster manager tells
dlm kernel that a specific node is still part of a lockspace resource
and there is a transmission happening to this particular node. However
I think pumping this value to the maximum amount of possible nodes in
a cluster is not a bad idea.

There is still a question of "why seeing SYN flooding" warning, but as
I said there are a lot of connect() happening at the beginning at
mostly the same time starting a cluster and some of them retrying
connect() fast.

...

- Alex

[0] https://pagure.io/dlm/blob/c1e2ee574794e0dea68fd45783991ef7b1835901/f/d=
lm_controld/dlm_daemon.h#_177
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lowcomms.c?h=3Dv4.0#n1226
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lowcomms.c?h=3Dv4.0#n1168
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lowcomms.c?h=3Dv4.0#n1220


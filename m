Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB2689E82
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjBCPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:50:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C84A1FE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:50:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so5021731wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCfzT6aYmrH2OqQ2RZxzVWm3B4Br51qWFv5znulYAtk=;
        b=T/hxJvNX1RrFBOKDM0+DZLLVWI8esbYNsme1UKAp/WVLTHpxNZVcret+AH6HYikMxv
         J/OUMqGkL3rjEAABuPPQWCG3WuG37O7mCAOC2Vcf8S8FAAS58XQ3uhD/nvJqZWQMCqWg
         d5u+5GlhHJMJ9I2aCfsyXVicoLdhTC8w/Ymbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCfzT6aYmrH2OqQ2RZxzVWm3B4Br51qWFv5znulYAtk=;
        b=I8/9asFB46scUN3RjRzEaUhQculsFowjB9NOXZTIZJMJiuoZwGxBiRwQQ/ADFiDPc1
         +NoMt4ar0GNwez4J9/JbvwPaw5kI0UiiMypGlVQjWHcIXK636Du8TaN4iBp8eTZ749Dn
         cUh+czUm/8X7uyJ35WnOLAUcj3puTQFkV6E6gQnuuDgeMq8GbqfiirQNJ7waAGdQacWv
         jmhFJldhX3KGMH26JNlm6iciZ2PCmBZKEz9Mq8ZZA23jeDqH6x1/89N5RwpyuDdqODOH
         fJ5ETCrrV1haW2VZ42LNKzWli/oI5G1eq4rp4OikwvYF3u19BLnMU6TyJ1OlMz1XLFAf
         h6UQ==
X-Gm-Message-State: AO0yUKX9eXkpEKbl1H9F3OZuKNZMfUSGjXp8KhqsyKuAjlXiPHgwgRx6
        1uyVrniTpz1N2LFabdJXvCBHug==
X-Google-Smtp-Source: AK7set/LDy+j+zyyotWFrklHxjdVAtQoTZY8wcPeEJtNYfmE4fZFXlqIFxo8RF8cECTo2hF3VK3Hfw==
X-Received: by 2002:a5d:65c9:0:b0:2bd:e87c:e831 with SMTP id e9-20020a5d65c9000000b002bde87ce831mr10619287wrw.69.1675439415570;
        Fri, 03 Feb 2023 07:50:15 -0800 (PST)
Received: from smtpclient.apple ([81.78.83.63])
        by smtp.gmail.com with ESMTPSA id e8-20020adffc48000000b002bdc3f5945dsm2246182wrs.89.2023.02.03.07.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2023 07:50:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [Cluster-devel] [PATCH] DLM: increase socket backlog to avoid
 hangs with 16 nodes
From:   Edwin Torok <edwin.torok@cloud.com>
In-Reply-To: <CAK-6q+gJ_JOo1KXwGsYPc1fkKnYLM3vNSZXuxxVSrdZbROzYug@mail.gmail.com>
Date:   Fri, 3 Feb 2023 15:50:04 +0000
Cc:     =?utf-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A25AA8AF-24D3-419D-BC27-2741CFC3A486@cloud.com>
References: <6b008b94e3b295f572502abec8ae15da46133a64.1675351367.git.edwin.torok@cloud.com>
 <CAK-6q+gJ_JOo1KXwGsYPc1fkKnYLM3vNSZXuxxVSrdZbROzYug@mail.gmail.com>
To:     Alexander Aring <aahringo@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2 Feb 2023, at 22:25, Alexander Aring <aahringo@redhat.com> wrote:
>=20
> [CAUTION - EXTERNAL EMAIL] DO NOT reply, click links, or open =
attachments unless you have verified the sender and know the content is =
safe.
>=20
> Hi,
>=20
> On Thu, Feb 2, 2023 at 10:37 AM Edwin T=C3=B6r=C3=B6k =
<edvin.torok@citrix.com> wrote:
>>=20
>> On a 16 node virtual cluster with e1000 NICs joining the 12th node =
prints
>> SYN flood warnings for the DLM port:
>> Dec 21 01:46:41 localhost kernel: [ 2146.516664] TCP: =
request_sock_TCP: Possible SYN flooding on port 21064. Sending cookies.  =
Check SNMP counters.
>>=20
>> And then joining a DLM lockspace hangs:
>> ```
>> Dec 21 01:49:00 localhost kernel: [ 2285.780913] INFO: task =
xapi-clusterd:17638 blocked for more than 120 seconds.                   =
                                                  =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.786476]       Not tainted =
4.4.0+10 #1                                                              =
                                           =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.789043] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.          =
                                                   =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794611] xapi-clusterd   D =
ffff88001930bc58     0 17638      1 0x00000000                           =
                                           =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794615]  ffff88001930bc58 =
ffff880025593800 ffff880022433800 ffff88001930c000                       =
                                           =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794617]  ffff88000ef4a660 =
ffff88000ef4a658 ffff880022433800 ffff88000ef4a000                       =
                                           =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794619]  ffff88001930bc70 =
ffffffff8159f6b4 7fffffffffffffff ffff88001930bd10
>> Dec 21 01:49:00 localhost kernel: [ 2285.794644]  =
[<ffffffff811570fe>] ? printk+0x4d/0x4f                                  =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794647]  =
[<ffffffff810b1741>] ? =
__raw_callee_save___pv_queued_spin_unlock+0x11/0x20                      =
                                     =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794649]  =
[<ffffffff815a085d>] wait_for_completion+0x9d/0x110                      =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794653]  =
[<ffffffff810979e0>] ? wake_up_q+0x80/0x80                               =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794661]  =
[<ffffffffa03fa4b8>] dlm_new_lockspace+0x908/0xac0 [dlm]                 =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794665]  =
[<ffffffff810aaa60>] ? prepare_to_wait_event+0x100/0x100                 =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794670]  =
[<ffffffffa0402e37>] device_write+0x497/0x6b0 [dlm]                      =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794673]  =
[<ffffffff811834f0>] ? handle_mm_fault+0x7f0/0x13b0                      =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794677]  =
[<ffffffff811b4438>] __vfs_write+0x28/0xd0                               =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794679]  =
[<ffffffff811b4b7f>] ? rw_verify_area+0x6f/0xd0                          =
                                                            =E2=94=A4
>> Dec 21 01:49:00 localhost kernel: [ 2285.794681]  =
[<ffffffff811b4dc1>] vfs_write+0xb1/0x190                                =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794686]  =
[<ffffffff8105ffc2>] ? __do_page_fault+0x302/0x420                       =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794688]  =
[<ffffffff811b5986>] SyS_write+0x46/0xa0                                 =
                                                            =E2=94=82
>> Dec 21 01:49:00 localhost kernel: [ 2285.794690]  =
[<ffffffff815a31ae>] entry_SYSCALL_64_fastpath+0x12/0x71
>> ```
>>=20
>> The previous limit of 5 seems like an arbitrary number, that doesn't =
match any
>> known DLM cluster size upper bound limit.
>>=20
>> Signed-off-by: Edwin T=C3=B6r=C3=B6k <edvin.torok@citrix.com>
>> Cc: Christine Caulfield <ccaulfie@redhat.com>
>> Cc: David Teigland <teigland@redhat.com>
>> Cc: cluster-devel@redhat.com
>> ---
>> Notes from 2023:
>>  This patch was initially developed on 21 Dec 2017, and in production =
use ever since.
>> I expected to drop out of our patchqueue at the next kernel upgrade, =
however it
>> hasn't, so I probably forgot to send it.
>>=20
>> I haven't noticed this bug again with the patch applied, and the =
previous value
>> of '5' seems like an arbitrary limit not matching any supported upper =
bounds
>> on DLM cluster sizes, so this patch has (unintentionally) had a 5 =
year test
>> cycle.
>=20
> Correct, I guess the 128 coming from dlm_controld 128 max node
> boundary [0] and I think it's okay to change it to 128, especially if
> you start a cluster every "mostly" node wants to connect() at the same
> time and the backlog of 5 could be not enough to handle them.
> =46rom my understanding the connect() will return -ECONNREFUSED in the
> case of backlog is full. As I see the code of kernel v4.0 dlm at this
> point will _not_ slow down a reattempt to run connect() again, see
> [1].

Thanks for digging into the code, that explains why 'SYN cookies' is a =
symptom rather than a bug here.

>=20
>>=20
>> Although the join hanging forever like that may still be a bug, if =
the SYN cookies
>> consistently trigger it lets try to avoid the bug by avoiding the SYN =
cookies.
>=20
> right, it should work even with 1 as a backlog... after digging into
> the code. My guess is that [2] ran into the MAX_CONNECT_RETRIES
> condition and we do _not_ reset con->retries to 0 if connect() [3]
> fails. If this happens we are kind of stuck and we would not try to
> connect() again. Means you run into the hung task situation, because
> e.g. ping_members() will not succeed.
>=20
> The current upstream code does not have any limitations of trying
> retries and will always wait some time to try a connect() again if it
> fails. It should retry to connect so long the cluster manager tells
> dlm kernel that a specific node is still part of a lockspace resource
> and there is a transmission happening to this particular node. However
> I think pumping this value to the maximum amount of possible nodes in
> a cluster is not a bad idea.


Although there are improvements possible in how connect failures are =
handled, this situation is quite rare outside of
a stress test under lab conditions, and this one-liner is probably the =
easiest way to improve robustness in this area.

>=20
> There is still a question of "why seeing SYN flooding" warning, but as
> I said there are a lot of connect() happening at the beginning at
> mostly the same time starting a cluster and some of them retrying
> connect() fast.

Yes, I think the SYN flood warning means just that: too many connects in =
a very short timeframe
and backlog exceeded, i.e. a symptom rather than a cause.

Best regards,
--Edwin

>=20
> ...
>=20
> - Alex
>=20
> [0] =
https://pagure.io/dlm/blob/c1e2ee574794e0dea68fd45783991ef7b1835901/f/dlm_=
controld/dlm_daemon.h#_177
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/dlm/lowcomms.c?h=3Dv4.0#n1226
> [2] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/dlm/lowcomms.c?h=3Dv4.0#n1168
> [3] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/dlm/lowcomms.c?h=3Dv4.0#n1220
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FC5EB5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIZXr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIZXry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:47:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0903492599
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:47:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x18so5142693qkn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=Ns4t/x9DBAySHPZtDToGSpr/LxaXlGe4KfUz12R2qF8=;
        b=gdVQIqWhFcYJfh88PdaR/FPTLnYukfw1Vl026oJduRBQdkomvO0vwABmc4EojMkBh/
         BY17WAoJiw+P5VbJYgypQLm30WF/5fXPDnQPlNev43fYV7LIm0ZrBCw3Upi41UqKijL1
         Fyhqqvz2+6qnkqoninfJ5/lerZa+B8Up7KV7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ns4t/x9DBAySHPZtDToGSpr/LxaXlGe4KfUz12R2qF8=;
        b=uvOa9Vx0vZPJqLZZp9hfchtEaQ2kb8zpnq4uFqRBLCUIQovCWC8k/7+O4BgwqKmgyp
         h5mf+BnF/a/KNc1yiFGnB4N7Q00qgt9eIpZ9FQ/MwVa5HHCKUoBU6oKcukXRXBA2fiik
         S68PEEubddfdq6EWTHyhfJGtOjTwlbO149k81WpSWEQSbf9PpDlQBVypJbb4wUfUYujB
         FMxYfNndDwZPXu5ACZoGv79J8d01LZHaSY5EZjhRt5fOfcXJmtPznm4k/Ap1fR5+C1mu
         pMQ+qX2GxtLP5e2ZcAGWQXwTfgmPGdmm8gSMKUQ58WghYszD7++WpRF+mjOpy4QXlSbs
         ZADg==
X-Gm-Message-State: ACrzQf2xeLLPsrIyN0ew9KvDWXX6R3Cr6NDD3gVhCxH/LDTxj0RmymB1
        sxD4vWgjf6iIzSRi4DECiYNm4g3Lbc2p5TpB
X-Google-Smtp-Source: AMsMyM6k3drMMCfs/elpDmyPs5HZhc0KUfZxOZ92oKV/Da628vTY6uGSwgKRHMkcU+Z2l15e8Dh+zA==
X-Received: by 2002:a05:620a:3724:b0:6ce:1a37:ef29 with SMTP id de36-20020a05620a372400b006ce1a37ef29mr16537662qkb.754.1664236071988;
        Mon, 26 Sep 2022 16:47:51 -0700 (PDT)
Received: from smtpclient.apple (26.sub-174-216-180.myvzw.com. [174.216.180.26])
        by smtp.gmail.com with ESMTPSA id c12-20020a05622a058c00b0035bafecff78sm12713257qtb.74.2022.09.26.16.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 16:47:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Mon, 26 Sep 2022 19:47:50 -0400
Message-Id: <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
In-Reply-To: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2022, at 6:32 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 26, 2022 at 09:02:21PM +0000, Joel Fernandes wrote:
>> On Mon, Sep 26, 2022 at 09:32:44PM +0200, Uladzislau Rezki wrote:
>> [...]
>>>>>> On my KVM machine the boot time is affected:
>>>>>>=20
>>>>>> <snip>
>>>>>> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Con=
nection
>>>>>> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
>>>>>> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form=
2 tray
>>>>>> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
>>>>>> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
>>>>>> [  104.115418] process '/usr/bin/fstype' started with executable stac=
k
>>>>>> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data m=
ode. Quota mode: none.
>>>>>> [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +=
AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +=
GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 defau=
lt-hierarchy=3Dhybrid)
>>>>>> [  104.340193] systemd[1]: Detected virtualization kvm.
>>>>>> [  104.340196] systemd[1]: Detected architecture x86-64.
>>>>>> [  104.359032] systemd[1]: Set hostname to <pc638>.
>>>>>> [  105.740109] random: crng init done
>>>>>> [  105.741267] systemd[1]: Reached target Remote File Systems.
>>>>>> <snip>
>>>>>>=20
>>>>>> 2 - 11 and second delay is between 32 - 104. So there are still users=
 which must
>>>>>> be waiting for "RCU" in a sync way.
>>>>>=20
>>>>> I was wondering if you can compare boot logs and see which timestamp d=
oes the
>>>>> slow down start from. That way, we can narrow down the callback. Also a=
nother
>>>>> idea is, add "trace_event=3Drcu:rcu_callback,rcu:rcu_invoke_callback
>>>>> ftrace_dump_on_oops" to the boot params, and then manually call
>>>>> "tracing_off(); panic();" from the code at the first printk that seems=
 off in
>>>>> your comparison of good vs bad. For example, if "crng init done" times=
tamp is
>>>>> off, put the "tracing_off(); panic();" there. Then grab the serial con=
sole
>>>>> output to see what were the last callbacks that was queued/invoked.
>>>>=20
>>>> We do seem to be in need of some way to quickly and easily locate the
>>>> callback that needed to be _flush() due to a wakeup.
>>>>=20
>>> <snip>
>>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>>> index aeea9731ef80..fe1146d97f1a 100644
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, s=
truct rcu_work *rwork)
>>>=20
>>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(wor=
k))) {
>>>                rwork->wq =3D wq;
>>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
>>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
>>>                return true;
>>>        }
>>>=20
>>> <snip>
>>>=20
>>> ?
>>>=20
>>> But it does not fully solve my boot-up issue. Will debug tomorrow furthe=
r.
>>=20
>> Ah, but at least its progress, thanks. Could you send me a patch to inclu=
de
>> in the next revision with details of this?
>>=20
>>>> Might one more proactive approach be to use Coccinelle to locate such
>>>> callback functions?  We might not want -all- callbacks that do wakeups
>>>> to use call_rcu_flush(), but knowing which are which should speed up
>>>> slow-boot debugging by quite a bit.
>>>>=20
>>>> Or is there a better way to do this?
>>>>=20
>>> I am not sure what Coccinelle is. If we had something automated that mea=
sures
>>> a boot time and if needed does some profiling it would be good. Otherwis=
e it
>>> is a manual debugging mainly, IMHO.
>>=20
>> Paul, What about using a default-off kernel CONFIG that splats on all laz=
y
>> call_rcu() callbacks that do a wake up. We could use the trace hooks to d=
o it
>> in kernel I think. I can talk to Steve to get ideas on how to do that but=
 I
>> think it can be done purely from trace events (we might need a new
>> trace_end_invoke_callback to fire after the callback is invoked). Thought=
s?
>=20
> Could you look for wakeups invoked between trace_rcu_batch_start() and
> trace_rcu_batch_end() that are not from interrupt context?  This would
> of course need to be associated with a task rather than a CPU.

Yes this sounds good, but we also need to know if the callbacks are lazy or n=
ot since wake-up is ok from a non lazy one. I think I=E2=80=99ll need a tabl=
e to track that at queuing time.

> Note that you would need to check for wakeups from interrupt handlers
> even with the extra trace_end_invoke_callback().  The window where an
> interrupt handler could do a wakeup would be reduced, but not eliminated.

True! Since this is a  debugging option, can we not just disable interrupts a=
cross callback invocation?

Thanks,

  - Joel

>=20
>                            Thanx, Paul

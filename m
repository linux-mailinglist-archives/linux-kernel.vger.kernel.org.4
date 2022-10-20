Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCC606A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJTVdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJTVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:33:40 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482732248F7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:33:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id mg6so573169qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1If2fEA1ln1Ldj1cDxXYN45cAJ7HIJhk+exacuEf5U=;
        b=SlnwfwnpEsI3kHTxvfD9wyQZpOGRfB6PPis7kHiM2LhDYB1zLec9xgwY0ugllOJSTe
         OEkoKuh/hS/IapZV8iQjoGrHJN1+LmJ1m5bWlg0/DUJikJjJpMHg904VANNsTpWLZNC/
         cvz96eBPRXTL7a0eRv7fiu9UY2Awh2x/K3lF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1If2fEA1ln1Ldj1cDxXYN45cAJ7HIJhk+exacuEf5U=;
        b=nZkj79u9nvqXb786hjVcgWNx0xu4O7MMn7We8HKzqmSNBUtI6eU8uipuYcGpsK+I+n
         290/EOYK4ys/svcsuq1HygYQ0mvx8jP7hKuEPXTrz2Yn8+FOIyUVDy0vCxtqNEYaOP5u
         g5FOpOwLmFi5jNOJ1kVF4yQUBc9+M0j7ddJMR3WaBZszTPzYK2LkIT+2y0KKpWt5Ndle
         ba/ClHcUHjrGZ+Y0hK77/b7aIdf8sJDxK54msfvJL7TuzfVF8t+tVTPCtYKc4sWezMDM
         d1l3N4/JcOlnfR52F5hEo2WhUF1URGcwFPt8A5VwfXp89CKYT/DkRV1KB7gm0qVe5IEi
         DTyw==
X-Gm-Message-State: ACrzQf0mfmiYKxr0187PL3zYrFvLrCKQa8LgLKMDqFJUT/c0WKiadlJX
        e2Sj5Iw9kY6jntVj0a9O9M4rr3yMaC6RJA==
X-Google-Smtp-Source: AMsMyM7tyRGkWMnqdw99NN/hOhwv9PDbG7dUHeGYG42co04kH+8w5RTU74/6uPi/eHThAha+q5AKrg==
X-Received: by 2002:a0c:e193:0:b0:4b4:7ac2:8c42 with SMTP id p19-20020a0ce193000000b004b47ac28c42mr13650926qvl.51.1666301618237;
        Thu, 20 Oct 2022 14:33:38 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b843:47ff:86c:c87:eba3:8788])
        by smtp.gmail.com with ESMTPSA id do20-20020a05620a2b1400b006ec9f5e3396sm8481939qkb.72.2022.10.20.14.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 14:33:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 17:33:37 -0400
Message-Id: <DC93C5EB-91A5-4291-A642-8A57179930E4@joelfernandes.org>
References: <95331C23-3632-4E0B-9959-43CE159FE60F@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <95331C23-3632-4E0B-9959-43CE159FE60F@joelfernandes.org>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 20, 2022, at 2:46 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>>>=20
>>>>> More comments below:
>>>>>>=20
>>>>>>>> Looks like though I made every one test the patch without having to=
 enable the config option ;-). Hey, I=E2=80=99m a half glass full kind of gu=
y, why do you ask?
>>>>>>>>=20
>>>>>>>> Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk,=
 but would you prefer to squash a diff into the existing patch, or want a ne=
w patch altogether?
>>>>>>>=20
>>>>>>> On the other hand, what I=E2=80=99d want is to nuke the config optio=
n altogether or make it default y, we want to catch issues sooner than later=
.
>>>>>>=20
>>>>>> That might be what we do at some point, but one thing at a time.  Let=
's
>>>>>> not penalize innocent bystanders, at least not just yet.
>>>>>=20
>>>>> It=E2=80=99s a trade off, I thought that=E2=80=99s why we wanted to ha=
ve the binary search stuff. If no one reports issue on Linux-next, then that=
 code won=E2=80=99t be put to use in the near future at least.
>>>>=20
>>>> Well, not to put too fine a point on it, but we currently really are
>>>> exposing -next to lazy call_rcu().  ;-)
>>>=20
>>> This is true. I think I assumed nobody will enable a default off config o=
ption but I probably meant a smaller percentage will.
>>>=20
>>>>>> I do very strongly encourage the ChromeOS and Android folks to test t=
his
>>>>>> very severely, however.
>>>>>=20
>>>>> Agreed. Yes that will happen, though I have to make a note for Android=
 folks other than Vlad, to backports these (and enable the config option), c=
arefully! Especially on pre-5.15 kernels. Luckily I had to do this (not so t=
rivial) exercise myself.
>>>>=20
>>>> And this is another situation in which the binary search stuff may prov=
e
>>>> extremely useful.
>>>=20
>>> Agreed. Thanks. Very least I owe per-rdp splitting of the hashtable, to t=
hat code.  Steven and me talked today that probably the hashtable can go int=
o the rcu_segcblist itself, and protect it by the nocb lock.
>>=20
>> I have to ask...
>>=20
>> How does this fit in with CPU-hotplug and callback migration?
>=20
> Yes it will require change and I already thought of that, have to update t=
he hashtable on all such events.
>=20
>> More to the point, what events would cause us to decide that this is
>> required?  For example, shouldn't we give your current binary-search
>> code at least a few chances to save the day?
>=20
> Totally, if you=E2=80=99re taking the patch as is, I would be very happy. A=
nd I=E2=80=99ll continue to improve it with the above. But I was not sure ye=
t if you=E2=80=99re taking it.
>=20
> I think it=E2=80=99s a worthwhile to take it for mainline in the current s=
tate and I=E2=80=99ll also add more data about callbacks to it in future (qu=
euing time of callback, etc) =E2=80=94 basically all the stuff I wanted to a=
dd to rcu_head.
>=20
> One reason for the above proposal is I also want to keep it turned on in p=
roduction, and the current solution cannot be, due to the global locking and=
 is not expected to be kept on in production. But is still a worthwhile addi=
tion for debug kernels IMO.

I realized while talking to Steve that the hashtable has to be per CPU if we=
 are to store more than a lazy flag, such as queuing timestamps. This is bec=
ause you can have multiple callbacks of the same function pointer queued on m=
ultiple CPUs. So you can have multiple timestamps to store. Same thing if we=
 stored automata. It=E2=80=99s per callback instance, not per callback funct=
ion.

Thanks,

 - Joel


>=20
> Thanks,
>=20
> - Joel
>=20
>=20
>>                           Thanx, Paul
>>=20
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>>>>>>> +#endif
>>>>>>>>>=20
>>>>>>>>> /* Maximum number of jiffies to wait before draining a batch. */
>>>>>>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>>>>>>> --=20
>>>>>>>>> 2.25.1
>>>>>>>>>=20

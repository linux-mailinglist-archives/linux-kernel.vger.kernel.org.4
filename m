Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152006788CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAWUzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjAWUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:48 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9E38B68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id t7so10180798qvv.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxFW990Hc2ogEB5SgKM/RiBrX6sbxaco4YvfU6sLwas=;
        b=kHTF4rra0X9wvs4ewR1ZAZotmFoe7ZdPcwJCEdEsHqOxkNKGwZNmOejgzdSYA4Qivi
         JS+snJV5pTVj5W6O2crOYaLC+AlbRDNdJ7/KP8jICevpl5M3VRbe+k8mfo6eNKOg02Ek
         xV4njFSi9CG6Jw+cdazj0MtTgMuCbtxwlc7kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxFW990Hc2ogEB5SgKM/RiBrX6sbxaco4YvfU6sLwas=;
        b=h4a56DAniPTpUibFjRBIFN6t/Jmylz/1B3g4JAQJH2mPCPJlJz6QQNlUn0ai4Snr43
         QxyzNCM+vkeKZPpNAzIh1jTtVqi4W6lH7W6jQaAjH8Wrqp81IWS2u3HdU/+E0pfAAxaB
         3qTmIX7N3/KJHNpujTSJiH9oIZ9sw3eIV06TcnjbZGn3xXXCKtgpoJZhXOqrXM79TAqz
         u8wJo3BO4Zk0LZ+cAcJarQh3PvhMr7L6wgt8vWa2GQLiMRtIDHFJonsPMQrS+85lNQsq
         x/NjQYAtc3CF9dMHTgzYM9SdlDD06FGs3IkjSpkN8oYIQA1HNr6VkjQ5yGTTEEkkQccI
         V5Eg==
X-Gm-Message-State: AFqh2krOlcyprf7Hlk0YnO/ciCq+M8znJPaJ0NZFxV/9OQ82V9DBkbA0
        KLLZ4unEuCRsnhgLV7ndcuQ8ku2GbWPOiHnP
X-Google-Smtp-Source: AMrXdXv2U7i31SNfUc+tzeUyxRfzaT+4wn43+5OzzVKoLFewQqVYwHrHYuOgHHqby/yT1AmlRu8JOg==
X-Received: by 2002:a0c:ef04:0:b0:535:2692:ef65 with SMTP id t4-20020a0cef04000000b005352692ef65mr36919461qvr.33.1674507261217;
        Mon, 23 Jan 2023 12:54:21 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id i184-20020a3786c1000000b00705c8cce5dcsm122080qkd.111.2023.01.23.12.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 12:54:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action from rcu_report_qs_rdp()
Date:   Mon, 23 Jan 2023 15:54:07 -0500
Message-Id: <375EBA2F-F47A-4BC6-B4D4-2E96D5D15AB6@joelfernandes.org>
References: <Y861Xuoa+CrZt9PB@lothringen>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Y861Xuoa+CrZt9PB@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2023, at 11:27 AM, Frederic Weisbecker <frederic@kernel.org> wr=
ote:
>=20
> =EF=BB=BFOn Mon, Jan 23, 2023 at 10:22:19AM -0500, Joel Fernandes wrote:
>>> What am I missing?
>>=20
>> That the acceleration is also done by __note_gp_changes() once the
>> grace period ends anyway, so if any acceleration was missed as you
>> say, it will be done anyway.
>>=20
>> Also it is done by scheduler tick raising softirq:
>>=20
>> rcu_pending() does this:
>>        /* Has RCU gone idle with this CPU needing another grace period? *=
/
>>        if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
>>            !rcu_rdp_is_offloaded(rdp) &&
>>            !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>>                return 1;
>>=20
>> and rcu_core():
>>        /* No grace period and unregistered callbacks? */
>>        if (!rcu_gp_in_progress() &&
>>            rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
>>                rcu_nocb_lock_irqsave(rdp, flags);
>>                if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_=
TAIL))
>>                        rcu_accelerate_cbs_unlocked(rnp, rdp);
>>                rcu_nocb_unlock_irqrestore(rdp, flags);
>>        }
>>=20
>> So, I am not sure if you need needacc at all. Those CBs that have not
>> been assigned grace period numbers will be taken care off :)
>=20
> But that's only when there is no grace period pending, so it can't happen w=
hile
> we report a QS.
>=20
> OTOH without the needacc, those callbacks waiting to be accelerated would b=
e
> eventually processed but only on the next tick following the end of a grac=
e
> period...if none has started since then. So if someone else starts a new G=
P
> before the current CPU, we must wait another GP, etc...
>=20
> That's potentially dangerous.

Waiting for just one more GP cannot be dangerous IMO. Anyway there is no gua=
rantee that callback will run immediately at end of GP, there may be one or m=
ore GPs before callback can run, if I remember correctly. That is by design.=
. but please correct me if my understanding is different from yours.

>=20
> And unfortunately we can't do the acceleration from __note_gp_changes() du=
e
> to lock ordering restrictions: nocb_lock -> rnp_lock
>=20

Ah. This part I am not sure. Appreciate if point me to any old archive links=
 or documentation detailing that, if possible=E2=80=A6=20

Thanks!

- Joel

>>=20
>> Thanks!
>>=20
>> -Joel

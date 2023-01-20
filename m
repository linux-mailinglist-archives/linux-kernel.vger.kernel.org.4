Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECD67561E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjATNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:47:54 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4F7A8C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:47:53 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id v81so2557994vkv.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kye/Ut1Af/DbDESgWkByHpPzhP9KtOWgHWRLp79CaMg=;
        b=MRkI2/Dx9mm2J6vT5Hg22AfzFL7N+TE+SQhwFk2tbG4T6KKy3QTRPoc9yVACHPT384
         WXcv3HtvfUfG4sDUGSyOU3m56jrLNfBQbpdp1g25hyGLahPKHZ53aX8uLHVbPjCvCd7e
         lUxysAqfatVQjzfjINvd5a2dlZ3qjx093y2ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kye/Ut1Af/DbDESgWkByHpPzhP9KtOWgHWRLp79CaMg=;
        b=1cb0Y5bCmuLYDPKx4/PbxIBrwensYJ112IL2rJCXoeAe1BTTa/cobLKYnV8G5rnGjQ
         gia+eaSFwkmPZqZ0NXtNw5033WLaaNmc+Iqor4lT/m3xLRdJTUNJtOl6FWbbo1ahNezR
         +rVZ90X0d0dOiNJ13cP3lnOeWmgDVQtaLwqqdWKprEGxH1ZVF4xbgByLUVBatvgGBOpt
         SFaRuKLsR7cPFiXvejimxdzFWvPlaBZeP/hzujyFhSlUOasKw6WXLRg2FYNHSJmM12BG
         76HQdVIFVuGY50qZU1K9Eb6TRR6xZrzbiLUExurvBlxEM++jZ3apY9NoH966r3yAfbEH
         wIaA==
X-Gm-Message-State: AFqh2kqb38JYG0r4dFJYgXbj/r4LtW3m8lAIE9ocZOzO4wNCON/ulXQw
        9U0tCALh4Yhra+TV4eHxCgE2UQ==
X-Google-Smtp-Source: AMrXdXs8Y5gViIyRRKBt8ClzRsd/iQKpRfC4ln1Z24rMG92kmNuCCQcKsRTbE4Ahoi9DAaoJNHTkLw==
X-Received: by 2002:ac5:cd42:0:b0:3da:6212:69b2 with SMTP id n2-20020ac5cd42000000b003da621269b2mr9615177vkm.14.1674222472644;
        Fri, 20 Jan 2023 05:47:52 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bl8-20020a05620a1a8800b006fa9d101775sm1443187qkb.33.2023.01.20.05.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 05:47:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
Date:   Fri, 20 Jan 2023 08:47:41 -0500
Message-Id: <6D3E70AC-8D01-41C7-9FDE-6693E9706425@joelfernandes.org>
References: <Y8qazpmqk4dmw37F@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Y8qazpmqk4dmw37F@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 20, 2023, at 8:44 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> =EF=BB=BFOn Fri, Jan 20, 2023 at 08:32:30AM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Jan 20, 2023, at 2:05 AM, Greg Kroah-Hartman <gregkh@linuxfoundation=
.org> wrote:
>>>=20
>>> =EF=BB=BFOn Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Googl=
e) wrote:
>>>> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined=
.
>>>> However, cpu_is_hotpluggable() still returns true for those CPUs. This c=
auses
>>>> torture tests that do offlining to end up trying to offline this CPU ca=
using
>>>> test failures. Such failure happens on all architectures.
>>>>=20
>>>> Fix it by asking the opinion of the nohz subsystem on whether the CPU c=
an
>>>> be hotplugged.
>>>>=20
>>>> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(=
). ]
>>>>=20
>>>> Cc: Frederic Weisbecker <frederic@kernel.org>
>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Cc: rcu <rcu@vger.kernel.org>
>>>> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the re=
st of the kernel")
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>=20
>>> Also want to cc: stable on the patch?
>>=20
>> Oh sure, sorry. For some reason I thought Sasha and your AI scripts
>> were looking at the Linux-kernel list as well. Or are they, and a Cc
>> to stable is just to be doubly sure?
>=20
> As per the rules we have had for the last 15+ years, always add a cc:
> stable to be sure that the patch will be considered for stable releases.
> If not, you are on you own and sometimes we might notice it, others not.
>=20
> See:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html=

> for the details.

Ah my bad, I did read that already but somehow assumed anything merged with a=
 Fixes tag was already considered for stable. I will always Cc stable hencef=
orth if I want something in stable.

Thank you!

 - Joel


>=20
> thanks,
>=20
> greg k-h

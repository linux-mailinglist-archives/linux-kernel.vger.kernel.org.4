Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796CF6FFF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjELEPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:15:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254A4EFE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:15:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f4fdf564d1so118811cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683864930; x=1686456930;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TPdIu92hVjkNl8T0IUuailFGe8fCvhTrnZtqlSjp5M=;
        b=xxyeGAJgdIOdxBYoDYVaY2zURP1w2xYTzIUDxH9Rq/Fm++I/WlE+bKTH1iuDuD9z7U
         zXdARcF39ulLFdhT5lKddCnZnAJcnOJFYgYAPTb6JCzg+JRomdwxLmF8Lo9IWR+eF0mN
         fVyd6o9RW6+aVGcxjWhcdDctEpiQyjT1uLs/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683864930; x=1686456930;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TPdIu92hVjkNl8T0IUuailFGe8fCvhTrnZtqlSjp5M=;
        b=T4GfYktuQ7KOdpOPx0gHKhELWY/BiZ1wiFjMinpJ0I6b1DOpYqzwYdHmmGpX5pgkm6
         KfH/7YWDS76pz81FHQ6GnZu8U27AVT1Hu0wNAtSqCuMkWM+qKbQNNVqgqfqd62vZwvCl
         ewzNHtkR8SYAThixYd174XN2Koi6i8lLuktz/c/3VYIbr8+L0oEbukZXjXxXkWB2OLqU
         mq449NYTAUh0rb6LcPcKhRaZf9t9/cfj/hIb2aTsbEzIJAtkg6+68nzf6olrYm322thl
         lGLc4MXECwO0WRc/0pxugkAQszP8g1JssG22GXKsofTdsiFt2hiHKZKES59QC4ACB4mj
         u2Vw==
X-Gm-Message-State: AC+VfDyZH8sZHMbkVBTKPL9WmdXe1U5ZGszF8c/4CVClr4tI8Xh4C7B8
        UfrEz3Pa01AZ84Gp/krXnozm1E+2jSNSqqD0G6UIdQ==
X-Google-Smtp-Source: ACHHUZ5KW0IGIezIRko/dgxuwz1tV/Lhi6kryhRQJNDyZTIMV634SAgzQmdZLpw+Pokzb+1LymGBdA==
X-Received: by 2002:a05:622a:1045:b0:3ef:5847:d7c8 with SMTP id f5-20020a05622a104500b003ef5847d7c8mr36977284qte.44.1683864930004;
        Thu, 11 May 2023 21:15:30 -0700 (PDT)
Received: from smtpclient.apple (123.sub-174-208-224.myvzw.com. [174.208.224.123])
        by smtp.gmail.com with ESMTPSA id bz13-20020a05622a1e8d00b003e8160cf93asm2775677qtb.80.2023.05.11.21.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 21:15:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
Date:   Thu, 11 May 2023 21:15:17 -0700
Message-Id: <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
References: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
In-Reply-To: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 11, 2023, at 8:20 PM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> From: Paul E. McKenney <paulmck@kernel.org>
>> ...
>>>> I wish diff was better at showing what really changed. The meld tool
>>>> can help but its gui...
>>>>=20
>>>> Should I run meld later (I'm out at a conference so no access to
>>>> meld-capable
>>>> machines) or are we sufficiently confident that the lines were moved
>>>> as-is ? :)
>>>>=20
>>>=20
>>> Thank you, Joel for this concern. Good to know the meld diff GUI tool.
>>> I just run the command below and confirmed that the lines were moved
>>> as-is: rcu_scale_{cleanup,shutdown}() follows kfree_scale_cleanup().
>>> You may double check it ;-).
>>>=20
>>>      meld --diff ./rcuscale.c.before ./rcuscale.c.after
>>=20
>> Nice, thank you both!
>>=20
>> Another option is to check out the commit corresponding to this patch, th=
en
>> do "git blame -M kernel/rcu/rcuscale.c".  Given a move-only commit, there=

>> should be no line tagged with this commit's SHA-1.
>=20
> Just had a good experiment with the "git blame -M" option:=20
> - Used this option to prove a move-only commit quickly (no line tagged wit=
h that commit) (the fastest method to me).=20
> - Then just only needed to quickly check the positions of the moved code c=
hunk by myself (easy). =20
>=20
> Thank you, Paul for sharing this. It's very useful to me.=20

Looks good to me as well and thank you both for sharing the tips.

 - Joel



>=20
>> They say that another option is to use "git diff --color-moved", which co=
lors
>> the changes.  That it does, but I am hard-pressed to work out exactly wha=
t
>> distinguishes a moved hunk from an added or removed hunk.
>> Fall colors vs. winter colors?  Exterior vs. interior?  Any particular de=
cade in
>> the endless rush of changes to fashion?  Perhaps someone with normal colo=
r
>> vision (to say nothing of better fashion sense) could try it.
>>=20
>> On the other hand: "default: Is a synonym for zebra. This may change to a=

>> more sensible mode in the future."  So maybe it is not just me.  ;-)
>>=20
>> You can also apparently choose colors using "color.diff.newMoved" and
>> "color.diff.oldMoved" when using "--color-moved=3Dplain".
>>=20
>> But "git diff --color-moved=3Ddimmed-zebra" might be more to the point fo=
r
>> someone like me.  I would need to experiment with it more in order to
>> confirm my hypotheses about what it is doing.  To say nothing of building=

>=20
> Yup, this looks a bit painful for me too (need experiments to confirm hypo=
theses ...).=20
>=20
>> trust in it.  Plus I have to open a color terminal to use it effectively.=

>> So maybe "git blame -M" continues to be the tool for me?
>>=20
>>                            Thanx, Paul

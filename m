Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D66AAFAA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 13:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCEM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 07:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCEM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:56:48 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155F10AB5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 04:56:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so7795927qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678021006;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2XDFrZbN2R3QrerdWbI2vAM5IjvoYd3LrvKIPWNBMM=;
        b=DwcsnVM/0wvDSVFvwkJg7MMwygBOl3ma1cPtNzXr1XVib4DICM6ylSyldpxox7oQe3
         QKajr5oX3v27f7YG4mlZYCSon9P7tfFcgclzhhjbenClPZ3daN7aV68XhGtu1hWazAeA
         wwSaWoosO4HCblQpg+mfiZ6c21tAiZtOr+jr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021006;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2XDFrZbN2R3QrerdWbI2vAM5IjvoYd3LrvKIPWNBMM=;
        b=X37cZhF0IQwD4idSeTh09iDgC35juPmY39fZHLVel434vAPH5WpmvS5rq0jVSmA5R8
         2xqY3HjmtBSM3PibUHcr029IHlR9BMAjnJECFlzNu1vB2wPJZjg77gk/q43Kb/PRpdln
         7cIgxKsFbXXGY5PzQxerYS/IJ/mohFB9T706tM3SJzqS3729CRmtEGMma9S/FcTp9Bg4
         +QcvkRBbSPb1jVuBNGb8XLKjubdJFXXB0TO0xo9Zp1vCJnHyJTKyUFs8tXo4+moIOgx/
         kHVHVG0fYqDdxjOVDNdFElzMZ4ifLjo7iWhkn8L+cwCNLbI94P0fv3NcrztqmmGCVwz6
         RLmA==
X-Gm-Message-State: AO0yUKUilRrfw3vy/LZfXbW2PVbVw713rBI1QwdPXMoKGVh+IJWFyJkU
        uixNp/+mXKH+plhCYI1vul3r5w==
X-Google-Smtp-Source: AK7set96BMq3T6wQESxMr1hZ3PhBGzTnQewXdFI8luRoOSNMaoCJgqBzLjJv6DBKWxzKI70C3m24sw==
X-Received: by 2002:ac8:7f87:0:b0:3bf:daae:7ee6 with SMTP id z7-20020ac87f87000000b003bfdaae7ee6mr12426886qtj.18.1678021006206;
        Sun, 05 Mar 2023 04:56:46 -0800 (PST)
Received: from smtpclient.apple ([2600:1005:b003:394d:acb0:58:f50c:218b])
        by smtp.gmail.com with ESMTPSA id q25-20020a37f719000000b007343fceee5fsm5486765qkj.8.2023.03.05.04.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 04:56:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Sun, 5 Mar 2023 07:56:33 -0500
Message-Id: <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
References: <ZAR//FKO4syzapk6@pc636>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
In-Reply-To: <ZAR//FKO4syzapk6@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2023, at 6:41 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>>> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wro=
te:
>>>=20
>>> =EF=BB=BFHi, All,
>>>=20
>>>> On Wed, Feb 1, 2023 at 10:11=E2=80=AFAM Uladzislau Rezki (Sony)
>>>> <urezki@gmail.com> wrote:
>>>>=20
>>>> For a single argument invocations a new kfree_rcu_mightsleep()
>>>> and kvfree_rcu_mightsleep() macroses are used. This is done in
>>>> order to prevent users from calling a single argument from
>>>> atomic contexts as "_mightsleep" prefix signals that it can
>>>> schedule().
>>>>=20
>>>=20
>>> Since this commit in -dev branch [1] suggests more users still need
>>> conversion, let us drop this single patch for 6.4 and move the rest of
>>> the series forward? Let me know if you disagree.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/co=
mmit/?h=3Ddev&id=3D9bf5e3a2626ed474d080f695007541b6ecd6e60b
>>>=20
>>> All -- please supply Ack/Review tags for patches 1-12.
>>=20
>> Or put another way, what is the transition plan for these remaining users=
?
>>=20
>> I am getting on a plane right now but I can research which users are rema=
ining later.
>>=20
> I am not sure. I think we can cover it on the meeting.

Cool, thanks.

> My feeling is
> that, we introduced "_mightsleep" macros first and after that try to
> convert users.

One stopgap could be to add a checkpatch error if anyone tries to use old AP=
I,
and then in the meanwhile convert all users.
Though, that requires people listening to checkpatch complaints.

Thanks,

 - Joel


>=20
> @Paul what is your view?
>=20
> Thanks!
>=20
> --
> Uladzislau Rezki

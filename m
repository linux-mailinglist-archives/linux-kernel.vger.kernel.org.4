Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4C647CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLID66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLID64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:58:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8814FFA6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:58:50 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fz10so2793012qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 19:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5NBFExJQX/d6O4EBVZbzy/yhUjpt1GHLcfTjZTMaiE=;
        b=iFcKcca7ArFEQgM14qoskwpw7ghHqKQbpaVNgtX+pbj7X6cfac6FCmqpneWw3drvep
         3bqnIWeR2CaEOlNogdF5MdGRBV47vAl/x9X2ettjsd9HwNFURwSkS2GrsINYzJiX0DYf
         qdKbkYWGFLuvliEUjA2fQEgHOHx8oNmB+WVts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5NBFExJQX/d6O4EBVZbzy/yhUjpt1GHLcfTjZTMaiE=;
        b=M1lmeea7Fj0X9e6ISYtgUvGrgb6BGhX82WkaUHgl+6RhkSoB59hj7UYU2s13wyDQo4
         tuDUfFXR5BabYyn5uSEkL8SHwuNorjnhBVdkrAzWd0ViwwqtpdDB5xkSEUVQ+m45fA1p
         d+vzCQmYH3jQd//CNpQwqxkCJx3sP7C9G9oNwJvmwSfz+Ra+Xlp0kTAbw70dZL4b2nVu
         chxRZSmS51++8bom2/U8YrTpxPenqk5IOZUOtLwEv7H1SFoatMBmI3OhmPQsqo5+Ctst
         oRSB/x6pl97Tm9eC7HunRfNViZZphay0kJNUkIQh0mmLlwerEMIOE3QIZkD6xl39xTWb
         TefA==
X-Gm-Message-State: ANoB5pnWjLRjE5SxcxjEAfdIEA80S/x2AUiPJZcv2SRVZfV1eOZWHg6N
        LpSAR+mf5G7kChw7NthBbPkUpTYNpnhqtyq4
X-Google-Smtp-Source: AA0mqf5rErhlkiiQqaAysDUvSWZ7f1LB1vbu2Rlbe1Sm5ag2aO6eDLaohQsq0nj3URy02xoQHnkN6w==
X-Received: by 2002:ac8:1013:0:b0:3a5:6961:e1c5 with SMTP id z19-20020ac81013000000b003a56961e1c5mr5613885qti.48.1670558328627;
        Thu, 08 Dec 2022 19:58:48 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b867:2d8b:5186:cf90:77eb:ee52])
        by smtp.gmail.com with ESMTPSA id bq39-20020a05620a46a700b006fbae4a5f59sm278336qkb.41.2022.12.08.19.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 19:58:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Thu, 8 Dec 2022 22:58:36 -0500
Message-Id: <2D7B1E52-D2FC-45ED-A739-BA9A1213FD49@joelfernandes.org>
References: <20221209032550.p4tcyypgkuspp2ur@offworld>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
In-Reply-To: <20221209032550.p4tcyypgkuspp2ur@offworld>
To:     Davidlohr Bueso <dave@stgolabs.net>
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



> On Dec 8, 2022, at 10:50 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>=20
> =EF=BB=BFOn Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>=20
>> Currently RT boosting is only done for rtmutex_lock, however with proxy
>> execution, we also have the mutex_lock participating in priorities. To
>> exercise the testing better, add RT boosting to other lock testing types
>> as well, using a new knob (rt_boost).
>=20
> No particular objection to the patches, but shouldn't these go as part
> of the next iteration of the PE series?

Hey Davidlohr,
Nice to hear from you. Paul was interested in these for some things he is lo=
oking at and also as general clean up ;)

Thanks.



>=20
> Thanks,
> Davidlohr

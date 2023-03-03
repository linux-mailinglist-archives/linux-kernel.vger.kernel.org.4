Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C06A9466
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCCJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCCJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:47:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99C10251
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:47:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so8001445edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1677836855;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ+INM3VwliGTzVvk8H3UaLOz2MRWdPHZPc0Z190kHc=;
        b=XDBR6dAdhp+6/U+LjGMvYZn2aMQ2GnSbRRuR4GsOvgRKx7Pq5mh379K9R+fVVz/2AV
         Pt8eGvvvS5rRLT971V9cHyljbebo70nc6rNqS+bDj7I5m/cZB8PlBZkgQmheTFzbCINp
         P+sfOrEiyYsLxEd/+4aMtUpK3bYWmjhl2QPEYp2Am0WfvcbZ7oyMUr/KUOq2o6vqtPoo
         kiEzMko5dfpltTFxj8QTJDM1p3MGr0LWeB27uOlPXSq9KgFYott3o3uM5cBpiO2TLG3a
         RuO1D5W6Kwjp9rvTmDckSi9QzBH08pwWQ+/uWs5SXy7TRN2N6toezs3DjhN47MNsZKb0
         k/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677836855;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQ+INM3VwliGTzVvk8H3UaLOz2MRWdPHZPc0Z190kHc=;
        b=avaIgRha7o6j6OvFQZF9SRoKjNL24jXt2RVnbyGGUm9qV8qfPjPtCiNqdvao8poT9q
         nx0aIxCI7WAkyJSgPvPMsETsP3EoBeEqibQYN5wwybQ6XxL8knoW2o1o2PfMZ4bNoYe0
         TS4xGcivMNkO6hJN8cyuFk74ulInX+mJyMECRM6Y3UchXeZ9KCCbwxssqInO9KwJ88kY
         DZ0e3LpXpow5Y+GLkirS7Mr/EOveOdI60S6yec2Q6O2cPX0hzy8zS2nULYPYaKTvuJb6
         Y2mYx2VvWyj4wdKxR5u76g5jJ14Z3sXjHSz9o8tiZbeGlkFbeHx/GFWb4fqklTxZWCVX
         C4yQ==
X-Gm-Message-State: AO0yUKWyjT9wQ9EK06lQd46SCQ1ajQza+0nuNvfTgndvJZobkcpxbbIS
        v6hixpmv/AlIyXtJCKUUoubRzcO30i8MCtFl
X-Google-Smtp-Source: AK7set9pHwKcED+DJNcPo6PEgMw4W5FOluoDPONxOKOnJv1Q+C1tUrW42StaSvzVymezAExY/UwGRw==
X-Received: by 2002:a17:906:cccf:b0:8b2:c2fc:178e with SMTP id ot15-20020a170906cccf00b008b2c2fc178emr842246ejb.74.1677836854760;
        Fri, 03 Mar 2023 01:47:34 -0800 (PST)
Received: from [127.0.0.1] ([194.110.115.73])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906c18e00b008b1b86bf668sm773251ejz.4.2023.03.03.01.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:47:34 -0800 (PST)
Date:   Fri, 3 Mar 2023 10:47:33 +0100 (GMT+01:00)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, mptcp@lists.linux.dev,
        Florian Westphal <fw@strlen.de>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Message-ID: <3d92e773-896c-43c3-94ae-cb7851213c55@tessares.net>
In-Reply-To: <ZAG8dla274kYfxoK@kroah.com>
References: <20230301180657.003689969@linuxfoundation.org> <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com> <ZAB6pP3MNy152f+7@kroah.com> <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com> <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com> <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com> <CA+G9fYuLQEfeTjx52NxbXV5914YJQ2tVd8k4SJjrAryujPjnqA@mail.gmail.com> <ZAG8dla274kYfxoK@kroah.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3d92e773-896c-43c3-94ae-cb7851213c55@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Naresh, Paolo,

Thank you for the new version and for having reported the issue and running=
 MPTCP selftests!

3 Mar 2023 10:23:06 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

> On Fri, Mar 03, 2023 at 02:34:05PM +0530, Naresh Kamboju wrote:
>> On Fri, 3 Mar 2023 at 13:34, Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> Hello,
>>>
>>> On Fri, 2023-03-03 at 01:32 +0530, Naresh Kamboju wrote:
>>>> On Thu, 2 Mar 2023 at 16:30, Naresh Kamboju <naresh.kamboju@linaro.org=
> wrote:
>>>>>
>>>>> On Thu, 2 Mar 2023 at 16:00, Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>> =E2=80=A6
>>>>>
>>>>> ....
>>>>>
>>>>>> =E2=80=A6
>>>>>
>>>>> Me either.
>>>>> That is the reason I have shared "Assertion" above.
>>>>>
>>>>>> =E2=80=A6
>>>>>
>>>>> We are running our bisection scripts.
>>>>
>>>> We have tested with 6.1.14 kselftests source again and it passes.
>>>> Now that we have upgraded to 6.2.1 kselftests source, we find that
>>>> there is this problem reported. so, not a kernel regression.
>>>
>>> I read the above as you are running self-tests from 6.2.1 on top of an
>>> older (6.1) kernel. Is that correct?
>>
>> correct.
>>
>>> If so failures are expected;
>
> Shouldn't the test be able to know that "new features" are not present
> and properly skip the test for when that happens?=C2=A0 Otherwise this fe=
els
> like a problem going forward as no one will know if this feature can be
> used or not (assuming it is a new feature and not just a functional
> change.)

All MPTCP selftests are designed to run on the same kernel version they are=
 attached to. This allows us to do more checks knowing they are not suppose=
d to fail on newer kernel versions and not being skipped if there is an err=
or when trying to use the new feature. If there are fixes, we make sure the=
 stable team is Cc'ed. If there are API changes, it would be visible becaus=
e we would need to adapt existing selftests.

That's how we thought we should design MPTCP selftests. Maybe we need to ch=
ange this design?

Is it a common practice to run selftests' latest version on older kernels?

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

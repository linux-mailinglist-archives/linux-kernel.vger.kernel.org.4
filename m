Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B416A9690
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCCLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCCLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:39:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A123131
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677843553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1Ct/6nINkmWZSFMigoxMFMstImpmSCqjjI/pBizmA0=;
        b=WSJ9KZpK4vih8azuewSkt/m8tva5TYHJ7JGhLYzj3q9hsBZ2evR073WBJq8FRuo3AE6YaK
        eSIK8x4Ft2Xa1PQunq3PPPAlKj+XoLmVobSEgQ+TnpTvtdKzypO6hOGYzTGY3bRLOoDUY7
        HPclpe5BwkKQH584WwUMLdQP8moISOw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-kxqEj5dpOvWwxgqyxxxnkQ-1; Fri, 03 Mar 2023 06:39:11 -0500
X-MC-Unique: kxqEj5dpOvWwxgqyxxxnkQ-1
Received: by mail-wm1-f72.google.com with SMTP id n27-20020a05600c3b9b00b003e9ca0f4677so873346wms.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Ct/6nINkmWZSFMigoxMFMstImpmSCqjjI/pBizmA0=;
        b=lDxsIGDq2n1vOGOYiO+0R8hsCj3fB59uKLknSgU8dHBMKZ6H27AuZ9KlJ7kDjXMVo+
         SXcW5EGuZbMZpcGn/JiVgY4ugHmzMRiTyuFUJiXoC7frycX52AM440cMyV3xOVzcpOPu
         Q9ufSCggfgcCbG5hNKOiL7m5iqrZIyj+dBPmGAYf3gkrjv8JMGZczPxNCt2/3PhA9MAE
         aLLLjdKUAJiM3hg93pSPE72tyS8a2jZsUe8U6AeJc1FRn4UJDauaz4J2jUeQAoLFO93l
         EDJt+O9cotflqhh9pKfJ9c4yX2QW45oOnqaMwCTqiS7OrLvR8amf96Wy+DEeLrjkkUnx
         hiaw==
X-Gm-Message-State: AO0yUKVbXy10tJueRv/PbzbgbE9Z2WKT1VQLq5vwum9BLDqZ4NDPfnAv
        UyPN9BcDkr51eBmmV+skrJ6MilrKTT2Ie8zfyKUfk6ARnqCxFRA8DrP0yppd9FPVXpsDKERIcHC
        9sJI+ibfBsKSqX8ZkhlGuKN6i
X-Received: by 2002:a05:600c:3b07:b0:3eb:2e2a:be82 with SMTP id m7-20020a05600c3b0700b003eb2e2abe82mr1246715wms.2.1677843550664;
        Fri, 03 Mar 2023 03:39:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9mwcWeiYEjlmyu4x2ILE7IqBBjOngusHgtCAMB0AGXHzaXoDMdecgdiEJ4F2mFuYU5V0UiRg==
X-Received: by 2002:a05:600c:3b07:b0:3eb:2e2a:be82 with SMTP id m7-20020a05600c3b0700b003eb2e2abe82mr1246704wms.2.1677843550405;
        Fri, 03 Mar 2023 03:39:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b003eb2e685c7dsm5725689wmj.9.2023.03.03.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:39:09 -0800 (PST)
Message-ID: <28afc90c1b8b51a36ced5b6026d1a64aeb7c0b14.camel@redhat.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
From:   Paolo Abeni <pabeni@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 03 Mar 2023 12:39:07 +0100
In-Reply-To: <ZAG8dla274kYfxoK@kroah.com>
References: <20230301180657.003689969@linuxfoundation.org>
         <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com>
         <ZAB6pP3MNy152f+7@kroah.com>
         <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com>
         <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com>
         <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com>
         <CA+G9fYuLQEfeTjx52NxbXV5914YJQ2tVd8k4SJjrAryujPjnqA@mail.gmail.com>
         <ZAG8dla274kYfxoK@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-03 at 10:23 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 03, 2023 at 02:34:05PM +0530, Naresh Kamboju wrote:
> > On Fri, 3 Mar 2023 at 13:34, Paolo Abeni <pabeni@redhat.com> wrote:
> > > I read the above as you are running self-tests from 6.2.1 on top of a=
n
> > > older (6.1) kernel. Is that correct?
> >=20
> > correct.
> >=20
> > > If so failures are expected;
>=20
> Shouldn't the test be able to know that "new features" are not present
> and properly skip the test for when that happens? =C2=A0

I was not aware that running self-tests on older kernels is a common
practice. I'm surprised that hits mptcp specifically. I think most
networking tests have the same problem.

Additionally, some self-tests check for known bugs/regressions. Running
them on older kernel will cause real trouble, and checking for bug
presence in the running kernel would be problematic at best, I think.

> Otherwise this feels
> like a problem going forward as no one will know if this feature can be
> used or not (assuming it is a new feature and not just a functional
> change.)

I don't understand this later part, could you please re-phrase?

Users should look at release notes and/or official documentation to
know the supported features, not to self-tests output ?!?

Thanks!

Paolo

p.s. for some reasons I did not receive the previous replies, I had to
fetch the conversation from the ML archives.


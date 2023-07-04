Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A6746A82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGDHXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGDHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8C1A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688455344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdLaHXWSXyMp87ZNvGpINxLMzOcUGO2IBdu2cJPw4Wc=;
        b=XRIeug19F2v1OpfXYAYXToT2QAXnE2lAtFEFbajzKqZDIErpXFLHP4KW0UCnRv/m9v2zyi
        ThvOJV/KdLZ3xFw6kT4YRkRxkAgLbXXNLaOZXaw8I+h6aSgbr5wpyxY/YWI0cfHdJB8UAV
        ti01lzMS6EQ0aDDnACABQNWWHs78xVM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-k0KuFHe4Mw2RUuIhQvMCfA-1; Tue, 04 Jul 2023 03:22:22 -0400
X-MC-Unique: k0KuFHe4Mw2RUuIhQvMCfA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b8cc7351f0so911570a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455342; x=1691047342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdLaHXWSXyMp87ZNvGpINxLMzOcUGO2IBdu2cJPw4Wc=;
        b=h+wYnpxnw06RoRkJO4Ts6IinJgEe7re5z61O7HB43wepVVi6Se99ALfR8R81LRgQIm
         gzr0G2AUaqiXz24q+7gADQwbaYYKi1aOb0Sv5MjknraXUl6kOOSmulLchS1VmBE4jQgC
         Xzqn9VxOCNC9CxMykZueUJYtwa+HbTFta6ss+ofRHHJo/7W4PRDPiLN754H/zEtXg3Tz
         TfWkVwnptMmt1GvwY5qzWBci75Ca7bajslO6BUIKYT+psHWeiLRx8VshtzSrYawaAm77
         dxDLBjjlmWBTYModYuaBYgVSxLj0CEg811qYpwdVLzbU/PhXjj4fjGuiyruPo72xHQ3l
         IBBg==
X-Gm-Message-State: AC+VfDzVbNGVkOEs0NuruQb0CmDVr8yab5rtoQ0WkDS6DlMGq29R7pMr
        3ev0aTbe4T6UJr8SM+/ndQ9nl6of/wvdk7Sl/+tmMnNzWDKOfXWZlyADVYvN6LleKuK/kTm5vRr
        Gmj54bsBA5iscy8kBqb3cQKXL
X-Received: by 2002:a05:6830:917:b0:6b5:33ea:6e11 with SMTP id v23-20020a056830091700b006b533ea6e11mr13103594ott.8.1688455341879;
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+761W4uDVVsjIqNlJix6Ll+/PJrIb4pGNbUIu0+CLwqti8xzBlSixZSbq4q+BWokV5DtPBg==
X-Received: by 2002:a05:6830:917:b0:6b5:33ea:6e11 with SMTP id v23-20020a056830091700b006b533ea6e11mr13103585ott.8.1688455341661;
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:faf8:1d15:affc:4ee8:6427? ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
        by smtp.gmail.com with ESMTPSA id m9-20020a9d6449000000b006b469ace1b1sm1127509otl.22.2023.07.04.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:22:21 -0700 (PDT)
Message-ID: <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jul 2023 04:22:17 -0300
In-Reply-To: <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
> Friendly ping
>=20
> On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.com=
> wrote:
> >=20
> > Changes since RFCv1:
> > - request->csd moved to the middle of the struct, without size impact
> > - type change happens in a different patch (thanks Jens Axboe!)
> > - Improved the third patch to also update the .h file.
> >=20
> > Leonardo Bras (3):
> >   blk-mq: Move csd inside struct request so it's 32-byte aligned
> >   blk-mq: Change request->csd type to call_single_data_t
> >   smp: Change signatures to use call_single_data_t
> >=20
> >  include/linux/blk-mq.h | 10 +++++-----
> >  include/linux/smp.h    |  2 +-
> >  kernel/smp.c           |  4 ++--
> >  kernel/up.c            |  2 +-
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> > --
> > 2.40.1
> >=20

Hello Jens,

I still want your feedback on this series :)

I think I addressed every issue of RFCv1, but if you have any other feedbac=
k,
please let me know.

Thanks!
Leo


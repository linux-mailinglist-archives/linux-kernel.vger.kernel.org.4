Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EC6AB465
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCFBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCFBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:46:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D813523
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 17:46:04 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f18so10762677lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 17:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678067163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4zNZSkdkbwHO9J+rqedPZEMqIZsYdo/MQm0ECFIqdQ=;
        b=Ou+RkVPzeUniMRb/ZEPt3z20p6Rvv/yGzA/sEyUizIVz+xtV/Of8LudBAiBe/tXtG5
         1ODB6AKfDYufSX0pV7ctla9JWxIBkB22k9ximYR8wuCn6XCCV2G8hMZZhq+3kK9zh9LV
         0cckje3Jft1TMEUtQI3/xi/XJnYG0Hth6Ul7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678067163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4zNZSkdkbwHO9J+rqedPZEMqIZsYdo/MQm0ECFIqdQ=;
        b=3Ac/ofK3Qbh1ngt/H7QOf2zsvZoHsaLRYQ46u9+/8QSDOW/HLvRikf5qiJvP+YxdHR
         IbP1WzI/8aMFDVEbv9yolCCBpIx/bEbhal2HwodPfVSe4aWYShUSGR8r4BgNlFiBsSFm
         W1VNk0divwFXEM4ZEemJqUXfZ4NlfRyUqdOTAMTAULSEAeH41o/H3/8bwS0WbFGBZzz8
         73zHrMlYbO/4VJQjN3R9xLoc1znUjbWE6ZH9dlYBKgUJZS2W9zLsA3A0ZiL04gCN8rLR
         MR7/NlugvaLKwp6rf1MzA0vJL4D/5ncT2k247g0WktvX2ET4JksU0Pn21hexww2NdpLv
         7NQQ==
X-Gm-Message-State: AO0yUKWkJu24XEUB3WgUVor1WigeBNWto9gRA4AEUBQJUDBsb7S0rqSu
        17vSy6pMmL5XjCfgZqp6y8Q28TXpq+nTWA695Fq4Yg==
X-Google-Smtp-Source: AK7set+YM3+oL/m1+RTW0glRFAjhQq3CZCbwaLK6ekLjyOtbtmtiut5TRou6qSjMzovUvDHaRAL+XV/pK0xAuOXi/qw=
X-Received: by 2002:a05:6512:4c2:b0:4dd:9931:c4ee with SMTP id
 w2-20020a05651204c200b004dd9931c4eemr2701803lfq.12.1678067162788; Sun, 05 Mar
 2023 17:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127044500.680329-1-stevensd@google.com> <Y9QjquvzoL7kKHWE@google.com>
In-Reply-To: <Y9QjquvzoL7kKHWE@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 6 Mar 2023 10:45:51 +0900
Message-ID: <CAD=HUj7P8XmWLVpwB_XABKT7GT1sLPRozmr=guVktOyk9R+3fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: x86: replace kvm_vcpu_map usage in vmx
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 4:19=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jan 27, 2023, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > This series replaces the usage of kvm_vcpu_map in vmx with
> > gfn_to_pfn_cache. See [1] for details on why kvm_vcpu_map is broken.
> >
> > The presence of kvm_vcpu_map blocks another series I would like to
> > try to merge [2]. Although I'm not familiar with the internals of vmx,
> > I've gone ahead and taken a stab at this cleanup. I've done some manual
> > testing with nested VMs, and KVM selftests pass, but thorough feedback
> > would be appreciated. Once this cleanup is done, I'll take a look at
> > removing kvm_vcpu_map from svm.
>
> Woot, been waiting for someone to take this one, thanks!  It'll likely be=
 a week
> or two until I get 'round to this, but it's definitely something I want t=
o get
> merged sooner than later.

Sean, will you be able to get to this in the next few weeks?

Thanks,
David

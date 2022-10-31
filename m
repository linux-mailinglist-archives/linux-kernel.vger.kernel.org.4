Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55843613E87
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJaTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJaTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:44:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813813F47
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:44:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so17429378wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oefrsxFs6OkOWnB0QsHyURHti+3sS6qCLWa2ONuVzNg=;
        b=jZhvykye0ev9jU5q7YAXev05nsde7hvzTtoX5x3wOlzmWD1VLefhB1hIvvC4ACbx2B
         Xm9wLjwMN8uNDPFUOpM5W7lYxc7h735xqr1szeYVSJn4nmx8Vjf5uHt2Kh2L5yAuJrQW
         xLmr4t1RYm9m5XOWbcQfzX37Omr3gXSY/wvu/9B6slV+02oq5gMbYitZpd8f9BsAgLN3
         E+RFc0mqTKuabz7gva/H2rUUSLue+q+VlFKmtyQ9ETLkDhLy+wBh+671xruEqFDN7gUC
         LM+/0B84eGFKeI/k4Sy1QhgmtyyEKdR/gjPDU9iAaeyMFe248yTywKjP+7u2CfdEkQz6
         /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oefrsxFs6OkOWnB0QsHyURHti+3sS6qCLWa2ONuVzNg=;
        b=5ZtrxdtZrJQeSyYZaIvlMJHBsIRfvqjUvcqodSkyU3yuZXW0ZWp0iChEv9GeS6iwMH
         uJzHdQZccdDsIoVhjiKHKROjmOpfDxpVjdefdu3wvA0RVsVmUysR9+piPSK+L2kNOm4C
         //ueZKbhcAJcVH63keNeSeijoULU+OVBkR7/XiXpPk1ccmbttOIZ3hgdkVBkojyg2P+u
         E5vCCKk/wq51yk/MMH6gIdEYPw3p95LTBH/s4FmJB6CHjvAb+9u8C8UcoHMFXWKKRre7
         V4/50TMbTmNek8EDO639HXFEiFf+H6jERUv2AJJvROP1E8rMteWcaZgt6LD1Z1+SgBMd
         nB/Q==
X-Gm-Message-State: ACrzQf1Jt4xAB3UAKx3BQDNiJgC8z3+Q73osoHlgR4de+RbQ3OuDd5Nu
        RBVpK+VuQJZFW0nGFFzpbcU0LoAdYY8WJaF0afIGkSauK80=
X-Google-Smtp-Source: AMsMyM4dtgCbsdWMcJdj/STIeNuYVjLaVPpfrrfShkklzrkUTjzIU/7jS9sghdp2YLeNNlFOtEgPfS4NulfyIBfLuCE=
X-Received: by 2002:adf:da4f:0:b0:236:cdd4:4ce2 with SMTP id
 r15-20020adfda4f000000b00236cdd44ce2mr3804942wrl.626.1667245480124; Mon, 31
 Oct 2022 12:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221031173819.1035684-1-vipinsh@google.com> <20221031173819.1035684-4-vipinsh@google.com>
 <Y2AfUKJ19yZrlHzN@google.com>
In-Reply-To: <Y2AfUKJ19yZrlHzN@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 31 Oct 2022 12:44:04 -0700
Message-ID: <CAHVum0f_Bv8rH8F3Q5GsdeJkjsQpgArmukFQ-bw6VryjaAsdaQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] KVM: selftests: Add atoi_paranoid() to catch
 errors missed by atoi()
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:17 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 31, 2022, Vipin Sharma wrote:
> > atoi() doesn't detect errors. There is no way to know that a 0 return
> > is correct conversion or due to an error.
> >
> > Introduce atoi_paranoid() to detect errors and provide correct
> > conversion. Replace all atoi() calls with atoi_paranoid().
> > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > index 6d23878bbfe1..ec0f070a6f21 100644
> > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > @@ -334,3 +334,22 @@ long get_run_delay(void)
> >
> >       return val[1];
> >  }
> > +
> > +int atoi_paranoid(const char *num_str)
> > +{
> > +     char *end_ptr;
> > +     long num;
> > +
> > +     errno = 0;
> > +     num = strtol(num_str, &end_ptr, 10);
>
> I take back my review.  This forces specifying params in decimal, e.g. a large
> hex number yields:
>
>   strtol("0xffffffffff") failed to parse trailing characters "xffffffffff".
>
> Obviously I'm intentionally being a bad user in this particular case, but there
> will inevitably be tests that want to take hex input, e.g. an x86 test that takes
> an MSR index would definitely want hex input.
>
> Looking through all selftests, I don't think there are existing cases that would
> likely want hex, but it's trivial to support since strtol() will autodetect the
> format if the base is '0', i.e.

atoi_paranoid() replaced atoi() which only works for base 10. I was
keeping it similar.

I'll wait a couple of days for any other feedback and send v8.

>
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 210e98a49a83..8c37cfa12edc 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -341,7 +341,7 @@ int atoi_paranoid(const char *num_str)
>         long num;
>
>         errno = 0;
> -       num = strtol(num_str, &end_ptr, 10);
> +       num = strtol(num_str, &end_ptr, 0);
>         TEST_ASSERT(!errno, "strtol(\"%s\") failed", num_str);
>         TEST_ASSERT(num_str != end_ptr,
>                     "strtol(\"%s\") didn't find a valid integer.\n", num_str);

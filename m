Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892DB62064B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiKHBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiKHBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:46:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7D1D66D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:46:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w14so18734336wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7p6vVvI8+Hv4y/fJS1gDlF7hOs1ZVuCP+SBkFwz7cA0=;
        b=jeVQaKE5t0rHzW4tszqPPSn5gjAs4kWcB+snLHSaIY8X25uuanoNZnW+ftz+2eCBQU
         iQBOL5SOv4E1Tkr7hDAr73leqVC4ZU8yz2tv5jQYh5a6hK13VL/+/jkOEUNkkxeaBF4i
         1Xi160dVCJwHTmhGT750ZSdFHFU5DfGYFkQYSRxJUHT65iE6J09HkkZCDVuyp252Ec0n
         8kwF39rRvvR1vX9viOBwB7i9z9p1kki1tb3lTkBxujS5AMcc1ZsQPRnzlpculTQQXNQc
         sr3g0+3QG01mbWArb3WLFf5NUqxxcJ3VsvnvUqPP3iHSFKdyoL11f0dME7AZ5A6ueQ3C
         41MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7p6vVvI8+Hv4y/fJS1gDlF7hOs1ZVuCP+SBkFwz7cA0=;
        b=usYvmZH81qdcUxwCJL9lcas7MDyzxcbIwHb79Fc7nNWoDe2w7FqBYILoiS53M0oGOB
         UIkbyrCDxdZG9j7kjLN0YTf+cNe9a37p+ewB85vIuXRGr4LBRsm7PcQftr3S5GOtOazP
         F/pi5iFLS+icp/3VmGznkUEhlT/QX9h7zbkh9uIfdffJKhlzaqDFkvS7zRjSVYZp7XCV
         4SIb/KkYnKMpIoeifAmFx5txSiQjXc25Quc84Es9Esamd9NrWjZcNBU5ixqIG4W5QpN8
         5L3ALS6PKL79AbcfwFvPWFvp7EaYfSj398bm8g2ZnobZHxRO8ViFpLhkLygHN4JBsbHE
         zgNQ==
X-Gm-Message-State: ACrzQf2m7sguTlIEf9EsG4MHTm4Ne3UrmojWWu34kGzkAIPi6R/lhAYQ
        I8cQblVzx/1+1scQHQpN/+0ZuG/jXNG8hI0Ils805BJOknM=
X-Google-Smtp-Source: AMsMyM7N3mXWwdksIEveVE4QjaDyuJfD504bJvidWu9tU4Utu7MEQgQuxHzhKEmVjXFhJNfvcE2N+aXavCKJXKI5cT4=
X-Received: by 2002:adf:f081:0:b0:236:5e7c:4ec2 with SMTP id
 n1-20020adff081000000b002365e7c4ec2mr32705752wro.641.1667872002041; Mon, 07
 Nov 2022 17:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20221105045704.2315186-1-vipinsh@google.com> <20221105045704.2315186-4-vipinsh@google.com>
 <Y2lOJqLaLIBxEP7P@google.com>
In-Reply-To: <Y2lOJqLaLIBxEP7P@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 7 Nov 2022 17:46:06 -0800
Message-ID: <CAHVum0dYcrYBGAEoGJCJT0xrJh=968QWEex1ForBzEP5QtAudQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] KVM: selftests: Test Hyper-V extended hypercall enablement
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 10:27 AM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Nov 04, 2022 at 09:57:01PM -0700, Vipin Sharma wrote:
> > Test Extended hypercall CPUID enablement
>
> nit: Use complete sentences and provide more details on what exactly
> is being tested.
>
> The rest of the commit messages look pretty good so I assume you just
> forgot to fill this one in fully before sending to the mailing list :)
>

Missed it, I will update it.

> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 4 ++++
> >  tools/testing/selftests/kvm/x86_64/hyperv_features.c | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > index b66910702c0a..075fd29071a6 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> > @@ -110,6 +110,7 @@
> >  #define HV_ACCESS_STATS                              BIT(8)
> >  #define HV_DEBUGGING                         BIT(11)
> >  #define HV_CPU_MANAGEMENT                    BIT(12)
> > +#define HV_ENABLE_EXTENDED_HYPERCALLS                BIT(20)
> >  #define HV_ISOLATION                         BIT(22)
> >
> >  /* HYPERV_CPUID_FEATURES.EDX */
> > @@ -164,6 +165,9 @@
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> >
> > +/* Extended hypercalls */
> > +#define HV_EXT_CALL_QUERY_CAPABILITIES               0x8001
> > +
> >  #define HV_FLUSH_ALL_PROCESSORS                      BIT(0)
> >  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES  BIT(1)
> >  #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY    BIT(2)
> > diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> > index 05b32e550a80..6b443ce456b6 100644
> > --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> > +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> > @@ -602,6 +602,15 @@ static void guest_test_hcalls_access(void)
> >                       hcall->expect = HV_STATUS_SUCCESS;
> >                       break;
> >               case 19:
> > +                     hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES;
> > +                     hcall->expect = HV_STATUS_ACCESS_DENIED;
> > +                     break;
> > +             case 20:
> > +                     feat->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
> > +                     hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES | HV_HYPERCALL_FAST_BIT;
> > +                     hcall->expect = HV_STATUS_INVALID_PARAMETER;
> > +                     break;
> > +             case 21:
> >                       kvm_vm_free(vm);
> >                       return;
> >               }
> > --
> > 2.38.1.273.g43a17bfeac-goog
> >

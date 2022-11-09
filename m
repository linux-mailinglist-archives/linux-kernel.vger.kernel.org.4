Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30A623321
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKITFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKITFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:05:43 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B01EED5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:05:42 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id z192so22195187yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CeYlj/V/FX7IavdtjtPot5IQiw4SpwEq4VoY6uQz3S8=;
        b=aMCPSxqTxHbOni1AT8tzAP+n78EJaMj5rB06nwPJ/VWFUb2sYmY8WcASVzku19XLdo
         ExAwImuGjkOMVcaZIAQ0nUU+p4kp/6VjIafHqYlM4s2g3lFtJhIDbp2MEaCEaGuadhGN
         DWMdVJ5V8LJyVWeeB6nE80/D5mUsAsmPXtdElvosa+NVEJfLZeHpEbTOB9i/txO7giPG
         D808lXxKbWB3tnNzPwewpZByxhEu+IycWBVbD7JBUUlBGotAbLALbsAVMERiO3RKzByg
         iwx+shSS0rFypJG8J+yjONvCQQKmQKVpCWKzNjgErMcj/hEAwawIIUGNyBcCryZjvL1D
         HAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeYlj/V/FX7IavdtjtPot5IQiw4SpwEq4VoY6uQz3S8=;
        b=d9nDKep+F53sLBK4QR+Gkqs+Ad/+srU5Ek2xXOWLXoZ1t5B8O1x7dXqiKM0pyg/K+E
         AxtifCDoqV+on3VF830Uhw/iA2QZtCIKMhfpl9ULMpypW0xS5psGtZ3zIoyIdMOeY9OT
         vT5ZDENvHQm8LDnNmMd6gFZ5SsmYDHisDlp7wMHZ4ybCXJPWMKdnwAm8AwRXkth7mLiV
         JUkfCIWWH4/CUUTmUH3QrjWnK4LXf+qd7hyTPa9JjSP08BL/rO0w2wgiPy+5iNl5DRBU
         5SOdNIZgfE78Vmy0BxriGhqzsUe+rv9Yj+kLqJgeaAkiFdrXqKqJqiZRqnyNC+uDr4N5
         aZIQ==
X-Gm-Message-State: ANoB5pnQa3As16WJougAeN4SLCndBkE0U8LGfFybu+u529GDQ0bKdGoL
        9eFqnhSvsCmxCBQckhnNYfDgIX08ODA6pVTe1w2wdA==
X-Google-Smtp-Source: AA0mqf7lMXTDw3cAqeSsEXRoKrE37gR3VGwuJxv2cmU18VUTmE88BpPmyWfGobVJkb7NtO9At58YvqC8Co+8MzVCuIA=
X-Received: by 2002:a25:2458:0:b0:6d5:d9bd:3a20 with SMTP id
 k85-20020a252458000000b006d5d9bd3a20mr18875695ybk.582.1668020741560; Wed, 09
 Nov 2022 11:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <Y1mlJqKdFtlgG3jR@google.com> <DS0PR11MB63731F2B467D4084F5C8D9B5DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1qnWFzekT27rYka@google.com> <CALzav=c4-FWVrWQebuYs--vbgnyPjEwZxfjSS1aMSRL3JMbWYw@mail.gmail.com>
 <Y1rNm0E6/I5y6K2a@google.com> <20221028124106.oze32j2lkq5ykifj@kamzik>
 <Y1v6AEInngzRxSJ+@google.com> <CALzav=chUT9v4wYVVy9dSLcevhADxONaf9iCMOWQ_vUOwpkV9g@mail.gmail.com>
 <Y2lMLfjiRAF8ZrNT@google.com>
In-Reply-To: <Y2lMLfjiRAF8ZrNT@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 9 Nov 2022 11:05:14 -0800
Message-ID: <CALzav=feThT9Gng8hJy54VDNO=m=ywpzUKyKjjLmj5ZFWUBJuA@mail.gmail.com>
Subject: Re: [PATCH v1 00/18] KVM selftests code consolidation and cleanup
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Jones <andrew.jones@linux.dev>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vipinsh@google.com" <vipinsh@google.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Nov 7, 2022 at 10:19 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Nov 07, 2022, David Matlack wrote:
> > On Fri, Oct 28, 2022 at 8:49 AM Sean Christopherson <seanjc@google.com> wrote:
> > > Anyways, if someone wants to pursue this, these ideas and the "requirement" should
> > > be run by the checkpatch maintainers.  They have far more experience and authority
> > > in this area, and I suspect we aren't the first people to want checkpatch to get
> > > involved in enforcing shortlog scope.
> >
> > Documenting would at least be an improvement over what we have today
> > since it would eliminate the need to re-explain the preferred rules
> > every time. We can just point to the documentation when reviewing
> > patches.
>
> Agreed.  And there are many other things I want to formalize for KVM x86, e.g.
> testing expectations, health requirements for the various branches, what each
> branch is used for etc...
>
> If you want to send a patch for the shortlogs thing, maybe create
>
>   Documentation/process/maintainer-kvm-x86.rst
>
> and link it into Documentation/process/maintainer-handbooks.rst?

Can do. I'll try to take a look later this week or next week.

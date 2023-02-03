Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420368A667
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBCW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjBCW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:57:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766767BBFA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:57:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g13so1982139ple.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odYR1omabJGTv/NIynzwZa3Xij8VrLkgoYUk9yR3l2s=;
        b=XafGo9twuPHPkrcLFLSPIV4hQ3mQbs9UhgKKtwggzJ3BW717TU7Oc6JIdeX4xzP+m0
         Tr130D4e8OqZsDn0ZqvJcBrcGld9vq3g65CrKuZ76X33y3AX5fINQmKsKMa6/p2UokSu
         sgsJWwPuSbhgy6SgMLRSJ/SqqnmcCsUeqkaoViJHAdiTOMTBJ0AgIAouTUh8i+5fcUDN
         mly79kEq8ZeiUKL5ezaOyUqoo4kVkFL9pcBuNw8rXCCYTfnImXQCITlVushFW2pCdqoW
         KRwjJgwoW44C79VKhYA+MKEnhLbEr7FN9Ku4iMbvs12eJ5z4rZqJj/qajD7hie8zlMgL
         h24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odYR1omabJGTv/NIynzwZa3Xij8VrLkgoYUk9yR3l2s=;
        b=0ZEPLNlqnTu0Bj/qxAi2SEPsT39f7bsR5eDQz0crwrAwL/KZlYFPDlVd607yf4VR81
         gF83pFpKS6GyzeTjpHRcSEvIrGbxkbNL52fbUiup+V2VjLekx+KsbxElpNp6QB7CYNCl
         ohv6ZW9x5LLp0eKNcZm4ZzvkLK+UE2gbJD3XEvvr1mtfF7DdqViVHP7dJj2XLWVOmNbC
         i0ajmGjUbaEiIxFywbdUrYg4QvPxHmgEEyQrrBWGrLyKUuCtJHH9sE3VaWcbDkhY40jK
         6DveTRIaPiS1jEiFQyS9Aqs1P/kThOb6BlbaUqoER7AFI7MZNcdvET7F5YAYrMz8/bhB
         DT4w==
X-Gm-Message-State: AO0yUKVE/MjfJ4Xg+z4qd00sJfLymouSBFAu0yv/LGXTTMUdWF3eZj1A
        m+6USZeDlg3QwtLs7GuqbaDPBsp0lPcKY7ab+vE=
X-Google-Smtp-Source: AK7set/TtZ/bwGvAwEgV/Zy92fwCPBVJKnDBWVxI0RNELEreO6jgD+SpqByY22dU1puCIHtmmN5Qiw==
X-Received: by 2002:a17:902:e808:b0:194:6d3c:38a5 with SMTP id u8-20020a170902e80800b001946d3c38a5mr55907plg.1.1675465059851;
        Fri, 03 Feb 2023 14:57:39 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b00186b7443082sm2117516pli.195.2023.02.03.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:57:39 -0800 (PST)
Date:   Fri, 3 Feb 2023 22:57:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        m Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [Patch v4 12/13] KVM: selftests: Make vCPU exit reason test
 assertion common.
Message-ID: <Y92RXxf62Q3qVLN0@google.com>
References: <20221212183720.4062037-1-vipinsh@google.com>
 <20221212183720.4062037-13-vipinsh@google.com>
 <Y9r0q9cuK/ifu+OW@google.com>
 <CAHVum0fEmEAQSxozb1BTTy-d3UGrsvhjt8V5FXQPrX5wOYqpPQ@mail.gmail.com>
 <Y9wGQx89zI3TMU1Y@google.com>
 <CAHVum0dFG6gFTQ=JzMkX5Yw-BO7jtUEQyVww6TpN9wk_hQMpqw@mail.gmail.com>
 <CAHVum0cDxK=wmd+UB9meZVm5h3tcGdkDJL=fK_jx19NhfikBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0cDxK=wmd+UB9meZVm5h3tcGdkDJL=fK_jx19NhfikBSg@mail.gmail.com>
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

On Fri, Feb 03, 2023, Vipin Sharma wrote:
> On Thu, Feb 2, 2023 at 10:59 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Feb 2, 2023 at 10:51 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Thu, Feb 02, 2023, Vipin Sharma wrote:
> > > > On Wed, Feb 1, 2023 at 3:24 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > > I love the cleanup, but in the future, please don't squeeze KVM-wide changes in
> > > > > the middle of an otherwise arch-specific series unless it's absolutely necessary.
> > > > > I get why you added the macro before copy-pasting more code into a new test, but
> > > > > the unfortunate side effect is that complicates grabbing the entire series.
> > > > >
> > > >
> > > > Make sense. So what is preferable:
> > > > 1. Make the big cleanup identified during a series as the last patches
> > > > in that series?
> > > > 2. Have two series and big cleanups rebased on top of the initial series?
> > > >
> > > > Or, both 1 & 2 are acceptable depending on the cleanup?
> > >
> > >   3. Post the cleanup independently, but make a note so that maintainers know
> > >      that there may be conflicts and/or missed cleanup opportunities.
> > >
> Small question:
> Will it be fine if I use the current kvm/queue head or do you prefer
> if I take one of your kvm-x86/linux branches?

Use kvm/queue, fixing up conflicts and converting stragglers should be easy enough.

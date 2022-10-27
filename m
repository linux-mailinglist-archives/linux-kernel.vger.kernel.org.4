Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967560FD04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiJ0QZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiJ0QYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:24:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472918E1E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:24:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z192so2820428yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvgAY0ZZmbPzBGdVsJyZMXiBsK/eMtf0JA26ukDv8hs=;
        b=Wm/2rODJoJ3iKDDmP8UspjBSiCJfYn2YUF1Nb7VYGMb/F2rvbfDeUDttsD2ncZb1ZA
         TZkDk+VQhP3vtAFv+i3ZCspALH2NZw1bjKAje7HMLaXNstQStMwe6xBkbpD+6HOq/bzA
         G/JyaiQxsYWe3/NW2ncg1km/9MciUynJFLrPbzXQBvvQH5I0MGEru5vWJPx8RkaiUTJ0
         qUMScZkqSJ/Og9wIk8Sc4gSmS1KXQQ65W06eM4RNMZsdLYcgBPzXr7ENtPAf09jLtmKA
         nqoLGsZYc74DfrlSQsOjb580cX/sPd2poW5VSNlUKXNWoSb5oCRv60uWraeglnykauPM
         Cp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvgAY0ZZmbPzBGdVsJyZMXiBsK/eMtf0JA26ukDv8hs=;
        b=T0kJZEouGLmeEa4Tx6UNVw9L3Q2WtSv/pna8MVWNqPi2zZSfi8Ey5jSq9eBwRlVkA2
         5wuW1SLy8BkaRb7X1vVOkPTjIhPeSHNL5d2XfnnnrnJPJdukT217VesBKgst8Z2DmbxO
         mAzZFANQq0y1WK5zvebR0CFaJIUrwM8fEzJF2K/TmPyc13awK6zTbWhpmd5CXk9QWO8C
         4lN2Sd75Nl0cop/L7qfawqPTi4mUGP+NfeXKae90plVqQEopEc6RjG3hLKYbKsR/f3gy
         e9ztOVbVWswHYkIJVYbNuQBzTZhxtUdK5sseR6p6Yo2CiDQXNqTr64edyMohCD/a6QFr
         qYSg==
X-Gm-Message-State: ACrzQf0HuUY4isU1gJO3bllcp+BT5bFmx4FZY4eRCG0x9xxfCCOQvIZo
        QMAHVLH1uX0cgwKusN48ns1XLc9b1ZyvAvcu/hdY8Q==
X-Google-Smtp-Source: AMsMyM7TguuBlam7+sMSZePWYhaZv13WFhlSNd3p2QDANa0Tr31MryRHpCR7/ilnDnpX91xNhmP1LzFTq1iyYXz5NzI=
X-Received: by 2002:a05:6902:68b:b0:6a6:bffd:b691 with SMTP id
 i11-20020a056902068b00b006a6bffdb691mr41406143ybt.607.1666887884400; Thu, 27
 Oct 2022 09:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <Y1mlJqKdFtlgG3jR@google.com> <DS0PR11MB63731F2B467D4084F5C8D9B5DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1qnWFzekT27rYka@google.com>
In-Reply-To: <Y1qnWFzekT27rYka@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 27 Oct 2022 09:24:17 -0700
Message-ID: <CALzav=c4-FWVrWQebuYs--vbgnyPjEwZxfjSS1aMSRL3JMbWYw@mail.gmail.com>
Subject: Re: [PATCH v1 00/18] KVM selftests code consolidation and cleanup
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
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

On Thu, Oct 27, 2022 at 8:44 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Oct 27, 2022, Wang, Wei W wrote:
> > On Thursday, October 27, 2022 5:23 AM, David Matlack:
> > > I haven't dug too much into the actual code yet, but I have some high level
> > > feedback based on a quick look through the series:
> > >
> > >  - Use the format "KVM: selftests: <Decsription>" for the shortlog.
> >
> > I know it's not common to see so far, but curious is this the required format?
>
> It's definitely the preferred format.
>
> > I didn't find where it's documented.
>
> Heh, for all shortlog scopes, the "documentation" is `git log --pretty=oneline` :-)
>
> > If it's indeed a requirement, probably we also need to enhance checkpatch.pl
> > to detect this.
>
> I like the idea in theory, but that'd be a daunting task to set up, and quite the
> maintenance nightmare.  There are probably thousands of file => scope mappings
> throughout the kernel, with any number of exceptions and arbitrary rules.

I was thinking about proposing this in checkpatch.pl, or in some
KVM-specific check script. It seems like the following rule: If a
commit only modifies files in tools/testing/selftests/kvm/*, then
requires the shortlog match the regex "KVM: selftests: .*". That would
handle the vast majority of cases without affecting other subsystems.

Sean are you more concerned that if we start validating shortlogs in
checkpatch.pl then eventually it will get too out of hand? (i.e. not
so concerned with this specific case, but the general problem?)

Either way, we should at least document the preferred KVM shortlog
styles in Documentation/virtual/kvm/.

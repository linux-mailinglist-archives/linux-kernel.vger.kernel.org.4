Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62F6744E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjASVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjASVhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:37:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926086A0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:27:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so9164096ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBxxsu+2nogYycJOVBa8FpBheOsrcQjWtd2yvS/CdzM=;
        b=KvYOhyZIL1Dh6zrbX5HfN3585SCgwWI5wmkMDA2Z2k2ZU/sx4hmrd+135EWaliWtKr
         yahZTBZ/X+RFVORo4q4lASCCHk6Qf9qBgAXJNNmo8BZ557jvNOW9epHdlyLAhnKjuFfe
         5Zz4N7xwc2W8ZHmsNw8z8EFlrD6NDrEYmFKHF6yKpvW2fGgDAj/TjYxAGjFBuqwRUgJ1
         CFwDdgdDDPQWMNufnh2dEPUVzOefvSVmkMNt155W2lVFFyjFFLvn4JT6fzDkVlcdnoBM
         pd1hzCCx8dH4NMAVlGfe1T1+byDGGuJ/p5U6rVApyfuGdKIrCatKBanJx08yINP0Fp8e
         dBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBxxsu+2nogYycJOVBa8FpBheOsrcQjWtd2yvS/CdzM=;
        b=7wMZuwaUlsfsZND6782J9h8BR5JRXOlDZgzbur+7d3S3plMZ3KYDaFPuPWmOIf9qBm
         pUJS7TU21Qn/APf/V9TWsPzOF4CGk0XVzTZ1eSUZEHmpjp6hNyspFsxFXJX4vJaSiVvf
         qF9lCiTtjJyFsY1YurhcEo7PpSp6carDY0yDfh4Ye+RUpEJX0rxRU/jYs4b7CB4FjDRZ
         DTPhikteL6eyhzczRzVzzgyfRUNnCDt4wWlQ2c1WSOH0dM9Q2O+1e7woiQAqytOLSa5u
         cfuQ78jCwjW4QOy6tvzXQWpC1fu7rcom34YbWYEv1/MIUpRJIfgXjK++7JVsLg45hkP9
         XrRw==
X-Gm-Message-State: AFqh2kqEaX0xYrXneMoi3977iTox/sYv/iC/dgpxCiRZ7ENdxYs63KRx
        f0/ZEUF0/WFT70E4J+wJrMQpV7fQKOs7uBkS3m/Cuw==
X-Google-Smtp-Source: AMrXdXuIsOhhmDKIq4/fwgQCcPRwc4Lx51i0zGBEM1sK0CndlvxhPhe4DwACAVirxFIrAz/SDTucUM1eJP9tBhNTX+8=
X-Received: by 2002:a17:906:f913:b0:85d:97b9:ec06 with SMTP id
 lc19-20020a170906f91300b0085d97b9ec06mr787050ejb.541.1674163663856; Thu, 19
 Jan 2023 13:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119200553.3922206-1-bgardon@google.com> <Y8mqd7HUzXDnhXLV@google.com>
 <CANgfPd902Sd+LCd61D8=ba2ZTbJCRu3emLXtE212_8NWW6c3Pw@mail.gmail.com> <Y8mt3uv5iF6i/DD1@google.com>
In-Reply-To: <Y8mt3uv5iF6i/DD1@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 19 Jan 2023 13:27:32 -0800
Message-ID: <CANgfPd8owr_=va1u4eoH6=anjM0VX_YSU5AyvBJaKjuifojVDA@mail.gmail.com>
Subject: Re: [RFC 1/2] selftests: KVM: Move dirty logging functions to memstress.(c|h)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>
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

On Thu, Jan 19, 2023 at 12:53 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Jan 19, 2023, Ben Gardon wrote:
> > Woops!
>
> Heh, and top posting too.  Me thinks you had too long of a break ;-)

Oh no, I'm in shambles (^:

>
> > I did not mean to tag this RFC. Sorry about that. I will include a cover
> > letter in the future and can resend these with one if preferred.
>
> Eh, no need, damage done.  I was just confused.

I sent a revised version anyway because I realized it probably made
sense to have test skip itself if TDP MMU or Eager Page Splitting was
disabled.

>
> > On Thu, Jan 19, 2023 at 12:39 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Please provide cover letters for multi-patch series, regardless of how trivial
> > > the series is.
> > >
> > > This series especially needs a cover explaining why it's tagged "RFC".

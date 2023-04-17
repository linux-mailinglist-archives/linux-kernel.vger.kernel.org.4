Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD756E4E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDQQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDQQwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:52:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A5AD38
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:51:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f69fb5cafso180074687b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681750313; x=1684342313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPGXtfoj8zWfrxnDm8mfNpTrHIS3T28NNHxcP0q+UvU=;
        b=fHPvgnEZ9Q20W163j2WeKhNLShLbrOCT756OhTAsT7XfjoUgvtomSsUpCGjDP2jzKt
         zJPjwyFsFZfWNtkXYd/+JgC17JTwMEJsrxsN/pUJ+kRta3Bcm+RkPVGiNlSHDx7xFxAR
         zqUjOzHidTSeHcSGw/qu4K+dwuH58vO6kfrCts0GQ7AMEE5xgUlg4JUlItGyTyGDaGad
         odbrhY2zgcepvi2XnmxdpNr5lITeZ/NPbmyyLpDxvhxeaBP4fBk2nQA/YdNocWQ7TWdk
         iE3n/LVcWOyPbX6Abiw5jMyZS9uTUtkYXvFNuGx3mrODqW27jzEszuAzRgpAv+9s6n7H
         EA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681750313; x=1684342313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPGXtfoj8zWfrxnDm8mfNpTrHIS3T28NNHxcP0q+UvU=;
        b=JMSeq6CSGVPZUkLYLp6cqbFZxQFGSlZWb9Fxj7FjOk0tRje3Iqf/85ZfjzJWfvh1+3
         VKsgdcZ1DafcOSKqIuFcqKyz/spIwTjIFPcT6Rm2R0wPz+OTG8QIaR/bK6W8n00+ma7f
         2IESrOiPdQKR1Q4d9FQLwZrjucW6Q0rZpjCNpJzW8DkNrGoUWVC11tBMQL/TjC+eCewj
         sybxJdvOal8pGzEzSTkpDN0EWi/E5r7SRBUuYYJHGsCS42CmXRygFbJqPO8JV0YdRe3S
         ZwMTnNtlBFr3S30A/MMyyuvUvH/i2fCnWYFhHF30aG0SxKGytVaHMfnA5vRmlz6Hiwe8
         WzSA==
X-Gm-Message-State: AAQBX9eRV+BxgDSFEOxOEeL0GHfbl1XZ10AVJ7hOJQkOuui531czjLzD
        j5o1m/NKeWJKTadRB+Tv/KnxCzeRKM8=
X-Google-Smtp-Source: AKy350ZrfKImkrnKZQlURSg7UI6PwCvqyet7zKKn2r62aQROPOQaP8MBSBy9i/kch4Xb/n5OAMaqLBYeXEs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e503:0:b0:54f:40fe:10cc with SMTP id
 s3-20020a81e503000000b0054f40fe10ccmr9678583ywl.9.1681750313800; Mon, 17 Apr
 2023 09:51:53 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:51:52 -0700
In-Reply-To: <20230415033012.3826437-1-alexjlzheng@tencent.com>
Mime-Version: 1.0
References: <ZDmSWIEOTYo3qHf7@google.com> <20230415033012.3826437-1-alexjlzheng@tencent.com>
Message-ID: <ZD15KFZO9J33Eodj@google.com>
Subject: Re: [PATCH v2] KVM: x86: Fix poll command
From:   Sean Christopherson <seanjc@google.com>
To:     alexjlzheng@gmail.com
Cc:     alexjlzheng@tencent.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023, alexjlzheng@gmail.com wrote:
> On Fri, 14 Apr 2023, Sean Christopherson <seanjc@google.com> wrote:
> > On Thu, Apr 13, 2023, alexjlzheng@gmail.com wrote:
> > > Fix the implementation of pic_poll_read():
> > > 1. Set Bit 7 when there is an interrupt
> > > 2. Return 0 when there is no interrupt
> > 
> > I don't think #2 is justified.  The spec says:
> > 
> >   The interrupt requests are ordered in priority from 0 through 7 (0 highest).
> 
> This is only true when don't use rotation for priority or just reset the 8259a.
> It's prossible to change priorities, i.e. Specific Rotation Mode or Automatic
> Rotation Mode.
> 
> > 
> > I.e. the current code enumerates the _lowest_ priority when there is no interrupt,
> > which seems more correct than reporting the highest priority possible.
> 
> The practice and interpretation of returning to the lowest priority interrupt
> when there are no active interrupts in the PIC doesn't seem reasonable, as far as I
> understand. For #2, in my opinion, the correct interpretation of the current code
> may be that a spurious interrupt is returned(IRQ 7 is used for that according to
> the 8259 hardware manual).
> 
> For #2, the main purpose of returning 0 is to set Bit 7 of the return value to 0
> to indicate that there is no interrupt.

Is there an actual real world chunk of guest code that is broken by KVM's behavior
for the "no interrupt" case?  Because if not, my strong preference is to leave the
code as-is.

I have no objection to setting bit 7 when there is an interrupt, as that behavior
is explicitly called out and KVM is clearly in the wrong.

But for the "no interrupt" case, there are a lot of "mays" and "seems" in both of
our responses, i.e. it's not obvious that the current code is outright wrong, nor
that it is correct either.  Given the lack of clarity, unless there's a guest that's
actually broken by KVM's current implementation, I see no benefit to changing KVM's
behavior, only the potential for breaking existing KVM guests.

And if the "no interrupt" case really does need to be fixed, please split it to
a separate patch.

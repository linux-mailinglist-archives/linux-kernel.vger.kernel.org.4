Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B36BA3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCOAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCOAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:05:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7D366BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:05:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso26195277b3.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678838725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vzmubcM69Fil86q8e8tUW9JBPrHO2RhwGYYUQmHRsE=;
        b=ZnaczMdxR52HI6QQFZjhNjzJ6kvL8qLWOSPjmN7j2y9SqoZw21p4892E7cHGlLlc4B
         tcc0+Y2yYxN4S/Q4/EddFjroQ8+kP86955e+f3QvDefnqzEJV9z8JaDbuIOE5rCQtseG
         kWYAa4O0PPR8eNuCJ28qsj2SnBERbTdvo0kIAUoVuRnkX6UA8nA8rxRkRMc9JCd93K2n
         41MnN/TvUv5RD4YUPtCpkyXwYftbK2HJTv9i6HIxUODtqizzSU5X6qwjrkjXu+QDvS+N
         6Z6fhLV2kCgbrsdCAlZM3vWCPn3wiu+i1WetoTxqSsFVyp6Oa7YuITbdROJOFBhRCoNC
         l9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vzmubcM69Fil86q8e8tUW9JBPrHO2RhwGYYUQmHRsE=;
        b=m+wp3ezgLQXSbz4LBCiCMu5sZJ958r+fU1cRUzCDOe3Mil6Sj4hU0hlgFYMa7ep54/
         lqvrOP4xZIG1omZtstJgpjwFXkoR6lQxkxxLJvaBvbSwZeNJ6uw+SBuby1Bjn+R/p0E5
         7ARNdGwrnKIiZIVV0ZnKAGNEAP4AR4ESXpOh9HhCb6yJCfFFML6PiFLeQf6NJEb5lBhW
         VxIQ6YE0BdyBy9nlrRMW/vbBrdKksOa5iUrNiTYTltf7xd32mEEcGhM4AhnkZ1Cj24l+
         TFWk0UTSuEgzRIfGBMgnsnvdyh/ju7caAhxjzqwtzMRCbH1t/9TGDx0v47AHfm3wVOd4
         QA7A==
X-Gm-Message-State: AO0yUKWt8Qu6qMSqK9coL5wpbrd5MfJYteHMSvzmxXodMKPQwx2IQOQc
        M0pOG7b9ANhCrfyAIpIkNQtigb+zpDk=
X-Google-Smtp-Source: AK7set+qGkXLCQFXa84yVq69DFMSdt+zf84Ii24CAPvfaY0vo52JD/nodvepV/bRZFtF8FTbc1R0bEfMp08=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8b08:0:b0:b14:91e:4d19 with SMTP id
 i8-20020a258b08000000b00b14091e4d19mr18376202ybl.7.1678838725738; Tue, 14 Mar
 2023 17:05:25 -0700 (PDT)
Date:   Tue, 14 Mar 2023 17:05:24 -0700
In-Reply-To: <CABgObfZoQAis56NaVO0Pi6U_BsY3_Ue41mOJGQtXTWex2D2Wpg@mail.gmail.com>
Mime-Version: 1.0
References: <20230211003534.564198-1-seanjc@google.com> <20230314134356.3053443-1-pbonzini@redhat.com>
 <ZBCEphyd205U4gxF@google.com> <CABgObfZoQAis56NaVO0Pi6U_BsY3_Ue41mOJGQtXTWex2D2Wpg@mail.gmail.com>
Message-ID: <ZBEE1GafxqQkjYuk@google.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Stub out enable_evmcs static key
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023, Paolo Bonzini wrote:
> Il mar 14 mar 2023, 15:29 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > On Tue, Mar 14, 2023, Paolo Bonzini wrote:
> > > Queued, thanks.
> >
> > Paolo,
> >
> > Are you grabbing this for 6.3 or 6.4?  If it's for 6.4, what is your plan for 6.4?
> > I assumed we were taking the same approach as we did for 6.3, where you handle the
> > current cycle (stabilizing 6.3) and I focus on the next cycle (building 6.4).
> 
> 
> This one is for 6.4. What we did for 6.3 included me merging a handful
> of series that were not included in the previous merge window; so
> that's what I did today. If that's okay for you, once the -rc3 pull
> request is sent (probably tomorrow) I will push to kvm/next and that
> will be it.

Works for me, thanks!

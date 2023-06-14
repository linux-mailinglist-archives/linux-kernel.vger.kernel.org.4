Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DA71EEA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjFAQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFAQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:21:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BA133
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:21:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a64so14099607b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685636456; x=1688228456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8MtW2Q7n+8kVk0jNDBvQTtFEDaPcuPqWej2hGKW7Ww=;
        b=ajNXyHBOUOC4trVOpRJKJj1vcm+0E379aucFQj2qjWrtdK8kMcjJVq6bwo/QPJJpsf
         ixvGSXMSfV0z2Bk5Ec41a/v8skxddaBMr7chx4+mg9OK4C3WscU7DpDW+2Ts2pBLCPhK
         KBGyb8U780xfJMXEN041JZvhKVFCH9McPcVt8xQ+UgtC8IaFVp1yh8+qXsdOPQxRiIep
         cU46b/x8Sk0XBsoT2T7yMeZA66gdwKQnzimTkyBuveQ/qMTBw49LpeAPlQleXRLYVlu3
         AMJ9WO7BiKhuv8+CTqgLwSHlSyAUID3JKCDsgcrldqjoUPsiTOFAVlTJF3Fb4ubz/pGX
         isGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636456; x=1688228456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8MtW2Q7n+8kVk0jNDBvQTtFEDaPcuPqWej2hGKW7Ww=;
        b=aHkE+HdlIYjCrOVEfOJyF/7cARc/Sl0JC0s1M/gv/+goWkNNKmuLlXlCFRA4vi+JvH
         qMb+Bhot7dfvRsoJvNeyKTGvDD6ZQ3TTvXkMx0/qDuAeSXlqCnkxsl3ewhcmKuf/0Qx8
         wisA1BHGUDfTkF+YAY0D7FEZZTCkjgr87v0UiIR/q8POoMRl92ad9APaLVV1KR4m9bR5
         gCP45VmMWoMQSmZSSez3ZGoJ1MGT3cjM0ogsIZEJvvK68idxcqMM6nbTkI9aoN+IheTG
         ycOMmXt+20dFf2da6L8kCneoBpzp80kuD2mnd9hLe7NzZ2vKynsP183OVBHuFVKEAIdS
         xLBQ==
X-Gm-Message-State: AC+VfDyGNBnNZTzCAmjknQRAbtp8YatS4D9s7+46v5NOMybR2eLLgE85
        zVeLguBx69ivHunEvhjPwwa+feQ2B8w=
X-Google-Smtp-Source: ACHHUZ6YvIG3cYXg02rNK4YX0kLcjPJqydSFn7vmiEQVEqNHhuwarV6iA3Sv8RueaV8SWnVS5rkfcHytUGk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad5c:0:b0:565:b7d6:712d with SMTP id
 l28-20020a81ad5c000000b00565b7d6712dmr5681145ywk.2.1685636456512; Thu, 01 Jun
 2023 09:20:56 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:20:54 -0700
In-Reply-To: <DS0PR11MB6373F567D22270CA3CE86696DC499@DS0PR11MB6373.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230307135233.54684-1-wei.w.wang@intel.com> <ZAkZjzQ8pJQXQhJR@google.com>
 <DS0PR11MB6373F567D22270CA3CE86696DC499@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZHjDra1HbG65o4uH@google.com>
Subject: Re: [PATCH v2] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
From:   Sean Christopherson <seanjc@google.com>
To:     Wei W Wang <wei.w.wang@intel.com>
Cc:     "dmatlack@google.com" <dmatlack@google.com>,
        "mizhang@google.com" <mizhang@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023, Wei W Wang wrote:
> On Thursday, March 9, 2023 7:26 AM, Sean Christopherson wrote:
> > On Tue, Mar 07, 2023, Wei Wang wrote:
> > > Current KVM_BUG and KVM_BUG_ON assume that 'cond' passed from
> > callers
> > > is 32-bit as it casts 'cond' to the type of int.
> > 
> > You're very generous, I would have led with "Fix a badly done
> > copy+paste ..." ;-)
> > 
> > > Fixes: 0b8f11737cff ("KVM: Add infrastructure and macro to mark VM as
> > > bugged")
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > ---
> > 
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
> Kind ping on this patch.
> Seems it wasn't noticed for months. Just check if it would be good to be
> merged or not proper for any reason?

I'll grab it for 6.5.

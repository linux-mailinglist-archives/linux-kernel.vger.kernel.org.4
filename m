Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663796740AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjASSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjASSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:15:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636631449F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:15:02 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b17so3063100pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xr3qcJgaF5vAgY/VqxwE2Z8SykyvgmfIn0SNmkAE4nU=;
        b=qhMvPE0EEmswKPBN9nfYdqxGi4HHSszB3D3IZvKJLTzMB+z8e7t9oJVhxCulTj+K48
         1ffeM0ws/7/yw7STUqda2AkBMXQaJxE63pPVbHIvABTbHarfvbc7+ajRWHFyytY19cHt
         kM+YgZTJzkjAtzdtqdHyhYifGOcGPJEjSvt1+Rgp2UMS4r5tLkBY8Ew5pbcMYBrSEFPo
         gb/QzeaIVxzGUk9Y4ZtkmF6veMo14/BHj04g5falnYfDQIliBYcw9F5+nuhm6rwo2vOz
         yu67BiSthp50cEWC6OJFICGk8M0WbX9T07CUHYLSMtFEtCO1tXKDw8T7/h8tqWExludb
         vS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr3qcJgaF5vAgY/VqxwE2Z8SykyvgmfIn0SNmkAE4nU=;
        b=WTgxyrvoeTShHyPVSt7bSrrCW+9f/pd0JVDcyj8wyJHVu7HDfGfBvMTv31obtFHY6S
         92rBkdk+LylnDjwQ1U6cYplbCrTrMSoEIYpz6CnnrihDcNV6PFAs0CdfgemHqjaH2SQA
         9mCWrt2oP0pfJx3p0PJEwGRw/HcoeYPIA77F3tir4JzMCJDTUcvRqfctZsaKjIFL5T0X
         jUW24IOv4ToQkyRWWNU8GzzaxWoNgWMOy8+PWDAZrgied2CKGcLBDQXUjsaAEXnvH+SH
         Ze+zmhMVXvanLInGfE8ax4rwsJVjdh4Izepn0T0BiTbsDnj+xdPEg416bE1K2MP003F/
         cFrw==
X-Gm-Message-State: AFqh2kq2jliIwitt2/VV6PP7jyEqtXfO4gWRhUqTFdZRZ3ns2TDEtmwm
        Up9GKQ28wfGmCFx2ZsnTaeXzcw==
X-Google-Smtp-Source: AMrXdXuVsr2wL2Ppd/PjLvkpdiTDSs59fU6gdeTLm9yL9pzPrqst5KlUg1m4KtxFcUCKIQZvhK7sVQ==
X-Received: by 2002:a05:6a20:a883:b0:a4:efde:2ed8 with SMTP id ca3-20020a056a20a88300b000a4efde2ed8mr3293758pzb.0.1674152101753;
        Thu, 19 Jan 2023 10:15:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z3-20020a6552c3000000b0049b7b1205a0sm21371832pgp.54.2023.01.19.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:15:01 -0800 (PST)
Date:   Thu, 19 Jan 2023 18:14:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
Message-ID: <Y8mIoUqO8qFgoBZI@google.com>
References: <20221228110410.1682852-1-pbonzini@redhat.com>
 <20230119155800.fiypvvzoalnfavse@linux.intel.com>
 <Y8mEmSESlcdgtVg4@google.com>
 <CABgObfb6Z2MkG8yYtbObK4bhAD_1s8Q_M=PnP5pF-sk3=w8XDg@mail.gmail.com>
 <Y8mGHyg6DjkSyN5A@google.com>
 <CABgObfZZ3TLvW=Qqph16T0759nWy0PL_C3w3g=PACj9cpupBQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZZ3TLvW=Qqph16T0759nWy0PL_C3w3g=PACj9cpupBQA@mail.gmail.com>
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

On Thu, Jan 19, 2023, Paolo Bonzini wrote:
> On Thu, Jan 19, 2023 at 7:04 PM Sean Christopherson <seanjc@google.com> wrote:
> > > It's clang only; GCC only warns with -Wpedantic. Plus, bots probably
> > > don't compile tools/ that much.
> >
> > /wave
> >
> > Want to queue Yu's fix directly Paolo?  I was assuming you'd be offline until
> > sometime tomorrow.
> 
> Yes, I can, but what other patches were you meaning to send?

A minor selftest fix

  https://lore.kernel.org/all/20230111183408.104491-1-vipinsh@google.com

and a fix for a longstanding VMX bug that seems problematic enough that it
warrants going into this cycle.

  https://lore.kernel.org/all/20221114164823.69555-1-hborghor@amazon.de

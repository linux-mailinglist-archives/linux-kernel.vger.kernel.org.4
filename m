Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B0647AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLIAtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLIAtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:49:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10CA5044
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:49:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3308049pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCGS+22W6Ijh4HDU2pimBENdE5ZifuGDf4GuruRkM4g=;
        b=qwep3DKOZnHoY1JGE+iMRqjy4owZLUgIPA/JL731c6MOAJRTs3ZOS4xliwDayBXYHC
         rUg6D31S7gKTYce6/izpBWkjG3UlraSEDVN5Hxl7zPyeIO4kCsiT6T7n5mwE39E2GxGW
         rhWrepw8F/8D1YFo5RFT7OZ0J36Nb9FomRy7IuLkDLywZk19EanWaml8VSnTAokhAOqT
         /h4pSFufZ5YCq1SGuGcw6buJyWJvVDkQS++Lq9xGKu9UlY3bgZiCDc7VTms2ByEiFf69
         l6iZ2QDSK1mO5yBdwBWVNy+SDyPlWhlNZYtBFRkiG5sxxZwJQckM0hoz8G1lPnSEnair
         qOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCGS+22W6Ijh4HDU2pimBENdE5ZifuGDf4GuruRkM4g=;
        b=KIVnVenivgoShetCxpvXHc8pBdVWk8Hg4n07IZ9o9KhE/I8RJ5/kJTK4eZYtuRsq0i
         knx5JCYnK3iraYwV11nD7nC000wBG1vGbULm1L5owGwIx+qa0aMl9rR9WnwnnNzCXp4g
         DNbEoDTbxQX84qGDUk3LfgzbfIQd5YsLWIwjL6Pi64e28RkI+kkLvG/+nPQcjVuW46yy
         l70qWZvwP3FPTDOsthYnisdQpMEkyyQbKiey0LUij41IDC3CGxCzP1SFAEtjvJvZ9Y+q
         r9E/MipqmzEOTPpELEmUxZqd38Jg9ITClP3neRA4fuR722vzXEIv/jP+DsE6R7lGXZxJ
         0FCg==
X-Gm-Message-State: ANoB5pnY6L4SNqMUdqZUwY+PRYspBXDJSHn175W3vwvwo2ViiYSRuz3p
        /E1HDz3jkBFBp5p16a8nRDBvHg==
X-Google-Smtp-Source: AA0mqf7vEtzTVp4FdYLvZLefVjq0aydKbjhTggbRBi05lVjEWHkl0WNCI6o4PP/9e8e6bzCA+uvIsg==
X-Received: by 2002:a05:6a21:9996:b0:a4:efde:2ed8 with SMTP id ve22-20020a056a21999600b000a4efde2ed8mr2396701pzb.0.1670546981034;
        Thu, 08 Dec 2022 16:49:41 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b0018980f14ecfsm43920plb.115.2022.12.08.16.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:49:40 -0800 (PST)
Date:   Fri, 9 Dec 2022 00:49:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 27/32] KVM: SVM: Update svm->ldr_reg cache even if LDR
 is "bad"
Message-ID: <Y5KGIdLU13z1AbtT@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-28-seanjc@google.com>
 <474e619c7caf5322abfe27cb65bbae3f67ecfccf.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474e619c7caf5322abfe27cb65bbae3f67ecfccf.camel@redhat.com>
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

On Thu, Dec 08, 2022, Maxim Levitsky wrote:
> On Sat, 2022-10-01 at 00:59 +0000, Sean Christopherson wrote:
> > Update SVM's cache of the LDR even if the new value is "bad".  Leaving
> > stale information in the cache can result in KVM missing updates and/or
> > invalidating the wrong entry, e.g. if avic_invalidate_logical_id_entry()
> > is triggered after a different vCPU has "claimed" the old LDR.
> > 
> > Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/avic.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 2b640c73f447..4b6fc9d64f4d 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -539,23 +539,24 @@ static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
> >  	return &logical_apic_id_table[index];
> >  }
> >  
> > -static int avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
> > +static void avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
> >  {
> >  	bool flat;
> >  	u32 *entry, new_entry;
> >  
> > +	if (!ldr)
> > +		return;
> > +
> The avic_get_logical_id_entry already returns NULL in this case, so I don't think
> that this is needed.

Hmm, yeah, it's not strictly needed.  I think I kept it because of the explicit
check that previously existed in avic_handle_ldr_update().  Part of me likes the
explicit check, but avic_invalidate_logical_id_entry() doesn't manually guard
against ldr==0, to I agree it's better to drop this for consistency.

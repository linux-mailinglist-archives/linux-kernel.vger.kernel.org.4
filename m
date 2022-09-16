Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6B5BB2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIPTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIPTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:10:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02133B967
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:10:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so17751326pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=druj11/35rpfBxm8kTiVsKQPWDTGtSwSDdBVz4fOVXo=;
        b=NEV8YR3GFSS9vYj4hr6SZRswGyP83saRLOq7HgABqp8izJDxNEme2glKeYHCVmDVFJ
         4zLN2PWPLvAq0l9i6qS3PPndrpeKaHzdjCmCm2giAS2Lkxmto7q/03JxTo0qYQUuoBiY
         3GYMv3L4G1fZ3SRxFNfVrmxS4HQSe/WSU8gxvLVWaTq6hyrXIid0Oetmt4K3gTHJsLz9
         Ixq0y8lmuSDNqIyiOHHOcrLvIJGvZKBhDbApGFUT9at5Myljg+vf7YjI8kuh6ALjmGWZ
         opOLZBULTAOkJuP2q0ta+UoPx+qBrGPCnXThoe1PHaSVNpMAGA0JB5l72XYSccY772n/
         H05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=druj11/35rpfBxm8kTiVsKQPWDTGtSwSDdBVz4fOVXo=;
        b=BjYnl/eZ92aUUBrajXu2IUoQgtzTQoQye5yUQC+Yo7OQ0iS/gDxXkZOAwEV2Z0fBIS
         ebxCH22MczvODy4+zEtHVDYwM1KHjM6HKOpKWmDT1imLFO2j2UPqm752RPGyjamY/bL6
         3b6GBvqP66c7jU2f5H5CtvN3pfwtS1WgVryeVxTXTfCsTxHh8jsZWbzQtHoZoV8PxNce
         TlS57WMDJw2R6RN3iV+KCBmPru5FwAAcd7+KKd9ioF8VvZqGFKjJJE6dgWev44X4QTKL
         okIiarMnXqwohnHoaAMYXpEOJSGb1fDs0x/sbPGjp56Xs0/jdAYJ6saVZFS+MEGNmKIa
         7llw==
X-Gm-Message-State: ACrzQf09LckXUfq19JthLld2hrz/CPfXP1sNbpPr6ggaxhrX6vYqrpjx
        Fw5RjZ+thuQF06KkyiQWc28o0Q==
X-Google-Smtp-Source: AMsMyM4/j4MgwN2dnCEJICPnQWJLFxoUzjVi8eFplySAjsdenR1va5ntv2Kq5rqmJyEx5yCGHz+JRQ==
X-Received: by 2002:a17:902:f547:b0:178:39fe:5b14 with SMTP id h7-20020a170902f54700b0017839fe5b14mr1279515plf.100.1663355410273;
        Fri, 16 Sep 2022 12:10:10 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0016f85feae65sm15488102plh.87.2022.09.16.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:10:09 -0700 (PDT)
Date:   Fri, 16 Sep 2022 19:10:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 04/23] KVM: x86: Inhibit AVIC SPTEs if any vCPU
 enables x2APIC
Message-ID: <YyTKDl04BQviLGW6@google.com>
References: <20220903002254.2411750-1-seanjc@google.com>
 <20220903002254.2411750-5-seanjc@google.com>
 <b6fcb487-56fc-12ea-6f67-b14b0b156ee0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fcb487-56fc-12ea-6f67-b14b0b156ee0@amd.com>
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

On Tue, Sep 13, 2022, Suthikulpanit, Suravee wrote:
> > @@ -10122,7 +10136,15 @@ void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
> >   	set_or_clear_apicv_inhibit(&new, reason, set);
> > -	if (!!old != !!new) {
> > +	/*
> > +	 * If the overall "is APICv activated" status is unchanged, simply add
> > +	 * or remove the inihbit from the pile.  x2APIC is an exception, as it
> > +	 * is a partial inhibit (only blocks SPTEs for the APIC access page).
> > +	 * If x2APIC is the only inhibit in either the old or the new set, then
> > +	 * vCPUs need to be kicked to transition between partially-inhibited
> > +	 * and fully-inhibited.
> > +	 */
> > +	if ((!!old != !!new) || old == X2APIC_ENABLE || new == X2APIC_ENABLE) {
> 
> Why are we comparing APICV inhibit reasons (old, new) with X2APIC_ENABLE
> here? Do you mean to compare with APICV_INHIBIT_REASON_X2APIC?

Heh, the truly hilarious part about this is that the code actually works, because
by pure coincidence, X2APIC_ENABLE == BIT(APICV_INHIBIT_REASON_X2APIC).  Obviously
still needs to be changed, just found it amusing.

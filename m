Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891956574FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiL1Jy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiL1JyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8608FAF1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672221216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czvn595fu0ek0uNlnXbZuA4z/DIyIK5PERCxoN5gwX4=;
        b=drzeMzh0XmvujgoVHtp44RXlk+xJqGrHT04SVarESaTkwaPjl2PkC5XB6gULvlhkXGBbj4
        yU5LjVqa0bQ8RnoTVgPtEU1p16sf+fYsRwq6JcjMQaApzEq942juV/EJxogbT9nfvbtF+g
        zr30wgvBGjRv6tLfNK06RHbPgsumu+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-UiuVtpHFOW6883rTUNE7kQ-1; Wed, 28 Dec 2022 04:53:33 -0500
X-MC-Unique: UiuVtpHFOW6883rTUNE7kQ-1
Received: by mail-wm1-f71.google.com with SMTP id m8-20020a05600c3b0800b003d96bdce12fso6368323wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czvn595fu0ek0uNlnXbZuA4z/DIyIK5PERCxoN5gwX4=;
        b=OOE+03N1mx098usKdWBTJQ6WgcaYoZjgiKCOd4W4xdlh+Vx0LA660LjW7K3sM0Ejgp
         f+3NOZPPmSCyqTITS36y49HqP+lao0wqRIyQ8VdRJwhh4TYqXjdZMxE53aVi6bO0M2ty
         l+aYslhKf46t+cez+QglAKEF1aP7ipo9n5vFlo2jLTgIhuVr6G35qm79EkQx194agPSg
         9zZR6JcssBM0C8gJxzy0qvh+qCDFCUdvL58J66coHa/Q5Ok68dFBCdMu85uVZfm1wn3T
         mI4y+GcGLyrsE6R9gcqpaBIfBru31XDGwzEJ7YYK7V9r5ax9hc3jcsJJbhgWs7ZJuGEi
         wIvA==
X-Gm-Message-State: AFqh2ko9EHnZwigwNezLaTMwuDTx39wiCNPDLJYvQ8lFOFUI23XTs80F
        gQJxzAT1rTdn97be+SpkVtokfv/2Un6/SsGPxP/muhpXRNNzKZinC8yio2pztz0zAUyiqsu1yrL
        I7bnwlsG7b/1rZ8G0FpYjaghK
X-Received: by 2002:a05:600c:18a3:b0:3d1:fcac:3c95 with SMTP id x35-20020a05600c18a300b003d1fcac3c95mr17340704wmp.34.1672221212265;
        Wed, 28 Dec 2022 01:53:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNrKlMJm9lNbW9xDACdCGpqFHEAdDzNhzaKDEc14ml4UEFGsql2V0g6Ne5SEoxnDyjuVsQcg==
X-Received: by 2002:a05:600c:18a3:b0:3d1:fcac:3c95 with SMTP id x35-20020a05600c18a300b003d1fcac3c95mr17340696wmp.34.1672221212100;
        Wed, 28 Dec 2022 01:53:32 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003d359aa353csm19837312wmb.45.2022.12.28.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 01:53:31 -0800 (PST)
Message-ID: <904ecd64fb5d0ae3512bb595ea326383e4099d54.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: restore special vmmcall code layout
 needed by the harness
From:   mlevitsk@redhat.com
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Date:   Wed, 28 Dec 2022 11:53:29 +0200
In-Reply-To: <3e0678e3ce57f3972945d2523ca66b9bc1d1e720.camel@redhat.com>
References: <20221130181147.9911-1-pbonzini@redhat.com>
         <Y4ffgC+HbftkPbaW@google.com> <87r0xjh3qk.fsf@ovpn-194-141.brq.redhat.com>
         <3e0678e3ce57f3972945d2523ca66b9bc1d1e720.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-01 at 15:48 +0200, Maxim Levitsky wrote:
> On Thu, 2022-12-01 at 10:28 +0100, Vitaly Kuznetsov wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > 
> > > On Wed, Nov 30, 2022, Paolo Bonzini wrote:
> > > > Commit 8fda37cf3d41 ("KVM: selftests: Stuff RAX/RCX with 'safe' values
> > > > in vmmcall()/vmcall()", 2022-11-21) broke the svm_nested_soft_inject_test
> > > > because it placed a "pop rbp" instruction after vmmcall.  While this is
> > > > correct and mimics what is done in the VMX case, this particular test
> > > > expects a ud2 instruction right after the vmmcall, so that it can skip
> > > > over it in the L1 part of the test.
> > > > 
> > > > Inline a suitably-modified version of vmmcall() to restore the
> > > > functionality of the test.
> > > > 
> > > > Fixes: 8fda37cf3d41 ("KVM: selftests: Stuff RAX/RCX with 'safe' values in vmmcall()/vmcall()"
> > > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > ---
> > > 
> > > We really, really need to save/restore guest GPRs in L1 when handling exits from L2.
> > 
> > +1, the amount of stuff we do to workaround the shortcoming (and time
> > we waste debugging) is getting ridiculously high. 
> > 
> > > For now,
> > > 
> > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > 
> > 
> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > 
> 
> I didn't notice this fix and also found this issue.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Best regards,
> 	Maxim Levitsky

Seems that this patch got through the cracks,
pinging so someone else won't need to debug this
test too.

Best regards,
	Maxim Levitsky


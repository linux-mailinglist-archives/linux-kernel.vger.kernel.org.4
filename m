Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD82691C06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjBJJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjBJJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDEB728BD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676022924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlYTQ4KlxOnSSgOz5EYIJQVx78dcnp/7ObBZhHdZOfo=;
        b=MMnTD7P72+d70wWHQO4HHyVB/+03AUbMAetgdCMA8FkSqijwgy6u/Fmfvs3r76LFDYjTnX
        Dd+1rXj8WWAdVIFY7EPQR7Cbmr9riu6JUDV2auBKxtkDdUBER/MMciAQ1tOpKiqvVLn3QR
        gEGGVC4TMHUjX2QQO2hiX9OPL8Zuack=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-HS8_LSPpNDmYARx6j44laQ-1; Fri, 10 Feb 2023 04:55:22 -0500
X-MC-Unique: HS8_LSPpNDmYARx6j44laQ-1
Received: by mail-ej1-f70.google.com with SMTP id l18-20020a1709067d5200b008af415fdd80so2683168ejp.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlYTQ4KlxOnSSgOz5EYIJQVx78dcnp/7ObBZhHdZOfo=;
        b=ie5R1uyF8pO8/xCW3b43fScwgIGeShpUfshW1ntVkB+NFv0jZ/HKHaoKlOkA4YPdLo
         Y0T0ZFAIvoeqJj34jVXOTN1jj7zfvk3iMArwDjRLFXkcdi6glnNXc+p7Qg2nqbap04Eq
         zAaSEwVVc+76BLXdGKR+nyvmQCjGRqeL0ISKu4IW2MGCG3hiUNRdhy/KEgxj7LsCAFHH
         jt5xhoP7HoXL4jp946wqcMyGes2JOSZqLc1UwsWQ3y6pmzbTAXGBRV2dJLQVTPE1sFEc
         zi2bMAlVygP5HgNxHBeYOdtvSzIwHVK/oU6qruDUpBDq38uYDStRoAUaTEjsYMnIDG8O
         PZOg==
X-Gm-Message-State: AO0yUKVijABXbl7OPX5vmNJ6YjKzuCPjhkTQyVX+/bpRftdmjRJfrINV
        QVuqqOZOshM/Y0cKubTc1kBGbCph1oo4dWm9dxJd3gojnxmsA9D5wvl1kn6gpws51ySNGGtSzA/
        SrsB9b71b3UdJU4N/Emq4NDIp
X-Received: by 2002:a17:907:8e86:b0:8aa:33c4:87d5 with SMTP id tx6-20020a1709078e8600b008aa33c487d5mr14015959ejc.10.1676022920963;
        Fri, 10 Feb 2023 01:55:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8l6KUkKlyqNem1AZE2/KhW2JD0JqV9K6hSx1e0fgBDbFsSiIPL5QzIdySg4c0oOxOTyn5rmw==
X-Received: by 2002:a17:907:8e86:b0:8aa:33c4:87d5 with SMTP id tx6-20020a1709078e8600b008aa33c487d5mr14015949ejc.10.1676022920808;
        Fri, 10 Feb 2023 01:55:20 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b007c0f217aadbsm2140397ejr.24.2023.02.10.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 01:55:20 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Stub out enable_evmcs static key for
 CONFIG_HYPERV=n
In-Reply-To: <Y+WaN8wW1EOvPbXe@google.com>
References: <20230208205430.1424667-1-seanjc@google.com>
 <20230208205430.1424667-3-seanjc@google.com> <87mt5n6kx6.fsf@redhat.com>
 <1433ea0c-5072-b9d9-a533-401bb58f9a80@redhat.com>
 <Y+WaN8wW1EOvPbXe@google.com>
Date:   Fri, 10 Feb 2023 10:55:19 +0100
Message-ID: <875yc97sl4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Feb 09, 2023, Paolo Bonzini wrote:
>> On 2/9/23 14:13, Vitaly Kuznetsov wrote:
>> > > +static __always_inline bool is_evmcs_enabled(void)
>> > > +{
>> > > +	return static_branch_unlikely(&enable_evmcs);
>> > > +}
>> > I have a suggestion. While 'is_evmcs_enabled' name is certainly not
>> > worse than 'enable_evmcs', it may still be confusing as it's not clear
>> > which eVMCS is meant: are we running a guest using eVMCS or using eVMCS
>> > ourselves? So what if we rename this to a very explicit 'is_kvm_on_hyperv()'
>> > and hide the implementation details (i.e. 'evmcs') inside?
>> 
>> I prefer keeping eVMCS in the name,
>
> +1, IIUC KVM can run on Hyper-V without eVMCS being enabled.
>
>> but I agree a better name could be something like kvm_uses_evmcs()?
>
> kvm_is_using_evmcs()?
>

Sounds good to me!

-- 
Vitaly


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D160C899
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJYJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJYJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206E9C2F0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+c6bP909bJHcHOCGyo96Lvt6YOrc+6UqMGU5ShIzww=;
        b=PS2lXyUHw93bOBF/6CZxcTGKi5ZF19dALBpVG02sxOEDXszCP8f/lEiLfQ9IQ2n4h1UmXj
        r065ltN7vsPrXO9qAFFDdMQfvVQgOwn3nJhkd2PQjBSrP/46JJmtxd0gafRfx3F6urw0xd
        g7NS0oUk3NveNp32Jh3CYkKJX/xHLj4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-HrBpxlG1OI2Uzy3oovyHuQ-1; Tue, 25 Oct 2022 05:42:40 -0400
X-MC-Unique: HrBpxlG1OI2Uzy3oovyHuQ-1
Received: by mail-qk1-f197.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso11143821qkp.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+c6bP909bJHcHOCGyo96Lvt6YOrc+6UqMGU5ShIzww=;
        b=3cm2bkhWdUwMR+wRDnoz03lS+9R3v9TQcLHbDnfHYsJEJpA40lRWlICyg3q6cC2f3W
         8STnkM+Z3HIIgM6d4WLUhfXQELw6u+PibiSf3vj+OMz1Z9NGrwUPOjvnv3wdAi1O52Xd
         y75S0qY7aPsMV2NpfHED/qJ31lCuHWLkwtIOHeSMQwYtZZdx+dRTboxdY88m1Uyoc9qr
         0ia6SrFBxpRi2RbY3DHGJ6sxA4CQO+47jQ+CjOJGdCQkph269pUJShvLBy66ZmTc26Fc
         RfsNXFjul1+2M+Ycf5/37+L07IbVHAd+1eV0xHn7ubkpjgpmMsdngkGE/q88glBp2hNJ
         uLvw==
X-Gm-Message-State: ACrzQf2RQc39sTmbts7pyhc+wFJh0yjpzktmG67/Z6Udwb2z8gJXkK8U
        xYn50v3oTi7sXcAYuyTRL5JSsw+xuGHYTliOHNtVhcRzHAE+GO9DHvslAjhS3rXfd4S9In7dDfM
        5FbgMwFEeBP4VafAvfucpd55u
X-Received: by 2002:a05:622a:1183:b0:39c:606d:1f7f with SMTP id m3-20020a05622a118300b0039c606d1f7fmr30963747qtk.313.1666690959641;
        Tue, 25 Oct 2022 02:42:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4u4PBjKEkxQAZBqNdtmV640oUq7rIw3hrHhUko3dJRZj5WH1kjJbMhGjw6D/OpPCGm27OjAg==
X-Received: by 2002:a05:622a:1183:b0:39c:606d:1f7f with SMTP id m3-20020a05622a118300b0039c606d1f7fmr30963731qtk.313.1666690959355;
        Tue, 25 Oct 2022 02:42:39 -0700 (PDT)
Received: from [10.201.49.36] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.googlemail.com with ESMTPSA id x7-20020ac86b47000000b0039a372fbaa5sm1317028qts.69.2022.10.25.02.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:42:38 -0700 (PDT)
Message-ID: <58d6167b-e1bd-df9f-5518-3173a9ab0581@redhat.com>
Date:   Tue, 25 Oct 2022 11:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] KVM patches for Linux 6.1-rc2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20221023174307.1868939-1-pbonzini@redhat.com>
 <CAHk-=wgL7sh-+6mPk7FGCFtjuh36fhOLNRTT0_4g3yd380P0+w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHk-=wgL7sh-+6mPk7FGCFtjuh36fhOLNRTT0_4g3yd380P0+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 00:15, Linus Torvalds wrote:
> 
> compat_ptr() also happens to get the address space right (ie it
> returns a "void __user *" pointer). But since the non-compat 'struct
> kvm_msr_filter_range' bitmap member doesn't get that right either
> (because it uses the same type for kernel pointers as for user
> pointers - ugly uglt), that isn't such a big deal. The kvm code
> clearly doesn't do proper user pointer typing, and just uses random
> casts instead.
In general KVM ioctl arguments very rarely have __user pointers in them, 
so there's not much need for compat ioctls at all.  KVM_GET_DIRTY_LOG 
and KVM_CLEAR_DIRTY_LOG get it right, but this one indeed can be 
improved with compat_ptr().  Will do for 6.2, thanks for the review.

Paolo


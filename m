Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F1725BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjFGKip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1921712
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686134275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vq4iY/12EDFCis/q0y3yHnpWxZ9O8Sy8phj5VJevVR4=;
        b=gsFt6puerqaD4wYESCv8+vdOvkeLqHIXELUFW0VcYE0XeXXi/tcj52xOy/tOQUzJhHmHdV
        wzloVmhNrbl7Z3q96OPX/M1jUPQE2KIywAHRc5A/2gz+Zqb0IOS0nawY9AIBSXPOlydcos
        tkeOhPRFwgVvI77aR/TiQkjUsFx7Qos=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-AedhZKB6MneadNw8t39Asg-1; Wed, 07 Jun 2023 06:37:54 -0400
X-MC-Unique: AedhZKB6MneadNw8t39Asg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-514a6909c35so792011a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134273; x=1688726273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq4iY/12EDFCis/q0y3yHnpWxZ9O8Sy8phj5VJevVR4=;
        b=c1SziSqZZkg0i7U5iXZm1qs6g0roF2ebuWEnfFsTd6DaxRdZlKogzOJ4N5GCYZ91av
         kAaQNyoSLfUuVArQ46uyKqnfA94eE6DbUUX/gdZ3cVokAfbGpsTWQtyJlLd3b4jMdGAg
         Wo1wKXCTW9XUu/iKgc04d+rG7iZYwgaxw+6RSBVkxVgjB7vvihpqEGb145ZRppeumnO0
         G/jOTZ/xkzkVfJuoQwjH4W9kRXcPMujqQfu+3v5SmLvTjDFy7J7LcU62S6XDMohKO8AY
         HK+MHOPkpMrz6qMyDBasbSL8SS6bCpGKgr/0lWyA//6TUFFAcjDy7REyvs/RC4yA84zg
         mNSw==
X-Gm-Message-State: AC+VfDxLz3S2tvpJG8x0O7hJsWdNb6qsTdIlKzlRI4YKs2xyeq8HkZAF
        jF0c/60dx4VZrjasGpl5sNaaa/txTqL3zmfBFq9wmzKVjiO7lz07CgKBeoyjMZTRRmQue8Tu5nF
        IzOsBPBQcSBsAciGfdk/OFf+F
X-Received: by 2002:aa7:d7d1:0:b0:516:9f47:5390 with SMTP id e17-20020aa7d7d1000000b005169f475390mr807629eds.27.1686134273070;
        Wed, 07 Jun 2023 03:37:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A9F7RygbWZFa68FEkMZz7F3vyq3rRZdc9t9YQhLQsarizrxtkW3i6VktegV0WsNVP1BDN7w==
X-Received: by 2002:aa7:d7d1:0:b0:516:9f47:5390 with SMTP id e17-20020aa7d7d1000000b005169f475390mr807618eds.27.1686134272818;
        Wed, 07 Jun 2023 03:37:52 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id b13-20020a056402138d00b00516654bf182sm2841294edv.41.2023.06.07.03.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 03:37:52 -0700 (PDT)
Message-ID: <5283b17c-185b-a37f-84e2-dcd08e042ec0@redhat.com>
Date:   Wed, 7 Jun 2023 12:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [ANNOUNCE] KVM Microconference at LPC 2023
To:     Babis Chalios <bchalios@amazon.es>, KVM list <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>, Alexander Graf <graf@amazon.de>,
        "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
 <150e1ad0-3d59-762b-6032-897d5630a3bf@amazon.es>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <150e1ad0-3d59-762b-6032-897d5630a3bf@amazon.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 12:13, Babis Chalios wrote:
> 
> 
> On our side, we 've been working on providing ways to let VMs (kernel
>  and user space) know that they have been cloned/snapshotted/restored
> from snapshots[1].
> 
> This is tightly coupled with PRNGs both in kernel and user space and
>  there needs to be some collaboration with random.c to tie everything
> together [2][3]. It sounds like it could be a good fit for this MC
> (?).

Does the VM generation ID ACPI device from Microsoft work for you?  It 
is not tied to Hyper-V.

Paolo


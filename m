Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8467B415
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjAYOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542759569
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674656254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZZP2VQ0m7L+P6Wmzdw4rMDbBVAh0dCyfGR86LB0pbA=;
        b=Gkhq0nTTGdiPv4M8cvn6mTWZfPqYj2awRBmqHOSlDGJ5f6+u9e2QTth8m58fGUmiOj64ml
        7F5OLkX585ejiICaHCjLQq+NrprUlPkCVVIJl8+Wto0cgwXa3J/NqeGSGnp3i2gL1PsGoy
        /6+qkNz+Ya7Xp3DB3f5mWpUwO5uICq0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-lAzBzac0OmKbx65RTKEaIw-1; Wed, 25 Jan 2023 09:17:33 -0500
X-MC-Unique: lAzBzac0OmKbx65RTKEaIw-1
Received: by mail-ed1-f69.google.com with SMTP id y2-20020a056402440200b0049e4d71f5dcso13038148eda.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZZP2VQ0m7L+P6Wmzdw4rMDbBVAh0dCyfGR86LB0pbA=;
        b=swnucye4KyOFjsgHI3srRa8xS7lLKaFVNMwCSA3qnfBQhnvYfdbsa4Fw8pvqRO1m00
         Tvvfu2v/vPVIzdFOFIz2h5eTZ02QFmeumyngvv7/fs4J6tCdWrERiqrRS58XZQuvu1xV
         voEVXv8YolbxmdwM+kAR9nqEPH9mRx1FU8uhY0j+mqI1Xi4SouRju04/JDomWNaLFR7Q
         RJTra4wMjyFif6XWxPN/WtmLcDhwk11u93beyf3vb+NVRv15hS9riiuJPyt+I257GobP
         fUSBn/K9m/BStDMWF08B8P87GpJiF1Mp9HvmNnrWS7LhZRkMR9oBR4r8eme/h/B1oNMQ
         XEQQ==
X-Gm-Message-State: AFqh2kqzZBIxpR7ObRDtUYf2BWBYaCIjn6HjXpmGhe6BeLerK1vRo0eo
        ANB239hS6vI5z6Xr9iNvGprZYQ9DkctLeTGji6aZc+nxJpXcss90DXURQrVhcqhH873Xp2vmZSr
        vgHUOF8AE7EDYXub194GzijJf
X-Received: by 2002:a17:906:8d08:b0:86f:e30c:72c1 with SMTP id rv8-20020a1709068d0800b0086fe30c72c1mr36842648ejc.8.1674656252044;
        Wed, 25 Jan 2023 06:17:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvBj7aU+14YJWcR++IIkzUaO6+QpEeJ1D/PdS8A9NhCEiPJCG7mo9mKIV50EbEdgEk9NeteVQ==
X-Received: by 2002:a17:906:8d08:b0:86f:e30c:72c1 with SMTP id rv8-20020a1709068d0800b0086fe30c72c1mr36842629ejc.8.1674656251863;
        Wed, 25 Jan 2023 06:17:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id da14-20020a056402176e00b0046dd0c2a08esm2420415edb.36.2023.01.25.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:17:31 -0800 (PST)
Message-ID: <3a23db58-3ae1-7457-ed09-bc2e3f6e8dc9@redhat.com>
Date:   Wed, 25 Jan 2023 15:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, stable@vger.kernel.org
References: <20221027092036.2698180-1-pbonzini@redhat.com>
 <CALMp9eQihPhjpoodw6ojgVh_KtvPqQ9qJ3wKWZQyVtArpGkfHA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Do not return host topology information from
 KVM_GET_SUPPORTED_CPUID
In-Reply-To: <CALMp9eQihPhjpoodw6ojgVh_KtvPqQ9qJ3wKWZQyVtArpGkfHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 00:16, Jim Mattson wrote:
> This is a userspace ABI change that breaks existing hypervisors.
> Please don't do this. Userspace ABIs are supposed to be inviolate.

What exactly is broken?

Part of the definition of the API is that you can take 
KVM_GET_SUPPORTED_CPUID and pass it to KVM_SET_CPUID2 for all vCPUs. 
Returning host topology information for a random host vCPU definitely 
violates the contract.

Furthermore, any existing userspace should be prepared to deal with 
nonexistent host topology leaves.  If you mean that said userspace would 
now pass no topology to the guest, that's not an API change either.

(Now, there are certainly other parts of the KVM_GET_SUPPORTED_CPUID 
contract that should be specified better.  But that should be done for 
each leaf one by one, which I intend to do, and would not extend to 
these three host topology leaves).

Paolo


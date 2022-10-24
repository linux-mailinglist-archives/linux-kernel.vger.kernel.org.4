Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B260B5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiJXSod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiJXSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CC14FD1F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666632258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYYeY6WmbISjt57nThyLXvb2Wb4vuO7aGaq3NhLmbyU=;
        b=UsejURkf8K6SER+SzL5EQRMCu7Fs7v+EgH0PjBl+QvqNzTAVYkonswgKHD5+0c9VEWwm7u
        QiKx3vZepez8+Xs39gma+5vvV2Oe0HbcU30YrE94K10RNp9dMSvov0irjquPrDBbe8PVE0
        haUJAByFEkAqnxc84bOxnxQ1ObAOWfE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-sQQxIzEzNXe0t1I1O_AOeA-1; Mon, 24 Oct 2022 08:57:37 -0400
X-MC-Unique: sQQxIzEzNXe0t1I1O_AOeA-1
Received: by mail-qt1-f197.google.com with SMTP id br5-20020a05622a1e0500b00394c40fee51so6994375qtb.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYYeY6WmbISjt57nThyLXvb2Wb4vuO7aGaq3NhLmbyU=;
        b=ofsKCT+TOgU9KrVUecDTQ5VmysZfUjsfdfBKY9rQbmgjGYzwgGgphglDNjPlGsQFIa
         8Jya+lE/IbhSco332/fREjLQBVLSxO7ei7ATbptOaJtr1taYGGyim7m84VittHWXhEkQ
         8a2Cql1Djs0bnzfKudkV81+lFt3R2QTn38GrPIRx7+047diL9Hw8cO5602giTvpjGsea
         +vDg2xBj+lxdpP6CpIV2dymx60cQ7WiL1FTeezyxF0VFN/XMdPgFm4nNYhxv+pDPNvop
         AyaP32nclxWT1EjMHxJdKcoexzCuu6W9k3A0+9F1UBmUbdgx6EaCXqqdhJU/PESfyYOb
         gClw==
X-Gm-Message-State: ACrzQf3U2cErZGl4aQk9s1wQNjKbY8eppSoUN8GAlk/kwk6sBJUKFRTF
        FoWt1cqDUWDVD0+XC2FzVtMnnn5Ov0sr9uIqHK9PTMAPdvG1so91fUmJK/hjwUXMgODZHkhq4pO
        4KSYNggSU2m8jHNR8u9p12Cn2
X-Received: by 2002:a05:622a:5cd:b0:39c:fcaf:7b36 with SMTP id d13-20020a05622a05cd00b0039cfcaf7b36mr23058061qtb.117.1666616257083;
        Mon, 24 Oct 2022 05:57:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7WC/42UgfWTDRy7m+TsBLfPQ7a53w+oMwbp6Q5j9cwx09EhMTQrNFPl7veBJ1xcH6Q+Absww==
X-Received: by 2002:a05:622a:5cd:b0:39c:fcaf:7b36 with SMTP id d13-20020a05622a05cd00b0039cfcaf7b36mr23058043qtb.117.1666616256881;
        Mon, 24 Oct 2022 05:57:36 -0700 (PDT)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006cddf59a600sm14693814qkb.34.2022.10.24.05.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:57:36 -0700 (PDT)
Message-ID: <fba8e829-0d28-8f4d-a8ce-84d533009eb9@redhat.com>
Date:   Mon, 24 Oct 2022 14:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] KVM: introduce memory transaction semaphore
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022154819.1823133-1-eesposit@redhat.com>
 <20221022154819.1823133-4-eesposit@redhat.com>
 <62500f94-b95b-1e16-4aa2-f67905fab01a@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <62500f94-b95b-1e16-4aa2-f67905fab01a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23/10/2022 um 19:50 schrieb Paolo Bonzini:
> On 10/22/22 17:48, Emanuele Giuseppe Esposito wrote:
>> +static DECLARE_RWSEM(memory_transaction);
> 
> This cannot be global, it must be per-struct kvm.  Otherwise one VM can
> keep the rwsem indefinitely while a second VM hangs in
> KVM_KICK_ALL_RUNNING_VCPUS.
> 
> It can also be changed to an SRCU (with the down_write+up_write sequence
> changed to synchronize_srcu_expedited) which has similar characteristics
> to your use of the rwsem.
> 

Makes sense, but why synchronize_srcu_expedited and not synchronize_srcu?

Thank you,
Emanuele


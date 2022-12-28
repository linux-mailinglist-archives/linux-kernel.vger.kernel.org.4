Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532246576E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiL1NWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1NWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C4F007
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672233716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoX0fOYy2BDjN7WWcv2XIAfkcDcckcAo0GBCFxmkNWU=;
        b=fssd/2wDD432zej+UDpql3mB5+yBKcGNhPiZPdKcOF+ZgLjtwel1V/bUjaf+YzOTGUBX3f
        XugrPRNxcvfaWkX7tC5X5gK+gRPtSoF8MBQWOcl1nYYiVMzF1ku9ae5xz5iJ/kgedhZT54
        mbY/hhAS90pexNj7P89Lww6+jdtxSSI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-w9eHhjQePMiFoD9FtLOhXw-1; Wed, 28 Dec 2022 08:21:54 -0500
X-MC-Unique: w9eHhjQePMiFoD9FtLOhXw-1
Received: by mail-ej1-f70.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so1097919ejb.19
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoX0fOYy2BDjN7WWcv2XIAfkcDcckcAo0GBCFxmkNWU=;
        b=V86e9EFWSRGZTQl1yrxcbLJ9Ye6jMMJRWwwcoM8ovaQC78V6tggFSGFp24lrDGIDLW
         QSHvPajHY7h8SS0BIjoD+jPmpM6bQH3Yu3nHOrezoKnc2GSj7U00Jfd0EsUEg25VSpml
         AQ0VLzLc1TmOu52+IyICvOdXfHCNH/Qj7daCFBNKtBKeIaOaT6G+xLT46PhKn55E9pRB
         n9FwtJVkbmWQO7/DKPKnku0i5iY5RSSJ/4lES1w49N16X83rDKtkfTRb9392C7uAhMim
         KaMFD1OTo6vceEzq9i5XTVupIfJsI0G5+hJOCB2g/QNEVUpsHLBD5DgbMFnhYSamPO81
         nKcg==
X-Gm-Message-State: AFqh2koriczKG4oHTNb/wv4Bc7wlVdJaBVFz+iWDSUbA28uninJE8zVE
        XyF1KHQZGME7qVJe6P7AGEy7+wbQYWVRpEk2NxNTSfvdGBQRpTrNr8Mvat6i6LnfLtjbx+YFvyV
        vRCKn0XGbuMXWp3jxhBoNQDl/
X-Received: by 2002:a05:6402:1609:b0:467:7775:ba8 with SMTP id f9-20020a056402160900b0046777750ba8mr22203170edv.1.1672233713542;
        Wed, 28 Dec 2022 05:21:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVQlyzIJlKOMVRWcRmu37jM2MJz8kjJirNUFMEGIsarUaKwr0SRSD4p42iR/9N9MpLeGEVfA==
X-Received: by 2002:a05:6402:1609:b0:467:7775:ba8 with SMTP id f9-20020a056402160900b0046777750ba8mr22203160edv.1.1672233713355;
        Wed, 28 Dec 2022 05:21:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id dn5-20020a05640222e500b004610899742asm7170937edb.13.2022.12.28.05.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 05:21:52 -0800 (PST)
Message-ID: <3619dc3b-d1b9-ab76-a008-2c45799d5803@redhat.com>
Date:   Wed, 28 Dec 2022 14:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>
References: <62d7c91f-1486-4aea-8764-352efb383326@email.android.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
In-Reply-To: <62d7c91f-1486-4aea-8764-352efb383326@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 12:55, Woodhouse, David wrote:
> 
> IIRC the send_port and type aren't used from hcall_send so we could 
> stick those in a union with a 'next' pointer and use it to build a list 
> instead of having to allocate the array (pathological worst case 32KiB).

Yeah I thought about using a list.  The union is doable as you say, but 
I wasn't sure if things were going to change in kvm_xen_evtchn_send later.

And the worst case is order 3, which is within PAGE_ALLOC_COSTLY_ORDER, 
so I decided to go with the array which only consumes memory on reset 
rather than always; it's much more likely that the array will be smaller 
than a page.

Paolo

> Or if the union is a bit icky, we could just add the 'next' pointer 
> unconditionally.
> 


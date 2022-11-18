Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B462F046
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiKRI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41316EB7F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668761842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0ERrz7JCn9BnDY0Ayxan7lnfD5vEWFwGFrA85kPodc=;
        b=OgUb7Rrvd0S/1tG9DsbgoEtyLBNYbCxqqbYFJDbu35hqQZr+wJtAgx+w6bHE4eJ5qICerB
        PrUVi5E4XJ3R+fwhh48R+uyH9MRTyR0deqnoNeQqWHjDMXZH/jSahOOlZYNILqGReO7bUD
        +MDfdnfgesbPwedipXYp9OSr/kKJZUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-3H1xl5MJP7K-GWCrG3znDA-1; Fri, 18 Nov 2022 03:57:21 -0500
X-MC-Unique: 3H1xl5MJP7K-GWCrG3znDA-1
Received: by mail-wr1-f69.google.com with SMTP id w23-20020adf8bd7000000b002358f733307so1332931wra.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ERrz7JCn9BnDY0Ayxan7lnfD5vEWFwGFrA85kPodc=;
        b=n++0kjTpajodD7o80T6LiMc+I9gT76pOU4fETF/alGYCHzFR9oQJY71g52JzbURPuc
         zgxpPMpGIswEl44LzSNHcvxCngNEkOmwKdDPvgZ4ShDB7rjnoKAxSI4FUoEkpLCQ3Xwv
         3VeqQ7BCCmg5OTO7l4EVBJWqlSPQgLLsouv5mvtQu56G2kb3GcK6vFP3+88nsRk/n6nT
         kt67cRD8bDhuJtUIenlMUpGSfFM+kVTRXIlendi7mPrsnOistMqRkOZG1YDOBBsTDzsg
         hWSew5PhZHIZhh//jj3loKvZ8r0Y0GmIMAsuZUELEcztFA2bE4raLObwpWpqEJuHDfzA
         t+Sw==
X-Gm-Message-State: ANoB5plPObf9kIRDnPmcU6zqMNZaTJi1ojHbmGxFG9BzwlCsMsUJpf/k
        B910dcbysiS9X0nKeKwtyBayL5a4+rYWzUAKRQYnVSwD8wip5Yup7gULCkTtC/dfMZDsma1zZ92
        e1Kzo8v+ESPctcTjIvr0v3vER
X-Received: by 2002:adf:facd:0:b0:231:482f:ed6b with SMTP id a13-20020adffacd000000b00231482fed6bmr3694257wrs.253.1668761840126;
        Fri, 18 Nov 2022 00:57:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50oZR0yD/v8/9UR7ki7wIw/KZLKr9m6FVoEPYMGY5P+v3sgErCbw58kQiRgWrcKNl7n+7VHQ==
X-Received: by 2002:adf:facd:0:b0:231:482f:ed6b with SMTP id a13-20020adffacd000000b00231482fed6bmr3694247wrs.253.1668761839750;
        Fri, 18 Nov 2022 00:57:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:f500:6512:fac3:2687:15ff? (p200300cbc704f5006512fac3268715ff.dip0.t-ipconnect.de. [2003:cb:c704:f500:6512:fac3:2687:15ff])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c024600b003b50428cf66sm3709552wmj.33.2022.11.18.00.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:57:19 -0800 (PST)
Message-ID: <16759fd4-3a8c-b52c-20c3-9a9129f26799@redhat.com>
Date:   Fri, 18 Nov 2022 09:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] exec: Remove FOLL_FORCE for stack setup
To:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118003410.never.653-kees@kernel.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221118003410.never.653-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.22 01:34, Kees Cook wrote:
> It does not appear that FOLL_FORCE should be needed for setting up the
> stack pages. They are allocated using the nascent brpm->vma, which was
> newly created with VM_STACK_FLAGS, which an arch can override, but they
> all appear to include VM_WRITE | VM_MAYWRITE. Remove FOLL_FORCE.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/lkml/202211171439.CDE720EAD@keescook/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for looking into this!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


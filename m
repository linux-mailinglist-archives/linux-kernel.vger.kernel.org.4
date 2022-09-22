Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFA5E6608
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIVOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiIVOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C858B7D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/9pBsgmOfMIOWdQk6MlBb5rIEq71XELNQZdnKY333M=;
        b=PRngVALWt0fiLbd1zdMqclsBCY6QG3jlvaBKCmXLhhYZeoBk7XDCd8h8KEjefdGQkrfaNo
        8rhUxlp3Ax9KH3hLD0oMw5VN5SkRWtXqB7J4hkA7fMB2aF8KfxrHfI+2cu4FtejqEXJUud
        DOnJ2fxcCcmdfvh/CzB7utyF2EPiWRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-03_lwKTwNlyFfKtvFa1Gbw-1; Thu, 22 Sep 2022 10:41:52 -0400
X-MC-Unique: 03_lwKTwNlyFfKtvFa1Gbw-1
Received: by mail-wm1-f71.google.com with SMTP id 5-20020a05600c028500b003b4d2247d3eso2749403wmk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=D/9pBsgmOfMIOWdQk6MlBb5rIEq71XELNQZdnKY333M=;
        b=Jzp4UY+d4gWVJdOBEdH6I/no0xxuZ0zubrG+bCPh8qp5J9vFfHuXelQo1D7f+oJRT9
         7am4H3UqwlNWOX7jPiODwIgSZM9a6mMnIsHLMt2LeEfrC8rMTIwggW7JaxF9uRLDMfWY
         KjECDRPQmYU1PVFe0nIUmJixMZmocWpJxnil9F3R945Jh/MfTjq57k8RlcX2XTuUkMC4
         qkVIE9LqCJ/0vH87yGTV1iiXpoWy+MNLtXNbGxEg6fwQ5E2M3E8Xi2L7i39x41IUqKRQ
         O1pMyHbim/5hbRa/3QY7JXBoagr8xAPBo6xJ+7LZKSc0He3/0ZUC/uhxJPSn0UPH8e1H
         DHRA==
X-Gm-Message-State: ACrzQf2hGKQGhOAhve+1p+idq9HRzrOKN8+jauhNntupkop82PmnFt1l
        l3unzIRJAEfeCSL4idw+Ca+3PrtGHLPTDB3/nV112HH5vLQEv4QPpqUOheI4zgcLaUfCxEho0BF
        gOzqSaidKhKjGpU0siHMTcGwy
X-Received: by 2002:adf:fb0a:0:b0:225:265d:493 with SMTP id c10-20020adffb0a000000b00225265d0493mr2315214wrr.394.1663857711758;
        Thu, 22 Sep 2022 07:41:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7s2pVMK50HQj4mxZLRHO2jsgVJQFzFTuu2Qp94Zer8UgJMh/RaCJ3PGvdhnjto9D+jNlkhFA==
X-Received: by 2002:adf:fb0a:0:b0:225:265d:493 with SMTP id c10-20020adffb0a000000b00225265d0493mr2315185wrr.394.1663857711445;
        Thu, 22 Sep 2022 07:41:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2200:d595:cc20:2e3a:fc5f? (p200300cbc7082200d595cc202e3afc5f.dip0.t-ipconnect.de. [2003:cb:c708:2200:d595:cc20:2e3a:fc5f])
        by smtp.gmail.com with ESMTPSA id bv3-20020a0560001f0300b0022b014fb0b7sm5493369wrb.110.2022.09.22.07.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:41:50 -0700 (PDT)
Message-ID: <9fc9759d-ac74-ca8f-874c-5058758c3ea1@redhat.com>
Date:   Thu, 22 Sep 2022 16:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     David.Laight@ACULAB.COM, akpm@linux-foundation.org,
        apw@canonical.com, bhe@redhat.com, christophe.leroy@csgroup.eu,
        corbet@lwn.net, dwaipayanray1@gmail.com, dyoung@redhat.com,
        jani.nikula@linux.intel.com, joe@perches.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mingo@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, torvalds@linux-foundation.org, vgoyal@redhat.com
References: <20220920122302.99195-2-david@redhat.com>
 <93343c05-f31e-cfbe-6650-8ea8d79e6d55@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
In-Reply-To: <93343c05-f31e-cfbe-6650-8ea8d79e6d55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   
>> +22) Do not crash the kernel
>> +---------------------------
>> +
>> +In general, it is not the kernel developer's decision to crash the kernel.
>> +
>> +Avoid panic()
>> +=============
> This looks to me like a subsection-level title.  The adornment symbol
> needs to be:
> 
>     *************
> 
>> +
>> +panic() should be used with care and primarily only during system boot.
>> +panic() is, for example, acceptable when running out of memory during boot and
>> +not being able to continue.
>> +
>> +Use WARN() rather than BUG()
>> +============================
> Ditto.
> 
>> +
>> +Do not add new code that uses any of the BUG() variants, such as BUG(),
>> +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
>> +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not
>> +required if there is no reasonable way to at least partially recover.
>> +
>> +"I'm too lazy to do error handling" is not an excuse for using BUG(). Major
>> +internal corruptions with no way of continuing may still use BUG(), but need
>> +good justification.
>> +
>> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
>> +**************************************************
> These wrong adornment symbol confuse ReST parser of Sphinx and results in
> the build error from "make htmldocs" at this title (long message folded):


Thanks,

the following on top should do the trick:


diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index e05899cbfd49..9efde65ac2f3 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1192,14 +1192,14 @@ expression used.  For instance:
  In general, it is not the kernel developer's decision to crash the kernel.
  
  Avoid panic()
-=============
+*************
  
  panic() should be used with care and primarily only during system boot.
  panic() is, for example, acceptable when running out of memory during boot and
  not being able to continue.
  
  Use WARN() rather than BUG()
-============================
+****************************
  
  Do not add new code that uses any of the BUG() variants, such as BUG(),
  BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably


-- 
Thanks,

David / dhildenb


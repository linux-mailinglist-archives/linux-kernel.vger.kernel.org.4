Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109A6D69BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjDDREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjDDREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B77D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680627830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8sSDVvxyvnOruB+0lVJW1HHgkW7ZReKHR1WtAZfwmo=;
        b=RmUHDlDww9Iy6ca4r7B33rIJAn/MWA6dHhCvQjNd2JAnLfJlCYcrEZs2LLpeo59j0mabAY
        vcBwRj8gW5SCOfcDQlUBfQb783QPFCBO4r88wJNASwVDxZhcTtf6c7zkn6SUbaVBKyugzS
        DVheRVUZDJ5e4ekZowVLnfJ0BJJG2pM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-cUMPNVrnPxGdJoN66cAQgw-1; Tue, 04 Apr 2023 13:03:49 -0400
X-MC-Unique: cUMPNVrnPxGdJoN66cAQgw-1
Received: by mail-ed1-f70.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so46223041edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627828; x=1683219828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8sSDVvxyvnOruB+0lVJW1HHgkW7ZReKHR1WtAZfwmo=;
        b=p49A8QYefrUpAO4B1DHONi0q2M1fcmNZ0FZ8J09uELvO8wOZjt9LVHvsvuXKEh1Bhl
         D/gnod58PL2sPuIuLkDmI8lEhhKBSqEPwPKQCtuYQU22Ts0UxxKBnipatE0O3tN0H9wN
         UzqZEMUYqR8TZs6Q3v24vIao6w+utoU8eS/k13cYG4j9zdLDlrDmxAMRX5i8ST3TjQva
         /fE0X7y5St+FOcxa/ywW1GfHXlF0GaGAnfI9nc1aI86QL8/WzqSqOCdOT2QcQ4gihMVX
         Ijs/E2/t+VvP/hRKwcmj+iIklUkDnGVyS3WsIVItr+Xvn0pThgRh8qKxuE1NQN0/m/gH
         4dAQ==
X-Gm-Message-State: AAQBX9fB60jbuzR1DaIUiUyPgKHrMq8zYQXQNxeWKkf5IIV0Ol0tmcx9
        Yhzs8nP109uEYid08ymxS8BRJfnviBGL197opr51WkGuSaQ2A/98EiVVtd5tB8W7Hie62bibDSW
        Qe5Xntls0QlCaEaYfUpv/FBl9
X-Received: by 2002:a17:906:360e:b0:931:ce20:db8e with SMTP id q14-20020a170906360e00b00931ce20db8emr222831ejb.51.1680627828513;
        Tue, 04 Apr 2023 10:03:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFFDO02CFOBCMJ38oBbcfDo2OcrnEUu9Q6JgQdWEtobOV1hRzKF0iFO6xz/n2FBierAH2GMA==
X-Received: by 2002:a17:906:360e:b0:931:ce20:db8e with SMTP id q14-20020a170906360e00b00931ce20db8emr222810ejb.51.1680627828194;
        Tue, 04 Apr 2023 10:03:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id j10-20020a17090643ca00b0092f38a6d082sm6128661ejn.209.2023.04.04.10.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 10:03:47 -0700 (PDT)
Message-ID: <3591487f-96ae-3ab7-6ce7-e524a070c9e7@redhat.com>
Date:   Tue, 4 Apr 2023 19:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/7] x86/entry: Atomic statck switching for IST
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Cfir Cohen <cfir@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Kaplan <David.Kaplan@amd.com>,
        David Rientjes <rientjes@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Stunes <mstunes@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, x86@kernel.org
References: <20230403140605.540512-1-jiangshanlai@gmail.com>
 <19035c40-e756-6efd-1c02-b09109fb44c1@intel.com>
 <CAJhGHyBHmC=UXr88GsykO9eUeqJZp59jrCH3ngkFiCxVBW2F3g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAJhGHyBHmC=UXr88GsykO9eUeqJZp59jrCH3ngkFiCxVBW2F3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 05:17, Lai Jiangshan wrote:
> The cover letter has 800+ lines of comments.  About 100-300 lines
> of comments will be moved into the code which would make the diffstat
> not so appealing.

Removing assembly from arch/x86/entry/ and adding English to 
Documentation/?  That's _even more_ appealing. :)

Paolo


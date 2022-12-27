Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB496569EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiL0L0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiL0L0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599AF2B8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672140358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYCATXIRInao3igNKiE7HLwP0l5ypFCWPTUkIt/6IA0=;
        b=IIB2AqrOhSP+3BZuOa/Cm/5hwSR7fYMHcM4U1sQRfCESmBkb80j4j8DaWltr0ZjiZkfqhO
        DwKuN/Y93Pi9E9R8ufY8TztGD0KFmH4l8l5CWngvID3jogCE3K0amJFjCzihJKHwCLCZx+
        9lolv0n3Ji8WUujLgFaUKStanTiaHUA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-cm3l1r6aMgmBG8RoxkyFYQ-1; Tue, 27 Dec 2022 06:25:57 -0500
X-MC-Unique: cm3l1r6aMgmBG8RoxkyFYQ-1
Received: by mail-ej1-f71.google.com with SMTP id qw20-20020a1709066a1400b007c1727f7c55so8827630ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYCATXIRInao3igNKiE7HLwP0l5ypFCWPTUkIt/6IA0=;
        b=qKNfDgsSTaQTJ/mODcvbG7HtQhE9KT31WmPYA0Rz/NMp3FKTs75KWazBcxQvvJJtTX
         5+jPzQENE291mIoi0FGOKZgJ3o4RpyKkmJUd2CnDCGiBMaUs2e3W2sye2vnzyh6AUXu2
         gpt5xR2Y7KYWd6U90AsmRr330fVXjObXJBVWs660Kd/dDVJvFfbQXYw6IikRJM7SXhTY
         2lGvV/CDZeUmqLSqQmPA1PgbOW+uv9vkOnG/uqY5wjycrUKO0C4RdshlFf/6okuU5GNr
         m/tyGs/NknaD3t38gX7CeYw3je3iv6QWQ+Th45+m/pMr4ixnNq8ZSV5iE7OJy7Yogz6l
         5V7g==
X-Gm-Message-State: AFqh2kqRKcUOD3k23PhAfQgq12x/0i+X3SDch2C8zbwTLA7XOqZckPeu
        jMPDTv+qG1CNB8w9meLAkHFQC4BxgwRjo0m1A3nKydpKCnXRMAxYi/okr4KuS//6NCmOddMXGCT
        0qTCfmp/QubaE/V905xqRP5vK
X-Received: by 2002:a17:906:7188:b0:7c0:f117:6990 with SMTP id h8-20020a170906718800b007c0f1176990mr18263827ejk.41.1672140356091;
        Tue, 27 Dec 2022 03:25:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuTP7i93tBCwXyLQpLIXG+XCM2m94bERKbwavktfnegZNG48TOZveL25h7nVRU130zhxlAa4Q==
X-Received: by 2002:a17:906:7188:b0:7c0:f117:6990 with SMTP id h8-20020a170906718800b007c0f1176990mr18263820ejk.41.1672140355863;
        Tue, 27 Dec 2022 03:25:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id y26-20020a1709063a9a00b0078c213ad441sm5883575ejd.101.2022.12.27.03.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:25:55 -0800 (PST)
Message-ID: <f37873fe-0340-e50c-a168-1b9ee12de890@redhat.com>
Date:   Tue, 27 Dec 2022 12:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 11/32] KVM: x86: Inhibit APIC memslot if x2APIC and
 AVIC are enabled
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-12-seanjc@google.com>
 <90d4a2a1733cdb21e7c00843ddafee78ce52bbdc.camel@redhat.com>
 <Y5zBH+2VuPJi4yYV@google.com> <Y5zJraa0ddooauXB@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y5zJraa0ddooauXB@google.com>
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

On 12/16/22 20:40, Sean Christopherson wrote:
> I was hoping to have a name that communicate_why_  the memslot needs to be
> inhibited, but it's turning out to be really hard to come up with a name that's
> descriptive without being ridiculously verbose.  The best I've come up with is:
> 
> 	allow_apicv_in_x2apic_without_x2apic_virtualization
> 
> It's heinous, but I'm inclined to go with it unless someone has a better idea.

Can any of you provide a patch to squash on top of this one (or on top 
of kvm/queue, as you prefer)?

Paolo


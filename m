Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF29609545
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJWRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJWRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92C66F01
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666547464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D09MWv0UvzUmBKDXwZPzEI59Y82igwH0mMVX8RFHjcA=;
        b=aQzzLjX4iX6ezs4ddlC8he+MZN+dsUrDB3Ly8XOFRWsLa2j/NbnwI1KqE+FioSpViA20Dn
        gk9nD+5/kWUatSoi2m00Wo4CxPSma2ygnWkLIwHw4JYk6DfCeUY9nT/0IjLQ1SlYq+YT+6
        gZk0CK/4JDeXszt1VU131FdRf2uXlEY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-487-YsNnthgJNv2fGCp3EVdXHQ-1; Sun, 23 Oct 2022 13:51:00 -0400
X-MC-Unique: YsNnthgJNv2fGCp3EVdXHQ-1
Received: by mail-ed1-f69.google.com with SMTP id y10-20020a056402358a00b0045d5cf18d4cso7350589edc.17
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D09MWv0UvzUmBKDXwZPzEI59Y82igwH0mMVX8RFHjcA=;
        b=oUiOrmkoXYBWYlIV8xl9PQ7HTRP5BTwwaHrU4/pJcHfb2bnjCr/bdPyMpv2QqeJa3e
         h8LIClQKUi1SxYq2ddMmFZnJbMURozce8J3Irt+GjkJ2ap6iHkOHyGJrzG4D2yRY6a8q
         SXkiZU0Fp6J/MEj8zfBet69yg/EA/UY98tx261+XUjYH2s6l9UPnYM4sgQCqnKlrYOBg
         eNqBon8fZC1HkCdOB1ajK9FZ731xsrAm9zXtXhkdj/5luVrv5DnTmW7Sr+DTvejWBpyM
         lqZbV/jFJsXT3sdlfjMVijAor6Bxb+DgAUm65DHxgbJ17z1+1Yu0TCmUHU3VR8j3/PSQ
         I2zA==
X-Gm-Message-State: ACrzQf0Khd4P+jjhX5uRY+aLTvMCu9QqRh3jLtnQXrmebikxo40aAmGz
        dAv1W9LXXSrc9jZMffm9jtvGzct2qYvfWFL015v238fFZC28ZlhCnTCX+iRCFrs6AG+Aa50Rnrv
        v5cvMAGaQzaeA1ejaV+0QKtzi
X-Received: by 2002:a17:906:846c:b0:7a5:ccb:c174 with SMTP id hx12-20020a170906846c00b007a50ccbc174mr3298670ejc.583.1666547458596;
        Sun, 23 Oct 2022 10:50:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lselhb4mBLW2XIV0vJT8VL/BMXi1ZtLK17hfsJ/qDg+TASFANunS0l1JbfqLOFrZxQJtg7g==
X-Received: by 2002:a17:907:9611:b0:78d:bb06:90a3 with SMTP id gb17-20020a170907961100b0078dbb0690a3mr24419521ejc.233.1666547448280;
        Sun, 23 Oct 2022 10:50:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id d14-20020a170906304e00b0078250005a79sm14429105ejd.163.2022.10.23.10.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 10:50:47 -0700 (PDT)
Message-ID: <62500f94-b95b-1e16-4aa2-f67905fab01a@redhat.com>
Date:   Sun, 23 Oct 2022 19:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/4] KVM: introduce memory transaction semaphore
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221022154819.1823133-4-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 17:48, Emanuele Giuseppe Esposito wrote:
> +static DECLARE_RWSEM(memory_transaction);

This cannot be global, it must be per-struct kvm.  Otherwise one VM can 
keep the rwsem indefinitely while a second VM hangs in 
KVM_KICK_ALL_RUNNING_VCPUS.

It can also be changed to an SRCU (with the down_write+up_write sequence 
changed to synchronize_srcu_expedited) which has similar characteristics 
to your use of the rwsem.

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C35F5D6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJFACk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJFACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F272FC2C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665014555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLnxttJ5cqTzzXANoD7R7Egg5KaefkmxBqgvnbxLZ7o=;
        b=Op5y3/3Wogwq5FcUdKaZ8n+2MfAu/+u9nXqF4t7aiSVSICwlnv2pmtHm+o5fP+AiqZnIf8
        rm3IJno/nhEQgXZlWLS1PIukcUJY17OWsJKuTFLQuHGYANZD+AGC+UAqmDYpYSeXG9VPG4
        0IN8YQsPsutR/cRLM4wb4XymbwJEcSQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-xkZRKJdDOlyECsEowbLuSg-1; Wed, 05 Oct 2022 20:02:34 -0400
X-MC-Unique: xkZRKJdDOlyECsEowbLuSg-1
Received: by mail-qt1-f199.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so163474qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:content-language
         :references:cc:to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLnxttJ5cqTzzXANoD7R7Egg5KaefkmxBqgvnbxLZ7o=;
        b=QiYz3dhooNmtTNa1+LdU+6oBHogp+onNI0/VpUM9w5l4756dgU3c/Cm0S32A5xWPSX
         nVTTxpz8oB4R5YjPA4wQo39Gn6ykv4Q85VrPOhRAYfUaAl4hgI+Voy5zsV63Ry/ZKQWA
         YtXEdu7no1dPSYcT2iDIJhURT6yUBPEX3QogUzOJoqIO+M7yEsz1GQLKqcc6ltCXVSAK
         kSHe92gmEfFJ+IRh88r1Muw3P4zI9rnvftsYCbD5p7pUPu+JpO6eEL72Pu+rhz9RXGRK
         LYTm3P0jeBkSURNTNX9CEK1Jqhv47qNB2TeoimhKrhisa3VdX4j6Q+I5un2S+DW8e+SY
         DwEQ==
X-Gm-Message-State: ACrzQf0f0z12i5DYMa5GDOHi3rW+/el2lHOH3xif/TrP1qWJvLc7iHVj
        IngognUBgrrLQJlJlPe0XoI1iS73SqBy6IITz10HJmRu/NNuHyb8gxXkMsSPPWmHaqTFXPmIBDe
        jVsH49uFAKLjm4LEcAk89gQX5
X-Received: by 2002:a0c:b294:0:b0:4b1:a396:d1cc with SMTP id r20-20020a0cb294000000b004b1a396d1ccmr1931748qve.107.1665014553767;
        Wed, 05 Oct 2022 17:02:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4J5dyK9AnDEZcPH91+Z4AnpysBSH+5TblQuNBD1IvApiQ1PvSTNfKK35D38Zw7CJgO9KtIIA==
X-Received: by 2002:a0c:b294:0:b0:4b1:a396:d1cc with SMTP id r20-20020a0cb294000000b004b1a396d1ccmr1931730qve.107.1665014553535;
        Wed, 05 Oct 2022 17:02:33 -0700 (PDT)
Received: from [172.20.5.108] (rrcs-66-57-248-11.midsouth.biz.rr.com. [66.57.248.11])
        by smtp.googlemail.com with ESMTPSA id r10-20020a05622a034a00b0035ce8965045sm16050036qtw.42.2022.10.05.17.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 17:02:32 -0700 (PDT)
Message-ID: <8602ab30-27e4-ae2d-d502-0f025c725801@redhat.com>
Date:   Thu, 6 Oct 2022 02:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
References: <20220930190836.116605-1-pbonzini@redhat.com>
Content-Language: en-US
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.1
In-Reply-To: <20220930190836.116605-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 21:08, Paolo Bonzini wrote:
> The first batch of KVM patches, mostly covering x86, which I
> am sending out early due to me travelling next week.  There is a
> lone mm patch for which Andrew gave an informal ack at
> https://lore.kernel.org/linux-mm/20220817102500.440c6d0a3fce296fdf91bea6@linux-foundation.org.
> 
> I will send the bulk of ARM work, as well as other
> architectures, at the end of next week.

Linus,

this hasn't been pulled yet, and I suspect that's because most patches 
have not been in linux-next for most of the 6.0-rc period, which earned 
me a place in the well-known shitlist.

So, what happened is that this is the first release with KVM/x86 
submaintainers.  I have noticed now that we have never asked for Sean's 
tree to be added to linux-next.  Sorry about that.

It is now "the end of next week", but I will wait a few more days for 
you to process this pull request, and then send the ARM/RISC-V parts.

Thanks,

Paolo


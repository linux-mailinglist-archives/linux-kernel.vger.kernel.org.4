Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92566B7D03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCMQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCMQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75C62FDE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678723471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyTlE23EmGZ1IziL094B1aKtOucRasxtiUxCQwEj/VM=;
        b=QtG4bsWjf6oiQ8NCUJZegydo6nv4daCvZG5ZhA7zHPnGXI7HYFvTveG97o8uQoNUZY/KE5
        oK8ih9VpFw7fTTTRUHxRdRdA9QwNhEgUjdlaTxo22GPQ8h6nAF3rpuzNkrvvh8SCw81MP7
        /YJWDFfUl8scWtogofHE1CRzRmK6IC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-sZdq9WsQP7y32nA9Ieyivg-1; Mon, 13 Mar 2023 12:04:30 -0400
X-MC-Unique: sZdq9WsQP7y32nA9Ieyivg-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so4351731wmb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678723469;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyTlE23EmGZ1IziL094B1aKtOucRasxtiUxCQwEj/VM=;
        b=olrEqXTAh1XPnNEZTkPuuIplWT69kMh2s6xCCuh6Q0cD0QEoPgOR29wpVZ07tmNKtK
         jFAVC3jpmlvwPBnUCKrLFL9/bgJGtP8Gwz2atAvUFLLhmPTlVaDSonjRdwbyp/Ye1j4V
         ah7Yg4AtC7EJPH/aZV3q+F9VFfozWQqCPNRadPr7KQ9yfTYhye45/HXr1C4+3jdKc3Tg
         t5T88aYGjAL1291OeKUXdSSIpCZ3eHj/JuTmEEysjqM3csNiPINXEJwROHTkpnM/Lspo
         CveA1U8xaf+Ki6ptGm1CZXf4NNuNrHOysJo9skDcOnWPVt+HONxRQtgVLuTS2nK/8SoI
         2Exg==
X-Gm-Message-State: AO0yUKUs32U+sxWrjADv4V5nGlDzKEjoV5v5TZE/g+8efYviI7u1Im+9
        TXWGerOo09pS0J/Ta5X7cOwGCh7iv9SRAEw/HINSGZYCdqN4XBYd9YdLGDZ7wvW7RRgZ/ELGSuH
        A2EM5zvoFuGmuw38VNX19RE+v
X-Received: by 2002:a05:600c:4453:b0:3eb:1432:a78c with SMTP id v19-20020a05600c445300b003eb1432a78cmr11563157wmn.37.1678723469161;
        Mon, 13 Mar 2023 09:04:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8//o209ILK+VZvcWRK74XZMCv7rPbsWwI1ZVQ9U2S8wa2pF/iZBIDNyfkXRmeD6xcZbfZ0oA==
X-Received: by 2002:a05:600c:4453:b0:3eb:1432:a78c with SMTP id v19-20020a05600c445300b003eb1432a78cmr11563129wmn.37.1678723468840;
        Mon, 13 Mar 2023 09:04:28 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6abf.dip0.t-ipconnect.de. [91.12.106.191])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003dc42d48defsm200292wml.6.2023.03.13.09.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 09:04:28 -0700 (PDT)
Message-ID: <267812a3-6576-33ce-4d41-054f6ecb812d@redhat.com>
Date:   Mon, 13 Mar 2023 17:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     yang.yang29@zte.com.cn, akpm@linux-foundation.org,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, Hugh Dickins <hughd@google.com>
References: <202302100915227721315@zte.com.cn>
 <9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com>
 <20230313151014.5e17fc19@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230313151014.5e17fc19@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If we'd really want to identify whether a zeropage was deduplciated by
>> KSM, we could try storing that information inside the PTE instead of
> 
> this is interesting, but needs caution, for the reason you mention below
> 
>> inside the RMAP. Then, we could directly adjust the counter when zapping
>> the shared zeropage or during MADV_DONTNEED/when unmerging.
>>
>> Eventually, we could simply say that
>> * !pte_dirty(): zeropage placed during fault
>> * pte_dirty(): zeropage placed by KSM
>>
>> Then it would also be easy to adjust counters and unmerge. We'd limit
>> this handling to known-working architectures initially (spec64 still has

^ I meant sparc64 here. We can (and should) have a testcase that 
deduplicates the shared zeropage using KSM and makes sure that writes 
properly lead to a write fault.

>> the issue that pte_mkdirty() will set a pte writable ... and my patch to
>> fix that was not merged yet). We'd have to double-check all
>> pte_mkdirty/pte_mkclean() callsites.
> 
> this will be... interesting

IIRC, most code that touches the dirty bit makes sure that it operates 
on a proper struct page (via vm_normal_folio()). 
madvise_free_pte_range() is one such user. But we have to double-check.

-- 
Thanks,

David / dhildenb


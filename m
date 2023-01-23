Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21507677940
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAWKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF31115F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674470012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElqFEoc0EbRc9UUN0JseQJHQuAPyVJiJ/2beNKrTrWs=;
        b=GPK/L0mM7v/ubK+43NTo2yFkja9gwJLQR7DpzyjD+cpAS4P+m19Lanamf+CgkhGXVBWhqN
        R6b+fc0SWoI8sm3LqS22L77GM4M9KIksYcX90p6fuDm4CR5XY+vEP/nUu4lRoR2EGeuhqA
        fFJrXo26tTdZCfh4D6i8EiLauUaiC18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-VwNwJErtOwW7F8Fx2jV1fg-1; Mon, 23 Jan 2023 05:33:30 -0500
X-MC-Unique: VwNwJErtOwW7F8Fx2jV1fg-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c4f4700b003d971a5e770so7292982wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElqFEoc0EbRc9UUN0JseQJHQuAPyVJiJ/2beNKrTrWs=;
        b=D9d8uFMDCNPswlpfO+z5XNiFVzZhbSx3m+dYGPt9loCYG/NIh2T6FC3lC09bTmo5gU
         npHG8HbL94n+oBwd6NyTfOFvGaokRIUUeaD2JyawQ/ELThKrEFtIKg/2xeB+dcuh2EQv
         0cfCPG2b9kaBzvjSeSSvrZZBMh/z1wu5jJ9YbPpoMUJwhVmgduXOKzXlDYhbAv4kkbHI
         OtT52p1NlxIEwRK3y/Ba+20QCBQ3YYP5gXR2f56QiKZMj4pSdFrkmLfHiVxri3AgSrj0
         kwMpNcfFMCf2RI0YsKWmaxVa+Q+QmjCCkf0u+sn5dmZF2SIqJ+e76gX2+N1xX2/4+LdJ
         gEHQ==
X-Gm-Message-State: AFqh2kqPDkmbI/BfQxMnnXoJESlbPvBDU0kOuKF2uY5LvExwEQ5BD2My
        3UYl0YTblRMTm/r1UcnXNYTUpK89rt6sbgvFJA1+1aN6Q8mfC8T42gwnleBN4qr3mfvZa6alO9M
        tqnlPfXUiXDdMZZ/mQGIJb6KU
X-Received: by 2002:adf:d0c3:0:b0:2bd:e5cb:e7df with SMTP id z3-20020adfd0c3000000b002bde5cbe7dfmr16250520wrh.32.1674470009603;
        Mon, 23 Jan 2023 02:33:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsk5G9ktr9anm6O4EXqjV/YLTZzKnz+baHLmpWrz/G0eS9BZQhooZDNEW6O1TbYbRlganruIw==
X-Received: by 2002:adf:d0c3:0:b0:2bd:e5cb:e7df with SMTP id z3-20020adfd0c3000000b002bde5cbe7dfmr16250502wrh.32.1674470009318;
        Mon, 23 Jan 2023 02:33:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm41477377wrn.90.2023.01.23.02.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 02:33:28 -0800 (PST)
Message-ID: <3842ed6a-6c9d-7909-2ab8-106cb4897973@redhat.com>
Date:   Mon, 23 Jan 2023 11:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] drivers/base/memory: Use array to show memory block
 state
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, shan.gavin@gmail.com
References: <20230120233814.368803-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230120233814.368803-1-gshan@redhat.com>
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

On 21.01.23 00:38, Gavin Shan wrote:
> Use an array to show memory block state from '/sys/devices/system/
> memory/memoryX/state', to simplify the code. Besides, WARN_ON()
> is removed since the warning can be caught by the return value,
> which is "ERROR-UNKNOWN-%ld\n". A system reboot caused by WARN_ON()
> is definitely unexpected as Greg mentioned.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


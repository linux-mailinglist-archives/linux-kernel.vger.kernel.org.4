Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84669465A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBMMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3126194
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoPnuk0eTFB4lwFXHE/o6JfLheTxlR2V4EZJdMaA1oA=;
        b=Ph1RzAIWk+tlTveaI7gjPxT1R7XrN9fBtKKLCJ/D1BVCvzAaPki8R0MXnURYdGUOkuhHqx
        NZqL7vJfUzgiS4W428dsaaTwG+PtL3ocdGocRQsXmwzChKrdMWK4pg9VlivGSjUQFVz07o
        Ei2jltpk2hcToETKnPye3Vvi5qssgF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-hkIYnPwbNhGx6MYcfQU_uA-1; Mon, 13 Feb 2023 07:51:56 -0500
X-MC-Unique: hkIYnPwbNhGx6MYcfQU_uA-1
Received: by mail-wm1-f69.google.com with SMTP id bi16-20020a05600c3d9000b003dfeeaa8143so6104467wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoPnuk0eTFB4lwFXHE/o6JfLheTxlR2V4EZJdMaA1oA=;
        b=Ehbka1wtFtzwJlOSS+ozirQIdqeCUPaVTv34oLrzOx/4tHA3XtyEA2sGfn4416y9l8
         8MtbQOUh/Gk+UCf4s3zdKI46dgWa9mfUBcckuxL1YTOFfUkMGxx1k/Zte0fHkxYZ4a/q
         0Heu0IioL/cNCYtaA8UgcZUetdCEQSlSchHlkhVFteDYpbvTQ+LrUq7MMbOFuaJ3+lY3
         9nThkjyze/L1HiDTtYSNBv80hBHodIyBtaMqbgrh7r8S1v5PPMJmcb7oATVxQaheS2Xr
         xwHWVcQ8eF1CuNmLvhGtWvaHTFnIUj9y1KLDgO7xtf6kceXCd1Lb09Oap2q/WXYEI+ku
         +JDw==
X-Gm-Message-State: AO0yUKUZhg/wN42fJ090G5427nW2JqDub+eKN6/BtwzxDPQR/qQ0gYL+
        9muRYSPA9O8q6ndZVqMp645Hw2JNFACyhiKMsjp/afGM9YmP0E9VvY+7dDagj9yuUbl2jhAXB9X
        7ZKH3OSHE+5vMGz0FbtcbjYqf
X-Received: by 2002:adf:e742:0:b0:2c5:53e4:9e53 with SMTP id c2-20020adfe742000000b002c553e49e53mr3751432wrn.65.1676292715361;
        Mon, 13 Feb 2023 04:51:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9smxW49CA0m4KiNwy7Slmijw2D6DfBOMZPymcaM4Suz+DpSuVvrTmBdSFDQlPUXY9CdP98hw==
X-Received: by 2002:adf:e742:0:b0:2c5:53e4:9e53 with SMTP id c2-20020adfe742000000b002c553e49e53mr3751415wrn.65.1676292715100;
        Mon, 13 Feb 2023 04:51:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d4c85000000b002c54d57e846sm6436559wrs.96.2023.02.13.04.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:51:54 -0800 (PST)
Message-ID: <f04b674d-93ce-7c83-601b-1badd9bde3d7@redhat.com>
Date:   Mon, 13 Feb 2023 13:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
References: <202302041443080696983@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/6] ksm: abstract the function
 try_to_get_old_rmap_item
In-Reply-To: <202302041443080696983@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.23 07:43, yang.yang29@zte.com.cn wrote:
> Thanks for these suggestions, we will take them into patch v6.

Please don't remove all context from your replies. Makes it really hard 
to follow-up :)

Further, there seems to be an issue with threading and your mails. For 
example, your cover letter [1] does not link the other patches like [2], 
for example, because the patches don't have "in-reply-to:" tags. Try 
using "git send-email", that should take care of threading automatically.


[1] https://lore.kernel.org/all/202302100915227721315@zte.com.cn/
[2] https://lore.kernel.org/all/202302100916423431376@zte.com.cn/

-- 
Thanks,

David / dhildenb


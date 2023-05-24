Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F970F1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbjEXJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbjEXJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E7189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684919553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrqSvOCbN1bUrkFrXD85UYULBUCaviBKiC2zpb1JIAE=;
        b=QfBdnrhCMayf4WmFkHpRPL45r76GKs9qHDrgyuXyfDUBagGyy9OLKh+mLaMzI+M3ZoBFLu
        N34m8ue3Yh2bH8EyTZvi0uhAe+Vyyob76TFD1e9wD8hxHtLIVSIo1wfVVNZuWgYKx4DjAf
        ibg4UgLv0tqZ3FylAM9yCF9aLpC5vsw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-YQzi5iFYMOq0QPeT2_5Flg-1; Wed, 24 May 2023 05:12:31 -0400
X-MC-Unique: YQzi5iFYMOq0QPeT2_5Flg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3062b468a36so208960f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919550; x=1687511550;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrqSvOCbN1bUrkFrXD85UYULBUCaviBKiC2zpb1JIAE=;
        b=FMxF32L2Bl34+nfjZAGL6XVxxSVMXADdYjJS1gbU02z8z74POh2oH3MxT6AsNZ8i6C
         0XtDv3OrqPTdOJ9lvKr6420nH1Mt6O8IYhivEzl/Lz3SL/nB6fvnrAk8IepH8LRbbTmz
         j0RsD1R2/PLsdZM94yIbGgXwxGSjwcbtGcHSwYkr0fSXnrWf/LwuYoZSBPlLQCrqsJc9
         yCy8/rVafVooiUEEoGIXfVxSRLSEvXA2BgBDhKyHFoviaWW/VeoJXZMlLuRp/UjyS7Hd
         HEReuTtBSTUJRV+BKa7NK/Xb4K4K6FeCNENpycK7tfOd9EC1rxfrvFOf8Gji0/pHxlfN
         azdQ==
X-Gm-Message-State: AC+VfDxIOhjGQwuq5wcpGyjJlDb32iZMwqls/D/m12gUuPVlZpfdsDgA
        Af+Xh6UNJ4lU1Wx4NU7VsU3Lu4owpdD/gFhRIl4zYnKCuywp6F+Rhcns707vowMVLaSi1iBPEQj
        ov+VBKUtmLM17+L+HORJbwGcO
X-Received: by 2002:adf:cc87:0:b0:30a:37aa:1fab with SMTP id p7-20020adfcc87000000b0030a37aa1fabmr8852633wrj.6.1684919550331;
        Wed, 24 May 2023 02:12:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KEz68EhkHsWcVdsA09XQqIpRXbaC7tJWwJQAZfHW8aAT/2OB/Js7JWIccTRjRqRb9blus8Q==
X-Received: by 2002:adf:cc87:0:b0:30a:37aa:1fab with SMTP id p7-20020adfcc87000000b0030a37aa1fabmr8852620wrj.6.1684919550092;
        Wed, 24 May 2023 02:12:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id a3-20020adff7c3000000b0030795b2be15sm13704737wrq.103.2023.05.24.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:12:29 -0700 (PDT)
Message-ID: <dbc686ac-2d28-8cd8-417b-4d10477d0f79@redhat.com>
Date:   Wed, 24 May 2023 11:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 0/5] ksm: support tracking KSM-placed zero-pages
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, jiang.xuexin@zte.com.cn
References: <202305241351365661923@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202305241351365661923@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 07:51, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The core idea of this patch set is to enable users to perceive the number
> of any pages merged by KSM, regardless of whether use_zero_page switch has
> been turned on, so that users can know how much free memory increase is
> really due to their madvise(MERGEABLE) actions. But the problem is, when
> enabling use_zero_pages, all empty pages will be merged with kernel zero
> pages instead of with each other as use_zero_pages is disabled, and then
> these zero-pages are no longer monitored by KSM.
> 
> The motivations to do this is seen at:
> https://lore.kernel.org/lkml/202302100915227721315@zte.com.cn/
> 
> In one word, we hope to implement the support for KSM-placed zero pages
> tracking without affecting the feature of use_zero_pages, so that app
> developer can also benefit from knowing the actual KSM profit by getting
> KSM-placed zero pages to optimize applications eventually when
> /sys/kernel/mm/ksm/use_zero_pages is enabled.
> 


Ran the tests and they worked as expected. I only had some remaining 
feedback for the last patch, otherwise LGTM.

-- 
Thanks,

David / dhildenb


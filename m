Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF76CFA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjC3EsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC3EsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABF1995
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680151641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WI7skcIMdsKFqr6Q4mz9+y189EcG3fURymOsrhUr7nA=;
        b=eIPh0PAlHyfHaJmEiafqQdspKdeciQflPTuKr+Jn42qJpOEBx46DEvRdWD4/34uWVzjDAL
        WsgkWgZqCIAAEbSQTKAfGp8v57vpoF5Q2ZlTCfihinesp1WT01JJZX0DDIrSCaP5WT0Q/7
        Jpp+T1R4cZCSWITkzeGMRLTkcEkTyw0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-StV1_NBQM0-CQkN_9oKK9g-1; Thu, 30 Mar 2023 00:47:20 -0400
X-MC-Unique: StV1_NBQM0-CQkN_9oKK9g-1
Received: by mail-pj1-f70.google.com with SMTP id j3-20020a17090a94c300b0024018f0656cso5377884pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151639;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WI7skcIMdsKFqr6Q4mz9+y189EcG3fURymOsrhUr7nA=;
        b=1h3mshAqovFh/4dPux3qedS1gedGhkUpJ9IUk4DWutxjS6pIxLiDdIZsO8J9otnmzG
         1s/is8p5U3j1wT/QJyS/xtrZoHsGGXYS3TDtve4uxaChlp5fQ7epxpQRXbERq1lI2AbN
         KqkRHJuSj+9hOO7HbkDXcHiR1nuLSgiUsfcHucWOGd8gRZUwhpYEz+MKg2Dq2dF7Pqb6
         P+9SWaC1mrXIRCCesxUWQCNnKdKmr1HrVoI/MaTuaXGaguQU+fiB/eubrVmXx0q8bOOr
         HmmJC/Fo8eT/7PuzoSFSpwxv87CewrY9xXQekQJIO2/vpcM/SmI8rDWG5wvHnQVGd8UV
         rTdw==
X-Gm-Message-State: AAQBX9eVVRoLvg70GlK1KD7QmiIA1V6AtW4dJQIHZ5wy9lsol175K/1G
        ZycuPtqVbCSole5ctRKJAH6G7ED+lXJz8NWsW9wJH5ZYucSd/6c/gj0Y2Y1fBZYoisn+eQEuS5V
        q6AxlDDOXdIqGclKOR1/hr/9Y
X-Received: by 2002:a17:902:e414:b0:1a1:b36d:7803 with SMTP id m20-20020a170902e41400b001a1b36d7803mr17809133ple.36.1680151638873;
        Wed, 29 Mar 2023 21:47:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aD0W9a0ga74YA+xgP3nkpy1sPD3F2aI7Cc1Mrstl29HO2k+W4VsHYLy5soMFeF3qXHSqtJwQ==
X-Received: by 2002:a17:902:e414:b0:1a1:b36d:7803 with SMTP id m20-20020a170902e41400b001a1b36d7803mr17809115ple.36.1680151638522;
        Wed, 29 Mar 2023 21:47:18 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b0019aa4c00ff4sm23856801plb.206.2023.03.29.21.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 21:47:18 -0700 (PDT)
Message-ID: <78e35d88-8a4e-3b36-bbbd-94048c0c5b54@redhat.com>
Date:   Thu, 30 Mar 2023 06:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, yang.yang29@zte.com.cn
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202302100915227721315@zte.com.cn>
 <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.23 00:38, Andrew Morton wrote:
> On Fri, 10 Feb 2023 09:15:22 +0800 (CST) <yang.yang29@zte.com.cn> wrote:
> 
>> The core idea of this patch set is to enable users to perceive the number of any
>> pages merged by KSM, regardless of whether use_zero_page switch has been turned
>> on, so that users can know how much free memory increase is really due to their
>> madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
>> all empty pages will be merged with kernel zero pages instead of with each
>> other as use_zero_pages is disabled, and then these zero-pages are no longer
>> monitored by KSM.
> 
> We appear to have some outstanding activity on this quite old patchset.
>  From my notes:
> 
> - An unresponded-to question from Claudia:
> 	https://lkml.kernel.org/r/20230307192421.30ab869c@p-imbrenda
> 
> - Hoping for overall review from David

I already shared some feedback in [1]. I think we should try to simplify 
this handling, as proposed in that mail. Still waiting for a reply.

[1] 
https://lore.kernel.org/all/9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com/

-- 
Thanks,

David / dhildenb


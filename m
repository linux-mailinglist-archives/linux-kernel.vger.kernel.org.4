Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE770D99B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEWJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjEWJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D421713
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684835476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Utz9GyNMlitUDGZqJTc8z9BwJtSeQQS1zcXV/HWkrQc=;
        b=CdGJEDrC5wADtlgFM92J75c9km4i2mFFl0comEtugNjfp51eRs74SdQ/CrzRfTOZkjTE3w
        c4L+NvjGqpvJsgnxtvDINBMhc/xfsdOo9COIVTidADTW8wKXxnpETRPB/OO6BRkfn/FvCy
        8+CbVJxYr0f3nPlgva7AnMm1EIpwvi8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-P7RPP7_ePear06HrJI6E7Q-1; Tue, 23 May 2023 05:51:12 -0400
X-MC-Unique: P7RPP7_ePear06HrJI6E7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f6038dc351so8307085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835471; x=1687427471;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Utz9GyNMlitUDGZqJTc8z9BwJtSeQQS1zcXV/HWkrQc=;
        b=hcmxUSbpkbnaXjfAZdIXFKjY+SkNPc32Bn3VeKK5bYjuRiT3n25+ukONR5asbC7RTI
         bkbT3JB2ehtA76yC7D4P7xclYl83Gn1Qsp2vu+TnKfo6DlJeBLGG6ug09la/8juYTFYj
         b11uPcLpfW4zbP1Qpni+ZThz0Y6pDWjxjfkSwAw9/UWHLBanomBBtOxOp2AX9+vFJvf5
         VRsiLjM3o9RMZ6AB5XCUuNOud55+2L9Okg6hWGLV4fccoGDymnQ2KZIC6nVKUStfuh2m
         KhdkEXtFBLGn1DUSDyBcfPbu06y17TIM/+8IUldmNeCHEbfCsyc114Rn40E18XEjrY0j
         kYqw==
X-Gm-Message-State: AC+VfDx0jKmhpFB/KWX4rzVxXZDdOJm/ZAj54tYTH8LOUoQYJdlfwc1V
        2W75x68+Zl71f2S+tMOjSSfEF0JHmHN9uMSEeC6b8MalI5/stdzlTyj2jyrnj+jcIFgNzM5+BEB
        RrO9ZMLoxuigM4xwrGmVvB7CV
X-Received: by 2002:a7b:ce95:0:b0:3f4:2b13:f0fb with SMTP id q21-20020a7bce95000000b003f42b13f0fbmr4348318wmj.13.1684835471413;
        Tue, 23 May 2023 02:51:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qNSzaVQMTj006xrZmNmFSzew8J6RqPIk3CxqLL4G+jJQqoKMsg5evkWGjoS+PFJnOZ5AJQw==
X-Received: by 2002:a7b:ce95:0:b0:3f4:2b13:f0fb with SMTP id q21-20020a7bce95000000b003f42b13f0fbmr4348305wmj.13.1684835471048;
        Tue, 23 May 2023 02:51:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b003f42894ebe2sm14284952wmm.23.2023.05.23.02.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:51:10 -0700 (PDT)
Message-ID: <27ca0db1-2648-3ea7-3a26-208bc580b72f@redhat.com>
Date:   Tue, 23 May 2023 11:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 2/6] ksm: count all zero pages placed by KSM
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522105229.4066-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522105229.4066-1-yang.yang29@zte.com.cn>
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

On 22.05.23 12:52, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> As pages_sharing and pages_shared don't include the number of zero pages
> merged by KSM, we cannot know how many pages are zero pages placed by KSM
> when enabling use_zero_pages, which leads to KSM not being transparent with
> all actual merged pages by KSM. In the early days of use_zero_pages,
> zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
> it's hard to count how many times one of those zeropages was then unmerged.
> 
> But now, unsharing KSM-placed zero page accurately has been achieved, so we
> can easily count both how many times a page full of zeroes was merged with
> zero-page and how many times one of those pages was then unmerged. and so,
> it helps to estimate memory demands when each and every shared page could
> get unshared.
> 
> So we add ksm_zero_pages under /sys/kernel/mm/ksm/ to show the number
> of all zero pages placed by KSM.
> 
> v7->v8:
> Handle the case when khugepaged replaces a shared zeropage by a THP.
> 

Oh, and just a note, such version comments should go below the "--", 
such that they will automatically get dropped when applying the patch.

(Usually, version information in the cover letter is sufficient :) )

-- 
Thanks,

David / dhildenb


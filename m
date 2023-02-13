Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB269461F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBMMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBMMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:44:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED386B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7vg5iaYjOoIBam3xF82k+EYYGMy8Wvvw+bIbFfOSKw=;
        b=U4SKkEno+oDqKg29CPEQcA3JvFI+XdePlvA4iICow1+FgXceGH5x++avZ8HFOiGZcUywif
        4VPimrWnqiUD3V8KBIPz1zE9M2DkzQYrUK7S4EOlCVpumaOmt6FzNg6eo9qHCmpAPaqZXg
        om7nY/+2Wca0osL75Cb7Usl2e9YlKgs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-ouPqVNdjP6GZ4oIUoEk56Q-1; Mon, 13 Feb 2023 07:44:10 -0500
X-MC-Unique: ouPqVNdjP6GZ4oIUoEk56Q-1
Received: by mail-wm1-f70.google.com with SMTP id n4-20020a05600c3b8400b003dfe223de49so9094229wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7vg5iaYjOoIBam3xF82k+EYYGMy8Wvvw+bIbFfOSKw=;
        b=w+YyYf0XOkUgxVcqdXyi6Znuye40OUz9gVcjowxNAHRZKdAgyifUyWsdZSNmPNFgn1
         HhlLkZJm6/QaU9q764rYy+3gCMH2p+d12U3idwQF3p3inwPIvI4khOkAL+hYwfpXsZPu
         86UujlMVyulw2ONQP+I0j/73U4cDFGbqnrx4MfBFdYkNV0c7EfjU/1EIYT4KFtAGXuBJ
         k1tKMd+GsmbZtP69fQ/MXSdRK0BcIHhgJAlqPRSvRaPnhJcJjpQIEnQK4vi/xjs0b6QA
         L6mKNNAPOZyyJryJQEUZlO8nvznVsV68Ln2tggoVJU9tkikVW0a9IuXIkDAUshMOYnNo
         tkpQ==
X-Gm-Message-State: AO0yUKUcSY/jm2FeJws64+0XwsPesw3h2GL+59WZIYHrMXnUiNHktTBi
        FM9NrATDwBhZygY9U3evt2YpoxJoCz1YbfSdPjZskpXCVrBGU2jlZgj3mAzCqIzAL3keMfpO/Ly
        pH3h+MajhSqP0oe25ix4afjjw
X-Received: by 2002:a05:600c:1613:b0:3df:b5ae:5289 with SMTP id m19-20020a05600c161300b003dfb5ae5289mr18594403wmn.8.1676292249238;
        Mon, 13 Feb 2023 04:44:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+YJ2O1ngBYEox9oF0U4TUiYdr2lsBCupEzqgvsMKdz9Anb/xs4M+tWqUfy/BO1NLh2F+Gabg==
X-Received: by 2002:a05:600c:1613:b0:3df:b5ae:5289 with SMTP id m19-20020a05600c161300b003dfb5ae5289mr18594388wmn.8.1676292248958;
        Mon, 13 Feb 2023 04:44:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003dfdeb57027sm16905905wmc.38.2023.02.13.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:44:08 -0800 (PST)
Message-ID: <ca0ada59-e1a4-dd74-1a52-233c77b3ad4e@redhat.com>
Date:   Mon, 13 Feb 2023 13:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/6] ksm: support unsharing zero pages placed by KSM
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
References: <202302041418359766772@zte.com.cn>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202302041418359766772@zte.com.cn>
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

On 04.02.23 07:18, yang.yang29@zte.com.cn wrote:

[sorry, was on vacation last week]

>> Why use flags if they both conditions are mutually exclusive?
> 
> Just to make the return value of break_ksm_pmd_entry() more expressive and
> understandable. because break_ksm_pmd_entry have three types of returned
> values (0, 1, 2).

It adds confusion. Just simplify it please.

> 
>> MADV_UNMERGEABLE -> unmerge_ksm_pages() will never unshare the shared
>> zeropage? I thought the patch description mentions that that is one of
>> the goals?
> 
> No, MADV_UNMERGEABLE will trigger KSM to unshare the shared zeropages in the
> context of "get_next_rmap_item() -> unshare_zero_pages(), but not directly in the
> context of " madvise()-> unmerge_ksm_pages() ". The reason for this is to avoid
> increasing long delays of madvise() calling on unsharing zero pages.
> 

Why do we care and make this case special?

-- 
Thanks,

David / dhildenb


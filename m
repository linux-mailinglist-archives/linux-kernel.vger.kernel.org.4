Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3055BE1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiITJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiITJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8046151
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663665555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy3pO7TKh5L4V8LJdgp6DzKLqARx7p99S8joQWi7yB0=;
        b=bvM9PKW/w6e6A0zuASCeb6m5snc4GkXxOJF3T0IHtbv+ew4BoCOIi26qbeEmhNMiFu4+k0
        +GsQalx9P6lOT+enF7Cz1bvkOlHKkguUphvnS31dcyLhhQX++k01IyZs25KHw7jojwiEbO
        nhgfuWpwDpTOn8iBHWewFDb2iIXH1kg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-oEL_mi8yMaOW4tTD_FTT1A-1; Tue, 20 Sep 2022 05:19:14 -0400
X-MC-Unique: oEL_mi8yMaOW4tTD_FTT1A-1
Received: by mail-wm1-f70.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so6002781wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xy3pO7TKh5L4V8LJdgp6DzKLqARx7p99S8joQWi7yB0=;
        b=TfQAJuKYLJPQDfU6j+xJSvfkr3pdIPYp/wA6xjAUymF0hHvwONYc7aIW35NQ6HUj4f
         3twQQsOtzKeaIpY1jCdG96iELQmwuHcvUa9ZbN+RWBnQw1L7cveUcFXIyucUK7/gqYGO
         LftcWp57VFMBmt4vLUzbcfkc+ZpoC4icdqL9KA/tO03ui/AU9BWwY3gzKXkIshtItkje
         eDjElvYA+WcD149wrG+cIuzbGx2xWL6YQTaN0YyESnAD3ez8pICnkPUBPfef+kkKObCc
         HUolLQKxZ8eqN2Zi8lImASJJfOHAiYIX4Rn/WJ0LQ6ZcOuJcWud7Uf03pR0AljVFm5Rd
         ZExQ==
X-Gm-Message-State: ACrzQf1+DonhUSOriz2YfJc3z7cjYGEa7fMI4eFm4pBO5NWtSRwYr1wu
        z/bfpfY5OLQKElyF3lAQmYa3PUIjjUrP4lvg+y8qj6NHaS82zluviBSAbo8kMuuVj52Hqns60N+
        GTPcWIZpOF3g6ztAqW2SVylG+
X-Received: by 2002:a5d:46ce:0:b0:22a:f992:42b4 with SMTP id g14-20020a5d46ce000000b0022af99242b4mr6756438wrs.108.1663665552882;
        Tue, 20 Sep 2022 02:19:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4y2xIUlqPqNJjV0bnVWI5QqfcCHFAn0XR7l9gyw2RGJxVKqhZaMiuBzrkUjs70+LkOdLDYwA==
X-Received: by 2002:a5d:46ce:0:b0:22a:f992:42b4 with SMTP id g14-20020a5d46ce000000b0022af99242b4mr6756424wrs.108.1663665552701;
        Tue, 20 Sep 2022 02:19:12 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d464f000000b0022a9246c853sm1041648wrs.41.2022.09.20.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 02:19:12 -0700 (PDT)
Message-ID: <bae0ae28-b3b7-765d-3ad1-aed269046437@redhat.com>
Date:   Tue, 20 Sep 2022 11:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: ERROR: modpost: "vmf_insert_pfn_prot"
 [drivers/gpu/drm/ttm/ttm.ko] undefined!
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209181951.Wdmac1wt-lkp@intel.com>
 <d369f23b-8c14-1d72-8d1c-2c3791a09b1b@infradead.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d369f23b-8c14-1d72-8d1c-2c3791a09b1b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

On 9/20/22 08:04, Randy Dunlap wrote:
> 
> 
> On 9/18/22 04:08, kernel test robot wrote:
>> Hi Javier,
>>
>> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> On 2022-June-19 Javier said that he would merge my patch:
> 
> https://lore.kernel.org/dri-devel/5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com/
> 
> What's up, Javier?
> 
> 

Sorry, you are right. I've pushed now to drm-misc (drm-misc-fixes)
after fixing the commit message and Fixes tag as we talked before:

https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=d8a79c030549

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


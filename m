Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604AE6BCFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCPMig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCPMie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC82698
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678970269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+hfNPh55s3QIpUAvR0km9DQY261PaQ6CD81XmL2nws=;
        b=EMVPbKc9jC8GJ/Q04l5N3HfdBu1DjWdFQgSZg5RMX+TplW5Xng8BXbZbTfAE8880n5dct6
        Fa2PDPA/9zR7iPjkEpnmT34d6/xZ2rywWuxHDXeZ9+lBx96EqU5St0gcqToKX4ae7fDO6E
        B1H1zdXU9fF4zzhr3e+jJGnVtIHE0lc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6Ed-Ng3pO6ifvgbj0ehqlg-1; Thu, 16 Mar 2023 08:37:48 -0400
X-MC-Unique: 6Ed-Ng3pO6ifvgbj0ehqlg-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so2563595wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678970267;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+hfNPh55s3QIpUAvR0km9DQY261PaQ6CD81XmL2nws=;
        b=aMhuEJlTCt0XOPyvDMCcBSHuCeDnZxervo2GlF5gm5jaq6ogVYXsk/wpweMvqSVKRz
         HPIDZx0F+lAxUEbptGDHy4XfhxdKIOte5D7ckq2wkWBXi7qR2VQwjNDeXqZmd4IQppzD
         J3rX2pX6IFLDtTL+Ou/F9VWAlYmH7kF3O6kGQi5crYwaiKbJm7JcGgCFffdYNpL/fToU
         nFyAyu2ayWwdDbayuCqg+GbECIHJdnSp6VHRLraVuFyTF66p0WAReWLyaepGo047Vam2
         3QmTgUkGqhnq1ODvfS6Y8+TRsayn20ihCwrNUX9m6p6w9lh8U5g/KfadBjXUaeJHEumZ
         F6Xw==
X-Gm-Message-State: AO0yUKW7voJw69R8kNOhmBQlUtKGiCXOOh/NcrTzM+5YoSqEy1Mlt7b6
        vOGzdSK7Ja+a4SZrPTGkI6A/6w+zkFUuSFKOwuZdJk5bi+K1AlTwbYpvHCzilmeFQI7/IlOid1s
        cSf/3ntyxLk7OVDzlEw5KC0ZT
X-Received: by 2002:a05:600c:19c9:b0:3ed:31fa:f563 with SMTP id u9-20020a05600c19c900b003ed31faf563mr5633484wmq.20.1678970267664;
        Thu, 16 Mar 2023 05:37:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set909uXZKSW83RKxR+7Cr6bSKy6Ix/SZI1X9kWjaMkvkdqwheynIZDPY0NqDBlcgG3YwAwc/EA==
X-Received: by 2002:a05:600c:19c9:b0:3ed:31fa:f563 with SMTP id u9-20020a05600c19c900b003ed31faf563mr5633453wmq.20.1678970267347;
        Thu, 16 Mar 2023 05:37:47 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b003ed23845666sm4764550wmq.45.2023.03.16.05.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 05:37:46 -0700 (PDT)
Message-ID: <d7a530a9-fa96-22fd-5dee-6951b923181b@redhat.com>
Date:   Thu, 16 Mar 2023 13:37:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 01/16] x86/tdx: Define TDX supported page sizes as
 macros
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com, peterz@infradead.org,
        tglx@linutronix.de, seanjc@google.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, rafael.j.wysocki@intel.com,
        kirill.shutemov@linux.intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, isaku.yamahata@intel.com,
        chao.gao@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com
References: <cover.1678111292.git.kai.huang@intel.com>
 <ca5d11744de083812ba121f1b8cc0576a8691342.1678111292.git.kai.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ca5d11744de083812ba121f1b8cc0576a8691342.1678111292.git.kai.huang@intel.com>
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

On 06.03.23 15:13, Kai Huang wrote:
> TDX supports 4K, 2M and 1G page sizes.  The corresponding values are
> defined by the TDX module spec and used as TDX module ABI.  Currently,
> they are used in try_accept_one() when the TDX guest tries to accept a
> page.  However currently try_accept_one() uses hard-coded magic values.
> 
> Define TDX supported page sizes as macros and get rid of the hard-coded
> values in try_accept_one().  TDX host support will need to use them too.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2755E7582
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIWIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2132EC2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663920909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51Kyuo7AJKV6gUq3xeGcAOBKueLhJINvkabwk/dQKks=;
        b=BElx00+GDXJ+dD1g9/6z8ajPLYnvDlp192A2LL5BjeKPzwAodGrFvvwmiPmrDdWqAF8cpF
        aXIjHL5cUckjwFrcjjmkqakdBWiOPaoE5Y0auqKpkK+TdVmP2XGeu2WmQ5lOhrXyKmJmQt
        Q9waoJ5Jtzw55S7m84R6zWEVl1fj8Xc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-gBi03-m9OIGP-jCugwRfTg-1; Fri, 23 Sep 2022 04:15:07 -0400
X-MC-Unique: gBi03-m9OIGP-jCugwRfTg-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso5224288wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=51Kyuo7AJKV6gUq3xeGcAOBKueLhJINvkabwk/dQKks=;
        b=M0x1nIbs55yBWte5qJBr6iSGsw4mD5ThIkhRAtev2s8TatoHtOXA84Qw0EMh0+R2ww
         YCepuubEOF9sW3MtXuera4qiC8ERgF8jW9eBTRuueqdR2J9DITRcxsc5/D7EKW9SS/5v
         XblF5hf3TIxS186rGilnKi72FL+2+glzxk7O90CUpgr7apNKOKXRb6NV7AuOVuiZaqgs
         GT9XYbo1Zxr3Wy2MdmSuNtAplayLC0Bcy2JmJUwQtN9wmbeYWHknEjCTkBJAD8rHSCMi
         0WvL5B5w75NscvZzWc/4hRprRuWsQ5jNrWdjiZ2wwLu2a0IxwYCffpH8PJ1TI/zWN5u8
         Gstw==
X-Gm-Message-State: ACrzQf1NNlR19qCDdYBgpJvCpDKYcKUpOdtZFuIVCx3Qv6Khmi4DpcDa
        lLJfdIOFVVpLYLylfMlPI/kgtK0oJYsAp2csjF2fwo74GxTdSXNt5Y7DAyBb0+dWi5XjswW8EqR
        +XLr+PWBK2jLXe62lXi9Jj9nS
X-Received: by 2002:a5d:5406:0:b0:228:db0e:a4d3 with SMTP id g6-20020a5d5406000000b00228db0ea4d3mr4195370wrv.8.1663920906556;
        Fri, 23 Sep 2022 01:15:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7N7PjOmTOcCq8bdyx+znheLafsJG6H/pTVCdHu+S1sg9WCHhM8KmqpAUjZN0hCppOKKZesCw==
X-Received: by 2002:a5d:5406:0:b0:228:db0e:a4d3 with SMTP id g6-20020a5d5406000000b00228db0ea4d3mr4195357wrv.8.1663920906249;
        Fri, 23 Sep 2022 01:15:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:cc00:4585:a83b:64f2:ad21? (p200300cbc704cc004585a83b64f2ad21.dip0.t-ipconnect.de. [2003:cb:c704:cc00:4585:a83b:64f2:ad21])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c05d300b003b3365b38f9sm1772470wmd.10.2022.09.23.01.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 01:15:05 -0700 (PDT)
Message-ID: <cefc89fc-72cf-7f03-670d-f5649a68b99f@redhat.com>
Date:   Fri, 23 Sep 2022 10:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: build failure after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220923181245.004d9278@canb.auug.org.au>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220923181245.004d9278@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.22 10:12, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) failed
> like this:
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/process/coding-style.rst:1213: (SEVERE/4) Title level inconsistent:
> 
> Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> **************************************************
> 
> Caused by commit
> 
>    13ea678a035b ("coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")")
> 
> I have reverted that commit for today.

Thanks, an updated patch is already in the works as that issue has been 
raised independently.

-- 
Thanks,

David / dhildenb


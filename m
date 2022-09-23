Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D35E78E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIWK6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiIWK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F6DE8F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663930712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pq+nqOhkpxfLUyiqEq4MNg6ulDavWi2pU/tSeIb7Oc0=;
        b=Gl2cDoLB6/AvIdcZ30SWvHLyp1GIr5KC5dwlIfWn7G+g9W8R1vRyGdKo5C8BW4d4hcFp+i
        gTGf/pnDjaAZYIhcC4xLdM+9RNrcuq1rcdT4UQmZ3h2tn+OXlOzFIPVzFjpPW2Er1g7Pir
        poaJbeOi3B9Hrm2smmnYnttw/Zx8KmU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-w6UK8VfmMiyVC1W9ExyIJg-1; Fri, 23 Sep 2022 06:58:30 -0400
X-MC-Unique: w6UK8VfmMiyVC1W9ExyIJg-1
Received: by mail-wm1-f70.google.com with SMTP id b5-20020a05600c4e0500b003b499f99aceso2561111wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=pq+nqOhkpxfLUyiqEq4MNg6ulDavWi2pU/tSeIb7Oc0=;
        b=VUh788tMLZ9xxHX9ezTAn/H5mzagZqXa4a5kJSa6eaQWIyNrM+QTa4Ggkerq4vEt36
         4p1kCGg0Mv2xvsJ3wk8v1YqXYKcvXNoBkl+jbCFFMl0EOUjHdhJZwT9GTzdAcg2ZYVvt
         GSiYARF6WO9EZR4sKC9dwUZ6r+eiqBQ5BFRV5dwdnbuGAIdFa4r25992xxC1BavmudJD
         iFjOtADdcaSWKAUicmYixyA5eagYzjNhWPZ1cXcjTNHdAN3EZHDsrElSNl5n7ya7clwR
         FsCNDD5y0D1uo1F5SSwfMw65t51xmzLWYPpkvEFGiYSQ4r8z4oPsQ1lU2OBuMQsWAN0l
         fEvQ==
X-Gm-Message-State: ACrzQf2eazK7wXMQ9B9i8THVHNnKbTa/LZPWRM5PQ4aIEoYPZvtjTfFO
        E4AZ7TqPTnOBzJ2iXIqHKZFtStTVHBuo6BX7NfoWePKWaRZHYpM7DuoRhmINiG69/fofCeLq+9R
        m5b3kL21ldmD4B1blmsiqOe7Y
X-Received: by 2002:a05:6000:794:b0:22b:311:afe9 with SMTP id bu20-20020a056000079400b0022b0311afe9mr4596519wrb.509.1663930709602;
        Fri, 23 Sep 2022 03:58:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM692HEan4sa48+pnUlqFXSHn8xzHJwtwuzQCIVFVG2mftuoGFZX1M6CyfbTNUt+KIc+bI3WYg==
X-Received: by 2002:a05:6000:794:b0:22b:311:afe9 with SMTP id bu20-20020a056000079400b0022b0311afe9mr4596495wrb.509.1663930709283;
        Fri, 23 Sep 2022 03:58:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:cc00:4585:a83b:64f2:ad21? (p200300cbc704cc004585a83b64f2ad21.dip0.t-ipconnect.de. [2003:cb:c704:cc00:4585:a83b:64f2:ad21])
        by smtp.gmail.com with ESMTPSA id i66-20020a1c3b45000000b003b2878b9e0dsm2158664wma.20.2022.09.23.03.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 03:58:28 -0700 (PDT)
Message-ID: <4f7ae306-7894-8baa-f920-441ce8c472a0@redhat.com>
Date:   Fri, 23 Sep 2022 12:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 3/3] checkpatch: warn on usage of VM_BUG_ON() and other
 BUG variants
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220920122302.99195-1-david@redhat.com>
 <20220920122302.99195-4-david@redhat.com>
 <d0c59eb8-baca-26fd-5f10-4a1f89bcf7b9@nvidia.com>
 <3179f4545d3f71358da3e6c6ee18085af601b2eb.camel@perches.com>
 <60fa5b16-021e-1e54-7e06-39bbb871eaef@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <60fa5b16-021e-1e54-7e06-39bbb871eaef@nvidia.com>
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

>> And I think that "Do not crash" is a stronger statement than "Avoid crashing"
>> so I prefer the original suggestion but it's not a big deal either way.
> 
> Yes, stronger wording is better. So how about this:
> 
> "Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants\n" . $herecurr);

Okay, let's use that.

Thanks!

-- 
Thanks,

David / dhildenb


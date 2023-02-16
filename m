Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37F699908
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBPPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBPPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8645456D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I32HaqGg+AKq8ms3i3r4JBgqBnj1q4TAYuoOZMeX78g=;
        b=NLjxOQlZDBQ6muKoCtrFokGXf73cP0/vvJvi0+usCcqlzYANzr+OndRXa4tN2pGvXZ1BY+
        c7UfBV4/ZfKpGiTvNrjpWN/Du0HepI/YLkoXKlYHiwXwWunpVGFsnwvn/8rjUvcsEc63YZ
        YisXbh4szUpt75aHw+DkSLFsWKEFta0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-3BRHsfjzPs-KCIK26i1A0A-1; Thu, 16 Feb 2023 10:37:23 -0500
X-MC-Unique: 3BRHsfjzPs-KCIK26i1A0A-1
Received: by mail-wm1-f70.google.com with SMTP id bg9-20020a05600c3c8900b003e1e7d3db06so1301095wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I32HaqGg+AKq8ms3i3r4JBgqBnj1q4TAYuoOZMeX78g=;
        b=JLblD182KUcMkPFsoLjb1sAtcnyikPIq8cZvT1CLvSmFGutM1bqjP0K+DssR/y2LhC
         2te2MdLeXMX0BiwFPIK1ciLw18wkZdxKx00ZYOuA55GW+wP32n5lgm+ulLrHvQXIbZUD
         4Y7/pLhK5nDUJ2m7QhHILGYe6JR1jIe99s6RInAwvZQeYHLQ5eOTLSJaGAUCgRyYJY0l
         M+4RA5rgLwfct9tkTK+5mgzsje/skuXWNHwUPZCgAjrOkr5fkFyr70khNNiEvR/BD6JO
         oY7iM9x2GEuCBS1visVymcnGF9iWsfqrd4k3OjP3B3ZAHrqZmIVFs98+OCE18qmweMUl
         Br4w==
X-Gm-Message-State: AO0yUKVwLYdMjHZ6/cfIK8C4LQr4lbmEkKWhwmX+dE2BZ8WPzJwBUIXT
        x6OXTZYpMHmki/BYL8SUF5K+mKiM/X4M1sdkl3Zk954fMNkSHWRzjpnAnAfzhcbLOOM5OimsPg9
        LCiQ9c+HO/5gw/FPKsFgxRhq0
X-Received: by 2002:a5d:6792:0:b0:2bf:cfb4:2e1 with SMTP id v18-20020a5d6792000000b002bfcfb402e1mr5001889wru.45.1676561842432;
        Thu, 16 Feb 2023 07:37:22 -0800 (PST)
X-Google-Smtp-Source: AK7set8j0tfkpfhsF4xOMrtNiyvA7JaWemN6+KGkpsQqSHCTudISN2xejSUKCEyhwombXhcajzI5xA==
X-Received: by 2002:a5d:6792:0:b0:2bf:cfb4:2e1 with SMTP id v18-20020a5d6792000000b002bfcfb402e1mr5001870wru.45.1676561842082;
        Thu, 16 Feb 2023 07:37:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id q14-20020a056000136e00b002c57c555010sm1773630wrz.28.2023.02.16.07.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 07:37:20 -0800 (PST)
Message-ID: <7c218446-cd3a-da90-0c18-83579bef34ca@redhat.com>
Date:   Thu, 16 Feb 2023 16:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty on
 sparc64
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        regressions@leemhuis.info, Nick Bowler <nbowler@draconx.ca>
References: <20230216153059.256739-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230216153059.256739-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 16:30, Peter Xu wrote:
> Nick Bowler reported another sparc64 breakage after the young/dirty
> persistent work for page migration (per "Link:" below).  That's after a
> similar report [2].
> 
> It turns out page migration was overlooked, and it wasn't failing before
> because page migration was not enabled in the initial report test environment.
> 
> David proposed another way [2] to fix this from sparc64 side, but that
> patch didn't land somehow. 

I pinged another time and asked Andrew to pick it up eventually.

-- 
Thanks,

David / dhildenb


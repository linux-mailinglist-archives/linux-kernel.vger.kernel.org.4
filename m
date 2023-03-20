Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252C6C0D86
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCTJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCTJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12612211F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGDPRnw1QH/lCuH6pKurUzPJ4+UKHmuK/kwnuU0RCE0=;
        b=Uuh/Ncpna9caH9XUeJ3Jj5sDF63DxiWhICF5rbVhy9hj9y1F70vF1woIuNZrllzSHquKqm
        B5Ll3n51sENiMRps6wZg7JSU/wFB+yoB39uLH/SThir8vTJsSuL8slJ3jpf3rST4GnuZ6w
        DSZHydZ+/H+fn7x1sjvZIV4dn/ztU5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-1kxEw_PzNvy-IAZ5tS9kKg-1; Mon, 20 Mar 2023 05:38:16 -0400
X-MC-Unique: 1kxEw_PzNvy-IAZ5tS9kKg-1
Received: by mail-wm1-f70.google.com with SMTP id m30-20020a05600c3b1e00b003ed31d151ecso4169576wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305095;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGDPRnw1QH/lCuH6pKurUzPJ4+UKHmuK/kwnuU0RCE0=;
        b=1tGoB24KBidR1DYq6/SSRTB1dngJddTUV2fOKawUMiO4c92os5XyDJ0HwXlBRLdrZN
         VBZJNhgxPTXO/nZSUFJBWtqyKgdPzoGdJF24xE1PMyG0PHmWB9egAxoihI7TKI2fKgtw
         jmh5RTw7w35H0rzCLwergo85Wi9ow7qw+TsF2zS777aqIeTBT3qUm37HKYUeoKEVYJFc
         rVbKJPiQABb5UsSq82dxsPiY32CeVyNxztt0hR63U0Y8v+zBLtzj3RyoxK6GNK6//klV
         EYMg+h1AXFiv/GqjAzhQakKfraFyVMKNnIVehLxtpe2xy58IWPEp5R+07pwH/3RZeKCo
         aFJQ==
X-Gm-Message-State: AO0yUKWSGMBEjfoOHHghMLsYljKdkLPoMzkNtXyDMPVx3+HLK1/j5ep5
        O7QxrY2oAMBxzd+yTFO7peVmt+uuiw1zjB7woinHgwpf2zZrHOaim+AXTVeWcZXJDAq57fo6oSj
        VLYibuyyVnadAhXajtZ+1OrjC
X-Received: by 2002:a05:600c:3109:b0:3eb:3104:efef with SMTP id g9-20020a05600c310900b003eb3104efefmr31671910wmo.31.1679305095225;
        Mon, 20 Mar 2023 02:38:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set83QC9uGibITnAfeztg19NJ6jZYL/XkfE0u7xq+2shUYwd5s2SuVvFk8M0/NRZRSHy0WjJUeg==
X-Received: by 2002:a05:600c:3109:b0:3eb:3104:efef with SMTP id g9-20020a05600c310900b003eb3104efefmr31671894wmo.31.1679305094944;
        Mon, 20 Mar 2023 02:38:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm8518881wrr.79.2023.03.20.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:38:14 -0700 (PDT)
Message-ID: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
Date:   Mon, 20 Mar 2023 10:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.23 01:11, Luis Chamberlain wrote:
> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>> in a couple of days (1-2), so no need to rush.
>>>>
>>>> The original machine I was able to reproduce with is blocked for a little
>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>> issue easily.
>>>
>>> OK give this a spin:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
> 
> Today I am up to here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
> 
> The last patch really would have no justification yet at all unless it
> does help your case.

Still waiting on the system (the replacement system I was able to grab 
broke ...).

I'll let you know once I succeeded in reproducing + testing your fixes.

-- 
Thanks,

David / dhildenb


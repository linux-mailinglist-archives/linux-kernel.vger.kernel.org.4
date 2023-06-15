Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B16731CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjFOPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345240AbjFOP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FA3A9B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686842889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlaHq+6BCrVBcrQ8Na7RMHfJ8FeQemTtI2xqglcCkXU=;
        b=DUGwePr5XLULOTmdcN+fP2hQinpUKpG89/BU97LKzO5nsRKZUojRgibtczfpmaW2qRv1Xs
        3/usnfLgYaz8oBO4/AdDl9/RQ22E3PS8hrdx9XW2/mSKKDzIMt/OVDzDhCmCmIdTUWoZgc
        A1ZgM+2QB8J+2WneCLvpfoiiLl9l4ps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-kmoDJkdWMhir5-5Ee9lOXQ-1; Thu, 15 Jun 2023 11:28:07 -0400
X-MC-Unique: kmoDJkdWMhir5-5Ee9lOXQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30932d15a30so4576907f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842886; x=1689434886;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlaHq+6BCrVBcrQ8Na7RMHfJ8FeQemTtI2xqglcCkXU=;
        b=GlSwF1FvwONGPyb5C9siKqNpKelG2zoQDGUoRtdyUczOzitQQKaSzi1Gy3PZ/MJrFa
         H61qjBfWwg/bpiAUHtgPPrLaFaeiw0kqv4tD9tqTSLiqFky12cecWqFt2+XhGxzQEM1T
         pSy/AF51WNWs+Ge3J4W4TjCraRgcioe4zf4Zu0L9zp120qb8eIHFtOX9+AV0HjFMGafk
         u7ZBisPwb/Yf3emtslqFQsTC58MMK0VpS7W+pB6we90LIMxV2ZErveI6cjOrkHdl3XMM
         vVTrdo8+DFYXXL64BWmAWuVCXzR3kurZ1NSQkNxBRwid64e98ws1zJGW/vIMHY18R6Ym
         phQQ==
X-Gm-Message-State: AC+VfDxCHYKIoNFy0+x09dnbIa11ENB8uJjgR+vNhxECIYoLpGiheTW7
        8PsYNHt8Fcg4FfGoQyRoDdI4YIImxZFUWWqRtCTLf7yMe2T+7XpatBb8KSLSeXtUVOlKi6TEJS0
        YQ0U+z6WEbyfffUMuY5xIUaxH
X-Received: by 2002:adf:ee0a:0:b0:309:38af:d300 with SMTP id y10-20020adfee0a000000b0030938afd300mr12258518wrn.33.1686842885918;
        Thu, 15 Jun 2023 08:28:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7i9Wv62/yjtEnLPAa08XZGuwZTqAknXVdxagM6V2PtcQKVccjjNFzlF8XbcFye7/05WLzkhg==
X-Received: by 2002:adf:ee0a:0:b0:309:38af:d300 with SMTP id y10-20020adfee0a000000b0030938afd300mr12258499wrn.33.1686842885541;
        Thu, 15 Jun 2023 08:28:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:b500:4648:c96c:d6ba:4b8d? (p200300cbc70bb5004648c96cd6ba4b8d.dip0.t-ipconnect.de. [2003:cb:c70b:b500:4648:c96c:d6ba:4b8d])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe78b000000b0030fc666686bsm10330585wrm.85.2023.06.15.08.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 08:28:04 -0700 (PDT)
Message-ID: <b6d8ab51-f75d-18f1-ed41-e2566eb76f9f@redhat.com>
Date:   Thu, 15 Jun 2023 17:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
Content-Language: en-US
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>
References: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
 <b777a049b3817c7eee364310aac89470e9ea882e.camel@perches.com>
 <IA1PR11MB641820FC52D35D1CECE6830DC15BA@IA1PR11MB6418.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <IA1PR11MB641820FC52D35D1CECE6830DC15BA@IA1PR11MB6418.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 17:04, Ruhl, Michael J wrote:
>> -----Original Message-----
>> From: Joe Perches <joe@perches.com>
>> Sent: Wednesday, June 14, 2023 9:47 PM
>> To: Ruhl, Michael J <michael.j.ruhl@intel.com>; linux-kernel@vger.kernel.org;
>> apw@canonical.com; dwaipayanray1@gmail.com; lukas.bulwahn@gmail.com;
>> corbet@lwn.net; david@redhat.com
>> Subject: Re: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the
>> excluded check list
>>
>> On Wed, 2023-06-14 at 12:49 -0400, Michael J. Ruhl wrote:
>>> GEM_BUG_ON is usually compiled as WARN.  You have to change to
>>> debug configuration to get this to be BUG.
>>>
>>> checkpatch flags this a WARN level issue.
>>>
>>> Since this is a i915 local debug macro, allow its use in checkpatch.pl.
>>>
>>> Fixes: 69d517e6e210 ("checkpatch: warn on usage of VM_BUG_ON() and
>> other BUG variants")
>>
>> Not a "Fixes", just an additional check
> 

That was discussed when developing that patch:

https://lore.kernel.org/linux-mm/87tu5vflld.fsf@intel.com/T/

GEM_BUG_ON(
-> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE

Just like VM_BUG_ON or CI_BUG_ON... that BUGs only with another kernel 
config on.

So this is expected.

-- 
Cheers,

David / dhildenb


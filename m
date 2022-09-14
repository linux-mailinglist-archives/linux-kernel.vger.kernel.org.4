Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EA5B860E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiINKPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582A5F6E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663150477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zy+HcecB9X1fmoe+ZX8nNbCTxaTOZTGJoW+YzpIXLDQ=;
        b=M3Z7JcjW7NrSyfbqZ/vi8X1Za3ZLc9ilgriin2kW6dhy8JF+cpWjaK9u80a1IsXgH3VbdS
        jTH8hzKF0Aj8+tSc87G4TdgMtoBBnekAqo/fTf+A3pGQUUlMu7NAXmq5pNAiK6PEIHLBQz
        60ttlDD7aj9PjAHGOZIBekTjClijCqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-mWLjvtTGMVaBbolDTwV5fw-1; Wed, 14 Sep 2022 06:14:36 -0400
X-MC-Unique: mWLjvtTGMVaBbolDTwV5fw-1
Received: by mail-wm1-f71.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so5229003wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zy+HcecB9X1fmoe+ZX8nNbCTxaTOZTGJoW+YzpIXLDQ=;
        b=XmAf9+DhS7JFiV0S8kftTnVbxgWbORVgn7dJe2gNy2mdKqTKtC/B2j87ktzbWRRaxC
         yI3OrCJxDKJnjdQKmgPJX/fe52z+jEsRmnhy/RaPwrcZ2ZyJ82hb4wowzdNA//AhAAGi
         QazrNLcyqhRPPIu3z9VFIrb/ZFaJdzfM0U9OZtOtnATgDU0SlU5jk7ntBRMHFaN7j+Mo
         BmjYj5jC3ukhfXSCrDe/pRzXSIfy+lwONt07W70N35Dof8eWAKPdsFNTGV/Xi5vNnVP1
         eI+XGEvK0P2DgMeIpxF51VIO21y9l5tZ6AGvqb1HuIK6Bu7S1pT/9adzabyw/S8/LTEU
         xTKQ==
X-Gm-Message-State: ACgBeo3mdtEKwUBaAYt81nm5rhsKgfp5DfblXGirsq90Ol2+GPBU7PGq
        SgSLD/iwOx5ZYtLS9tAKaLilH/f2fYBJK6FiuzpRob18gXIZHJsAA1HfxGSvxGR7I10BmVopO2B
        mlQ0TQedWJDDUOb3Ks+qOE8MV
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id r12-20020a05600c35cc00b003a60f0809b1mr2466544wmq.22.1663150475168;
        Wed, 14 Sep 2022 03:14:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6tsbQzTZqxq9VBgBW8gyHvMcYArl5cDcuQG6dou43DSCrZ3irgtyQ51KtnTgmIsxZSJdl4Jw==
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id r12-20020a05600c35cc00b003a60f0809b1mr2466520wmq.22.1663150474902;
        Wed, 14 Sep 2022 03:14:34 -0700 (PDT)
Received: from [10.119.22.46] ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b002258235bda3sm13171662wrv.61.2022.09.14.03.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:14:34 -0700 (PDT)
Message-ID: <433f00b8-c860-e2ad-09ba-b1abd4dc6189@redhat.com>
Date:   Wed, 14 Sep 2022 12:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
References: <20220913094306.317734-1-namit@vmware.com>
 <20220913094306.317734-4-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220913094306.317734-4-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.22 11:43, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Following commit 68f2736a85832 ("mm: Convert all PageMovable users to
> movable_operations"), the code of vmballoon_compaction_init() is very
> simple and does not worth a separate function.
> 
> Instead, open code vmballoon_compaction_init. As migratepage is always
> defined, use IS_ENABLED(), which makes the code easier to read. No
> functional change is intended.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


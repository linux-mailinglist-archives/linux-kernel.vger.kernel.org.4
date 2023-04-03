Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB76D4170
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjDCKA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjDCKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649010C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680515978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z59tmpsp0VXUZcDPnQt0KpJ5wAxtGYR6oL5KYWwMgmk=;
        b=HN98RD/kxpB6LB0j6AlDAxfxQH+xsu+H/TQmL7BOs84WuiUqgZEjHy9aRJZ32rUrobKnd7
        otTGUHFPOliwsZh002TZx1xGWzl4J2r4Kh6Vg2MAa1zsSIF1WeepT5fQoW/L0Njee+91Bh
        wzaUT6KClxyi71WzByZ539I/zmaau8A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-eQmzSAtXNm-gp1dIlIboQA-1; Mon, 03 Apr 2023 05:59:37 -0400
X-MC-Unique: eQmzSAtXNm-gp1dIlIboQA-1
Received: by mail-qv1-f72.google.com with SMTP id pe26-20020a056214495a00b005df3eac4c0bso9690897qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z59tmpsp0VXUZcDPnQt0KpJ5wAxtGYR6oL5KYWwMgmk=;
        b=FK6K0ZNP2tC6YMOnAQxCvU5qEhWSV3mhzrJHD9lpQwSOIG5lkHnEGfVgMk5Zow+vU9
         V8+DnVxHMnteMMoUKZ1inA3Yt+/47ObR/hVZIn2YP+0ngJLVyXkEpDXYlmk30Er/OZ8W
         Dg3DE3Oq2VAfoTkbZm+QB5V4V/0AZ0GXpG0JydCgxZIvivFpb1stUStT3hLlO0Fg94Mp
         o58UO5CmjjCYe8QuCjORHyd2Mz9D3WkKtr7bM0i4K/kzqNPmiTrnlK3P2aNBsjpV2/8i
         NOYqvNLeX41HXOqTnP/eUso92prURqRuJGpKC4LLhK+QQje+UwfiRPvkiG/k/ju7XHX5
         NYxQ==
X-Gm-Message-State: AAQBX9fi+/lzdsbmlAqELzWqTLJqqmtoqFKmUN2WeimAt0s2Rd4+A5tn
        B4J8qQCym8/8yI6vKETT0eLO8QjkxlDiLP2/Mffkt4TA5fcngo+Ej7NALKfumjWF7PKmXNaHl3N
        uBrkNJrj+Rc68BLFHyqPZ56g=
X-Received: by 2002:a05:622a:1756:b0:3e4:dfbf:1f45 with SMTP id l22-20020a05622a175600b003e4dfbf1f45mr51589396qtk.37.1680515976925;
        Mon, 03 Apr 2023 02:59:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350bINRrQFEUrLlAAUQ95PxQWaw7AwLJtuZlrgT7yOTzoulFIvub+2bPnqer8MlZFO9ouU1BlTg==
X-Received: by 2002:a05:622a:1756:b0:3e4:dfbf:1f45 with SMTP id l22-20020a05622a175600b003e4dfbf1f45mr51589383qtk.37.1680515976680;
        Mon, 03 Apr 2023 02:59:36 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id o26-20020ac841da000000b003de4e646d63sm2436041qtm.32.2023.04.03.02.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:59:36 -0700 (PDT)
Message-ID: <ebc31b2a-82b2-a197-1a8c-df2a509b19e4@redhat.com>
Date:   Mon, 3 Apr 2023 11:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] fpga: bridge: fix kernel-doc
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330174505.158920-1-marpagan@redhat.com>
 <ZCkiWfQQsFEaHm4K@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZCkiWfQQsFEaHm4K@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-02 08:36, Xu Yilun wrote:
> On 2023-03-30 at 19:45:05 +0200, Marco Pagani wrote:
>> Fix the following warnings issued by the kernel-doc script:
>>
>> drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
>> drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
>> drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
>> drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
>> drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'
> 
> I see you are trying to clean up the warnings, but I found more in
> drivers/fpga. Could you help at least fix all core code,
> (of-)fpga-bridge/region/mgr.c/h in series? Thanks.
>

Sure, I'll do it.
 
>>
>> The patch is based on top of 38dbcd697770 ("fpga: bridge: fix kernel-doc parameter description").
> 
> I didn't found this commit, could you elaborate? And you could put this
> info in changelog, don't show it up in mainline.
> 

Sorry, I accidentally put the wrong hash. I was referring to this patch:

https://lore.kernel.org/linux-fpga/20230301140309.512578-1-marpagan@redhat.com/

That has been applied to char-misc-next:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/drivers/fpga/fpga-bridge.c?h=char-misc-next&id=7ef1a2c1c9dffa177ecc3ea50b7f5ee63a621137

Thanks,
Marco


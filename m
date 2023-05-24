Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163C870EF52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjEXH0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjEXH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427D90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684913115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWSXqauAfNHPJuKsKdbaqQql9PsPaAFFdxN4RB2Q3oA=;
        b=OcAHzPd8OnVm5+TF51xUwSHk99f5ytGux0nWP6jEF82edj4hCUMpy+r1Cj00XwbOiASgdH
        RfYxLtMEqV5FEfza25r5FHR6Zb+VUga+lvllHH57a80ae0T0in+X8SRYFLV8Hmj7lAzEd+
        yineYL38lk6wKX3uZIsdjXO+MSa9nVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-rkMzdx78MW2eSQ0XU4D3BA-1; Wed, 24 May 2023 03:25:13 -0400
X-MC-Unique: rkMzdx78MW2eSQ0XU4D3BA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4dd7f13d0so2646415e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684913112; x=1687505112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWSXqauAfNHPJuKsKdbaqQql9PsPaAFFdxN4RB2Q3oA=;
        b=NF3RsENLbZblZgztfarOHNnUQHcDMf42JZu1CaLqxoVcLBdjmJL2L5/jkvxjpZ+HJo
         6JRPa0K5B54wMJ3UsG/DkP23xmHSStaELivtLQuylqg6XNVBmt06DNhjGZnocyOAAJUQ
         inkipjNZcXIshgWkP0GLHZofagNahxLjiCyh+Nln4H8+0BWX1eMRF8pQPVz+ms+ClAqi
         oR4mwA3nJknTsuYdDl2WrcJBwg0RuDScy8Aa5SBXGfY8lEaDfTU4Javh3Sbp4k7oTWZK
         LNKrQ+EwoBsxxjfMuy7hiJ3sh2qYN+J/59cm1KjiyKQfyPgcHqLInNEiujzzcYTnz0xx
         CudA==
X-Gm-Message-State: AC+VfDyjUdiaOzqE2NgoVvc8ROCiTZuxbvG2D2f00nu8rqOctUg+/e1O
        A+r5LNb3J6/2A95znQLsA0fZ7Y/3CfsjwKQoMzjHG6KuwVWcp92DuqRCHjJHGvx3sJVLrXHPrVr
        Em7u+IkMUL2nEfso6BChBkwPr
X-Received: by 2002:a7b:ce12:0:b0:3f6:38f:aa07 with SMTP id m18-20020a7bce12000000b003f6038faa07mr7768776wmc.24.1684913112238;
        Wed, 24 May 2023 00:25:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lgsff9iqzGhSfQoNDY6nmmo+TLB+2UaUr546vhBOlAYM6wzq3tdCWiwtdaOEgsdPlRlQK3Q==
X-Received: by 2002:a7b:ce12:0:b0:3f6:38f:aa07 with SMTP id m18-20020a7bce12000000b003f6038faa07mr7768764wmc.24.1684913111943;
        Wed, 24 May 2023 00:25:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c28c800b003f4272c2d0csm1270069wmd.36.2023.05.24.00.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:25:11 -0700 (PDT)
Message-ID: <b16e6c10-e7a3-78e1-f3f4-d40465cbfbf7@redhat.com>
Date:   Wed, 24 May 2023 09:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 4/5] ksm: consider KSM-placed zeropages when
 calculating KSM profit
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        shr@devkernel.io
References: <202305241351365661923@zte.com.cn>
 <20230524055851.20565-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230524055851.20565-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.23 07:58, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> When use_zero_pages is enabled, the calculation of ksm profit is not
> correct because ksm zero pages is not counted in. So update the
> calculation of KSM profit including the documentation.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


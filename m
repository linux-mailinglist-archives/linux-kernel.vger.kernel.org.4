Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F425712DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbjEZTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjEZTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E7FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685130124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQbvDzRrNGGmJC0cFwixRt7YyXto2u7DcheHfHIL6TM=;
        b=OYsU0+OjhamxJKamSgkSp/7bkjbZqPzBIg9R6Aqza2jiaiD5hJumOxDDsBEqZQzhGbyV4e
        lD2TkJtptNBJo+/U1HIsJdTcRRX5JYrT4wf6kpsnVy7vA3GmDao3N/FZ32A5OTNS/SPEMw
        xTlGRvZQSfjazl9IDak81+1foULFboM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ENhkZAlEO86Y4ZQC1axtjg-1; Fri, 26 May 2023 15:42:03 -0400
X-MC-Unique: ENhkZAlEO86Y4ZQC1axtjg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f6eb8d3848so3855255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130122; x=1687722122;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQbvDzRrNGGmJC0cFwixRt7YyXto2u7DcheHfHIL6TM=;
        b=mDYwsGtzb+EXmSU6M4K3BbBbef8xANr4C2wUl5TYexXTwEzzzk3dFYreMWX/14Ypqi
         8rVC4tkbRd9TuTmnQAN9XIm4HK2fYzOizNm+z6oc3G7z8Jh14Q1apfeDItXGC7SKmIDE
         CyZenO1CW7e579JOOcw46iJDaAJ63gA1gkDEfa71K1VpEpbag2MXEFv97NFW3T+Vb4W5
         r5pjoN4OUCd53yiM+Xx6Y+w6Z18C0HM1gym7Bx5GlQPeZX+WG+nGd+TazXl62gpji/F2
         RbFOWIg8vh2AYb6cvE3CYKjk3WT74n9ZiSbq5/O783/AsBOf8ILnju0OYdLjd5FUMfDg
         bJ8g==
X-Gm-Message-State: AC+VfDzMm+p2uptT2691k05nFT/pu9y654jQZsx+o/sjA8tV5UNeyYkJ
        OSrhUe7GbyAItgfwPRri1LtQVZmvU2SwJUgr6HWU1/SKCHwKU+HvymqibgMn9tQNJSgy9a/X511
        +b6t1Pww2wjfl63AAM04O4eOH
X-Received: by 2002:a1c:7407:0:b0:3f6:cfc7:8bce with SMTP id p7-20020a1c7407000000b003f6cfc78bcemr2507518wmc.22.1685130122171;
        Fri, 26 May 2023 12:42:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Fy1XekX9Vh+eeukEwm41budqTXKnvaC+Uc6qWThUB3TK1m5Tn41fjaNow0dI/Ly8Sf8pxmw==
X-Received: by 2002:a1c:7407:0:b0:3f6:cfc7:8bce with SMTP id p7-20020a1c7407000000b003f6cfc78bcemr2507506wmc.22.1685130121842;
        Fri, 26 May 2023 12:42:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003f4e8530696sm6035997wmj.46.2023.05.26.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 12:42:01 -0700 (PDT)
Message-ID: <f232be95-74aa-8beb-0413-3dcc7e541ba5@redhat.com>
Date:   Fri, 26 May 2023 21:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/gup_test:fix ioctl fail for compat task
Content-Language: en-US
To:     Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
References: <20230526022125.175728-1-haibo.li@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230526022125.175728-1-haibo.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.23 04:21, Haibo Li wrote:

Nit: "mm/gup_test: fix ioctl fail for compat task"

> When tools/testing/selftests/mm/gup_test.c is compiled as 32bit,
> then run on arm64 kernel,
> it reports "ioctl: Inappropriate ioctl for device".
> 
> Fix it by filling compat_ioctl in gup_test_fops
> 
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> ---
>   mm/gup_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index 8ae7307a1bb6..c0421b786dcd 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -381,6 +381,7 @@ static int gup_test_release(struct inode *inode, struct file *file)
>   static const struct file_operations gup_test_fops = {
>   	.open = nonseekable_open,
>   	.unlocked_ioctl = gup_test_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
>   	.release = gup_test_release,
>   };
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


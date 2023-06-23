Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8373BBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjFWPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjFWPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:38:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A2E5B;
        Fri, 23 Jun 2023 08:38:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-312824aa384so781759f8f.1;
        Fri, 23 Jun 2023 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687534691; x=1690126691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNXbjuOqHdtzZtqUY4ByxrF/CgsTtwnSlgbUWKLQCLw=;
        b=IJdAgbrD9Tw+m6nq97yBcx8ID+jzUjScesGwDUwKrjfPLl5/AxNIiEKlLQ9uLPdSGk
         TVWr9HscdRRAXLpg6/uiP+nrYj0I6HP/q0RUNGiCrUwcxsq01V2sRb9Cc/zVWfm+qMbQ
         pKuA2mnKlA/RV+P/cHzD9oaoTZyX9zu8EQWze7WubA7nHbwCt5Xz4bcMUzfdROdL9qSs
         D9kxcRaOyW3UgmjmcMaGp+DJm2xyarPlEsbl5JhUq3wrZW0eXXJMWCcaLfK76ovr6xnX
         yKN19K6d/wHuVNxVOs3iPX8m5WU/vOR6h9TYMagzOxk8jqhzgDH/Y0/GwZCWSlLKpilZ
         bLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534691; x=1690126691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNXbjuOqHdtzZtqUY4ByxrF/CgsTtwnSlgbUWKLQCLw=;
        b=MN/ffxdUWMF0YQgbrBDqbpj5ttkKYsdwP6EZnTi48NG32OypwoK77Eq3AQaXU3xU2J
         urvSQnTMvx1qLSlwf7T1C5lsThcxY/eukqdgFG0U2aAokyz/I+Y55I6qFzuR1WXNCCyI
         K1Q8mK2eBZYVZq0N/DSVULZtJDM45rJ+0tQoJ9X+ZRZYD+bgEwMATwGofSkRIb7d2NKa
         /Qq/H96jG85lZPg8bVFvfWSKckpWvo2ofiWT1Y7APF5+6zWL5DUHVh0lBoHAgXgbl9L7
         fOwj6V7r9KXF9Y6GpG1tIX0tjbaBR87Fjkrzxkz003NdBgmTTEyDBdKHpLDFJqmqmwKN
         ld6g==
X-Gm-Message-State: AC+VfDyTMC/6gBoVAN/CWROnqPvo4fAuUP6BFi/2Rp4gyeYLFoaA6vhg
        jIe7XqP2vY3Jw9OqOYjyaHY=
X-Google-Smtp-Source: ACHHUZ5fQsTepIAGmk+q7diQzlvb77qb9u3WmJzUDuQEmEeTWTEimHchssqUJ9Wh4vD/Z9igZB0dzQ==
X-Received: by 2002:a5d:4008:0:b0:2ff:f37:9d0f with SMTP id n8-20020a5d4008000000b002ff0f379d0fmr14901207wrp.57.1687534690924;
        Fri, 23 Jun 2023 08:38:10 -0700 (PDT)
Received: from shift.daheim (p200300d5ff176500aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff17:6500:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id k10-20020adff5ca000000b0030ae87bd3e3sm9844115wrp.18.2023.06.23.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:38:10 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qCirR-000CFs-22;
        Fri, 23 Jun 2023 17:38:09 +0200
Message-ID: <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
Date:   Fri, 23 Jun 2023 17:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
To:     Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Shiji Yang <yangshiji66@outlook.com>,
        Nick Kossifidis <mickflemm@gmail.com>, jirislaby@kernel.org,
        Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230623152443.2296825-1-arnd@kernel.org>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230623152443.2296825-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 17:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The carl9170_tx_release() function sometimes triggers a fortified-memset
> warning in my randconfig builds:
> 
> In file included from include/linux/string.h:254,
>                   from drivers/net/wireless/ath/carl9170/tx.c:40:
> In function 'fortify_memset_chk',
>      inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
>      inlined from 'kref_put' at include/linux/kref.h:65:3,
>      inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    493 |                         __write_overflow_field(p_size_field, size);
> 
> Kees previously tried to avoid this by using memset_after(), but it seems
> this does not fully address the problem. I noticed that the memset_after()
> here is done on a different part of the union (status) than the original
> cast was from (rate_driver_data), which may confuse the compiler.
> 
> Unfortunately, the memset_after() trick does not work on driver_rates[]
> because that is part of an anonymous struct, and I could not get
> struct_group() to do this either. Using two separate memset() calls
> on the two members does address the warning though.
> 
> Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Wait! I want to point out this funny thing is happening in ath too!

https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541

And that patch got NACK by Jiri Slaby because like me he suspects that
this is a compiler bug.

so, what's going wrong with fortified there?

Thanks,
Christian

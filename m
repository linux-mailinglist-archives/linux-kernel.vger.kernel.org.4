Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4472677B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjFGRdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFGRdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:33:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557E1FFE;
        Wed,  7 Jun 2023 10:33:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-542c54455e7so2511049a12.1;
        Wed, 07 Jun 2023 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686159194; x=1688751194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5xO5f1/YmAiDSNjj/LslOHBNempPJp5NbvHAzvw4dfA=;
        b=Yuv2CijGi2UBCZ9W5Vdxu+tT8uMuXH0oovH5GrN9tKjwLZQ9o7zbZr7zg6uGT3TY0Q
         hXWnW6Mr7xZExiI2HXqYzGIcqvDFnARpPTGTgmkT1sYJ1awysJjSZmxyjv7WNEOEu6WE
         cnhQgM+WqPvLyoKBV1a2fcO8PNozHGIBQ3BD+C7vuHnzag+gTFuM3Ckv1HhQViboP1hz
         P2rPZjo0gIrLxRdShgrFe1qSYKm2F5se7JVvY1sme99F69fWi9mkky5RktGOegte+OYY
         1NDHnDs4FiV5zNePZUCi+gH505wzbVLDiKub2vLMxib7bt/MSyQIjZVjJwJahu/VaHSz
         D5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159194; x=1688751194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xO5f1/YmAiDSNjj/LslOHBNempPJp5NbvHAzvw4dfA=;
        b=Zf2cp1ODnQk3dG9yX954nH+cCn7xh5xc0BB57wwlOI+dtvafL1d0eJw6mNv5a+peHR
         Ac6K1OYUclUWJu68aNx2od9BuSHLeivialcbciKpZSTQCtlnsw1qt5vyo1f7jy7oUTuc
         XPHdmwg517xl4U4jY0nxE7sjbDRKMu2w+PnguoksOLW4RdrqIJ6HlkiEEmnWroRCwI8r
         hSVcYTzKaf5Rwy+hS/6SkkDOyMfJxiD/7q9VoyOS1n5L9v4Ks/91JUd2Eq5AQru5PdRO
         v6JuIe6lJjcrJGdEhN2VtpGMaOu+/W9IuM7i8dvrH6w/ZdFSeo2n+aVROfShd+p/Vsb7
         f7uQ==
X-Gm-Message-State: AC+VfDx/Z2qUz045WMyYSadyfnBpOR4B/PXXNwDN939d64MjO2fV2ARk
        sPlKIig8yI8Gd9QSxIB8QVI9yKPwv18=
X-Google-Smtp-Source: ACHHUZ4zEY+ELx1X98bZ7haUA6dXfbRAvxq0m+9yyJlMwMl5y14Trt7HmiBtW7iRYgpPzwYbaqhagA==
X-Received: by 2002:a17:902:9a94:b0:1ac:859a:5b5a with SMTP id w20-20020a1709029a9400b001ac859a5b5amr2416516plp.0.1686159194037;
        Wed, 07 Jun 2023 10:33:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001afd275e186sm10639132pli.286.2023.06.07.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:33:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <94f78001-13df-8c39-4771-7842dc94195e@roeck-us.net>
Date:   Wed, 7 Jun 2023 10:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported
 boards
Content-Language: en-US
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230527012206.133464-1-samsagax@gmail.com>
 <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
 <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
 <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net>
 <CABgtM3h0KMsOzZZvYKZLsFXn9A81V59ygSKizoF3TTkraMWr-Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABgtM3h0KMsOzZZvYKZLsFXn9A81V59ygSKizoF3TTkraMWr-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 05:40, Joaquin Aramendia wrote:
> Hello again. And sorry for my late reply. I'm struggling to find a
> good solution to this functionality. It most definitely feels icky to
> be attached to the hwmon driver so it should be a different driver for
> those devices. Would misc be a good place for that single toggle? or
> maybe platform? The latter seems most fitting since is very device
> specific.
> 
>> You are attaching the attribute to the hwmon device. Moving the driver
>> to another directory would just be an attempt to avoid review by a
>> hwmon maintainer. Just for that reason I would NACK such an attempt.
> 
> By no means I intend to avoid review. Don't get me wrong. I'm trying
> to understand what the best practice would be in this scenario. The
> driver is part reverse engineering and part asking contacts from the
> manufacturer (who is no longer in the company so it is reverse
> engineering at this point). So any new functionality we find might be
> a different driver for what i gather since it is not related to
> hardware monitoring. The oxp-sensors as is now it is mostly done and
> it works well for the users.
> 

Why don't you just attach the attribute to the platform device as I
had suggested earlier ?

Guenter



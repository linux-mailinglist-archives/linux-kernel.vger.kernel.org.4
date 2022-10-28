Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAE6113DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJ1OBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJ1OBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:01:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586B1213D6;
        Fri, 28 Oct 2022 07:01:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d24so4929272pls.4;
        Fri, 28 Oct 2022 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzrT4rDKHGVcSASZdk2vgblIAXRTRtBk/UeL/heid0Q=;
        b=BG3Pd52vxz7FCMwsHVabpMk1NSqJQel/piPy76J2aKZ6cFNoCiNlK/yQaXpSW49pdV
         fbHYk/uNaJZ5BXU3+LDe7sZY6+FLJgWxQxBSP8jKUujvuteW8WA1yAsj7hH5VBF8wOJ3
         GItCA4kWa8ApsneZh53Y1E/TEratf38l2qTB7cLc5OZ1mWXZljy0l7f9cTkdD6/2nj/k
         DBMDugBpOxkE0oZO8lGY9ZaDb5HcsOvDl2Y+VS8mYAogprT3Y5RcgQp8RpGiIYUkwUgE
         UH4D1Ace0YobLWkfaUtRJoqcz2yG0GNbc2kMKmgqf6VZucS0gL4NIvw3x7zcjy2rXko1
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzrT4rDKHGVcSASZdk2vgblIAXRTRtBk/UeL/heid0Q=;
        b=YQhIq64Qo50N116PqlUiJ+K7xaJGyZ/xDbq04IABkAph18DXt6go64cPwwyDJg7qhY
         Rr93H1X2oG2aENaARJT15nOecdjAy931VnFq40LlbPQ6P0r8pHPMj09nYA07HgF39UnG
         Qs3s3AYvWtweQJtRg75aiG5EpAsLyu+6qB8TKKw/BzIKVHP5T9mAdJQjHaPenWpuuF3U
         FIiSYItVxZVd1VmfgshieWli8aE1qrh8pEFenIZIsFl2dWz3Jdwopm6tS/YZaAKlyIud
         LOywP8MM7Tgdh07j2/LA40b0d/+85pOAIXpcosh51AO0wDNPJa+2xImAFotTUaM7GzZ9
         Q9uQ==
X-Gm-Message-State: ACrzQf3VfxJadDHr+DvjIfwG5qIbMTfiou8aVdvwVmqENK7QI16gn3E9
        BoaQ+QoK0gpJ69cXxpvmQ2c=
X-Google-Smtp-Source: AMsMyM7U9TGZLeKkJ8uj85NlJ2JhWTtOjKOG0VBqHH5AXSoTwrKedoeBTqh+GVXpKiko+SwxV8oFTg==
X-Received: by 2002:a17:902:d54c:b0:186:c092:97db with SMTP id z12-20020a170902d54c00b00186c09297dbmr21200680plf.28.1666965670128;
        Fri, 28 Oct 2022 07:01:10 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id om2-20020a17090b3a8200b0020d3662cc77sm4293127pjb.48.2022.10.28.07.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:01:09 -0700 (PDT)
Message-ID: <0286fc73-da93-42b7-2f87-4191f51dcbb2@gmail.com>
Date:   Fri, 28 Oct 2022 21:01:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 14/15] scsi: ncr53c8xx: replace CCB_MAGIC with bool busy
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-scsi@vger.kernel.org
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <182906437bbf7597968cc68e0babe6f7ff772f79.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <182906437bbf7597968cc68e0babe6f7ff772f79.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> As for magic numbers, we have largely moved away from this approach,
> and we have better debugging instrumentation nowadays: kill it
> 

Meh, see [1] for the same reply.

[1]: https://lore.kernel.org/linux-doc/80c998ec-435f-158c-9b45-4e6844f7861b@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara


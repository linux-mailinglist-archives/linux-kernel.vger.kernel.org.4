Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3C716A68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjE3RDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjE3RDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:03:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F184EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:02:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-76c304efb8fso23443939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685466169; x=1688058169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRoDmakO8mrN7BvELyyzaW32Q2l2bnomKWiwa5cHUpA=;
        b=be4Ruwzg4H/6dypcz6TQR2g21cAynOFpZugTdkH/nePfKZg/I7DE/R6DZjIOANPgfm
         EAZ1UP9ba9X+Vx317rQuKLUuIFNw/meR3q9d9Zko6p7didG6zgOhXETAXIHhJvjbSezT
         vlHtWsO1NVQlXphb44pIScjiowuV/Kf/RkoWMGRQIN7O9eIBdfZleNxY4y19kGQMdVW6
         wNoZoQwSNWUuLzx+TbleFYQtMY1GGeQYuAnCBXZqZQfX16/md2jVEC4sRBgeRZaO+0Hc
         YnYPWRkVvi+ozXjs9yfcPtAnYV198p8a8ZOLtE7QGIMdLHBzRT7knB5kruCdwYNmDmsl
         yySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466169; x=1688058169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRoDmakO8mrN7BvELyyzaW32Q2l2bnomKWiwa5cHUpA=;
        b=juiGGOfqXFKCYKqQn5Aw9h2tma7TuSvCNgFBJ5TMoT3MCsO+swRCclJFQaubgpWLPq
         TdKGk/MVuNaE2ATcNMHT2JcMV6usqTVgml5qTU3gDS9A/oDyQG2lFk2xdl0bs7cm9/sp
         S3CTKpmDKY7TnBc+n4U+EB24piu+tDGlxi0eVZAW6BSTLVt+5AtPmIvQVSuApVF/wd/c
         quFWSA5AfZp9x8EkMSE5i2I6z6B5QHxtXSg3DwCZTZno8RSb8lVwkiW24rzGRGCHeRtG
         izCgOvnVbgLgmkk+sxUfaTgk1NowUoXjokrhC0y9t8Y70Q6lsNISpIXehXhjp5W8T/ek
         xjBg==
X-Gm-Message-State: AC+VfDy65nPshgVjiK7vwjg1bmhs9ZCdcopbiUv7WneBySMOqCkDurJ7
        4OUafvTgr3fT7WNDKRjlypmF3L/1j3NVqoCb6sU=
X-Google-Smtp-Source: ACHHUZ6xqxRUQnK9LwqsJczYvkyFp5/L3wIJn+R0nqdGP4nB/d5h2eGBwNj8PrSrGnWnQ+dnnCA5SA==
X-Received: by 2002:a05:6e02:1248:b0:33b:3a14:c14c with SMTP id j8-20020a056e02124800b0033b3a14c14cmr14294ilq.3.1685466169616;
        Tue, 30 May 2023 10:02:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s185-20020a0251c2000000b004187f6d4e78sm877638jaa.105.2023.05.30.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:02:47 -0700 (PDT)
Message-ID: <00c4aa95-a096-0487-c162-e8817dfc0b96@kernel.dk>
Date:   Tue, 30 May 2023 11:02:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] block: constify some structures of
 partitions/core.c
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
 <5aeb26f6-aeca-4f77-8328-a753f9a5141b@t-8ch.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5aeb26f6-aeca-4f77-8328-a753f9a5141b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 10:52 AM, Thomas Weißschuh wrote:
> Hi Jens,
> 
> could you take a look at this?

Looks fine to me, more const always a good thing. Can you respin
it against for-6.5/block?

-- 
Jens Axboe



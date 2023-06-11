Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC672B271
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFKPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFKPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:22:04 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8181BB;
        Sun, 11 Jun 2023 08:22:01 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-653436fcc1bso2879531b3a.2;
        Sun, 11 Jun 2023 08:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686496921; x=1689088921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkO45KeJdEpx3Se2ZTh73OLYZQ+QPKr/D2y/xQd9e3U=;
        b=LEgZhzFj35eShBZpeHUCRV4r7KW1jqD48U3e0rbJaMVq6FrYhs93ZGTlpMjm3u3dKS
         FG74fjl+OkRg2VjK3Xzq07gsyVjFDwg5jVS/HS6BKZfbAZ5hPdZ1JX9ou59TELowWMnT
         0cugRZtoAlGhNr/m4A+D2MbZtHe/VLc9aYouUHZ7VaSx3sdOzJYY8jHAlk7CDdb6Wjf3
         +R69JNoHYi0bd61rbndSujP8uj7+WH6HUu1uR0S0A5oTHdva7zm0yl8Dv9o2YVt4s0dm
         fWOvjh/57Ly0H877LzCxHxc6sp42+d08j4aLnn/izW8R6AJRMlNdsEIIXJDIzw6kboxD
         49pg==
X-Gm-Message-State: AC+VfDxeLedwO52gHRuDKsESTD8IvIA3rvUlvYFdaKt5p8BBao0aSM38
        mx7OAArNoBM6q8xlOb0jplg=
X-Google-Smtp-Source: ACHHUZ4d4NpK7AJHOF6a4bBcWkXSodbTR9hYUf0gLKHkzP/qRhS+ld13K10x82nWt42VQEJeypafpQ==
X-Received: by 2002:a05:6a20:8f1e:b0:103:883b:10c1 with SMTP id b30-20020a056a208f1e00b00103883b10c1mr8410722pzk.41.1686496920530;
        Sun, 11 Jun 2023 08:22:00 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e10-20020a62ee0a000000b0064fdf5b1d7esm5449598pfi.157.2023.06.11.08.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 08:22:00 -0700 (PDT)
Message-ID: <bb0cbd67-12ff-476c-628c-0e6dfd2cd482@acm.org>
Date:   Sun, 11 Jun 2023 08:21:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: blk-mq: check on cpu id when there is only one ctx mapping
Content-Language: en-US
To:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk
Cc:     kbusch@kernel.org, liusong@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, stanley.chu@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com
References: <20230531083828.8009-1-ed.tsai@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230531083828.8009-1-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 01:38, Ed Tsai wrote:
> commit f168420 ("blk-mq: don't redirect completion for hctx withs only
> one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
> will be no remote request.

The above sentence is incomprehensible. Please make it comprehensible.

> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

This patch comes from Keith Busch. Why has his name not been mentioned? 
See also 
https://lore.kernel.org/linux-block/ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com/.

Bart.


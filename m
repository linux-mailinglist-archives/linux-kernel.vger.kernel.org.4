Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19D96E4A46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDQNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDQNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:45:42 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0D10E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:45:41 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f174c4b404so618975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739140; x=1684331140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy7wQsGi6Nyz8v43nQvutVpWGG1vp+oDxTzBNGMPHN8=;
        b=kAGYieZho9eBUVdaNMOBSdYntF1gyaQYWTruFm6flWtejNMjgfxlhjFxQ3SgGGNk9d
         wZHFvdfPAs+X2YUMSE1boxxDI4sPfnfId5UG59ZYIjI/ntnQQ0pezg2LJZDy5NBQJ87A
         ds53SROQnGBnM0wyeHTpbs2v39wjDW+Vo2AaBQLdaRhIRnqDDoYbJKJ3wR/h5DN7poRt
         5kVkd0/1q9WxQpDyXvN9/DmrnxdnGYI1DYqiuP4P2t8Q62rxlyFJvLbuiTmV7KE1Yv77
         WYWSOFGWFp/J7MkhO5C4yvhlcrGeFUOSqoInOHpRzfDOnN/wa2PqGVGZR74cUmRcczOs
         uzfg==
X-Gm-Message-State: AAQBX9e1a4NorOvYL8hHDYaEzAk0/l6tdu6huYsqskhwKuP3st+Rwisj
        el/VSbhsNzxbe6XXo7l920Q=
X-Google-Smtp-Source: AKy350YBfbjvfjeQ0sD799bOScyuPO276lIbLuDkqHFHL2HlShdNtg9EsNM1V+hrzVVo4DsgmCrraw==
X-Received: by 2002:a05:600c:1c93:b0:3f0:b1c9:b676 with SMTP id k19-20020a05600c1c9300b003f0b1c9b676mr7756064wms.2.1681739139515;
        Mon, 17 Apr 2023 06:45:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c7406000000b003ed2c0a0f37sm11966478wmc.35.2023.04.17.06.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:45:38 -0700 (PDT)
Message-ID: <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
Date:   Mon, 17 Apr 2023 16:45:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To:     Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lifeng1519@gmail.com
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230413063317.2455680-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Li,

> The default worker affinity policy is using all online cpus, e.g. from 0
> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> have a bad performance.
> 
> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
> socket worker threads.  The parameter is a comma separated list of CPU
> numbers.  The list is parsed and the resulting cpumask is used to set the
> affinity of the socket worker threads.  If the list is empty or the
> parsing fails, the default affinity is used.

I can see how this may benefit a specific set of workloads, but I have a
few issues with this.

- This is exposing a user interface for something that is really
internal to the driver.

- This is something that can be misleading and could be tricky to get
right, my concern is that this would only benefit a very niche case.

- If the setting should exist, it should not be global.

- I prefer not to introduce new modparams.

- I'd prefer to find a way to support your use-case without introducing
a config knob for it.

- It is not backed by performance improvements, but more importantly
does not cover any potential regressions in key metrics (bw/iops/lat)
or lack there of.

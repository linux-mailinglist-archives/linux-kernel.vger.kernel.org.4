Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC307263B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbjFGPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbjFGPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:09:21 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA561720;
        Wed,  7 Jun 2023 08:09:20 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f6148e501dso13700525e9.1;
        Wed, 07 Jun 2023 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150559; x=1688742559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Tfr++mPN7lwxIu391zOQKRd2DnQsvqPWThhmfURIKET36MfOGmpTCauXmANTQg5OTz
         DxVt5be22SHkRoEv7WLzg64wL2xEgslB2GUHXoXKPp9m655ffTsJ6w8DL1g99fDL0CMI
         5imruTEoEH9V/KoFlAiK3odRrOBhXCAe58rlpoo7n+inaunFBGurdw/pNsVDNA9u9f4w
         lJwP/vENZvvRhJq30lnOFfYMy0nFjH4s3H+HSPNE9SQBJCUgGSSYSkVcBJ8hzjDyLPO0
         4ppUVf6YlUNv9c1r0TOT8DLr6fcAJ6TIg8dudckVEa0BAr5Y4JoZi2Uyk4V19xgOGIdi
         jHyA==
X-Gm-Message-State: AC+VfDzzCcqwLLGUB2K9u+vgVRIyX0f7c631AbU/eF+7yrUg3B5TeCH/
        xJyWaYBTVrvnQHyMt0Pud1Ui4zttZZc=
X-Google-Smtp-Source: ACHHUZ5/26BTbJMRoP8XTsZlcyMHQa/LbgWoM3h1E/Xrk8NzT0bt7lrE4blBBatA5XZZ3SEl7N51ig==
X-Received: by 2002:a05:600c:3d94:b0:3f7:3579:2843 with SMTP id bi20-20020a05600c3d9400b003f735792843mr2141492wmb.4.1686150559063;
        Wed, 07 Jun 2023 08:09:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003f7e4639aabsm2448473wmk.10.2023.06.07.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:09:18 -0700 (PDT)
Message-ID: <718fa1d1-2c1c-a373-e96f-2aac9017c280@grimberg.me>
Date:   Wed, 7 Jun 2023 18:09:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when
 unregister fails
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
References: <20230606122411.7972-1-dwagner@suse.de>
 <20230606122411.7972-2-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230606122411.7972-2-dwagner@suse.de>
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

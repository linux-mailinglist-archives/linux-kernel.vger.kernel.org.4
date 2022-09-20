Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C535BE47C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiITL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiITL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:29:44 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FE8E098
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:29:41 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id az6so1682382wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=URWCXNQ5YHvkyCvX5bdKcCLQ4Piclp57iUCltD9+ciE=;
        b=BNAxgRxJiocsUdSPLR3bOkydphJZfD2kDx3KtFtYpdyRXGllVQTGfsHJFYR5dNOZaa
         tjTqW6uCzPt2L8IyX9irmsY7QFpxqv7zBaPRYRdyHoi469IT6jcxASd1pn42GSPeYe6k
         tI2kRC/2lEy5aKUbrFqZntowPm825SkYXOoRi0U4RTcaJNTeiM1xa73G+FIMOLB6UnaF
         GtY+qJv0r3BTKJqHAxuZXM4+Uu9CgF3Jpumq2McrHfOISU8mSSOG1lqsXhCzhqPLpaCy
         8OLQfC4zz6mUI5/baJZxIE18vOHyZPzA8bAW1uCwR1sqgyToPOZgZfyJYZ11l8pc9v5R
         lyAw==
X-Gm-Message-State: ACrzQf0SG5Omve6KsbbL6dgDQZW6NxTnpHaTzZWFgL8GQuIwUqHoZ6T3
        3vr6m04oUwXLl8pByVMf4X0=
X-Google-Smtp-Source: AMsMyM67dmckDdLq7F5wSsz+U8zB0mfdBBfKguo9pV4uQ9FyZiAr6SpKsl3ZxyomPp1YxslmdEEkOg==
X-Received: by 2002:a05:600c:4e94:b0:3b4:baf8:cf18 with SMTP id f20-20020a05600c4e9400b003b4baf8cf18mr2078891wmq.170.1663673380152;
        Tue, 20 Sep 2022 04:29:40 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c502200b003b47a99d928sm2174187wmr.18.2022.09.20.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:29:39 -0700 (PDT)
Message-ID: <c4f7f644-9dc9-48ed-a411-5074fc51f9cd@grimberg.me>
Date:   Tue, 20 Sep 2022 14:29:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
 <20220913014253.931724-2-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220913014253.931724-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:

Would it be possible to resend this patch rebased on top of nvme-6.1?

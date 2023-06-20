Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA96736E71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjFTONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFTONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:13:11 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06596B1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:13:10 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f9085f97a4so8704625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270388; x=1689862388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=e9scUHTPuiRjsrMvyUQ5D2oRSKA11naC7MHXAkmYN1QbYNtqGqP/SpfHxwPljENz0l
         GAVjReO1VxnPid3fj5bHsBRUX3N/52efo99ezl5EnaIUhRMgUJKHtSTChBCrpkx+EqTX
         oBhBDNUqpI7bNfuz1BM2lNgXjc1EQaH8AYwSvSeRbbnD6wO5Txzm2UzN+oGqZYhd28rn
         bC9/6U72fB/WJ3LRIajGPpNtsbulqd8jw4KxNFC/Igs7dctu7Hs7yTPqtXEqYMGGV9l8
         kn0a6v0xhoqZWxCXkKFuSa9cOuYzgaJHsOZvjQRfTYsIHCz60MHRh+hbJb7CSd9l5Yuh
         0Hzw==
X-Gm-Message-State: AC+VfDy8DswDcQkXDJTBCe9v/OVrKE9i5ZvUG82owIuAeSZp+SBb442e
        vzQWVviaXUJLEWvYsyDwL7E=
X-Google-Smtp-Source: ACHHUZ4g3isyRwCrwcjd2Om7u+FTf0FHHIAZ/J9ebt+mRhj31XdhigHftz/TVnLibCmotJ54wqtjTA==
X-Received: by 2002:a05:600c:3c87:b0:3f8:efad:31ee with SMTP id bg7-20020a05600c3c8700b003f8efad31eemr11170736wmb.2.1687270388436;
        Tue, 20 Jun 2023 07:13:08 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003f907bdeef3sm9769924wml.26.2023.06.20.07.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 07:13:08 -0700 (PDT)
Message-ID: <eb0d768d-d395-e49f-c478-394f5ce9f656@grimberg.me>
Date:   Tue, 20 Jun 2023 17:13:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230615094903.1341683-1-leitao@debian.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25771094A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjEYJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjEYJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053C139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685008434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0TswLZiuTcFZhOtfA5is2rv7dXuw9Ktiejos0vq5FE=;
        b=TuFogsdVRMjxtFx9WdieZAstRxe/JunPwSHZQjoJO53gP/noxz9GFO0kFqq3VGC00//yg0
        Etez+Z1GWGZp5FCPdqOsLB6xYMCumf0f3jWA+3UotiO4nCqE8p2B8ZLUdrbKB/XAeQqQXR
        fXYZ9wCmROpIjDbhQT79tFdNQ/RDZVw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ofh9wgwHNqCQ7HZzFSMRDg-1; Thu, 25 May 2023 05:53:52 -0400
X-MC-Unique: ofh9wgwHNqCQ7HZzFSMRDg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-96f6fee8123so44805166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008431; x=1687600431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0TswLZiuTcFZhOtfA5is2rv7dXuw9Ktiejos0vq5FE=;
        b=X3hZ8TylwPOgfMXLZXI/S0b/Qrj8wQcH6SMKvYIjD2YD74vAQURp7DDt3wArosW0gb
         N6+SleJ6Z2ZCbDoDPOUhbvGjPTdRH2CMD4zPFqRsYxcNXo2bVS3P9JH2WyLtVmw6DFdk
         pdKC3UL0ygbDes146pcNdocV9P3mOaIbtg7Kt6fVZPU5CC3gKt/E7KHxZmgPHcBHwIfW
         GtrcBEAFP3RS4JDv9gKM90WfVcBqlFKf3wafnrCx5xg+WqTon/sEhowCrUNxa8YKzISC
         Q6Wmfa639sRvaUGkkJkcrcX1vDItuP1BTf7gw98nf2qg4rJwoE2+qOWlp49KfCjRS/ee
         uGcA==
X-Gm-Message-State: AC+VfDx6j0oppI06ZKkxHRaTGGco1xFrEtR3ArT5qV6ZhNVo9nfJNFYm
        xkoilJpTZA9ZbP9WkxoA5cfz/tS7Dg/GMkab4QoLSh3qnYNQJzVQUxbMB1Q6C4771WonKD/1HYV
        SnQdipzL02IFEvDnTByCEntQS
X-Received: by 2002:a17:906:ef0b:b0:947:ebd5:c798 with SMTP id f11-20020a170906ef0b00b00947ebd5c798mr931208ejs.54.1685008431433;
        Thu, 25 May 2023 02:53:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6M8UlWgrb7S33MQ8fHo90AEfW4XT6eXh87t2Np2motIhZaJRdoKW/lc7d27n1kS2dNtBxZeg==
X-Received: by 2002:a17:906:ef0b:b0:947:ebd5:c798 with SMTP id f11-20020a170906ef0b00b00947ebd5c798mr931188ejs.54.1685008431092;
        Thu, 25 May 2023 02:53:51 -0700 (PDT)
Received: from [192.168.0.46] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906049200b009661484e84esm618086eja.191.2023.05.25.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 02:53:50 -0700 (PDT)
Message-ID: <8a5cf5e9-9582-a0b1-b374-753035c2ca5d@redhat.com>
Date:   Thu, 25 May 2023 11:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/deadline: remove unused dl_bandwidth
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20230524102514.407486-1-linmiaohe@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230524102514.407486-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/24/23 12:25, Miaohe Lin wrote:
> The default deadline bandwidth control structure has been removed since
> commit eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
> leading to unused init_dl_bandwidth() and struct dl_bandwidth. Remove
> them to clean up the code.

I wondered if it desire a Fixes tags... Anyways, it is just dead code.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F76AE3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCGPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCGPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:05:36 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E17E897;
        Tue,  7 Mar 2023 06:58:35 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id x11so9817649pln.12;
        Tue, 07 Mar 2023 06:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWJwHQNCTLgErc1vg/iPxUDh+PSydV45wrKzi3IF5RU=;
        b=AhJb3Rm6knG7IiAM2Cwoa+cJB8FZgNApHiX5ZWurdV6tptowpuRIrKEcLOkhAL6vxb
         j106k1ZRdc6XfoDbD33Wp57tkp+wT9fUg8k3VginzkSBhkdPAiHBQhqfJky9M82pvukU
         RNE2IPE6jYVmnuVM3r20fawulbXsgm2fdbGrLXYJ8MVcPYg5JopUwtkNDtvHOVUdJvJQ
         3KPYeptBV2yYrmE0qaCjyS0sh9TadP9UzF6zJjFVd4nPLM+4H6amMf03FoXvQQltZcCq
         lmazndrszF3zxjdzjp6C1DuYNBUgE4lSSrVsgvEQWHn+TOy/W2OAtBT7fl8TSqJqHcTz
         uLDQ==
X-Gm-Message-State: AO0yUKUqrsnDnwNiBjaQBhdBEirGAyeaBV4NtYTMHB0GClxsJyAJoQ3B
        PjEBCzFri6e7nEgHV0bzEIg=
X-Google-Smtp-Source: AK7set9+BdLMAhJYQN3qA6/DzIyARcN0o5SXgbby9Opjq1V1/73l3+OB4slzvGzRQW5d95ylmpt56A==
X-Received: by 2002:a05:6a20:4b0f:b0:cf:71ee:6329 with SMTP id fp15-20020a056a204b0f00b000cf71ee6329mr8094633pzb.7.1678201115050;
        Tue, 07 Mar 2023 06:58:35 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b005b02ddd852dsm8206361pfm.142.2023.03.07.06.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:58:34 -0800 (PST)
Message-ID: <7c66fd8e-78bf-9f3e-0baf-36a8fef27f45@acm.org>
Date:   Tue, 7 Mar 2023 06:58:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/11] scsi: scsi_debug: Don't hold driver host struct
 pointer in host->hostdata[]
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
 <20230307105555.3745277-2-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230307105555.3745277-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 02:55, John Garry wrote:
> +#define to_sdebug_host_from_shost(shost)	\
> +	to_sdebug_host(shost->dma_dev)

Please make the name of this macro shorter and following naming 
conventions used elsewhere in the SCSI core. How about the following 
name: shost_to_sdebug_host()?

Thanks,

Bart.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7A6CCA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjC1TQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjC1TQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:16:04 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673830FD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:16:03 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso10097754wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030962;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8ZQhFwzV6bNnVy05rsCSnE52HfhjbIc2keuM5D6r/8=;
        b=KQIgkJW8N9r/zM6caSNOq85K18MPHMjaFDkg+lg+7cSJY9svhMLHDUNfqE8BmkoYxs
         F/Dkq+JRmqAok22cqyp5WwTVngl+DbRsVpK42LHuzbtzg4ruq9O2nY7InMNEwm5+s1wf
         WVwDjUUhYKVeoUoE+adfNN5bWiXcA0nd8FtY1bN1OG85YrYxafRhuCiNabLIpoO/fFRY
         Ns0mMSL/UQCCfWKexyN53688IIqencPj5UdlG7n8O9cXgLr4Rlf2nHXZeiK7HR3+LlZe
         yFrd58fKM+8uXwvF7TLyDaL9cyUVE8NYy1zWpoz7kI2eXKMQTzpQ8cMof8e7u91PaVa9
         jfcg==
X-Gm-Message-State: AO0yUKWB9SUahKC96nJiEp7lyTqNuTlUk2HkXTZQe2LCcx4cOC6kdMmG
        7zuuR6iPK3RIUkCWI7SKVBf/Kd1nVaDpug==
X-Google-Smtp-Source: AK7set/AWJ2TJNZU3wqLgYZsGlngApy6IOn7saT84c7cbkYnkongE2tbrycaC8mp621QfyBexkK6eA==
X-Received: by 2002:a05:600c:21da:b0:3ed:346d:452f with SMTP id x26-20020a05600c21da00b003ed346d452fmr13672429wmj.26.1680030961847;
        Tue, 28 Mar 2023 12:16:01 -0700 (PDT)
Received: from ?IPV6:2001:a62:1493:d101:4d3:48a6:f3ea:7a64? ([2001:a62:1493:d101:4d3:48a6:f3ea:7a64])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003edc11c2ecbsm12161695wmi.4.2023.03.28.12.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:16:01 -0700 (PDT)
Message-ID: <29e2695e-a08a-2ffa-4323-c0286fcea9ef@kernel.org>
Date:   Tue, 28 Mar 2023 21:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
From:   Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v2 1/3] mcb: Return actual parsed size when reading
 chameleon table
To:     =?UTF-8?Q?Rodr=c3=adguez_Barbarin=2c_Jos=c3=a9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jth@kernel.org" <jth@kernel.org>,
        =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>
References: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
 <20230328143441.78932-2-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230328143441.78932-2-josejavier.rodriguez@duagon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 28.03.23 um 16:34 schrieb Rodríguez Barbarin, José Javier:
> Function chameleon_parse_cells() returns the number of cells parsed

^ The function?

> @@ -239,12 +240,15 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
>   		num_cells++;
>   	}
>   
> +

Stray newline.
>   	if (num_cells == 0)
>   		num_cells = -EINVAL;
>   
> +	table_size = p - base;
> +	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
>   	kfree(cb);
>   	kfree(header);
> -	return num_cells;
> +	return table_size;

Ahm doesn't that need to be:
             return num_cells < 0 ? num_cells : table_size;


Otherwise we loose the -EINVAL return here.

I could've fixed up the 1st two, but the last one is a functional change 
and I won't fix it
up when applying.

Byte,
     Johannes

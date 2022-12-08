Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA53647500
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLHR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLHR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:29:14 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFC98940;
        Thu,  8 Dec 2022 09:29:13 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id k79so1826575pfd.7;
        Thu, 08 Dec 2022 09:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztcXmUJ4P+6GjCnHFY/BSOYOyDGiUUKbnQUPEYp5yqI=;
        b=f7ncjaNwKn8kmCqGRFRKpHmtwMeEY+9zg+qFpY69vDsHJ8puTQPXvI/MKqljekeVtT
         WyvFnjuagkbH0ILhrwnR7M5Uy53Fjv+RXwKC/KDrtZS9oVzlPjxLeeleNgOxaaq3conD
         XcjTOb0tNl89v+KESXvvOddxXKxVq56+CLRWYOECqrU1q++/ASkVyUFDSZ92oNL0YVgK
         QvMzzhZO5zumC7qSOKVth1HL784rPhnQkFFg7p4OF1U+Dh9H24mcxS3hJPDUwq+qnceM
         N2vigPmcpQaNcv0O8ln8JCh852Dsx1c3PtIAfAfHpmx5B0w1yyXruQpoMtvhTeqPOT4+
         8PCA==
X-Gm-Message-State: ANoB5plb5nX1dvRZmXrZdvQbFjixRLTWYNEoKEZ6y/19a7SbXuGF+0eF
        QIptzMe38KVN4rCmxaUJ3cc=
X-Google-Smtp-Source: AA0mqf7T4077ASs2izTlVklOWK7nSR0lb4Po5Sq1V/mwM/qza21Sv1QGDCq9Dnp1/AbLn2Q4rw8XUg==
X-Received: by 2002:a62:6406:0:b0:576:51c:e539 with SMTP id y6-20020a626406000000b00576051ce539mr36123426pfb.6.1670520553078;
        Thu, 08 Dec 2022 09:29:13 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7b97:baa3:badc:5af? ([2620:15c:211:201:7b97:baa3:badc:5af])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001782398648dsm11512412plh.8.2022.12.08.09.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 09:29:12 -0800 (PST)
Message-ID: <e4ba7d84-e681-379b-19e1-abad3dbe43da@acm.org>
Date:   Thu, 8 Dec 2022 09:29:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/4] ufs: core: Remove redundant wb check
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 04:08, Arthur Simchaev wrote:
> We used to use the extended-feature field in the device descriptor,
> as an indication that the device supports ufs2.2 or later.
> Remove that as this check is specifically done few lines above.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



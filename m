Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AA64974A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 01:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiLLAMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 19:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLLAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:12:15 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D895BB;
        Sun, 11 Dec 2022 16:12:14 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id o12so7259393qvn.3;
        Sun, 11 Dec 2022 16:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbsJncDF4k/nje7/k7lqGjJdwRQs7s+dB9lApe4/jJg=;
        b=T/00l0PhFJvmtdZyqljFQvKDedQi+ga5gWzep07+ajdBSU294HVQvdfptfQ9FEI/b2
         3h32K2meJ07KDUGoZYDGRle0eCPg2NwqFCpzV1Fl2vbTyZxkR4bPzWdjLXjg2F8ibOaR
         n5pK/d6FusDZD9MkRn3YRMSCbsWsGFEH58UK7fFN1ipE6OfgyL2m/y0DguhTBHk1l10F
         0cMIvSkNhQoRX3ujIiZkbyCMjVEDkbb91W1C7RgPE7EW28fYxaLKwE0KXeIy4i0v9sGX
         YksoWKf98vnzi2tCHC0syYd2i93CYXi1PiN1E5OoIGSFyQRri9i3OU01lILtSabDT/fR
         Sp5g==
X-Gm-Message-State: ANoB5pmYfGg72ksytkqmkwoEqL3Pfpm+WWxs3qSDzmET5PtEIcZ3GbQo
        eLyP81q/I5MfInhBgoR7HhY=
X-Google-Smtp-Source: AA0mqf5fbxnDNw0pxU2VtPnYdOTuwUwOhWk3ENQ83l+WSeM50DRdYxkZWaPzy7QhUIvcuvw4japzkw==
X-Received: by 2002:a05:6214:43:b0:4b4:a3d5:17da with SMTP id c3-20020a056214004300b004b4a3d517damr16910109qvr.14.1670803933010;
        Sun, 11 Dec 2022 16:12:13 -0800 (PST)
Received: from [10.205.211.210] ([67.142.235.252])
        by smtp.gmail.com with ESMTPSA id bi35-20020a05620a31a300b006faa88ba2b5sm3267251qkb.7.2022.12.11.16.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 16:12:12 -0800 (PST)
Message-ID: <d9837210-aacb-4941-a9bd-beed6de86aec@acm.org>
Date:   Sun, 11 Dec 2022 16:11:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 2/4] ufs: core: Remove redundant desc_size variable
 from hba
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1670763911-8695-3-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1670763911-8695-3-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 05:05, Arthur Simchaev wrote:
> Always read the descriptor with QUERY_DESC_MAX_SIZE.
> According to the spec, the device returns the actual size

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

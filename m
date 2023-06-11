Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782F72B241
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjFKOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjFKOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:06:55 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E92D5F;
        Sun, 11 Jun 2023 07:05:10 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b01d3bb571so16743425ad.2;
        Sun, 11 Jun 2023 07:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492262; x=1689084262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3aNsVT2Zyjlv5yI6jAICSDyYxatshbbYQsLDjEFFKE=;
        b=M/AsVNHHeocx9wcbxGIVwBp+NCQ6lhz412dwdg24i62OHNgBxqzo0OySToaliDvrJ5
         NDFqL3mK2Q+wGI0t9bFmfEGJHyFzDUxp6JhCAqWmFAL6swl6aNCQ3GRqb+gjFTNay2YA
         LjyWG3gHkByPTkz3hV3ucsoM4V07Vev6xgTYPqcCSbMFKiqoEn/GuF3EcYinXOL45GjK
         7smX740UAe0yCQXTNZBzWAddBuCRlap4pj8NPL/InxGQXOCF+hTQxQm1whiTYyWFgHye
         2TEasDQ+rBN2N8fvMBlYeuhBgZUmAGFbWeyE052TepE/TbXMIWfEfLDtMRM8sdJyDLGa
         lFGA==
X-Gm-Message-State: AC+VfDxI8EM1xS7zttydc64V87HXHwpSpjmwVpdwmrA26z89EUe5T8Xz
        sFwYK3OiNsz7j/pl36/FG58=
X-Google-Smtp-Source: ACHHUZ6odNRYSU945jpWDAuFs/i2irvaRQA2K8MvuiANF3UazTkEWAJQmXgYy/BEyEKMvRGsoi2CYg==
X-Received: by 2002:a17:902:e885:b0:1b2:61eb:a735 with SMTP id w5-20020a170902e88500b001b261eba735mr5575807plg.38.1686492261981;
        Sun, 11 Jun 2023 07:04:21 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001ae0a4b1d3fsm6459966plg.153.2023.06.11.07.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 07:04:21 -0700 (PDT)
Message-ID: <8fa21662-7e2d-07c1-aaca-649dead624cf@acm.org>
Date:   Sun, 11 Jun 2023 07:04:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] scsi: ufs: core: Remove dedicated hwq for dev
 command
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20230610021553.1213-1-powen.kao@mediatek.com>
 <20230610021553.1213-3-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230610021553.1213-3-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 19:15, Po-Wen Kao wrote:
> This patch depends on patch
> "scsi: ufs: mcq: Fix the incorrect OCS value for the device command"
> which take care of OCS value of dev commands under mcq mode.
> 
> We are safe to share first hwq for dev commnad and IO request here.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

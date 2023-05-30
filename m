Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C3717215
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjE3Xyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjE3Xyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:54:45 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38904107;
        Tue, 30 May 2023 16:54:31 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b011cffef2so44895495ad.3;
        Tue, 30 May 2023 16:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490870; x=1688082870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+iWViYCQVb/xzSsBfREywiRrxXxPKruIfOn3/8DPd0=;
        b=PfbMHhMP2LLKMw9XGyURqueUhWTCT7V7YIOzCq57NrJYML2+dcvBKBuGorPV1NeweL
         AD+PKOD9RuLoxCa1xlouHCO78kXShhQOclSCk1D5Gzfe2dEeR1nLNHdrqWE/cO+UrovJ
         UiUPUAx5zGsjxEC4HrlCrtB7G69mes7aubGxFAXb7HzMWUpCngtPWuOwCm2nM2zAoaNr
         REscmsKY2W2jgvzXsVHlqWjIDFAWfAd/ap7/v5kcnp2n/Me+4yOA1dvTZMAo6/ka1ezu
         zQGJvKFjEm9v2AFdqvehXldBMTUXwZkvS9DyjD1odIFyaWUQkpXrMsLBv/NkmGF8LYZ9
         rK5Q==
X-Gm-Message-State: AC+VfDyBq742Ms5B4Jjg9rZ5EfPLQLeoHHUkkZxSlHXSHxs4Jn34Hr0n
        Pod8gxJP9AXbx03HTqarLhU=
X-Google-Smtp-Source: ACHHUZ6aA6UX+ERfkedHwLCP3QGXLJg26VTfEDrtGYzZXT3pXM/s2icGJNVn/HpUNxbK93SptJYO0g==
X-Received: by 2002:a17:902:d4cc:b0:1b1:1168:6571 with SMTP id o12-20020a170902d4cc00b001b111686571mr1192834plg.36.1685490870603;
        Tue, 30 May 2023 16:54:30 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001b033873744sm6111930plb.249.2023.05.30.16.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:54:30 -0700 (PDT)
Message-ID: <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
Date:   Tue, 30 May 2023 16:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
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
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-2-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230530023227.16653-2-powen.kao@mediatek.com>
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

On 5/29/23 19:32, Po-Wen Kao wrote:
> MCQ sq/cq mapping is not just one for one, could many for one.
> This patch allow host driver to change the mapping, assign cqid
> for each hw queue.

What use case do you have in mind for associating multiple submission 
queues with a single completion queue?

No matter what the use case is, I think that which submission queues are 
associated with a completion queue is independent of the host driver and 
hence that such logic should exist in the UFS core instead of in a host 
driver.

Bart.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4E6FE681
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjEJV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjEJV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:57:23 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC49526A;
        Wed, 10 May 2023 14:57:19 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ab01bf474aso60092285ad.1;
        Wed, 10 May 2023 14:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755838; x=1686347838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu7y9LzfEIZvZTvBssNGLr/qUvOha+J51xmnyfJ7wQU=;
        b=EhwkmYPtZGKlawu2rSQ7Mo55vtRpfapPUAatS21dr1PRgqFpj8VcwVD1vGDuanEcHz
         EJxUJoZmkyu658x3rlmdMY3eeFGFVAUk54nhtjjC5KVMXx4t5AYpYjF8YzQE/d9zhecU
         beK5OIvv4SQi/yyJ69Puz3S3xUz+rWR7vU8yPXgZrsQkuwCpo/BV8w+Xqv0k/kNt1XeA
         NEfQgBe6PDdW//EQBj+yUM1aO0IwZzHCwTkvWBMrr954l+Z4uixovFIKZuTdysvFaFrw
         suwAgCHO5gYTVhV5eY0k2zWl0Rx9nmwwVzZ3k9P6DlSt/IA9PcDDgthcv0nin1+SG+PV
         CfIQ==
X-Gm-Message-State: AC+VfDzcxpGw5Dhuhq2Oxoz6+opuqVfLrVqRjvVaHEXEJhcGPJvSDRnE
        0UeTXYn2X80oeXXJ1piKIyo=
X-Google-Smtp-Source: ACHHUZ5VzcSPauKR0pgfG9bCdnELPy9qfPFHtYXMHKVHVqr998Pa5j/xE5UFJ7+7jO+vlsSf1DBwPQ==
X-Received: by 2002:a17:902:7001:b0:1aa:df9e:2d19 with SMTP id y1-20020a170902700100b001aadf9e2d19mr20321367plk.54.1683755838449;
        Wed, 10 May 2023 14:57:18 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:d8b7:fa5f:6808:3db3? ([2001:4958:15a0:30:d8b7:fa5f:6808:3db3])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b001aaef9d0102sm4270530pls.197.2023.05.10.14.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:57:18 -0700 (PDT)
Message-ID: <9549e867-fddc-8625-0a34-862f648bef75@acm.org>
Date:   Wed, 10 May 2023 14:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] ufs: core: Update the ufshcd_clear_cmds()
 functionality
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
 <6c9990cd13220ceea343b1e5ba463732c4ccffb9.1683688693.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6c9990cd13220ceea343b1e5ba463732c4ccffb9.1683688693.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 22:24, Bao D. Nguyen wrote:
> -static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
> +static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 task_tag)

Since this patch changes the behavior of this function from aborting 
multiple commands into aborting a single command, please rename 
ufshcd_clear_cmds() into ufshcd_clear_cmd() in this patch.

Thanks,

Bart.

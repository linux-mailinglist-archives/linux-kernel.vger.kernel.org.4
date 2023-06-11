Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2172B223
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjFKN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:59:30 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA6E57;
        Sun, 11 Jun 2023 06:59:27 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b3c0c47675so3952885ad.1;
        Sun, 11 Jun 2023 06:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686491967; x=1689083967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGcBhD0QJ/SDVN3EhFINqJYKQ61sqPGoftqj/7P70NA=;
        b=UlJl3GRZpc4GNE7ImYIqBjt2SRi9uJOsWpAF4ON3jMs93TVgl/GzRxXI5TkBnGPNWf
         UzUqNFUtmnq4otWR1L05tRPBRejkbx0CrOYQJjUggw0tuDN9DQariuxDXoq3PvmCY+yF
         U326jrJoZJod2RLEXPP/5wlbsJOfq1tljdafVtzOK6dAzyx4ZoCuOK/9I0j5CL63LwuZ
         w+gfmAa1kHplUECS68em6nonYfj62JajzcvU8lMtM4tTkQz0WWUjPhgISuNP2LmC/xKI
         xAbHXOz4B/Llp10bh6yvnR3QjmpuK37V2jVR0J/J4G9gLfwLSVbHDCTyV7BIqkf9Y+ey
         l4Rg==
X-Gm-Message-State: AC+VfDzftwCuWBM7CWqHIJRNF+dW3Y6gFGk/66ijifAsyoEI1qzd8pBU
        huHby7UdszTIAv+z3drgzbw=
X-Google-Smtp-Source: ACHHUZ6IsISFV4tY6Qv5XaU6ArqGmNrcGtIsLbka5W+fKgbHv4JIAUTaIHORVi2LdEduBrJq/il1iQ==
X-Received: by 2002:a17:903:32c7:b0:1b0:4c32:5d6d with SMTP id i7-20020a17090332c700b001b04c325d6dmr5724979plr.31.1686491966644;
        Sun, 11 Jun 2023 06:59:26 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001b034d2e71csm6414306plk.34.2023.06.11.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 06:59:26 -0700 (PDT)
Message-ID: <0367b612-b6a5-8fb1-9cee-28de04b7ce81@acm.org>
Date:   Sun, 11 Jun 2023 06:59:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] scsi: ufs: mcq: Fix the incorrect OCS value for
 the device command
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
 <20230610021553.1213-2-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230610021553.1213-2-powen.kao@mediatek.com>
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

On 6/9/23 19:15, Po-Wen Kao wrote:
> From: Stanley Chu <stanley.chu@mediatek.com>
> 
> In MCQ mode, when a device command uses a hardware queue shared
> with other commands, a race condition may occur in the following scenario:
> 
> 1. A device command is completed in CQx with CQE entry "e".
> 2. The interrupt handler copies the "cqe" pointer to "hba->dev_cmd.cqe"
>     and completes "hba->dev_cmd.complete".
> 3. The "ufshcd_wait_for_dev_cmd()" function is awakened and retrieves
>     the OCS value from "hba->dev_cmd.cqe".
> 
> However, there is a possibility that the CQE entry "e" will be overwritten
> by newly completed commands in CQx, resulting in an incorrect OCS value
> being received by "ufshcd_wait_for_dev_cmd()".
> 
> To avoid this race condition, the OCS value should be immediately copied
> to the struct "lrb" of the device command. Then "ufshcd_wait_for_dev_cmd()"
> can retrieve the OCS value from the struct "lrb".

Since with this patch applied ufs_dev_cmd.cqe is always NULL, please 
remove the 'cqe' member from struct ufs_dev_cmd.

Thanks,

Bart.

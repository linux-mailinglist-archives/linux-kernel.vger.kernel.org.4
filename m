Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82372B221
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjFKNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:54:31 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70A1BB;
        Sun, 11 Jun 2023 06:54:26 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-65131e85be4so3701593b3a.1;
        Sun, 11 Jun 2023 06:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686491665; x=1689083665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MO+ohuQcrAOw9OBmJA7Fh5q8NnQvwvaRkJI5TNnbOcA=;
        b=YKoV0zswQdUe8sO98two5/6ZPW1S2BOGrqKFwsblQx4mRDHIviDlkuS/I2eBrb23mR
         B+MD63Tt6vpOL5VK4M8qWEgwDMd8muslQnyZfDOCSw47uO730xkqpBvEcXYeVps+i9jZ
         7uf7roVHCKDoLvLrWLsvI4XuMYLQblvUuqf8Vr4dU2GX7SO+bH8Ej5Rl6QD7ccaB5iUy
         39TCJTxR8kMOrJh3JPojNs1ylJIUwX7sfAzpDVtPFLH+tLaNodOpkFeqpbUwdlziteNV
         XR9QcbXkRWBQXh+zuFU4YBChZhZFMb/xzGqJpcDYgxj+zDQrk7i078sNEDOmHNYseNRC
         oQPA==
X-Gm-Message-State: AC+VfDyjd4oBImdeBgA+xCiAQg87zQu643VlTkAtHFi2jS8lFD6F05/M
        EBbsSiu815x6I8r8u4puY4c=
X-Google-Smtp-Source: ACHHUZ6cOoivqhoGmQCBJYgZZ8gW7sltqaACH5POEZBSCvCwESFo/qpfARuMGJSyLcMwf8B2PFf+xQ==
X-Received: by 2002:a05:6a00:1746:b0:663:5fbe:c695 with SMTP id j6-20020a056a00174600b006635fbec695mr8335638pfc.16.1686491665433;
        Sun, 11 Jun 2023 06:54:25 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b0064d57ecaa1dsm5420843pfa.28.2023.06.11.06.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 06:54:25 -0700 (PDT)
Message-ID: <b9455b36-270f-f2bc-bdda-bf63f47df20c@acm.org>
Date:   Sun, 11 Jun 2023 06:54:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
References: <20230610083321.5566-1-powen.kao@mediatek.com>
 <20230610083321.5566-3-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230610083321.5566-3-powen.kao@mediatek.com>
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

On 6/10/23 01:33, Po-Wen Kao wrote:
> Add UFS MCQ vops and irq handler for MediaTek platform.
> PM flow is fixed accordingly.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB07611CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJ1VxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1VxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:53:05 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288724C978;
        Fri, 28 Oct 2022 14:53:04 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id p21so2087831plr.7;
        Fri, 28 Oct 2022 14:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHW0VpCYFExt/yJYXKv4CHfVB0y8NEIPRLasE5/M9fU=;
        b=oNoLsF0h9+0rbURD9pboRjTuA+0uJ7hoBPwsk/7OPNAdK09P5ycee2yThc/zEs+9FC
         TR8BBgUIJdvcOLxLolVfheRNEOY0J7a7J1MLHkVOwp3uc2TxAMhFuJAhS28S+4lcpHtv
         sN46PZc/bG4Jclv65+4T6FQ8f+EBFNKc6TEuH+ehLJBAKWm4FdT1fhFuc6fTYSFNsTjO
         cewzp7rt1nVLy/ai/W8Q5RjT6WueTPQIFu/zat+qKzArodaQWvrot0aTHuWUjNVretcP
         IM+5t2vANjpqD4JHnyfq+k0e8dzsRTBGMIRm7LCLhBhqKc0i9uNvVAWuX8tAPrJdc9Mf
         TMZQ==
X-Gm-Message-State: ACrzQf2crsu+MA7PYL+CuHpbR8Bsu99l2qUcm+3xTo7xMCQSbPdHXVmb
        Ccu5MIGKCeQMeuHtrqBC/SM=
X-Google-Smtp-Source: AMsMyM7B3Xyir5PKlTiNvIB9P3ZB8N9O1f8bxaCqGk3PwosEpzTJTt5dyRPVqzbE8EEaHRM0LJ0dbQ==
X-Received: by 2002:a17:902:b092:b0:186:9dc3:dc44 with SMTP id p18-20020a170902b09200b001869dc3dc44mr1167576plr.112.1666993984173;
        Fri, 28 Oct 2022 14:53:04 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090a660d00b00212e8945d97sm4618065pjj.56.2022.10.28.14.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:53:03 -0700 (PDT)
Message-ID: <817ec99a-b28e-6fb7-383d-f8a3ac578686@acm.org>
Date:   Fri, 28 Oct 2022 14:53:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 12/17] ufs: core: mcq: Find hardware queue to queue
 request
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <c70e6972daf3bb1cef6fbf157b8549bfc365f674.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c70e6972daf3bb1cef6fbf157b8549bfc365f674.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> +struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
> +					 struct request *req)
> +{
> +	u32 utag, hwq;
> +
> +	utag = blk_mq_unique_tag(req);
> +	hwq = blk_mq_unique_tag_to_hwq(utag);

A minor stylistic nit: please combine declaration and assignment as follows:

         u32 utag = blk_mq_unique_tag(req);
         u32 hwq = blk_mq_unique_tag_to_hwq(utag);

> +	/* uhq[0] is to serve device commands */

is -> is used?

> +	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

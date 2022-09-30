Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099EA5F13D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiI3Ulm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI3Ulh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:41:37 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF728165134;
        Fri, 30 Sep 2022 13:41:35 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d82so5203333pfd.10;
        Fri, 30 Sep 2022 13:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=60CrGrB0e6fs1uT+/qZjiXxM9X8SBAH3xk7kv3P7tIA=;
        b=IG8kEJ3GXaTVd+LZmlr3M5/MLvgOPMNxwRBfOJZA7lDN3A7K0FOFxPdXKTK+POnll7
         7Z9JTDgT4eohyZytrhJ1oDgFN7BYv9wFRGc/Ia42uRHNPNtJsr4m0uT1rwClgBLQxACG
         lc6sdgkD0oE7e3X6Nlc0ELVPNkImaY+XNmHchZQWJDn/AB96m4ffQpiEcheJ5Mkn+sbh
         hIQTwBsxZf7z8FmSj5V2mSAm+q+tQdGVb/4dtoUXnxu9ykHdLF312/7xNWQa8XdwMXyP
         7NdfdMrbXfQ+ZPyPzutCCsmtkgWYZFufaerhDdpUVtVQ6Oj5r39zcQPMpGnfLlVJqAOP
         t5Yg==
X-Gm-Message-State: ACrzQf3AYIhBrZh61QHGDCZmBwspNxx61Z4rvSVbF5FF1GQu+OvPd4N2
        BheyOvEz6ya1o6wYsf2+De0=
X-Google-Smtp-Source: AMsMyM5MYGchnh/5092UUxijYEqfRZb1CYA1EwF+TiolECUJn54DGNFvapBS5cLz3NzmwnxfgIr/cg==
X-Received: by 2002:a65:4303:0:b0:439:f026:ccee with SMTP id j3-20020a654303000000b00439f026cceemr9087282pgq.322.1664570495276;
        Fri, 30 Sep 2022 13:41:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9b89:d9c:f74c:7711? ([2620:15c:211:201:9b89:d9c:f74c:7711])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016d6c939332sm2283577plx.279.2022.09.30.13.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:41:34 -0700 (PDT)
Message-ID: <d0ce6b32-04ac-e3bc-d999-6a9c3d757645@acm.org>
Date:   Fri, 30 Sep 2022 13:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 13/16] ufs: mcq: Add completion support of a cqe
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <80b24ce43aadac3bf561a60a65303f36ae8c0c21.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <80b24ce43aadac3bf561a60a65303f36ae8c0c21.1663894792.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 18:05, Asutosh Das wrote:
> +static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> +				     struct ufs_hw_queue *hwq,
> +				     struct cq_entry *cqe)
> +{
> +	dma_addr_t dma_addr;
> +
> +	/* Bits 63:7 UCD base address, 6:5 are reserved, 4:0 is SQ ID */
> +	dma_addr = le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA;
> +
> +	return (dma_addr - hba->ucdl_dma_addr) /
> +		sizeof(struct utp_transfer_cmd_desc);
> +}

Since the above code only works correctly if the size of struct 
utp_transfer_cmd_desc is a multiple of 1 << 7, please add a 
BUILD_BUG_ON() statement that verifies that the size of 
utp_transfer_cmd_desc is a multiple of 128.

Thanks,

Bart.

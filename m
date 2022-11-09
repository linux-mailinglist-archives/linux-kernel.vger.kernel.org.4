Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F106235ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiKIVgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKIVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:36:50 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78138133;
        Wed,  9 Nov 2022 13:36:49 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id v28so17889115pfi.12;
        Wed, 09 Nov 2022 13:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekjpjj5nyN02ZyfoZICWJuW6QISswDAaeSQvs1DRQ84=;
        b=HVqUYnt3bRKc7rORpe/AIpGQRsbRR5zSPzm4WPxlcjJAzTOV0POx1e5jE658TN57oW
         EsW0OFP5piI+LU9H21pZeOnKxtc7cDms91kYLJOY2T5s4aRh/u3pLMVykC52orKVcPhH
         gbswgU1+y5rHWgIOmm36l/iA20lN29ChkbnXIkL5UOQUUOwOoNOUNoqAUUv5m6jLy4Nj
         YxxosiSaEm7TmwgZ1SdHIhoFf0rxkGEBCBMZZZDPY7gRb/4yd2quoIa8lX/o609Uhc9T
         f0Bz7KYmC01/asUxsxfpDIcCD1C1Ry7peV4nSpD/MGwBNA3+qK8rdgW6Nb3Hg7NN72Lb
         tw1g==
X-Gm-Message-State: ACrzQf0ymLF9+7BOTdmVvrDzm3O4kvFmxt6+6/DXA6gtGh3jezu6BNDh
        E+k+/2r5VwaLoEt/8BByvd8=
X-Google-Smtp-Source: AMsMyM6/C1Wc5PHegn2vrSEu9cg71zeZc/wuTrrXqxaqv4MFT6f1cqdwd57D+D1+gR8oY198br7XpQ==
X-Received: by 2002:a65:4b85:0:b0:46f:63e:9e30 with SMTP id t5-20020a654b85000000b0046f063e9e30mr53016358pgq.409.1668029808965;
        Wed, 09 Nov 2022 13:36:48 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090a8a0b00b001faf7a88138sm1653665pjn.42.2022.11.09.13.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:36:48 -0800 (PST)
Message-ID: <3d1474df-4dfc-4c67-2fb7-8fd81fa375c5@acm.org>
Date:   Wed, 9 Nov 2022 13:36:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 08/16] ufs: core: mcq: Allocate memory for mcq mode
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <2bfd44292d48b024ffa161c055e7e6fe908281b9.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2bfd44292d48b024ffa161c055e7e6fe908281b9.1668022680.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 11:41, Asutosh Das wrote:
> +struct cq_entry {
> +	/* DW 0-1 */
> +	__le64 command_desc_base_addr;
> +
> +	/* DW 2 */
> +	__le16  response_upiu_length;
> +	__le16  response_upiu_offset;
> +
> +	/* DW 3 */
> +	__le16  prd_table_length;
> +	__le16  prd_table_offset;
> +
> +	/* DW 4 */
> +	__le32 status;
> +
> +	/* DW 5-7 */
> +	u32 reserved[3];
> +};

Since this data structure comes from the UFSHCI specification, please 
mention the name of this data structure above this data structure, e.g. 
as follows:

/* MCQ Completion Queue Entry */

Thanks,

Bart.

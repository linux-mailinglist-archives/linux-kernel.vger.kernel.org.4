Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0660CDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiJYNhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJYNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:36:54 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE7C171CFB;
        Tue, 25 Oct 2022 06:36:52 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id l6so7308103pjj.0;
        Tue, 25 Oct 2022 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Acu/xNd/HmZ/EXl3u9/qJoTfHx6u5hhQzvnjXM48pQ0=;
        b=hirXNIB3fAWgNkk9D1OURfpbjLNhC/FSMDRfjSkNyT9nznuvUmy6nDQqGWSgBL78XR
         huZ00StUfvZwpTXa5HNVXdgtJd60bs/ayK2JVqv/BKscB+0g/TDyfbXILCBOm5ZxjD+A
         AVGnPfydbdzuq43N41hcqKwP2nvlW/IbfISdZPqxloDQx/9k1vKNGxJ5YuG7MamUvIV/
         +XIOp9q1DMyWNSeo55BSJyrvF7ooqaNKjg9CVOBIlUSCSjLDQbFYk0qfaVCGfMWv5y5c
         VGNfldnpfTCNF6Tcrn7FaK1adyr9v4SuQ0qzLI9RpHdYIvEhqLS4xFQv7Iy4mIt649o3
         ey5A==
X-Gm-Message-State: ACrzQf2j8Pp2nbzOdvt0xSfAGGUJfB9TI1wPGTmfCfL14xm4dp/7D94m
        Jy6+Sc22zCpfb+51u0fWTISDI9QNPA0=
X-Google-Smtp-Source: AMsMyM6wWzB+vzPHbyGyvAdru1He4hA7BRl54Pgfzx30gzgZd3AXnq7KTLElE9LnGXjWQd0by2S4HA==
X-Received: by 2002:a17:902:7c0d:b0:178:a6ca:1dbc with SMTP id x13-20020a1709027c0d00b00178a6ca1dbcmr39102831pll.115.1666705011879;
        Tue, 25 Oct 2022 06:36:51 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f12-20020aa7968c000000b00560a25fae1fsm1381386pfk.206.2022.10.25.06.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:36:51 -0700 (PDT)
Message-ID: <c1ea0854-5375-951e-e90f-63578aa824f3@acm.org>
Date:   Tue, 25 Oct 2022 06:36:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-3-beanhuo@iokpp.de>
 <1915c52f-0c76-0f90-97e9-0c27c36a9e1a@acm.org>
 <2f0141705b06339d31063c731b0511fc186364fd.camel@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2f0141705b06339d31063c731b0511fc186364fd.camel@iokpp.de>
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

On 10/25/22 04:44, Bean Huo wrote:
> On Mon, 2022-10-24 at 16:25 -0700, Bart Van Assche wrote:
> If having a look at
> 
> scsi_change_queue_depth() {
> 
>    depth = min_t(int, depth, scsi_device_max_queue_depth(sdev));
> 	...
> }
> 
> so the final depth per Lu is still 31.  I did test and debug, this is
> true.

Hi Bean,

Thanks for the clarification. I will add my Reviewed-by to this patch.

Bart.


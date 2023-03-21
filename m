Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA526C37EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCURMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCURL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75B5370A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679418620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eV478PA/Hk/t+tkEqxFD+LaNbEr3bs77VNjalKwaSeE=;
        b=dkbzQW6OYSAwtk8LbaWcM9U+ryhWI2jlJbwI4keO+j8Mcqtzef56tBlbkpPKgmIX7zp/qM
        6YEwhpR6viKbEooD4THzvukOBt6KP2YusDQzmt8WC76HmXmaHWgFo5CHp0XuLEKgb7MwOs
        E1gDJM7Ie/CuckAD3+v1i7Bmyg6xrEo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-FaKpEkUQPuKGw19JmlhB8A-1; Tue, 21 Mar 2023 13:10:18 -0400
X-MC-Unique: FaKpEkUQPuKGw19JmlhB8A-1
Received: by mail-qt1-f200.google.com with SMTP id s4-20020a05622a1a8400b003dbc6fc558aso6896337qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418618;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV478PA/Hk/t+tkEqxFD+LaNbEr3bs77VNjalKwaSeE=;
        b=NuKT2upgmzJD13pn4FFyk4E5+XpL8H6QpfI73PKKMLhcA1RxaUkmRCeTuflvCQ8Y1z
         3Wy8QTkyxZheE391zvz/AFo5mj/4+lPq6vZXLDFF8I1MaUwnun3uC0qwAmr+lMo9pjNz
         Ow7tTyvtIGzrFEP8cAilrt73wgzPEtSm4MYs2U8+/oolblEvY/Nz3gQj5JT/gw5CYKtO
         rTbN/OsDHzNdrxZolxEkORu5mbP8gG/0zq0dseUgiKTq6RqqXXr8aigO5gtGuEainp/J
         AbONN+bCgrDBcxCQjF8Aqffbkc/nJKX+joHa+r8sr77DaU2YaJqDzUvfRie7YuvnS3Dy
         yz+w==
X-Gm-Message-State: AO0yUKVUz8Cxkh0thYA5MpSUml9OED89Pd9vFNIlrbFlu/vESI5BDmki
        BsW+gZg+vJkyevUScOSrrBI3KUSYBTluIB3cv16oB1Hwb0W0OCpZjm6hiYUZtoyTE5L7gNiItao
        8WcvgOPq5sQ0msTz8XomP3kf2
X-Received: by 2002:a05:6214:1248:b0:5ab:af50:eb41 with SMTP id r8-20020a056214124800b005abaf50eb41mr1268685qvv.14.1679418618056;
        Tue, 21 Mar 2023 10:10:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set97uIe6CMD1+C8TfEABm2y039+BlpvCFoYFo2lNCzufbwTL3awI2y6KlXes4DSNwbGg3evF/g==
X-Received: by 2002:a05:6214:1248:b0:5ab:af50:eb41 with SMTP id r8-20020a056214124800b005abaf50eb41mr1268633qvv.14.1679418617727;
        Tue, 21 Mar 2023 10:10:17 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b00706bc44fda8sm9729513qkp.79.2023.03.21.10.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:10:17 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Use readl wrapper instead of
 pure readl
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
References: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <18e45db9-0b7d-abc3-5564-93968819f877@redhat.com>
Date:   Tue, 21 Mar 2023 10:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/23 8:33 AM, Michal Simek wrote:
> Driver has IO wrappers but xlnx_pr_decouple_read() is not used and readl is
> used instead which is just wrong.
> It is also generating sparse issue that xlnx_pr_decouple_read() is unused.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Created based on discussion with Tom here
> https://lore.kernel.org/r/20230317230617.1673923-1-trix@redhat.com
> ---
>   drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 2d9c491f7be9..b76d85449b8f 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
>   	if (err)
>   		return err;
>   
> -	status = readl(priv->io_base);
> +	status = xlnx_pr_decouple_read(priv, CTRL_OFFSET);

Thanks for the change.

Reviewed-by: Tom Rix <trix@redhat.com>

>   
>   	clk_disable(priv->clk);
>   


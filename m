Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744674F646
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGKRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGKRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462895;
        Tue, 11 Jul 2023 10:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE20461589;
        Tue, 11 Jul 2023 17:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375B2C433C8;
        Tue, 11 Jul 2023 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689094839;
        bh=346yK9h/7alRf5IvzPQUD+x2Jl0TUTmpOJfnmMXPzMs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d/r7syOuC9xcDqahSv9EGz3F+6tSYZ6NqfFl2aYlRlZ6y1j1qb/VL9lsp7ztLPnzY
         ihmbSoQAu1NjvsVRCiz/s7W8/7vD+tfPefZYWU5pQKVIJgrZvNvtmTgE6SsshthQsD
         /so3nPlkrq9yO8xyPSa/ngYuTsbAakSzPupVKNx3l9NqC1pjBOeQr3h/sqYf5q+yJp
         LrhKsy+qCtxx4xMvIr2wEG9u1TGX6LJ7Eeaql4OGpB0XEdHg0BNpNP05xM8mKLf5IM
         /7D5PijpzJoJOwk3DxozYfVsLdKHlnAeTMrisuXWBKSdcO4O4wnzEVYyRLeh/DhJEu
         Zy0tT04KaGfrA==
Message-ID: <d3837825-5169-7dcf-3c65-a39c60ff6f95@kernel.org>
Date:   Tue, 11 Jul 2023 20:00:34 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] serial: qcom-geni: use icc tag defines
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711160516.30502-1-johan+linaro@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230711160516.30502-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 19:05, Johan Hovold wrote:
> Use the Qualcomm interconnect defines rather than magic numbers for the
> icc tags also in the restore() PM callback.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Georgi Djakov <djakov@kernel.org>

> ---
>   drivers/tty/serial/qcom_geni_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 444c74eeab7d..88ed5bbe25a8 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1757,7 +1757,7 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
>   	private_data = uport->private_data;
>   
>   	if (uart_console(uport)) {
> -		geni_icc_set_tag(&port->se, 0x7);
> +		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
>   		geni_icc_set_bw(&port->se);
>   		ret = uart_resume_port(private_data->drv, uport);
>   		/*


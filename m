Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BE5EC763
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiI0PQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiI0PP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF516F4C;
        Tue, 27 Sep 2022 08:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE0961A22;
        Tue, 27 Sep 2022 15:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B89C433C1;
        Tue, 27 Sep 2022 15:15:54 +0000 (UTC)
References: <20220926124359.304770-1-patrice.chotard@foss.st.com>
User-agent: mu4e 1.8.9; emacs 28.2
From:   Felipe Balbi <felipe@balbi.sh>
To:     patrice.chotard@foss.st.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Audu <jerome.audu@st.com>
Subject: Re: [PATCH] usb: dwc3: st: Fix node's child name
Date:   Tue, 27 Sep 2022 18:15:18 +0300
In-reply-to: <20220926124359.304770-1-patrice.chotard@foss.st.com>
Message-ID: <87o7v0g860.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


<patrice.chotard@foss.st.com> writes:

> From: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Update node's child name from "dwc3" to "usb", this fixes
> the following issue:
>
> [3.773852] usb-st-dwc3 8f94000.dwc3: failed to find dwc3 core node
>
> Fixes: 3120910a099b ("ARM: dts: stih407-family: Harmonize DWC USB3 DT nodes name")
>
> Reported-by: Jerome Audu <jerome.audu@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 166b5bde45cb..6c14a79279f9 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	/* Manage SoftReset */
>  	reset_control_deassert(dwc3_data->rstc_rst);
>  
> -	child = of_get_child_by_name(node, "dwc3");
> +	child = of_get_child_by_name(node, "usb");

there could be DTBs in the wild which have `dwc3' as the child name. It
seems to me that you should try both names, instead.

-- 
balbi

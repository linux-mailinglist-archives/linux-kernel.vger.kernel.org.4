Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD1625CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiKKOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiKKOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:14:10 -0500
Received: from radex-web.radex.nl (smtp.radex.nl [178.250.146.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 507925CD29;
        Fri, 11 Nov 2022 06:04:18 -0800 (PST)
Received: from [192.168.1.35] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 2347A24071;
        Fri, 11 Nov 2022 15:04:17 +0100 (CET)
Message-ID: <d92dbf13-5c64-03d0-1aab-6f96d8f45669@gmail.com>
Date:   Fri, 11 Nov 2022 15:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Content-Language: en-US
To:     Ferry Toth <ftoth@exalondelft.nl>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>
References: <20221110211132.297512-1-ftoth@exalondelft.nl>
 <20221110211132.297512-2-ftoth@exalondelft.nl>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20221110211132.297512-2-ftoth@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NICE_REPLY_A,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Stephen Boyd

On 10-11-2022 22:11, Ferry Toth wrote:
> Since commit 0f010171
> Dual Role support on Intel Merrifield platform broke due to rearranging
> the call to dwc3_get_extcon().
> 
> It appears to be caused by ulpi_read_id() on the first test write failing
> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
> DT when the test write fails and returns 0 in that case even if DT does not
> provide the phy. As a result usb probe completes without phy.
> 
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> ---
>   drivers/usb/common/ulpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index d7c8461976ce..60e8174686a1 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -207,7 +207,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
>   	/* Test the interface */
>   	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
>   	if (ret < 0)
> -		goto err;
> +		return ret;
>   
>   	ret = ulpi_read(ulpi, ULPI_SCRATCH);
>   	if (ret < 0)

Would this affect others phys (like qcom HSIC)? I'm not sure if failing 
the test write is a normal behavior.

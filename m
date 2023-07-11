Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9121774E475
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjGKCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:49:50 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE7120;
        Mon, 10 Jul 2023 19:49:47 -0700 (PDT)
X-QQ-mid: Yeas43t1689043677t873t55355
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.130.21])
X-QQ-SSF: 00400000000000F0FPF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2893266932846902209
To:     "'YueHaibing'" <yuehaibing@huawei.com>,
        <mengyuanlou@net-swift.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221105080722.20292-1-yuehaibing@huawei.com> <20221105080722.20292-3-yuehaibing@huawei.com>
In-Reply-To: <20221105080722.20292-3-yuehaibing@huawei.com>
Subject: RE: [PATCH net-next 2/2] net: txgbe: Fix unsigned comparison to zero in txgbe_calc_eeprom_checksum()
Date:   Tue, 11 Jul 2023 10:47:56 +0800
Message-ID: <031801d9b3a2$191cc510$4b564f30$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFi2DHPEYcXaQ1O7miR/ExBhxCcIQE5uFuqsJfCJPA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 5, 2022 4:07 PM, YueHaibing wrote:
> The error checks on checksum for a negative error return always fails because
> it is unsigned and can never be negative.
> 
> Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> index 9cf5fe33118e..167f7ff73192 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
> @@ -200,10 +200,11 @@ static int txgbe_calc_eeprom_checksum(struct txgbe_hw *hw, u16 *checksum)
>  	if (eeprom_ptrs)
>  		kvfree(eeprom_ptrs);
> 
> -	*checksum = TXGBE_EEPROM_SUM - *checksum;
> -	if (*checksum < 0)
> +	if (*checksum > TXGBE_EEPROM_SUM)
>  		return -EINVAL;
> 
> +	*checksum = TXGBE_EEPROM_SUM - *checksum;
> +
>  	return 0;
>  }

It is a pity, I didn't review this patch carefully. *checksum will sometimes
be larger than TXGBE_EEPROM_SUM. It's correct to remove these two lines:

-	if (*checksum < 0)
-		return -EINVAL;

I'll send a patch to fix it.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34E742D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF2TWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjF2TWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:05 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1938A3C2B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:21:15 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id EwFJqyKYMKBQaExCdqFEPM; Thu, 29 Jun 2023 19:21:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ExCbqRXYVqOHoExCcqMWA9; Thu, 29 Jun 2023 19:21:14 +0000
X-Authority-Analysis: v=2.4 cv=M7Velg8s c=1 sm=1 tr=0 ts=649dd9aa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8
 a=JVAyioYkJOEp9aBO_QMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=17j2CnZnjoSsNdoDaHKN3iihC0WboI8ajeA2vNVcd4M=; b=hJaeMGrC+8sigC8TiZ7oj3XS+N
        4kdxJiMOusjxgC+xwENu8CwtjLQewCX+YS1bSr8tad2X9Yp79lSS8tdwdwaK9DSMDPuYfK5BZTJFw
        LGghGhnmlQyo3eCo3gGqdKzKYDYbKzIfwV7kX91Ty8dmR2FoCG53bRfu1WOxqanbzocaiXpquDa1a
        15d6qJzauKUf44WZ9w+IOorilIkYcE4KGHx/qqS2tBAxXQDn3KvmMqcg9mjFvY1LpvCF5X+ep1sXJ
        NYP/tX8HVeq7/f+N2sliNkw81jP9JBUA1c7iGsjwotWtQ5lCFGfhMbzsuJ4MA5cAfolYeg6JtGYlA
        mNR+BC1A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:52578 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qExCb-001ANQ-13;
        Thu, 29 Jun 2023 14:21:13 -0500
Message-ID: <3068b31e-9a18-68e3-0a15-05a026435ddc@embeddedor.com>
Date:   Thu, 29 Jun 2023 13:22:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array with
 flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230629190900.never.787-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230629190900.never.787-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qExCb-001ANQ-13
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:52578
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGvO57Mf5fUTgQ+E2WHXbQExVxSkD9u3fdF/TqS9LD4zxwhgXl7FQPFUpYTx5nvAMRPvDXVht78hPuN+EP5lX3p8oMGGI4OT6/xtPwd0PCew60dQ4Om9
 RtMXjt/SD0hS7fHsMSknxbJH/Bpqqs7LCXMkv+FS+d5jWbUD0MQ6TPD1FkXVQuQ35ZTi4kTQNBqmj99rcGA1J3SkORigynsOn8k+gUhO7CUF2GfKegJchESt
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 13:09, Kees Cook wrote:
> Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> bmSublinkSpeedAttr will trigger a warning, so make it a proper flexible
> array. Add a union to keep the struct size identical for userspace in
> case anything was depending on the old size.
> 
> False positive warning was:
> 
> UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31 index 1 is out of range for type '__le32 [1]'
> 
> for this line of code:
> 
> 	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Closes: https://lore.kernel.org/lkml/2023062945-fencing-pebble-0411@gregkh/
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   include/uapi/linux/usb/ch9.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index b17e3a21b15f..3ff98c7ba7e3 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -981,7 +981,11 @@ struct usb_ssp_cap_descriptor {
>   #define USB_SSP_MIN_RX_LANE_COUNT		(0xf << 8)
>   #define USB_SSP_MIN_TX_LANE_COUNT		(0xf << 12)
>   	__le16 wReserved;
> -	__le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */
> +	union {
> +		__le32 legacy_padding;
> +		/* list of sublink speed attrib entries */
> +		__DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
> +	};
>   #define USB_SSP_SUBLINK_SPEED_SSID	(0xf)		/* sublink speed ID */
>   #define USB_SSP_SUBLINK_SPEED_LSE	(0x3 << 4)	/* Lanespeed exponent */
>   #define USB_SSP_SUBLINK_SPEED_LSE_BPS		0

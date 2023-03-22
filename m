Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6646C5A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCVXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCVXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:34:26 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506721A2D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528061; x=1711064061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0FLVwTfQCk=;
  b=FfI1wl3GFPx1aHtfzlQjVPWOGRMy6XdNCX7C9Kq/r/WYw/8+G3NK4B9f
   cLteEMArP/Xq7Wfi5ta+KkKxdp31oXvFKtYIF+JztbsTrgxk66byDnzxD
   CgVWrGdVe1Hd9y4RfXyf/FEJ8z5ziurlt8JkZZ+6Hq9mMePi8O1BnEsq1
   x7fIfEzMKLTOE/7OFQtyZNs4AHfe1SNC0mSTZjhB4l8KpGz6H0WY8pNHh
   /z6H+9pQVFjKMswVMrZ8hdkYuP6QAMXIbJxvrIld8mom3p0IP3ymiBaYm
   YguDANKaGxSua+MS6rDwKD+3XorNYk6MUyC1r6A3hsErrkavgRHGaVtRD
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330695539"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:34:20 +0800
IronPort-SDR: bNnStH8H6tmYbObvMVKZ18oY2BaPqxY/8Q75PgP9TWlfpu6mahdQgxidu1FzquOwi+Np0Y34Yd
 rU9ZYSWGPdetuROiMc4QPKjbfU8YfhhsIATbyLcB0wE0uViGeTONg2bsM8nePEzv9EsRcVq7TK
 IzvpJDAARBKjoZ0MQHOc8NQRG9QbXpVygp7nB1vYglYOqmwTbH70tAu8Dt2dWI8Z1HXdeFnWQZ
 2rDs3heUlESKPlR2xgrzxsqSSAq7BoepvtAXJvCICHek8W0zLZ7ZTvPQfMzGY3FWUMpsqhqDo5
 oUg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:50:38 -0700
IronPort-SDR: c0WReqRN8Q9O6IRtczFxxSlDScjKifyysmPWD4458+hKrEx9vS0vMDCuMRjV4RH9sRPDpWoESl
 xO5citTO/r3IQi2xDwx2PBqXXXsTZuiUOwAUWj55Cl8wO/REekZZSQWVtPTEcBcQm7RqOTJbz1
 DC6anEfUN+xJPQW6rtSUv0v1Y4OQE5XIoKP7jVM3DrSk++xPrXu8HZdbTUxNIg4aq+K/FhEK32
 qamtX1791Rm0Nu8UaNmbQ8CWG4mo7+RSrasiNLbYvtc+kIRlEOCYgVThI+iB9Qiu6ShpOLiM3w
 iJk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:34:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlDX5hggz1RtVv
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:34:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528060; x=1682120061; bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0F
        LVwTfQCk=; b=KIoKRoAyDoLX5+1BdzL/wF05+aNmFvhHkeLfugMJRhymYlef0Ps
        crYVyhuywL8h3CnFK36j1vKet47n7GDD45edGQzyySv0HvohdJGE2UudSkX8sqbY
        5Nj/N+EUDWqiR5RIvMfWbBw0lpH0ClyhU2nAJUAHzvijsjc+/zZAO5wT00j+LZT1
        nLkGlB+7tAXyPPQrSMBCpYKi5TfDoKQ6oZSvm2u2yADc8/0b+Wnk5gyH7spVbVYp
        j62qfUSKHI6y1jKwM8Nx1jMu3AFuxEPLhGIiMjbOa8RrXON6m0d3rtPZmf+rwvd3
        a3g30ix6wWkyvcTAAnveV5jaZ/vNmAYcuCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7HFjCdtQykvN for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:34:20 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlDW3JbWz1RtVm;
        Wed, 22 Mar 2023 16:34:19 -0700 (PDT)
Message-ID: <8731d0e1-61ba-b894-f4ac-51b17ee675ec@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:34:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 05/10] ubifs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-4-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


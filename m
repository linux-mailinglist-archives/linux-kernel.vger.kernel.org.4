Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205A96BC7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCPHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCPHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:53:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A389F38
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678953194; x=1710489194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RXkfFrZ4cJbq5mA2q725lauWqEHcqyRQeVT3Aao/9Qw=;
  b=GrCCwow9VFG416vzING7UcyQi6WcgDKzYhD2jl/4LaP2rISKd8EwtcCc
   yQAkIFyv7j3ORDeJnqT8K1GHsXIrZGHMByCg3svdlPJhLjbiWt7dTHoR+
   uRPRaJY3HjEB8+gjwo9jBkWesDkelWPbtJgzbGrZXMTSGnomdXjnJAlTe
   mf6IbvZKHz9HRT4AwexoEBhjxkHfM5QG9TKjUSKRwUQgQaL6vZ92Q/fbb
   OCxK4KFPvOhMd2Nyt4gRbGRbPms5NYmaEzCaOGh6gQapDmC9+DRq15tYV
   Vgv3rMj+7/KY+o+tRY6xKqWuNMF2JPPQ66eVFmGiTkTExNt3fPpMR99lC
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="330149600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 15:53:12 +0800
IronPort-SDR: tc9uy5odJLhbkqZGByfi2aHiKkh6z5cLfKYQ6ynCAOOgwe0yFt1vSHlFhcSf80l0mIdLoYZKM2
 jG4IHIR0h3gdMYv8i527Nxej0fZ6v73+g7kKiiRWrSXD40ECAmciedxI+7Xbu1/XyPWwU6H8PL
 FpoBtQOgn+r/EIHyyzpz7uDGuqtgLU1cFXcZd8KgZAE/xN/UCaPBDJ8As5MQgStqBAiyqzd7EZ
 ESunnAkM+lXWPcwuUUKR/Jol1ZEjPoBXVmLhvFRY7adXNJ68CDiLElnmU1EMHsqpCR+G87/51z
 GBA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 00:09:38 -0700
IronPort-SDR: q/Xyl1+KfvYHtGk/SYV/IVTV1CJqBq3GCwBwYrqGEJrMnTnwIGhi2Apa24PYY5NA8eZ4Cy879b
 ZAOP26xzkplK9eLbbC8Rvw7KUildHZ3J39cugYzXyr0dRIg8G7HA9bqzv9WfXVoJritm6JrG95
 aGZCdddXjuPXYzkSbhmm9ZPPkwS6sBFv123HB4G3gQ9OrnaObSItFCkOlRp1TU3yw+IUOxdehh
 oE1kDwE2aXeaWzmWOjEJGsJMh8m+S9AnF4yqlYdnHWPVIwyxTGQuMngO2HWEOkW1QwfMhjef0V
 6Zw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 00:53:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcfdN1Grtz1RtVq
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:53:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678953191; x=1681545192; bh=RXkfFrZ4cJbq5mA2q725lauWqEHcqyRQeVT
        3Aao/9Qw=; b=DIG7KAu3wMdekvKQcingmQSqSs4fueFQoXvHqyjox234L/dSEnJ
        4ApWYRt8E95IJUM6s0FrJ3iaS3St6PDKFc23HG6ahIqPYxx+WxstlEP5ggyGV/yG
        1rp1+qakICc9f6hSIjtmUzsmdhTgOW4Z9h8JxwdX68o30/lBodQMLk9ihQxIXwUT
        qGXw96CHc9jZKm45oGYMNNLPZRkuEYo+un5hoVOsPrzOlQqy8xMP01cuPTSM6Unr
        REmnZ1r8YbKxu7bryo72OF18xSxKuJKYJr9rGAtIxCigoUoDkq3mQnSgBCpFN6AR
        582oCAHYbUImHrPQjuPJnqp1zGJPWCXS/cQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wcoFR9AlQVbL for <linux-kernel@vger.kernel.org>;
        Thu, 16 Mar 2023 00:53:11 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcfdL2lflz1RtVm;
        Thu, 16 Mar 2023 00:53:10 -0700 (PDT)
Message-ID: <2fa6c8ec-c25f-5338-ac78-eee422935ab8@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 16:53:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] pata_parport: fix memory leaks
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
 <20230314225805.9124-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314225805.9124-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 07:58, Ondrej Zary wrote:
> When ida_alloc() fails, "pi" is not freed although the misleading
> comment says otherwise.
> Move the ida_alloc() call up so we really don't have to free "pi" in
> case of ida_alloc() failure.
> 
> Also move ida_free() call from pi_remove_one() to
> pata_parport_dev_release(). It was dereferencing already freed dev
> pointer.
> 
> Testing revealed leak even in non-failure case which was tracked down
> to missing put_device() call after bus_find_device_by_name(). As a
> result, pata_parport_dev_release() was never called.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied to for-6.3-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8616C5978
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCVWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCVWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:34:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F11D18E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679524480; x=1711060480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GRC+ab3cu9sXA63M9BMs8MDzDk/qWTmdP9YEIETyYIY=;
  b=Qr25iwlysBkQihP/HgfpVoOQpf63r/4wyhs/u6lr4VIk5/Ocvu/ensAi
   uoTHV13p7EO6wcZdpbdMiEOqnn7MwpLzra0arak2DRhe3e0Yp4b2AuIIt
   RxrV3qSWnLGxU+zmuax1IsxBCiRSqpQ2Bv5RxFfIFv469GDEWPh3MiRpt
   N/G1nwstHlkdoIfoj4l5KSfHu0hY2vzc1RoNYLoGgEAlrFrAh1AgM3S1h
   thsaGztL9EnpW/TMMB4R4v2MrUYCNzjCtBwypRiuBOwMr8S0bJdUn9mTg
   L+P4uYBg9y+xzrGTTi5E7SKcl/FPAfbmnyRZW0IX5n/T823RsuQYyZZfO
   g==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="226270637"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 06:34:38 +0800
IronPort-SDR: Y5uvfMVcqHPsfatka/j6AyJ5hMzKchW8PgXqqK6v5az4zarZ6thGVLxMfEts1IuKIBq2sy8Mgv
 w1WQgKhGWVwIU76jn3Zua/ZiVQdPK/tAjf5O1AYdyhZZFe10Dd8NooND5MCX15djppQFnvbsOf
 cFEa6cmVvZ5u3OGWATRGkDVOZ0QPGooCVNh+9KvnyPRggX8s94kWO+oTQwHwF6olM+bnjBVGt8
 ntDxxUU4ywo02yMAYEq1C6GPszw40KfZg4b3coQy9rMuRGTFBBZ+pfPXFYgvx3NPt3eh6/r9eJ
 wac=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 14:45:14 -0700
IronPort-SDR: TET2YpgVoi4t4TQvdUWba6shHEi8bzUJ7lm2w+PzISLNervvGFvw1B0EGjDRg1yD8xAh8ZZpW9
 dlAT5OoeSVSqduH+06bCUo/Tv5t/zFa4KLi59X0aFEUl7VpkKWCvoAmVPYR5eA4iadUzpXZ2nv
 GAsv2KPVfAqxj7s9rhuoDx8IabOs5oFuHyPkU2+7tKAumNJDOIOUJV1olz2NFnIQKyB4dXaIJO
 4SG6b+p2pxWW3Pjm31bqxgYIcEkqH1LByvqnNUrcPKntF461Sy5d21UGsOxpJrQrVGfssQ0HSd
 VFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:34:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Phjvf1W17z1RtVv
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:34:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679524476; x=1682116477; bh=GRC+ab3cu9sXA63M9BMs8MDzDk/qWTmdP9Y
        EIETyYIY=; b=e4+/obu7OG3gBlCqgE0TZNoDvNNJ53c7Wzf2eZOgGZoaAxz6Qih
        14mmLlPwRVn9OVBw6VsoKUb/63zgQA1yECgO7KDIAzuikqyPecZk/j2OhOs13JNl
        IXeYHNbSrIc0NDq/37fQlLhnIuYmlDJrEb9WYfIvLSv1SgApA8KMxqYFjxy2tNFD
        04vjjnaAzQYiGdLLdL6bS9Asi1LNlh0bE7g6see1mLd3ok+SiYk/RSoPUjfapilT
        nZQ8ZZXZxMYG1P/nBZHizeNwUF3KTuGvvfV3kAEs/MWI5m+ZTL6cS+MPtPfG2xmq
        NeM+Yd5PCjRkUVC8vN8G4ZLPu0Bj9TG2qJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l6bDSlUVeA4f for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 15:34:36 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Phjvb0JL8z1RtVm;
        Wed, 22 Mar 2023 15:34:34 -0700 (PDT)
Message-ID: <e717267b-6dc2-5018-01f1-143fe1bf0793@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 07:34:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk>
 <202303181955.41922.linux@zary.sk>
 <d16b4b27-f1d3-bf05-e062-516e7c708fa2@omp.ru>
 <202303221310.44235.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303221310.44235.linux@zary.sk>
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

On 3/22/23 21:10, Ondrej Zary wrote:
> On Sunday 19 March 2023 21:02:43 Sergey Shtylyov wrote:
>> On 3/18/23 9:55 PM, Ondrej Zary wrote:
>>
>>>>> This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
>>>>> the simplicity of other protocol drivers. It also converts the direct
>>>>> port I/O access to paraport access functions. This conversion revealed that
>>>>> there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
>>>>> that.
>>>>>
>>>>> Tested with Backpack CD-RW 222011 and CD-RW 19350.
>>>>>
>>>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>>>> ---
>>>>>  drivers/ata/pata_parport/bpck6.c   | 452 +++++++++++++++++++++++++++--------
>>>>>  drivers/ata/pata_parport/ppc6lnx.c | 726 ---------------------------------------------------------
>>>>>  drivers/parport/parport_pc.c       |  20 +-
>>>>>  include/uapi/linux/parport.h       |   3 +
>>>>>  4 files changed, 370 insertions(+), 831 deletions(-)
>>>>
>>>>    OK, it's finally clear I can't keep up with reviewing 32 patches posted
>>>> at once...  Luckily, all those patches seem to be dealing with parallel port
>>>> control), not the PATA control! Of course, when I volunteered to review the
>>>> PATA driver patches, I didn't expect such patch volumes -- I mostly expected
>>>> some odd fixes, not a massive driver rework... :-/
>>>
>>> So you're going to review the (P)ATA parts (if any) only.
>>
>>    I saw no PATA parts in this patcheset...
>>
>>> Maybe Sudip (as parport maintainer) could review the parallel port parts?
>>
>>    I have no objections! :-)
> 
> Looks like Sudip does not care. What needs to be done so this can be merged?

I will have a look at the series this morning and merge it if I do not see any
issues.


-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9168065B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjA3HK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3HKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:10:54 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3D624135
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675062652; x=1706598652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PL8Lnq9pEFeL1Z1v5KoXHjGiWf+Wd0+HxXQ5TzyyMB4=;
  b=WQnLTLK2WW5O4zsNhv/UJQThYWpuXza79lY23pn7idHcAijf+XgGyni8
   6d6Un6XIZR6hnRHBrHZQ036yG/6xBkJABCoOOZ1/WOZd+UKWAH9EcBP6C
   dFlJ6ph4q+7Owd9wKZ/p4M6XahqT0OEmjDuIwQfsY+8hkjDJbJ4yR+OJM
   KCA+AI8emV1zwzRd667BIpRwPuGqUtlYvvam5n3bEuFD7rIzf+j6gVScz
   OAiYfxSlaU+aVZh14RlFZmqDXQ8rjLUvgBokSwqPKFz9lJt0EpMp4YMl9
   ZnUX8Jxz2txaTxocQkbSd5x7Wfjye2ZvbQg2MjCc+kMEJWKSmozdtmxeG
   w==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="334022332"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 15:10:52 +0800
IronPort-SDR: lhU90do8CTsmeAm8T9YIfzYnLK5UmVYj1E9B6OHaPiWgp7iTePaGexS8gVONZotFDqllIndynb
 hJbhH5I6ezXSR0398xplgJRfsV+0t9jCOMDWgbvxTOsK8WCJLYERyQ2krlvVfcGaNBykHurAhE
 Sx/EZz+DmnqlQ8IakGBkfgr5Ow8/Tq3uph7oY8O/VCQfde0N0An33bw67L3a+GkIJkNQgEmxXQ
 pNJX0RJYzwqN37eRcKT1OmRrCx0ItwC2tCUid8a6qV9GwWJee/jD00bOetkCeTQprVfEv8MTCc
 P1U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 22:28:18 -0800
IronPort-SDR: dwrhhEDDXHvQr54Wm750B7xKWSS1Q9vMoqGEndODV3pfvKExRhFpbMDbdvL+InVHI8elYdMt9r
 xzJ44EpkKNIPeOD4pxhQ9ALkWzAZ88Id6CY0UcyorbC1HoKzdqs6GbdbI0NANiED6+brenG7fq
 Fth5fxlW2m8x+M5WQ8iVN/knAazid7e7q4tuPImu+wb+klrCG2IXlCGkuRAKW0QQOctmQOKFxy
 2QzSzDIGo6qMn12QSApYErjQ4QX2unItV8iNoiwWuqkm1/d6NfpA+k1TPq1kJbJm6BpF+VT6kH
 Bxo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 23:10:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4zqH5fGMz1RvTr
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:10:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675062651; x=1677654652; bh=PL8Lnq9pEFeL1Z1v5KoXHjGiWf+Wd0+HxXQ
        5TzyyMB4=; b=opqERaEqJ150TbkCWlAbq11jv+vVl4igNIi3xPZN0mdfGACuZvp
        vBaxbEBjz+85TyLe2FlUDTN5BlP6/JzXbjokz7Ax96xBdxjCRL3yJlTRzQpsug+l
        FmuuYzHE+jWq2nwaX797vVOQlIU75z5D92QTQHe11kdTZsQSJFEeyb2Z3scqSi1u
        DBppLgTWFy9wKxQfhtE9rtW26fmOXCvzwAUF/d3cVHSbQQLrL6wZKIvPIVolmm2J
        UbWVqXVBeroP5T/oHKGUGWYgxkxIq6k6ano2r5jPgmg2d8Nk3U9BDnCTKKNymeL5
        y71gnjVdectGeRG1sVV+oJ2itDKKMlBtyyg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XUFytgdlWf7V for <linux-kernel@vger.kernel.org>;
        Sun, 29 Jan 2023 23:10:51 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4zqF6KkRz1RvLy;
        Sun, 29 Jan 2023 23:10:49 -0800 (PST)
Message-ID: <569cb9ba-52d6-da73-dba0-cc62c91f6db2@opensource.wdc.com>
Date:   Mon, 30 Jan 2023 16:10:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
 <20230123190954.5085-1-linux@zary.sk>
 <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
 <20230130064815.GA31925@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230130064815.GA31925@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 15:48, Christoph Hellwig wrote:
> On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
>> I would prefer if we just delete it after merging this one, in the same
>> release. I don't think there's any point in delaying, as we're not
>> removing any functionality.
>>
>> You could just queue that up too when adding this patch.
> 
> I'd prefer to just deprecate.  But most importantly I want this patch
> in ASAP in some form.

I will queue it. But I think it needs a follow up to result in something
consistent with KConfig. So either deprecate or delete PARPORT. I can queue the
deprecate patch and delete in 6.4, even though I share Jen's opinion to simply
delete directly. I am still fine either way.

Jens,

If you are OK with that, can I get your ack for the deprecate patch ? Unless you
prefer taking it through the block tree. Either way is fine with me.

-- 
Damien Le Moal
Western Digital Research


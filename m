Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1338C5F17A6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiJAAu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiJAAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:50:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7241005EB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664585420; x=1696121420;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GzapoAx1yyETlTo9s+u64ZXimE4706mEDDvom0JArvo=;
  b=kQsWDdAp/4+bb2PmUqv804DEx0Z92xqgBGrDIMiNyeB/W+ZXVKHQTBIX
   JwTMiP6UM0UINHwFm8drYtoq6v7qNgFUgmoceXt8IlDYB2k1tzO522GJH
   GGFT+aOuW+l4KTn5o0MGD+fxXSwyIHoLjckeGJb+sCpbAyjEqih20FdVB
   zWJGI3jLVKkqD6wIMWPMW4bvwYtB/0U3nb/LqQadwiaMNOjt7tSe7c2dc
   RnqwZkKN/V1P18a6uuVvDoJh9HlEOnwLGDeXUkqOQaur+xDHKcuxmsjwu
   /YT9XIqobRG1p3Y4RjT22CCFN5RxNcSuTy6I1pMcPmPQOqYPsruZUlkI2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,359,1654531200"; 
   d="scan'208";a="212712831"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2022 08:50:18 +0800
IronPort-SDR: Bko5uJdeLAWWrCX/dTKQXGuCqhOyEDZB5rF+9QesaL5TsPC6DIrq8khQOIekMDC8bpaZZ1A4wZ
 ubY78L//+j1yDyyrG9k3BWpn3gK4eS255UnNVNgNUmuBvArx5o6nguwTWjc6J2QZlIsM8+mZfB
 +Qnj4rc4Z9XwnT51FWuG/VyFoBu20FSggI8Ghq5SbbloQUp/dBG2NigUXeOXdI3r3oHooQ+dyM
 7MvY+9eQyfJJpOi1F6Ust9ui4KkhzFFVoIms7k5J/pewvHeAb7+XbxB3/X2XOvGahKqcQC9tKK
 bJOJYMBDe0peLE76mtv0uTTy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:04:38 -0700
IronPort-SDR: n12wYzXvaW4cdqUHdQBWFd/Pgr0TdRh7vACspb5WlB4DVBO0aSfpnsTjisgzwlvLMzztrpIJJm
 Jv+MflgcxmDqoq084SGYIvSFlyFxNiGRrT4nyZIKy1r+S+3viM2sVt3BaIPzqSLAkuA+dARfA3
 mqSG56KV35be5WAKW1piYL5IfP4AnWADL76Fbidks8QfPb4uFdKpBn8Xez3VEwkb0RrxRRodQv
 DaVEM2GYMKghCEm02szhYSujg/80tTr5VMgECqVXZYPfp/Crl7dkIIANuHUIytXYMgsWlL7SHX
 /xU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:50:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MfT621JTNz1RvTp
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:50:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664585417; x=1667177418; bh=GzapoAx1yyETlTo9s+u64ZXimE4706mEDDv
        om0JArvo=; b=h0NMvYe8gVC4DRidCFZQZfOluWYBomEst7HZUcZGnIdW6TtaT0E
        g7s4/SLonH5tK12LSokZWrniSr1NV/MB6VhSWSMO8lWfLHTpu7fSH9MfCY5tG/qn
        BIAeQcU+isdpCHCG4IHheJuX5AG7hESunecmj7CKID2TmrtUAqVaPRHgedRpIinY
        bwUz1Lv0HQOrbpWuCCKnlLOmV3NDeyriCB8OFAw25kPFpUtXQpH9nlT+JaYRmA+d
        mbHEQjrwJn4vMffL7v80fRfIdnwpwyRmRgf8HW4jocjc1/bulknJ5zYVeJLY7Z83
        MvqHQ4wLUpALCkOj2RjV1+NboWNC50zehdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xH4lzNeuHWl8 for <linux-kernel@vger.kernel.org>;
        Fri, 30 Sep 2022 17:50:17 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MfT5y5FD4z1RvLy;
        Fri, 30 Sep 2022 17:50:14 -0700 (PDT)
Message-ID: <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
Date:   Sat, 1 Oct 2022 09:50:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: block: wrong return value by bio_end_sector?
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/22 00:59, Paolo Valente wrote:
> Hi Jens, Damien, all other possibly interested people, this is to raise
> attention on a mistake that has emerged in a thread on a bfq extension
> for multi-actuary drives [1].
> 
> The mistake is apparently in the macro bio_end_sector (defined in 
> include/linux/bio.h), which seems to be translated (incorrectly) as 
> sector+size, and not as sector+size-1.

This has been like this for a long time, I think.

> 
> For your convenience, I'm pasting a detailed description of the 
> problem, by Tyler (description taken from the above thread [1]).
> 
> The drive reports the actuator ranges as a starting LBA and a count of
> LBAs for the range. If the code reading the reported values simply does
> startingLBA + range, this is an incorrect ending LBA for that actuator.

Well, yes. LBA 0 + drive capacity is also an incorrect LBA. If the code
assumes that it is, you have a classic off-by-one bug.

> This is because LBAs are zero indexed and this simple addition is not
> taking that into account. The proper way to get the endingLBA is
> startingLBA + range - 1 to get the last LBA value for where to issue a
> final IO read/write to account for LBA values starting at zero rather
> than one.

Yes. And ? Where is the issue ?

> 
> Here is an example from the output in SeaChest/openSeaChest: 
> ====Concurrent Positioning Ranges====
> 
> Range#     #Elements            Lowest LBA          # of LBAs 0
> 1                                               0
> 17578328064 1            1                         17578328064
> 17578328064
> 
> If using the incorrect formula to get the final LBA for actuator 0, you
> would get 17578328064, but this is the starting LBA reported by the
> drive for actuator 1. So to be consistent for all ranges, the final LBA
> for a given actuator should be calculated as starting LBA + range - 1.
> 
> I had reached out to Seagate's T10 and T13 representatives for
> clarification and verification and this is most likely what is causing
> the error is a missing - 1 somewhere after getting the information
> reported by the device. They agreed that the reporting from the drive
> and the SCSI to ATA translation is correct.
> 
> I'm not sure where this is being read and calculated, but it is not an
> error in the low-level libata or sd level of the kernel. It may be in
> bfq, or it may be in some other place after the sd layer. I know there
> were some additions to read this and report it up the stack, but I did
> not think those were wrong as they seemed to pass the drive reported
> information up the stack.
> 
> Jens, Damien, can you shed a light on this?

I am not clear on what the problem is exactly. This all sound like a
simple off-by-one issue if bfq support code. No ?

> 
> Thanks, Paolo
> 
> [1] https://www.spinics.net/lists/kernel/msg4507408.html

-- 
Damien Le Moal
Western Digital Research


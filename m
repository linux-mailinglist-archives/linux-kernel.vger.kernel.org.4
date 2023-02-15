Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAA69757B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjBOEnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBOEnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:43:08 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671915569
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676436184; x=1707972184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rllAuMPvoBr0L1lHfSbaKvi2l3urZy0SiU0ZdfBD6O0=;
  b=X/W9mgLFimZ+bAygmZp84dgaNGDRw5gTzpOB1793TKho0aVie6KURXYW
   LHb551mquLxIjkDOvcEf/GH9fqkIH5HrpzBPFEMRi6UJEtyGqONv+Le77
   kJgqPFuh5H8jYWgBqD88i48OKtcc81r0q/koeFzs6ehmmeSw1I7bLX6FI
   Tt+kYx7Rv7kYPzWXWO35gjfjH8VSr18nrR2wTF9ovp1bLAcMHSQEwS/vF
   EmZOviTpbEBRAOV8cvGYzxLui+2DnZaZiUUvvAI0HxrDXGNQjMJQpJxcX
   eYIrG8dbxk9KXFZQFQXbkDKgxPLhbw7XmQ7IA6CAJ7D4siFWdKwoV95ry
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="327634829"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 12:43:03 +0800
IronPort-SDR: M9jxpSR3XzpbpECpEIfguWC8+bYVxhOmsaYSxcz6fEXclf9UxZYcd3qxeHRo127qnD5bAC17Bo
 TKRAREsr8Ln4cixTWmAcPtD4R6kSmiPwUDlwozL5Jg6kkU7lXQruMseCAX7d40CBSsCljYhXZv
 9szg2UnImKS4TLIJsLm1HvXTLbsSWpGlLRbHlaG6heykKg1CdVyWq0EeFFY+4j8OJOrUHECroz
 IHS73ytshGMY+wZkjU7gNn+H0G/LvI5aEkNIISCVrGMB+nHWPlmQRjjlICd2Dfw7d1/4ALcMPv
 0lE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 20:00:10 -0800
IronPort-SDR: xnl9uH9YFVrnhp5XpWjjwOVVGkxrVzWkffUKcQ0M4V80m8JDI400Zjsq9A1kNajNQFX3uh2xJJ
 FCoDEnA44F+wzFxTCJR3cIfryRa2dnBGs539l3TpKE3BbgLgHT62e24kh0y7V0MjefMw1LoXKL
 x3FZ5VUYSExkOTOkzS66ei5mLoANe7QxgpfxSsggLHievVRnkQAAmJXbqSRPxZfITHuFEnF1VG
 cMLWb1Yc2Oca9TvLwxGoHFHC3dnwy0UL1Tquq8c+3+bIz3ogw81MO6t2ng9rACVVzmLnIv1Wz/
 VNk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 20:43:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGlnM1TB1z1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:43:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676436182; x=1679028183; bh=rllAuMPvoBr0L1lHfSbaKvi2l3urZy0SiU0
        ZdfBD6O0=; b=dHQcYyajSSXM3vLe5O/aieZcOGHfjTcjzMVab0z7BQxFXU3AFt7
        iBcfAg5kHGp/5Re1Suib2SfpNsfA4/wXnNbUEeMf+xcGJRae9VnnWCpttZnYHcJA
        iF3CnB2ioq64V9Zsb88hVrkAUeWavmELQzeY9PylCte00lyxUXOiO0XvDYoSZtJA
        KCML8nF4cHwSngLEW5vuVrKsFCakIfeQq3Df1QAEUBnZ/TL2faF2sIS0F05PGV79
        ia3cjxFss3JRqxvvKkElS7ooNpl9zzv1ldvSZrBzqdPflMvhbUxhK9P+vF0YOkYB
        SAeE0lIHOkiyeoYDOEqfDTBIGGrBL7qYxUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Oi6_ZgREvfzO for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 20:43:02 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGlnJ0CZsz1RvLy;
        Tue, 14 Feb 2023 20:42:59 -0800 (PST)
Message-ID: <63b3aeca-d219-264c-c944-eb4e85f36f9f@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 13:42:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] [v2] scsi: ipr: work around fortify-string warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@SteelEye.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230214132831.2118392-1-arnd@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214132831.2118392-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 22:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ipr_log_vpd_compact() function triggers a fortified memcpy() warning
> about a potential string overflow with all versions of clang:
> 
> In file included from drivers/scsi/ipr.c:43:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __write_overflow_field(p_size_field, size);
>                         ^
> include/linux/fortify-string.h:520:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> 2 errors generated.
> 
> I don't see anything actually wrong with the function, but this is the
> only instance I can reproduce of the fortification going wrong in the
> kernel at the moment, so the easiest solution may be to rewrite the
> function into something that does not trigger the warning.
> 
> Instead of having a combined buffer for vendor/device/serial strings,
> use three separate local variables and just truncate the whitespace
> individually.
> 
> Fixes: 8cf093e275d0 ("[SCSI] ipr: Improved dual adapter errors")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


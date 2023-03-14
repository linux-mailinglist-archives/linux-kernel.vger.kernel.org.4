Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72FE6B92C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCNMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCNMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:12:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F032364C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678795951; x=1710331951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AWlliTNQy/jtW/E1Q9kESrXcsNXoqskGW2n4Kz4CcNM=;
  b=M+xVF1NhRN4YWCsG06Hx7uF/1CriCRtjWMge8DwDHPp2Ub9KBMCQ/iji
   M39LIXj8BQLFLgOsUjsZa3ElS3P2w2kVtJjGVVeI0UFQP1vUxtTZ8QT7g
   Yq1pBGlji/jEuFH55LK0iZ6H5fQZ5awsZpt2OPrbMX/W8CS03SoaCS1PM
   GMtm5TqV7BBWvn/J7Mrhs4Wy16mZGeSSwConX6EJAsckebCP3T0J7XP1T
   jle1KlJJmZBlBdfMzpm8TSfg5OWRsrmZCi7lUGzbxHNT2HF96k3LOjd4+
   XJXGpjSXGstnCIvEzkvaH/W7YIVeCYwVXjT2T7lXQgtgb6vmpxYYCZzOF
   g==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="223879556"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 20:12:31 +0800
IronPort-SDR: OrxtvsdB8i4JcGRhx0ul8JT/66Q08MlYJ4Ud/HvJW3S0+YXl8JqfczLvX5rE2TNXXgvmY29nce
 vSHx1Xiire5cbzekvUr1SBvSj3G5j8y+MeOYcdd8ITkWGt9nuDISs5RvjJbhsVW1LWajqkGMTm
 48j//vUJGZX0Jpu937ybrvOAeBA2EXqIKr+RcHcPELPfpLt2wJCyYV3AO82MSl8OXsD1OroI6q
 LTAVGkzPZ1ObhgH4XMGFErROW1OwB4WpB9t72HRibTaPFhMGGgseE+9iG91GOyZ9ISe2lxm8s7
 ueI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 04:23:18 -0700
IronPort-SDR: MbmTta0s1akcuCrPPlmWoRBM5LAdYGZXCvq87OP8tA1q19KoAdUjB+CDpfpHNOoXwb//v4rRG0
 ZSKPD/tr6pXx/9D79x9N12dx48oFPFzFSzkpjfxF0yUC7iqKyHMUOcOeqofTuNJsm89agHMCFD
 FHoYdl24pwfcDNCqncePUY60d4X3W4+vmiClKszKFlZz1td1nudu7aN2XXpKssXTOrgoahBVoq
 GRajGhs/8E2f7kZNcKzBK/fjfEPYQk91W7+6gpeBK9d+6nlEqRvnBlr1lUpmf6/Q1x3ySXy1C9
 XIg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 05:12:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbXTV70yfz1RtVv
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:12:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678795950; x=1681387951; bh=AWlliTNQy/jtW/E1Q9kESrXcsNXoqskGW2n
        4Kz4CcNM=; b=dcRlGhE9YGHu+giJbC0D0Ij4I8F+fruLSEa86H2oLB7+c0LDRAm
        nqcXES3yCK4XAMhVL2Ymg02x5uzM9e4V/kh3sXxOt69qD78k+hNqhbSHTkryVbgE
        V3JtNyGhW5i+GqmJbBF14VuvUNrUf2kn9BEhIysopzTh5KKUXYqRGz8RqKNS1ZON
        LgVkrzRXIgDQ/EDYV6IM1oSaVDvB/oFGHHCzYwCrJeCCtktlCEBOdEONjE+md9Rp
        Jjmn0vnPgYV7rC7lIFFPfKwAVlK9zHlRE172nRVLnBUM7gQ0ZpFRuBlaHooBG8aq
        Q1CyqzbDzIF3u9V3g9E3CLb08lg9G9L62KA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R3mD5djHCHBB for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 05:12:30 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbXTT2PB0z1RtVm;
        Tue, 14 Mar 2023 05:12:29 -0700 (PDT)
Message-ID: <76456032-cc76-aede-f760-65cb999a2163@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 21:12:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>
References: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 21:49, Geert Uytterhoeven wrote:
> The Freescale QorIQ AHCI SATA controller is only present on Freescale
> Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without Layerscape support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b56fba76b43f48f7..42b51c9812a0ebab 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -276,6 +276,7 @@ config AHCI_XGENE
>  config AHCI_QORIQ
>  	tristate "Freescale QorIQ AHCI SATA support"
>  	depends on OF
> +	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	  This option enables support for the Freescale QorIQ AHCI SoC's

Do you want this in fixes or queuing this for 6.4 is fine ?

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84BD5FE79F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJNDdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNDdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:33:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E966E8C67
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665718380; x=1697254380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7/i9odLgURMcNLh9baM3cplpp14Eizpe1w6f4JvRqRQ=;
  b=MO8b3qYp0Ycp4VOthZZLe0rYskTlJ/vSyIYuCk+rZ2hNarGshlYUgxZe
   heInDM9kup0VpFMTke8ZoSjRQNBxveoWSVEsV1jpU9nWgPLL7pvF1rLaP
   g/xbYLkWry9dN3SX8BQiKwwYn/7UqCUoHnx9krlYYUfsHLVYajzHyvzwb
   fz1JJD2nSD/ZNBQRDbUuA47fFt3SiHCJXU9TqZ8w0TPXguBf/9zhvUg+v
   Sf4tvWBmtBZS4n82bSyanAhEBkiZ5DdSlXf9/UhmbukD9YEeIxENvjMQK
   zQi2reMvH3pq5JfjCa3T9t3LQUb1DZ14+N8twCz30n3OUiaiVXC+nR1Ex
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="325867341"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 11:32:59 +0800
IronPort-SDR: p+Q+QtQNGnhVltdm++l5q42fw3Nkg+7wU4lSehqx4mXlqit6T+lTrICTkL3KxF5tNClxl3tLyF
 lMt5OpWjU0DtBpWUDQHJePTM3MpMJmuIskaQiuZx5GAqDH5Db+GKCfN3jeXDzNpLC25+yezUby
 xfipYCvHH84BbSfbuwx+CKWxcJ/c7MuP5+5upUsdOQsBl32Q84RHZq1IBrCrOYJx7r6j3ZVAK/
 16Y4Nve76nY1RqyN2sw35RbeyyJUWn9ymIEvUWvNyYuX+D6j3Qpi7WuCxGBfBI8wcJxKxXI2z+
 iqZ69AcTALfAOQdvUUCTixq6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 19:52:36 -0700
IronPort-SDR: 2varK9509TavzIH+B80hvPPrXtmWH0zUuRRMNVqhBIZIEs8BLiZKMlGt50bjEHZwBQMBTiT0/O
 YTawrQdRAN1gAWZ8RI4CI4H+2Xl+/KX6IywredWK++Rkasw19IuiAKU2z1fGTBcO3ME/HMdNWS
 LOpeDLdYJADBc9YfJlJvoTr3Aw7rqUyPTA3Vci4mBpD8om6GSQ/QzzlJxgdv7EeemMIlzUZN7C
 QwELC0WjM40tuEeObsSrPkM4DQY1+SFvP9enHzrtyLW13Kw82cFnwooVjEcfc+1BJoJwhPmbYe
 SPA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 20:32:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpX5l0STXz1RwqL
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:32:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665718378; x=1668310379; bh=7/i9odLgURMcNLh9baM3cplpp14Eizpe1w6
        f4JvRqRQ=; b=BNMbR8lmt9ePsQ6R7UKXfyQ4/5L6WItbjD1dz6+7NPquJLfRr7M
        SXWFR+aR9+vEAsAcU/cQGVqeybVpZMji67UWIA8eV5c9HHg8l+tiYFAbr0a+5Ddv
        a6tVLz11vodfs8ne5Q8tWydrXq9jMclzQxT75wYUL+KjzQK6RDh2O1nYHCgDpNny
        i7KHuT6LGOzlLWgx9OY0rrPCJd9SFWCzRLg0eufdHW2pxAWGKdaR58kPLxOx85vJ
        YV12d9LFUNPJMxveK1J2I2M8Fu4S8YLGmJKr3325Je5j7te1nfRqcctd4J9B4gJb
        HSwgVRIVXTE32PSlxp6ObEEDNAuYKFmhbzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o--e75QqUHt2 for <linux-kernel@vger.kernel.org>;
        Thu, 13 Oct 2022 20:32:58 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpX5j5jdrz1RvLy;
        Thu, 13 Oct 2022 20:32:57 -0700 (PDT)
Message-ID: <76a729e7-5d65-d965-da8e-f3ff3fd781d8@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 12:32:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011024617.720898-1-kai.heng.feng@canonical.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221011024617.720898-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 11:46, Kai-Heng Feng wrote:
> UBSAN complains about array-index-out-of-bounds:
> [ 1.980703] kernel: UBSAN: array-index-out-of-bounds in /build/linux-9H675w/linux-5.15.0/drivers/ata/libahci.c:968:41
> [ 1.980709] kernel: index 15 is out of range for type 'ahci_em_priv [8]'
> [ 1.980713] kernel: CPU: 0 PID: 209 Comm: scsi_eh_8 Not tainted 5.15.0-25-generic #25-Ubuntu
> [ 1.980716] kernel: Hardware name: System manufacturer System Product Name/P5Q3, BIOS 1102 06/11/2010
> [ 1.980718] kernel: Call Trace:
> [ 1.980721] kernel: <TASK>
> [ 1.980723] kernel: show_stack+0x52/0x58
> [ 1.980729] kernel: dump_stack_lvl+0x4a/0x5f
> [ 1.980734] kernel: dump_stack+0x10/0x12
> [ 1.980736] kernel: ubsan_epilogue+0x9/0x45
> [ 1.980739] kernel: __ubsan_handle_out_of_bounds.cold+0x44/0x49
> [ 1.980742] kernel: ahci_qc_issue+0x166/0x170 [libahci]
> [ 1.980748] kernel: ata_qc_issue+0x135/0x240
> [ 1.980752] kernel: ata_exec_internal_sg+0x2c4/0x580
> [ 1.980754] kernel: ? vprintk_default+0x1d/0x20
> [ 1.980759] kernel: ata_exec_internal+0x67/0xa0
> [ 1.980762] kernel: sata_pmp_read+0x8d/0xc0
> [ 1.980765] kernel: sata_pmp_read_gscr+0x3c/0x90
> [ 1.980768] kernel: sata_pmp_attach+0x8b/0x310
> [ 1.980771] kernel: ata_eh_revalidate_and_attach+0x28c/0x4b0
> [ 1.980775] kernel: ata_eh_recover+0x6b6/0xb30
> [ 1.980778] kernel: ? ahci_do_hardreset+0x180/0x180 [libahci]
> [ 1.980783] kernel: ? ahci_stop_engine+0xb0/0xb0 [libahci]
> [ 1.980787] kernel: ? ahci_do_softreset+0x290/0x290 [libahci]
> [ 1.980792] kernel: ? trace_event_raw_event_ata_eh_link_autopsy_qc+0xe0/0xe0
> [ 1.980795] kernel: sata_pmp_eh_recover.isra.0+0x214/0x560
> [ 1.980799] kernel: sata_pmp_error_handler+0x23/0x40
> [ 1.980802] kernel: ahci_error_handler+0x43/0x80 [libahci]
> [ 1.980806] kernel: ata_scsi_port_error_handler+0x2b1/0x600
> [ 1.980810] kernel: ata_scsi_error+0x9c/0xd0
> [ 1.980813] kernel: scsi_error_handler+0xa1/0x180
> [ 1.980817] kernel: ? scsi_unjam_host+0x1c0/0x1c0
> [ 1.980820] kernel: kthread+0x12a/0x150
> [ 1.980823] kernel: ? set_kthread_struct+0x50/0x50
> [ 1.980826] kernel: ret_from_fork+0x22/0x30
> [ 1.980831] kernel: </TASK>
> 
> This happens because sata_pmp_init_links() initialize link->pmp up to
> SATA_PMP_MAX_PORTS while em_priv is declared as 8 elements array.
> 
> I can't find the maximum Enclosure Management ports specified in AHCI
> spec v1.3.1, but "12.2.1 LED message type" states that "Port Multiplier
> Information" can utilize 4 bits, which implies it can support up to 16
> ports. Hence, use SATA_PMP_MAX_PORTS as EM_MAX_SLOTS to resolve the
> issue.

Yes, makes sense: em_priv declaration does say so:

	/* enclosure management info per PM slot */
	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];

So if it is per pm slot and we can have at most SATA_PMP_MAX_PORTS, then
indeed EM_MAX_SLOTS should be equal to that. I wonder why a different
macro is used, but I have not dig into git log history to find out :)

> BugLink: https://bugs.launchpad.net/bugs/1970074

Ideally, this would need a Fixes tag too I. EM_MAX_SLOTS was set to 8 from
the start:

18f7ba4c2f4b ("libata/ahci: enclosure management support")

but the code has changed a lot after that.

Adding "Cc: stable@vger.kernel.org" should suffice here since your fix
should apply to all stable versions (please check !).

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/ata/ahci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index da7ee8bec165a..7add8e79912b1 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -257,7 +257,7 @@ enum {
>  	PCS_7				= 0x94, /* 7+ port PCS (Denverton) */
>  
>  	/* em constants */
> -	EM_MAX_SLOTS			= 8,
> +	EM_MAX_SLOTS			= SATA_PMP_MAX_PORTS,
>  	EM_MAX_RETRY			= 5,
>  
>  	/* em_ctl bits */

-- 
Damien Le Moal
Western Digital Research


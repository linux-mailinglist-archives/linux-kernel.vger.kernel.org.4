Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA570D414
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjEWGiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA1119;
        Mon, 22 May 2023 23:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0986662173;
        Tue, 23 May 2023 06:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF449C4339B;
        Tue, 23 May 2023 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684823898;
        bh=RQN6DnPAkpIIPJFpuYK/5KbWPqfsotMI4hEIyiXVqNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=blbM+QbZDBmJi43qCrEwuSymFbY1PKe0FUNhaI9igDkUtfMOKf2pbsmLLtNNBkR4m
         Maq1Cq84ZlgC3J7TRxQxZjqEYwpFjMac1QrSuRvy5a+dB+OOYylIljesMDSQ2dtyo7
         /FPPNFrz8RZcJ6nfmGmfcYDrbTU0vKvSu2purLAEmk1DDE7QgA3SCTShUdRY6mdWTx
         Ca3HovYmcd5UmqXhoESvTOtudRrURLPe/2aw9szc+Lbvxn33FaBKuIEpd6Xogg3zjm
         W+UIguzQsaPQgao4yVq8PvKYH2nFRMfMQKb0A2cJan1m4Xn5j2IPC08QkqCVlDqpkO
         Dl8yjZb0lSpzw==
Message-ID: <c7e0574e-bfb2-fee7-2467-5f9cd8d335f5@kernel.org>
Date:   Tue, 23 May 2023 15:38:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: build warning after merge of the scsi-mkp tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230523133833.64560bf3@canb.auug.org.au>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230523133833.64560bf3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 12:38, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/ata/libata-scsi.c:3864: warning: Function parameter or member 'spg' not described in 'ata_mselect_control'
> 
> Introduced by commit
> 
>   df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> 

Martin,

This is missing:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 69fc0d2c2123..c676b1e9b6c9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3850,6 +3850,7 @@ static unsigned int ata_mselect_control_ata_feature(struct
ata_queued_cmd *qc,
 /**
  *     ata_mselect_control - Simulate MODE SELECT for control page
  *     @qc: Storage for translated ATA taskfile
+ *     @spg: sub-page of the control page
  *     @buf: input buffer
  *     @len: number of valid bytes in the input buffer
  *     @fp: out parameter for the failed field on error

Do you want me to send a fix patch or can you fold this in ?

-- 
Damien Le Moal
Western Digital Research


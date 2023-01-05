Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47F65F38B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjAESNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjAESMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625D656C;
        Thu,  5 Jan 2023 10:12:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A6F0B81B3E;
        Thu,  5 Jan 2023 18:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF1C433EF;
        Thu,  5 Jan 2023 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672942353;
        bh=t2Ard4AIZn0bA5uFWm/ttV/iCirtM24HVwYbrcC4K3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrOfgsZMDbPRtl8slDBwDJZFOdlkc17CWZXXZsO3gihzjMvNtpEpTZUNPQgXSmnRW
         AMo8wYCj5ZIOd/OMwz+6UDTA/VirogVeVdk2y0iJL5r2c1ButggZqcPWHCBpIEdtEf
         Qz+yRG9lYKPgDDgwZfLEcqyhIYANjimi8InflhhxSNeLZNoSjei3T8z8biPItnc6hi
         QTfRlbmqwYnLucUyFjNAHCM9LMcfiN2R98F7XwJ9SU/gMt+umplcZXPK8+KsN4s7b4
         BPT0YhrJ85XoMPIWDJWcInppc5xnQ48DszfH5DSe4BCnWTe22EFYKw7deBEFCxtrIJ
         Q0T5415rskytA==
Date:   Thu, 5 Jan 2023 12:12:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: mvumi: Replace 1-element arrays with flexible
 array members
Message-ID: <Y7cTFfWzLeHKuGWC@work>
References: <20230105011143.never.569-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105011143.never.569-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:11:50PM -0800, Kees Cook wrote:
> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element arrays with flexible-array member in struct
> mvumi_msg_frame, struct mvumi_rsp_frame, and struct mvumi_hs_header,
> adjusting the explicit sizing calculations at the same time.
> 
> This results in no functional differences in binary output. An explicit
> add is now folded into the size calculation:
> 
> │       mov    0x1070(%r14),%eax
> │ -     add    $0x4,%eax
> │ -     movabs $0xfffffffdc,%rbx
> │ +     movabs $0xfffffffe0,%rbx
> │       add    %rax,%rbx
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Wow, those "magical" 4s seem quite elusive. It's more common to see people
using sizeof applied to the element type, like sizeof(u32).

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/scsi/mvumi.c | 4 ++--
>  drivers/scsi/mvumi.h | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index b3dcb8918618..60c65586f30e 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -1841,7 +1841,7 @@ static enum mvumi_qc_result mvumi_send_command(struct mvumi_hba *mhba,
>  	cmd->frame->request_id = mhba->io_seq++;
>  	cmd->request_id = cmd->frame->request_id;
>  	mhba->tag_cmd[cmd->frame->tag] = cmd;
> -	frame_len = sizeof(*ib_frame) - 4 +
> +	frame_len = sizeof(*ib_frame) +
>  				ib_frame->sg_counts * sizeof(struct mvumi_sgl);
>  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
>  		struct mvumi_dyn_list_entry *dle;
> @@ -2387,7 +2387,7 @@ static int mvumi_io_attach(struct mvumi_hba *mhba)
>  	struct Scsi_Host *host = mhba->shost;
>  	struct scsi_device *sdev = NULL;
>  	int ret;
> -	unsigned int max_sg = (mhba->ib_max_size + 4 -
> +	unsigned int max_sg = (mhba->ib_max_size -
>  		sizeof(struct mvumi_msg_frame)) / sizeof(struct mvumi_sgl);
>  
>  	host->irq = mhba->pdev->irq;
> diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
> index a88c58787b68..1306a4abf19a 100644
> --- a/drivers/scsi/mvumi.h
> +++ b/drivers/scsi/mvumi.h
> @@ -279,7 +279,7 @@ struct mvumi_msg_frame {
>  	u16 request_id;
>  	u16 reserved1;
>  	u8 cdb[MAX_COMMAND_SIZE];
> -	u32 payload[1];
> +	u32 payload[];
>  };
>  
>  /*
> @@ -294,7 +294,7 @@ struct mvumi_rsp_frame {
>  	u8 req_status;
>  	u8 rsp_flag;	/* Indicates the type of Data_Payload.*/
>  	u16 request_id;
> -	u32 payload[1];
> +	u32 payload[];
>  };
>  
>  struct mvumi_ob_data {
> @@ -380,7 +380,7 @@ struct mvumi_hs_header {
>  	u8	page_code;
>  	u8	checksum;
>  	u16	frame_length;
> -	u32	frame_content[1];
> +	u32	frame_content[];
>  };
>  
>  /*
> -- 
> 2.34.1
> 

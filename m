Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89B6699B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjBPRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBPRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:23:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9A564A7;
        Thu, 16 Feb 2023 09:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE693B82926;
        Thu, 16 Feb 2023 17:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EEFC4339C;
        Thu, 16 Feb 2023 17:23:01 +0000 (UTC)
Date:   Thu, 16 Feb 2023 12:22:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v1] scsi: ufs: core: Add trace event for MCQ
Message-ID: <20230216122259.7f44be57@rorschach.local.home>
In-Reply-To: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
References: <1676515562-55805-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 10:45:55 +0800
Ziqi Chen <quic_ziqichen@quicinc.com> wrote:

> Added a new trace event to record MCQ relevant information
> for each request in MCQ mode, include hardware queue ID,
> SQ tail slot, CQ head slot and CQ tail slot.
> 
> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c  | 15 ++++++++++++---
>  include/trace/events/ufs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78..0037f4f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -426,6 +426,8 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>  	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>  	struct scsi_cmnd *cmd = lrbp->cmd;
>  	struct request *rq = scsi_cmd_to_rq(cmd);
> +	struct ufs_hw_queue *hwq;
> +
>  	int transfer_len = -1;
>  
>  	if (!cmd)
> @@ -456,9 +458,16 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
>  	}
>  
>  	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> -	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
> -			doorbell, transfer_len, intr, lba, opcode, group_id);
> +
> +	if (is_mcq_enabled(hba)) {
> +		hwq = ufshcd_mcq_req_to_hwq(hba, rq);
> +		trace_ufshcd_command_mcq(dev_name(hba->dev), str_t, tag,

It's better to move the processing of the "dev_name(hba->dev) into the
trace event code. Maybe even just pass in hba.

> +				hwq, transfer_len, intr, lba, opcode, group_id);
> +	} else {
> +		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> +		trace_ufshcd_command(dev_name(hba->dev), str_t, tag,

Here too.

> +				doorbell, transfer_len, intr, lba, opcode, group_id);
> +	}
>  }
>  
>  static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index 599739e..a406404e 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -10,6 +10,7 @@
>  #define _TRACE_UFS_H
>  
>  #include <linux/tracepoint.h>
> +#include <ufs/ufshcd.h>
>  
>  #define str_opcode(opcode)						\
>  	__print_symbolic(opcode,					\
> @@ -307,6 +308,53 @@ TRACE_EVENT(ufshcd_command,
>  	)
>  );
>  
> +TRACE_EVENT(ufshcd_command_mcq,
> +	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,

So you would pass in the type of hba here.

> +		unsigned int tag, struct ufs_hw_queue *hwq, int transfer_len,
> +		u32 intr, u64 lba, u8 opcode, u8 group_id),
> +
> +	TP_ARGS(dev_name, str_t, tag, hwq, transfer_len, intr, lba, opcode, group_id),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)

		__string(dname, dev_name(hba->dev))

> +		__field(enum ufs_trace_str_t, str_t)
> +		__field(unsigned int, tag)
> +		__field(u32, hwq_id)
> +		__field(int, transfer_len)
> +		__field(u32, intr)
> +		__field(u64, lba)
> +		__field(u8, opcode)
> +		__field(u8, group_id)
> +		__field(u32, sq_tail)
> +		__field(u32, cq_head)
> +		__field(u32, cq_tail)

I bet the above has a lot of holes in it. The above is not packed, so
make sure you count the size of each field and try to keep them aligned.



> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);

		__assign_str(dname, dev_name(hba->dev));

> +		__entry->str_t = str_t;
> +		__entry->tag = tag;
> +		__entry->hwq_id = hwq->id;
> +		__entry->transfer_len = transfer_len;
> +		__entry->intr = intr;
> +		__entry->lba = lba;
> +		__entry->opcode = opcode;
> +		__entry->group_id = group_id;
> +		__entry->sq_tail = hwq->sq_tail_slot;
> +		__entry->cq_head = hwq->cq_head_slot;
> +		__entry->cq_tail = hwq->cq_tail_slot;
> +	),
> +
> +	TP_printk(
> +		"%s: %s: tag: %u, hwq_id: %d, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, sq_tail_slot: %d, cq_head_slot: %d, cq_tail_slot: %d",
> +		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),

				__get_str(dname),

-- Steve

> +		__entry->tag, __entry->hwq_id, __entry->transfer_len,
> +		__entry->intr, __entry->lba, (u32)__entry->opcode,
> +		str_opcode(__entry->opcode), (u32)__entry->group_id,
> +		__entry->sq_tail, __entry->cq_head,  __entry->cq_tail
> +	)
> +);
> +
>  TRACE_EVENT(ufshcd_uic_command,
>  	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
>  		 u32 arg1, u32 arg2, u32 arg3),


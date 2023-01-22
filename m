Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D641677187
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjAVSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:30:20 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C544CC27;
        Sun, 22 Jan 2023 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674412208; bh=ElZMTwW2yu8oewdRYQDALPo3Sk3ZTuh+Oblh05N6xcw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=T0lNyxFmE+dA1NGAL9zNlvpaRNwiiTmCD35R5iD2Cy9ig6Hn7poqjZ9EuaMfp9SwI
         wNUkDLWDND/RMCJtvLnjPBhacoGzpEPqDkA/rQtqFbjK6mPmeFIWfWefXN0+GhI2aS
         BinlIOmNJcmpsxubKDqhZpaUoNwnHY6xCjI2aslU=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:30:08 +0100 (CET)
X-EA-Auth: ckPJ/nVNLUCaQA4OwNmrFjIGTFI9QekKy1ednMJV5VLEvc5A9rkuk1VITfPpA0qlijjoazcAJmbGA9sHgLN/L/4fzhfxWHjQ
Date:   Mon, 23 Jan 2023 00:00:04 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v2] scsi: qla2xxx: Simplify if condition evaluation
Message-ID: <Y82ArKIL4ChMzxx4@ubun2204.myguest.virtualbox.org>
References: <Y7+oJuah0MgEW0PQ@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7+oJuah0MgEW0PQ@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:56:46AM +0530, Deepak R Varma wrote:
> A logical evaluation of type (!A || A && B) can be simplified as
> (!A || B).
> Improvement by suggested by excluded_middle.cocci Coccinelel semantic
> patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
May I request a review and feedback comment on this patch please?

Thank you,
./drv

> Please note: Change is compile tested only.
> 
> Changes in v2:
>    - Correct the if evaluation from (A && B) to (!A || B). Feedback
>      from Lee Duncan <lduncan@suse.com>
> 
>  drivers/scsi/qla2xxx/qla_target.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> index 548f22705ddc..4f104fbfe55d 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
>  		}
>  
>  		if (ha->flags.edif_enabled &&
> -		    (!own || (own &&
> -			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
> +				(!own || own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
>  			sess->edif.authok = 0;
>  			if (!ha->flags.host_shutting_down) {
>  				ql_dbg(ql_dbg_edif, vha, 0x911e,
> -- 
> 2.34.1
> 
> 
> 



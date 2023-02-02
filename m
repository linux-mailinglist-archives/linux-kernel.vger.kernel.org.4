Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42690688840
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBBU2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBBU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:28:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F738E99
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:28:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6405836pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kCeSKsaiEn0ZIK4bA5yE4w/pjc6DqI6l1J6JDIP3nQA=;
        b=fyLHSpVqKD2jEZCRFdH9Hm9DZGY4bwXlC1M1zi883+qOV+pc56CQalsX0kjMJc8MI+
         XYAi1mUqqlyTJ7C/Qd3A+4Tt26YQPzCnDidTIjuQ55zm0q+okDtQ8esuws3SJHpmMxDv
         L8L2JLR26CAdCKs7V541FTwTpfsEYz2LHlPUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCeSKsaiEn0ZIK4bA5yE4w/pjc6DqI6l1J6JDIP3nQA=;
        b=nIr8n+vZvUiwQCsokdyDdNU27wiOTxf3VJUg0mUhO9Cw0zdfsBMmnMz8IjbPeQ25zb
         fvcWTEfi3+FH1tGviknjB3Mu9Y8eseZK7yV3580Dxk11H8tYY/g5KrwQBzEC74uw4qK8
         93idpM0exg8O7utuJWEhLoLc6pLR8c/SU9X4NoIqU4suIpcI5GeY8tBkhHj1UEPWYQa/
         9RMFeyXtrUdf0rSvTy6kR24HqBBbXA/cVH1PkUN/JI/W5GVn5v4NBNwctQsgwbbiSbT+
         gavJvSAP6Q1zzFjLZyNCUHXbRAGp4Lzfz3Jb0TZT6il3IK1XuuNj0zlQs2cfu3tX9SzD
         1MgQ==
X-Gm-Message-State: AO0yUKUPgaGawkw3FdXQBkTQxpTmqIUS8NxW9uNCpHdqWM5XUvXix4Vb
        Dd8tctMDizWOTqQqOs1tMAdVbgxnRcpvrKbc
X-Google-Smtp-Source: AK7set8/0ss9qYyQiFWrVF9nmGsWNhlsjTyaztcZXm/XLquFezmkBOFFR1j2rtW4e/z2gad/W90XuQ==
X-Received: by 2002:a17:903:230d:b0:196:4fe3:21b1 with SMTP id d13-20020a170903230d00b001964fe321b1mr8477930plh.27.1675369709462;
        Thu, 02 Feb 2023 12:28:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001929f0b4582sm63943pll.300.2023.02.02.12.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:28:29 -0800 (PST)
Message-ID: <63dc1ced.170a0220.f43a2.02c5@mx.google.com>
X-Google-Original-Message-ID: <202302022028.@keescook>
Date:   Thu, 2 Feb 2023 20:28:28 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3][next] scsi: smartpqi: Replace one-element arrays
 with flexible-array members
References: <cover.1663816572.git.gustavoars@kernel.org>
 <62bb7891b3a752e7302286030ba9fafe58dffb1e.1663816572.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bb7891b3a752e7302286030ba9fafe58dffb1e.1663816572.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:29:29PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in structures report_phys_lun_8byte_wwid_list and
> report_phys_lun_16byte_wwid_list.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/204
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Are there any binary differences after this patch? I assume not, so:

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  drivers/scsi/smartpqi/smartpqi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
> index d1756c9d1112..b31b42530674 100644
> --- a/drivers/scsi/smartpqi/smartpqi.h
> +++ b/drivers/scsi/smartpqi/smartpqi.h
> @@ -982,12 +982,12 @@ struct report_phys_lun_16byte_wwid {
>  
>  struct report_phys_lun_8byte_wwid_list {
>  	struct report_lun_header header;
> -	struct report_phys_lun_8byte_wwid lun_entries[1];
> +	struct report_phys_lun_8byte_wwid lun_entries[];
>  };
>  
>  struct report_phys_lun_16byte_wwid_list {
>  	struct report_lun_header header;
> -	struct report_phys_lun_16byte_wwid lun_entries[1];
> +	struct report_phys_lun_16byte_wwid lun_entries[];
>  };
>  
>  struct raid_map_disk_data {
> -- 
> 2.34.1
> 

-- 
Kees Cook

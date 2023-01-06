Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E566041E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAFQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAFQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:17:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FED66992;
        Fri,  6 Jan 2023 08:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 858CBCE1D41;
        Fri,  6 Jan 2023 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F2C433EF;
        Fri,  6 Jan 2023 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021853;
        bh=p0T7Tal9cw1KeAxQQjgXPOaok/DYAkfyk6EUv0mG6iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKvGty8XT9ubhMgeJ82QbqE4jlo35zlRXEcYVgE24ny44/yAT0gfYbzUmvZgPeivg
         TwXVYc1piBEeSxMyAGx+bkufo8P2tMZQo2ElXEeS8V0EmhysnL/KvUZIk8DkgScryc
         wGl/AGvI2aZO52OtPiNk9EXTg/zZubLUiguypHbGZfQEKfFLCIsnTpx4hIa6s6PUHw
         oQh5b2Vkm8SeRDS7p54EiZ6AeU2jFkET2RCA3xf2t7BRGlsm7d8D5WvAvE0DlNthMq
         mI8lFWVFXKc13Jl+geqwgwKn0vTu06wteBFdMd2HT78cRGtEJUKabmVM3wNIRG3ONu
         WqzWUAX5tO1OA==
Date:   Fri, 6 Jan 2023 10:17:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: uapi: Replace 0-length array with flexible array
Message-ID: <Y7hJo5+TXOdCEXbB@work>
References: <20230105233042.never.913-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105233042.never.913-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 03:30:46PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct
> fc_bsg_host_vendor_reply's "vendor_rsp" 0-length array with a flexible
> array. Detected with GCC 13, using -fstrict-flex-arrays=3:
> 
> drivers/scsi/qla2xxx/qla_isr.c: In function 'qla25xx_process_bidir_status_iocb.isra':
> drivers/scsi/qla2xxx/qla_isr.c:3117:54: warning: array subscript 0 is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
>  3117 |         bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = rval;
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from drivers/scsi/qla2xxx/qla_def.h:34,
>                  from drivers/scsi/qla2xxx/qla_isr.c:6:
> include/uapi/scsi/scsi_bsg_fc.h:219:15: note: while referencing 'vendor_rsp'
>   219 |         __u32 vendor_rsp[0];
>       |               ^~~~~~~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/uapi/scsi/scsi_bsg_fc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
> index 7f5930801f72..5e46cf1054af 100644
> --- a/include/uapi/scsi/scsi_bsg_fc.h
> +++ b/include/uapi/scsi/scsi_bsg_fc.h
> @@ -216,7 +216,7 @@ struct fc_bsg_host_vendor {
>   */
>  struct fc_bsg_host_vendor_reply {
>  	/* start of vendor response area */
> -	__u32 vendor_rsp[0];
> +	__DECLARE_FLEX_ARRAY(__u32, vendor_rsp);
>  };
>  
>  
> -- 
> 2.34.1
> 

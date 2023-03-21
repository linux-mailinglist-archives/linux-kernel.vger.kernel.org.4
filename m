Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAF6C3435
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCUO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:28:34 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 07:28:04 PDT
Received: from smtp108.iad3b.emailsrvr.com (smtp108.iad3b.emailsrvr.com [146.20.161.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A5C4219
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1679408287;
        bh=TlmvMoZFxOuSDyvJfZ0J5hwIF97FbtPnlE66kHho/mo=;
        h=Date:Subject:To:From:From;
        b=cN2TurYcLx7jbqyoU/aWftymQORWLtAJT3eqTv7+rRiexgMUlyIYOpSkryUTtAD6V
         zxU0mFyn9sfR14jIevO+IpEVNzCmXzaEdtZ2k9ngRWP+/U/RsksH3X5LC83X0miI1I
         VPKFnCA1sjnz/yRxMAqFfs5jFWriW4T4soObNVGo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 34C5DE0553;
        Tue, 21 Mar 2023 10:18:06 -0400 (EDT)
Message-ID: <a0eb6753-a92f-70bc-7794-c58f8362b1a4@mev.co.uk>
Date:   Tue, 21 Mar 2023 14:18:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] comedi: remove unused dma_chain_flag_bits function
To:     Tom Rix <trix@redhat.com>, hsweeten@visionengravers.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230321121410.1782901-1-trix@redhat.com>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230321121410.1782901-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: ce337f4d-767b-48db-80cb-328976d526b4-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 12:14, Tom Rix wrote:
> clang with W=1 reports
> drivers/comedi/drivers/cb_pcidas64.c:377:28: error: unused function
>    'dma_chain_flag_bits' [-Werror,-Wunused-function]
> static inline unsigned int dma_chain_flag_bits(u16 prepost_bits)
>                             ^
> This function is not used, so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/comedi/drivers/cb_pcidas64.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
> index ca6038a25f26..59390b23fa81 100644
> --- a/drivers/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/comedi/drivers/cb_pcidas64.c
> @@ -374,11 +374,6 @@ static inline u16 pipe_full_bits(u16 hw_status_bits)
>   	return (hw_status_bits >> 10) & 0x3;
>   };
>   
> -static inline unsigned int dma_chain_flag_bits(u16 prepost_bits)
> -{
> -	return (prepost_bits >> 6) & 0x3;
> -}
> -
>   static inline unsigned int adc_upper_read_ptr_code(u16 prepost_bits)
>   {
>   	return (prepost_bits >> 12) & 0x3;

Looks OK, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94C470EC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjEXDyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbjEXDyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A740196;
        Tue, 23 May 2023 20:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7D563870;
        Wed, 24 May 2023 03:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD908C433D2;
        Wed, 24 May 2023 03:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684900437;
        bh=4f1gt/BCfbLHog09/Xsin0iYouAloZtBkhPaw5h+3Uk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTjRau/bNOfmdJ33zPP9fzppLzalj2n66xWeUM8et/U2kDIXenWJlws9ke/J63cua
         7h8nbEpBrHk+3kbBwK4hYrTG0TJuuA4Y8nyVrZV34Feh/wVZUCXe9pHkiL5GrZpTPb
         1pUq0WoLiV4z1hh/q8nIAUP6Q7nvRsPe6zxlxMbem5vTDjKC2IBSsISEX6TycDAT+K
         E11xrcZaYzPDD+AvVcAUfQueTdIeTLMtPcPMx7rpOceZRwETWUuo1o7AcoLQuOypBm
         fbpREO7W2cFcnLHLSfIPlJAIvbGWiK22cduJxuIMSKGEpMfWr2jO0/7hSlREuEGrtM
         7Bq4VihlXfeWA==
Date:   Tue, 23 May 2023 20:53:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Don Brace <don.brace@microchip.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Guo Xuenan <guoxuenan@huawei.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kernel test robot <lkp@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, storagedev@microchip.com,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Add struct_size_t() helper
Message-ID: <20230523205354.06b147c6@kernel.org>
In-Reply-To: <20230522211810.never.421-kees@kernel.org>
References: <20230522211810.never.421-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 14:18:13 -0700 Kees Cook wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
> index 37eadb3d27a8..41acfe26df1c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
> @@ -185,7 +185,7 @@ struct ice_buf_hdr {
>  
>  #define ICE_MAX_ENTRIES_IN_BUF(hd_sz, ent_sz)                                 \
>  	((ICE_PKG_BUF_SIZE -                                                  \
> -	  struct_size((struct ice_buf_hdr *)0, section_entry, 1) - (hd_sz)) / \
> +	  struct_size_t(struct ice_buf_hdr,  section_entry, 1) - (hd_sz)) / \
>  	 (ent_sz))
>  
>  /* ice package section IDs */
> @@ -297,7 +297,7 @@ struct ice_label_section {
>  };
>  
>  #define ICE_MAX_LABELS_IN_BUF                                             \
> -	ICE_MAX_ENTRIES_IN_BUF(struct_size((struct ice_label_section *)0, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_label_section,  \
>  					   label, 1) -                    \
>  				       sizeof(struct ice_label),          \
>  			       sizeof(struct ice_label))
> @@ -352,7 +352,7 @@ struct ice_boost_tcam_section {
>  };
>  
>  #define ICE_MAX_BST_TCAMS_IN_BUF                                               \
> -	ICE_MAX_ENTRIES_IN_BUF(struct_size((struct ice_boost_tcam_section *)0, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_boost_tcam_section,  \
>  					   tcam, 1) -                          \
>  				       sizeof(struct ice_boost_tcam_entry),    \
>  			       sizeof(struct ice_boost_tcam_entry))
> @@ -372,8 +372,7 @@ struct ice_marker_ptype_tcam_section {
>  };
>  
>  #define ICE_MAX_MARKER_PTYPE_TCAMS_IN_BUF                                    \
> -	ICE_MAX_ENTRIES_IN_BUF(                                              \
> -		struct_size((struct ice_marker_ptype_tcam_section *)0, tcam, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_marker_ptype_tcam_section,  tcam, \
>  			    1) -                                             \
>  			sizeof(struct ice_marker_ptype_tcam_entry),          \
>  		sizeof(struct ice_marker_ptype_tcam_entry))

Acked-by: Jakub Kicinski <kuba@kernel.org>

but Intel ICE folks please speak up if this has a high chance of
conflicts, I think I've seen some ICE DDP patches flying around :(

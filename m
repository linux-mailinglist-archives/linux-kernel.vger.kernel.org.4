Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136B723446
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjFFBDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjFFBDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:03:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA3100
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:03:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b0201d9a9eso40433665ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686013400; x=1688605400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+MUoCOufjL+jgfYX81aknXyDcs0G9ERx0AOhezKwvw=;
        b=HLXWeH9ydbwyjK2QQ2/FJYVRGGXWTlX/tgfxpc7B/NTahljnX7/GOTEa83lr3MjpNk
         /Ze73Ehjg/OgWeWM5bYdduqVL7QukbHTf3XYFzHvflh4+GWtFKGv3qM1LLgUa8JR9c19
         wucBprADLLGkv4uaUW81HEmxDAjHVpP/iFMQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686013400; x=1688605400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+MUoCOufjL+jgfYX81aknXyDcs0G9ERx0AOhezKwvw=;
        b=BWWDGH7Rsm9YFX00x42LlEsbT4PBfskHnwLQE+a9bZiGRcJlKOjs29CCbzueMDxj5u
         z45FHN/Xxjcr7pZBXn1jLMbs59nK6NScGknpxk9+AcnEV5VczuCmuT8CcQSC1+yxDcvj
         qhnqwbFfV5P4nP/uqIeVfZYlNr8cpRx+N36RYEGTcl7CLLyShkgGc+te79cXkloc7ALh
         LbfnP1HlbtZUrPX1d9JAnolIDGieG6Qt/53OL8LM1mxGZJaVm6kMiz6C0yodIwCv8Ni6
         nTfe2dXfbqAQtMhhzRyMwdi4/RPo3s/pRACMq6RfxZdk+KOlK7gVLgGc6tot2cTu6rwh
         suxg==
X-Gm-Message-State: AC+VfDyLvOSv7ouw6gDqkkcSQ4zrZpscU+pdr0B0qctEQuZqmp9JSEPA
        JNNSZ0HdSU6cFEOv8aiyuGB0lb+BJTG7FG1Zhko=
X-Google-Smtp-Source: ACHHUZ6YVOiHbysOOAh2pnyOQ50zFHy6l3cr7qmte9qDKRcu8rilGyc0pA/1SxZkjc/xHX3RvgkpXw==
X-Received: by 2002:a17:902:8343:b0:1b0:3ab6:5133 with SMTP id z3-20020a170902834300b001b03ab65133mr9426752pln.24.1686013400562;
        Mon, 05 Jun 2023 18:03:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ac55a5e5eesm7204234plq.121.2023.06.05.18.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:03:19 -0700 (PDT)
Date:   Mon, 5 Jun 2023 18:03:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Message-ID: <202306051758.CD86F1E638@keescook>
References: <ZHpGN555FwAKGduH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHpGN555FwAKGduH@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 01:42:47PM -0600, Gustavo A. R. Silva wrote:
> kmemdup() at line 2735 is not duplicating enough memory for
> notif->tid_tear_down and notif->station_id. As it only duplicates
> 612 bytes: up to offsetofend(struct iwl_wowlan_info_notif,
> received_beacons), this is the range of [0, 612) bytes.
> 
> 2735	notif = kmemdup(notif_v1,
> 2736			offsetofend(struct iwl_wowlan_info_notif,
> 2737				    received_beacons),
> 2738			GFP_ATOMIC);
> 
> which evidently does not cover bytes 612 and 613 for members
> tid_tear_down and station_id in struct iwl_wowlan_info_notif.
> See below:
> 
> $ pahole -C iwl_wowlan_info_notif drivers/net/wireless/intel/iwlwifi/mvm/d3.o
> struct iwl_wowlan_info_notif {
> 	struct iwl_wowlan_gtk_status_v3 gtk[2];          /*     0   488 */
> 	/* --- cacheline 7 boundary (448 bytes) was 40 bytes ago --- */
> 	struct iwl_wowlan_igtk_status igtk[2];           /*   488    80 */
> 	/* --- cacheline 8 boundary (512 bytes) was 56 bytes ago --- */
> 	__le64                     replay_ctr;           /*   568     8 */
> 	/* --- cacheline 9 boundary (576 bytes) --- */
> 	__le16                     pattern_number;       /*   576     2 */
> 	__le16                     reserved1;            /*   578     2 */
> 	__le16                     qos_seq_ctr[8];       /*   580    16 */
> 	__le32                     wakeup_reasons;       /*   596     4 */
> 	__le32                     num_of_gtk_rekeys;    /*   600     4 */
> 	__le32                     transmitted_ndps;     /*   604     4 */
> 	__le32                     received_beacons;     /*   608     4 */
> 	u8                         tid_tear_down;        /*   612     1 */
> 	u8                         station_id;           /*   613     1 */
> 	u8                         reserved2[2];         /*   614     2 */
> 
> 	/* size: 616, cachelines: 10, members: 13 */
> 	/* last cacheline: 40 bytes */
> };
> 
> Therefore, when the following assignments take place, actually no memory
> has been allocated for those objects:
> 
> 2743	notif->tid_tear_down = notif_v1->tid_tear_down;
> 2744	notif->station_id = notif_v1->station_id;
> 
> Fix this by allocating space for the whole notif object and zero out the
> remaining space in memory after member station_id.
> 
> This also fixes the following -Warray-bounds issues:
>  CC      drivers/net/wireless/intel/iwlwifi/mvm/d3.o
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function ‘iwl_mvm_wait_d3_notif’:
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2743:30: warning: array subscript ‘struct iwl_wowlan_info_notif[0]’ is partly outside array bounds of ‘unsigned char[612]’ [-Warray-bounds=]
>  2743 |                         notif->tid_tear_down = notif_v1->tid_tear_down;
>       |
>                  from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
> In function ‘kmemdup’,
>     inlined from ‘iwl_mvm_wait_d3_notif’ at drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2735:12:
> include/linux/fortify-string.h:765:16: note: object of size 612 allocated by ‘__real_kmemdup’
>   765 |         return __real_kmemdup(p, size, gfp);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function ‘iwl_mvm_wait_d3_notif’:
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2744:30: warning: array subscript ‘struct iwl_wowlan_info_notif[0]’ is partly outside array bounds of ‘unsigned char[612]’ [-Warray-bounds=]
>  2744 |                         notif->station_id = notif_v1->station_id;
>       |                              ^~
> In function ‘kmemdup’,
>     inlined from ‘iwl_mvm_wait_d3_notif’ at drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2735:12:
> include/linux/fortify-string.h:765:16: note: object of size 612 allocated by ‘__real_kmemdup’
>   765 |         return __real_kmemdup(p, size, gfp);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Link: https://github.com/KSPP/linux/issues/306
> Fixes: 905d50ddbc83 ("wifi: iwlwifi: mvm: support wowlan info notification version 2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice catch!

> ---
> Changes in v2:
>  - Use sizeof(*notif), instead of sizeof(struct iwl_wowlan_info_notif).
>  - Fix typo in the changelog text s/bouds/bounds.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZHpEjTmBys5cCOGZ@work/
> 
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 37aa4676dc94..6d1007f24b4a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -2732,17 +2732,13 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
>  		if (wowlan_info_ver < 2) {
>  			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
>  
> -			notif = kmemdup(notif_v1,
> -					offsetofend(struct iwl_wowlan_info_notif,
> -						    received_beacons),
> -					GFP_ATOMIC);
> -
> +			notif = kmemdup(notif_v1, sizeof(*notif), GFP_ATOMIC);

The only question I have here is whether or not pkt->data actually
contains sizeof(*notif)-many bytes? It seems the length isn't checked
until after this area:

                len = iwl_rx_packet_payload_len(pkt);

So, perhaps this needs to be changed instead, and the length
double-checked, etc. Perhaps a regular kzalloc + memcpy is needed to
handle pkt->data not being large enough?

>  			if (!notif)
>  				return false;
>  
>  			notif->tid_tear_down = notif_v1->tid_tear_down;
>  			notif->station_id = notif_v1->station_id;
> -
> +			memset_after(notif, 0, station_id);
>  		} else {
>  			notif = (void *)pkt->data;
>  		}
> -- 
> 2.34.1
> 

-- 
Kees Cook

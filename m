Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FB629EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiKOQYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbiKOQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76626B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668529403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ci9vEZZd7PIXQiAbPPazeWj16pxvXWYEaZMVH28k3eg=;
        b=h2UBsPYm6117zn9Xj39zeaiGJIeCeJA5iJIAHKPhJLCk3rAi5utHrmw3CDAJdzFUqbxkBa
        CN1CbL24gpAiH8pU9y8bWJQ/QSTaQhrMN8yvQU82Xq2ir/9LilTbCJ7A+ma6tCIb8MnXUg
        OqrAtRQGqEZeCzYcZ3HNlftCp9LP04Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-y4RNgx0iNYaqvauW37ptEQ-1; Tue, 15 Nov 2022 11:23:21 -0500
X-MC-Unique: y4RNgx0iNYaqvauW37ptEQ-1
Received: by mail-ed1-f72.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so10206731edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci9vEZZd7PIXQiAbPPazeWj16pxvXWYEaZMVH28k3eg=;
        b=jH4yNeJ8yIYsCjBbc6JKXNaxk2Pubg+/gOIoia28xbEJbc94Z3by65cWFJzTnU2W1B
         N87OJ903fU3G2rgLxpjRXm9Oz0oa5gCsv9WRT8m+8uMIoIoYmp0M2oXhlDuEJYo7J6Kj
         WYGATzNgUXS1U82yWflneSCZ4nf+w8OlQrLht2+koSryB4bJbRJjTEXUasSSdA1m4g4E
         w8sshE0opMk+bQOZjk5SiXi2lak4xa4WcQU9SafpssGebmMAs0mkL9nLt6M8kSLD8f3+
         EZoSPmn0eZSogHkcr/EayZx5+DkruZ96cEBWhedWmp2Bzfy/A1BaXDL2lYSY/OWpcXpQ
         BdaA==
X-Gm-Message-State: ANoB5pnHxNDSU9LFJFpcS0F5ekWW8oqO4lcsB6P7PDcH4YvwotISIwNS
        /yT8k1Rn6AjQ2K4e05be7arNrNIyTJpXrt3vPEVrazQvQV/5HrzX980hWMIMKbcJ+WhTV6r9HWk
        wSIrYSTX6bLZqTceKZ/7ZoWnh
X-Received: by 2002:a50:9e43:0:b0:461:8dc1:10b with SMTP id z61-20020a509e43000000b004618dc1010bmr15799162ede.113.1668529400607;
        Tue, 15 Nov 2022 08:23:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5XyDm+yixzRI15F63g79qoETPymzFpi8YahRFdLxhZdAJ5pQYy/PBdlbLy+eAOetK9Ug4gOw==
X-Received: by 2002:a50:9e43:0:b0:461:8dc1:10b with SMTP id z61-20020a509e43000000b004618dc1010bmr15799142ede.113.1668529400392;
        Tue, 15 Nov 2022 08:23:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906305000b0078d21574986sm5613288ejd.203.2022.11.15.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:23:19 -0800 (PST)
Message-ID: <7f906ecf-f115-c102-35b6-0974d98d65e1@redhat.com>
Date:   Tue, 15 Nov 2022 17:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] platform/surface: aggregator: Do not check for
 repeated unsequenced packets
Content-Language: en-US, nl
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221113185951.224759-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221113185951.224759-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/13/22 19:59, Maximilian Luz wrote:
> Currently, we check any received packet whether we have already seen it
> previously, regardless of the packet type (sequenced / unsequenced). We
> do this by checking the sequence number. This assumes that sequence
> numbers are valid for both sequenced and unsequenced packets. However,
> this assumption appears to be incorrect.
> 
> On some devices, the sequence number field of unsequenced packets (in
> particular HID input events on the Surface Pro 9) is always zero. As a
> result, the current retransmission check kicks in and discards all but
> the first unsequenced packet, breaking (among other things) keyboard and
> touchpad input.
> 
> Note that we have, so far, only seen packets being retransmitted in
> sequenced communication. In particular, this happens when there is an
> ACK timeout, causing the EC (or us) to re-send the packet waiting for an
> ACK. Arguably, retransmission / duplication of unsequenced packets
> should not be an issue as there is no logical condition (such as an ACK
> timeout) to determine when a packet should be sent again.
> 
> Therefore, remove the retransmission check for unsequenced packets
> entirely to resolve the issue.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch-series, I've applied this series to my
fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this series in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  .../surface/aggregator/ssh_packet_layer.c     | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 6748fe4ac5d5..def8d7ac541f 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1596,16 +1596,32 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>  		ssh_ptl_tx_wakeup_packet(ptl);
>  }
>  
> -static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, u8 seq)
> +static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, const struct ssh_frame *frame)
>  {
>  	int i;
>  
> +	/*
> +	 * Ignore unsequenced packets. On some devices (notably Surface Pro 9),
> +	 * unsequenced events will always be sent with SEQ=0x00. Attempting to
> +	 * detect retransmission would thus just block all events.
> +	 *
> +	 * While sequence numbers would also allow detection of retransmitted
> +	 * packets in unsequenced communication, they have only ever been used
> +	 * to cover edge-cases in sequenced transmission. In particular, the
> +	 * only instance of packets being retransmitted (that we are aware of)
> +	 * is due to an ACK timeout. As this does not happen in unsequenced
> +	 * communication, skip the retransmission check for those packets
> +	 * entirely.
> +	 */
> +	if (frame->type == SSH_FRAME_TYPE_DATA_NSQ)
> +		return false;
> +
>  	/*
>  	 * Check if SEQ has been seen recently (i.e. packet was
>  	 * re-transmitted and we should ignore it).
>  	 */
>  	for (i = 0; i < ARRAY_SIZE(ptl->rx.blocked.seqs); i++) {
> -		if (likely(ptl->rx.blocked.seqs[i] != seq))
> +		if (likely(ptl->rx.blocked.seqs[i] != frame->seq))
>  			continue;
>  
>  		ptl_dbg(ptl, "ptl: ignoring repeated data packet\n");
> @@ -1613,7 +1629,7 @@ static bool ssh_ptl_rx_retransmit_check(struct ssh_ptl *ptl, u8 seq)
>  	}
>  
>  	/* Update list of blocked sequence IDs. */
> -	ptl->rx.blocked.seqs[ptl->rx.blocked.offset] = seq;
> +	ptl->rx.blocked.seqs[ptl->rx.blocked.offset] = frame->seq;
>  	ptl->rx.blocked.offset = (ptl->rx.blocked.offset + 1)
>  				  % ARRAY_SIZE(ptl->rx.blocked.seqs);
>  
> @@ -1624,7 +1640,7 @@ static void ssh_ptl_rx_dataframe(struct ssh_ptl *ptl,
>  				 const struct ssh_frame *frame,
>  				 const struct ssam_span *payload)
>  {
> -	if (ssh_ptl_rx_retransmit_check(ptl, frame->seq))
> +	if (ssh_ptl_rx_retransmit_check(ptl, frame))
>  		return;
>  
>  	ptl->ops.data_received(ptl, payload);


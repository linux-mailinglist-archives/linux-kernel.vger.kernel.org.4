Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D40700EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjELScE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbjELScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:32:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0093ED
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:31:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6436b503faeso10387693b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916283; x=1686508283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq2By9mZuUQ7p1oM5SkoXHJiUzdgw169iTgadwLtfnQ=;
        b=JWT1FrK7ck7EpDsQRE4pCSwDvUGJ63OfyV6gRQBf3N6utX08/U1OHXmvomU3P6Z3G6
         N5Tvx3vxz4Y6ynHYvG8gsQs85MZ7VK/EoDwOcb9T7Vuf16vwygdYAzo/UNwe5EPtiLD8
         HAQ764S9LE4N6qXozvAtzgduNz/lnpvl878hU17TpCFsRDDOzxM/9/Y7iSQQ3Zx2WZpj
         I4fJF+J/zB+k1AZUcc8RBSXW1+T9EWoDEQpcvOtBknUhsuo/Cja32EUu70hGOaWdrDKH
         6PzSqv0XmVdYlay6qmzlhnjOFde/W19FX57pttk9HvCy1ixM/Fgu/A/6SlTmkdEkZhVw
         NRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916283; x=1686508283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wq2By9mZuUQ7p1oM5SkoXHJiUzdgw169iTgadwLtfnQ=;
        b=f1/kAxKJtnDMfGLlPt3m732l29YzOHN9h8GN7NLlgm+d2o1D6l354IY52ZMQKivt/Q
         cgPWKJLyVSdf0ZNzPyQJraRqhyHoHZsQc3NrHHbACFdcDR5ePW3Fe2PFtFre4rHNi4RX
         /WSsxdiN7PJhpnfxjie+AOnnsR0Zq75yCOv8+ALr+zwrRlOwjcqHBWtTtL/JzeHUSxt/
         uVlcbmX0U7cESS5Wj5Uy27+rJA9VLl/w0j6rUKJdiM4Re+8Qzw/GLnzJkEMsN/YIC1Lt
         tJYblIy1oRHsluPCsDiQYJ+pkrI/fZni5USiCkiqCFJoJGsk28hHka5TAKvhI8/QWlEC
         9LgA==
X-Gm-Message-State: AC+VfDwzuCi6yDyQ389YqBP5GygwAv5GXHaSQYXMPzw4MDw8fFJQBnPd
        ZYDR23LNhusfZLmHf1V/PhVIXIY=
X-Google-Smtp-Source: ACHHUZ5yguYzBo0raBvnnA2xkJTrHlxk1B/ym21H6OwVm5I5+i5m5lU08ouAnUGmmP635rdcxpsTQfI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:7c6:b0:643:599b:4db4 with SMTP id
 n6-20020a056a0007c600b00643599b4db4mr6882664pfu.1.1683916282830; Fri, 12 May
 2023 11:31:22 -0700 (PDT)
Date:   Fri, 12 May 2023 11:31:21 -0700
In-Reply-To: <20230512152607.992209-11-larysa.zaremba@intel.com>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-11-larysa.zaremba@intel.com>
Message-ID: <ZF6F+UQlXA9REqag@google.com>
Subject: Re: [PATCH RESEND bpf-next 10/15] ice: Implement VLAN tag hint
From:   Stanislav Fomichev <sdf@google.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12, Larysa Zaremba wrote:
> Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> packet's VLAN tag.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 1caa73644e7b..39547feb6106 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -627,7 +627,51 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_ctag - VLAN tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_tag: destination address
> + *
> + * Copy VLAN tag (if was stripped) to the destination address.
> + */
> +static int ice_xdp_rx_ctag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	netdev_features_t features;
> +

[..]

> +	features = xdp_ext->rx_ring->netdev->features;
> +
> +	if (!(features & NETIF_F_HW_VLAN_CTAG_RX))
> +		return -EINVAL;

Passing-by comment: why do we need to check features?
ice_get_vlan_tag_from_rx_desc seems to be checking a bunch of
fields in the descriptors, so that should be enough?

> +
> +	*vlan_tag = ice_get_vlan_tag_from_rx_desc(xdp_ext->eop_desc);

Should we also do the following:

if (!*vlan_tag)
	return -ENODATA;

?

> +	return 0;
> +}
> +
> +/**
> + * ice_xdp_rx_stag - VLAN s-tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_tag: destination address
> + *
> + * Copy VLAN s-tag (if was stripped) to the destination address.
> + */
> +static int ice_xdp_rx_stag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	netdev_features_t features;
> +
> +	features = xdp_ext->rx_ring->netdev->features;
> +
> +	if (!(features & NETIF_F_HW_VLAN_STAG_RX))
> +		return -EINVAL;
> +
> +	*vlan_tag = ice_get_vlan_tag_from_rx_desc(xdp_ext->eop_desc);
> +	return 0;
> +}
> +
>  const struct xdp_metadata_ops ice_xdp_md_ops = {
>  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
>  	.xmo_rx_hash			= ice_xdp_rx_hash,
> +	.xmo_rx_ctag			= ice_xdp_rx_ctag,
> +	.xmo_rx_stag			= ice_xdp_rx_stag,
>  };
> -- 
> 2.35.3
> 

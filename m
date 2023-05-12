Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC28700E91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbjELSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjELST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:19:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9AE50
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:19:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6439bc1e3aaso6118527b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683915595; x=1686507595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Je0QZ3OEcPYIjlzwUZPK1i4M9j5mxA5BuIpDlUTvQs0=;
        b=m7pNH+tJv1eJb1PQNpYn7KL+B8x6ruIGuglVNB8oPweOb20MnT+8J0OjNba+0GMzAK
         i2qJQSsCLilZbh/VpSYzFhr+8TWJLN04ELWSCloAo8uOukOYPyZW2y8WCHI2gWKiGPQV
         mrdpFmtHsu5KgALTxLapvn6bfo9H/5o0X4lIsxV8DrTfvLPVA+RJ+JLrS8SyutdKHk91
         ZZOOJNOsgnh7HNk/c9g6OpoP2ftc70yyq7mybLStwyewVu3ewf9Fk314s4R2f5cbmvbp
         1CR/ln9gWb+p/8b1nsfv1vw52Mmb4WkjQI0lXCU+fYFEL2vb9AAks2Y6sdhizLX3G56c
         UgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915595; x=1686507595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Je0QZ3OEcPYIjlzwUZPK1i4M9j5mxA5BuIpDlUTvQs0=;
        b=cIgNM8H0p/t2xJlHIWJ8KlE+ZgpzUiDMKTvilt8tz7DJ4p1YdIi83FB+t7pEhUED2n
         lioZBFeloxZzdpPviKR7wr4q7WaYucHwv7xsSpN6e4pvs6bryW1VAUH9usqD0ErcN/UO
         WrT9cxdIUbAWicOTXw+fAXCYi98x+HDFpM1AyA7+6krcs0CEWB1XC43zyDgpd+JtlWgB
         BTUrKtq1K2ayOJsRXEjwJTpjHaYebxNYgxfPl/iNbmH0Cf+TDrwVQDSvuXFdaskAQOJa
         G4f2zOvSU+65puKGx5fiZRZWA3UO+tZ0fDRtyUvsRDBV/CLU2nNmkJi1Oo0uapfeeuCa
         U1YA==
X-Gm-Message-State: AC+VfDxDhKsMmUYbF5T56uk7fMt+h9oAXCiTEVQmcdLpv4joA67SAaMQ
        05q4lzsNlY9XkoqKUP64x92W/6g=
X-Google-Smtp-Source: ACHHUZ4ijGlK7Lm+EEX2bsGa22HNJnpvzQmaM/g3aYsO0WEKo4uUmlXchpuaAJE65klqvjmYPTAzyvA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:be7:b0:641:31b1:e781 with SMTP id
 x39-20020a056a000be700b0064131b1e781mr7072190pfu.5.1683915595291; Fri, 12 May
 2023 11:19:55 -0700 (PDT)
Date:   Fri, 12 May 2023 11:19:53 -0700
In-Reply-To: <20230512152607.992209-7-larysa.zaremba@intel.com>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-7-larysa.zaremba@intel.com>
Message-ID: <ZF6DHOtnr/AfYxML@google.com>
Subject: Re: [PATCH RESEND bpf-next 06/15] ice: Support HW timestamp hint
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
> Use previously refactored code and create a function
> that allows XDP code to read HW timestamp.
> 
> HW timestamp is the first supported hint in the driver,
> so also add xdp_metadata_ops.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 22 +++++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index aa32111afd6e..ba1bb8392db1 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -962,4 +962,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
>  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
>  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>  }
> +
> +extern const struct xdp_metadata_ops ice_xdp_md_ops;
>  #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a1f7c8edc22f..cda6c4a80737 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3378,6 +3378,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
>  	ice_set_ethtool_ops(netdev);
>  
>  	if (vsi->type != ICE_VSI_PF)
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 2515f5f7a2b6..e9589cadf811 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -537,3 +537,25 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>  			spin_unlock(&xdp_ring->tx_lock);
>  	}
>  }
> +
> +/**
> + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> + * @ctx: XDP buff pointer
> + * @ts_ns: destination address
> + *
> + * Copy HW timestamp (if available) to the destination address.
> + */
> +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	if (!ice_ptp_copy_rx_hwts_from_desc(xdp_ext->rx_ring,
> +					    xdp_ext->eop_desc, ts_ns))
> +		return -EOPNOTSUPP;

Per Jesper's recent update, should this be ENODATA?

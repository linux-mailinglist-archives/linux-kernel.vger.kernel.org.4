Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6EA700EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjELSh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjELShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:37:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795B35A9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:37:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba6f530c9c7so2535746276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916668; x=1686508668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zboVOwqqV2t+sWom/4kttINSyimT2o2UbgCRgWVc8fA=;
        b=fblFRNo8UQl44zBJrRLzXecFe1I+pMjTOLDVKmvVGTWEmqhmhmHjsF65sGuIcN8KGo
         5aicg+lg/yO6VoujBtMcq9FBX6286ctSUAuJYD/aRQeHfUvaOoWMF1mF8jlNV3BA+Qu7
         x6MEddujT5hloeJyBRL7jFkaOcM4Ezx82bqFmBHNjID0qc59h+M0n0vogkO06Vs41V6J
         ky7JyPkksC0Wjy5jdPDmdqqXlVW2U00tK6yLLQEFc1IcTxh4lVHVt4k5pfjbDA+/KTCl
         xHLt64efrqmvdHsYyFwWUu9ctUzwNU/IBeXgIGnCN3Kn1ctzE48+4D27ZR8mgjpH3myC
         FffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916668; x=1686508668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zboVOwqqV2t+sWom/4kttINSyimT2o2UbgCRgWVc8fA=;
        b=LrXPl45mEmt7vKQc698zG24n1/r/+c2NTgxRdTejXCoalFK5Yl1rlQSPgdNtbgUaNu
         dFGKsKPeqAAHS3vzEEgYxe2Yl1lPxz5kn2O2PvfDV1682yF2QYc7BVRgWC/Y3Un42iqN
         YLzMUm2OzTvsJ8fvW+wwLjFc0ITXGFS+6IpXLem8AZx/xKEe2oPAld6blRkx7kStbgRJ
         7NqDiCSwRRhWFdq3b9vZAM78fgOIkSOGFrZgtAICm8XSTHb5jlwVHJ93Lg6TqJqL3+WN
         B34pwSPtlOBNbDAm1W2RfV7rpNgNBdzW5C680txnWrMRKIYI7o+NDxShVRTs54Yi0JPo
         9ZuQ==
X-Gm-Message-State: AC+VfDxCbPAd+XGDmmKE1L5ZrR+b/Dlu7stJ97gbJ3Y9xvQX3mbMqB1F
        2nC+ym58ytJP9sGR8Nq+2Zlma0U=
X-Google-Smtp-Source: ACHHUZ7USl24Sz0lNjT4gOgSLfYQu6o9kzkQudxt7lv7JTr+L0u0cffl5efd7Q5Gwf/cp+vIHzQhdJ4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:545:0:b0:b99:4473:ed93 with SMTP id
 66-20020a250545000000b00b994473ed93mr11326655ybf.4.1683916667981; Fri, 12 May
 2023 11:37:47 -0700 (PDT)
Date:   Fri, 12 May 2023 11:37:46 -0700
In-Reply-To: <20230512152607.992209-16-larysa.zaremba@intel.com>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-16-larysa.zaremba@intel.com>
Message-ID: <ZF6HehIpD67kkldx@google.com>
Subject: Re: [PATCH RESEND bpf-next 15/15] selftests/bpf: Add flags and new
 hints to xdp_hw_metadata
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
> Add hints added in the previous patches (VLAN tags and checksum level)
> to the xdp_hw_metadata program.
> 
> Also, to make metadata layout more straightforward, add flags field
> to pass information about validity of every separate hint separately.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../selftests/bpf/progs/xdp_hw_metadata.c     | 40 ++++++++++++++++---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 29 +++++++++++---
>  tools/testing/selftests/bpf/xdp_metadata.h    | 28 ++++++++++++-
>  3 files changed, 85 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index f95f82a8b449..97bad79ce4ca 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -20,6 +20,12 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>  					 __u64 *timestamp) __ksym;
>  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_xdp_metadata_rx_ctag(const struct xdp_md *ctx,
> +				    __u16 *vlan_tag) __ksym;
> +extern int bpf_xdp_metadata_rx_stag(const struct xdp_md *ctx,
> +				    __u16 *vlan_tag) __ksym;
> +extern int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx,
> +					__u8 *csum_level) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -83,15 +89,39 @@ int rx(struct xdp_md *ctx)
>  		return XDP_PASS;
>  	}
>  
> +	meta->hint_valid = 0;
> +
>  	err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
> -	if (!err)
> +	if (err) {
> +		meta->rx_timestamp_err = err;
> +	} else {
> +		meta->hint_valid |= XDP_META_FIELD_TS;
>  		meta->xdp_timestamp = bpf_ktime_get_tai_ns();
> -	else
> -		meta->rx_timestamp = 0; /* Used by AF_XDP as not avail signal */
> +	}
>  
>  	err = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> -	if (err < 0)
> -		meta->rx_hash_err = err; /* Used by AF_XDP as no hash signal */
> +	if (err)
> +		meta->rx_hash_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_RSS;
> +
> +	err = bpf_xdp_metadata_rx_ctag(ctx, &meta->rx_ctag);
> +	if (err)
> +		meta->rx_ctag_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_CTAG;
> +
> +	err = bpf_xdp_metadata_rx_stag(ctx, &meta->rx_stag);
> +	if (err)
> +		meta->rx_stag_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_STAG;
> +
> +	err = bpf_xdp_metadata_rx_csum_lvl(ctx, &meta->rx_csum_lvl);
> +	if (err)
> +		meta->rx_csum_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_CSUM_LVL;
>  
>  	__sync_add_and_fetch(&pkts_redir, 1);
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..efcabe68f64b 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -156,15 +156,16 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
>  
>  	meta = data - sizeof(*meta);
>  
> -	if (meta->rx_hash_err < 0)
> -		printf("No rx_hash err=%d\n", meta->rx_hash_err);
> -	else
> +	if (meta->hint_valid & XDP_META_FIELD_RSS)
>  		printf("rx_hash: 0x%X with RSS type:0x%X\n",
>  		       meta->rx_hash, meta->rx_hash_type);
> +	else
> +		printf("No rx_hash, err=%d\n", meta->rx_hash_err);
> +
> +	if (meta->hint_valid & XDP_META_FIELD_TS) {
> +		printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> +		       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
>  
> -	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> -	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
> -	if (meta->rx_timestamp) {
>  		__u64 usr_clock = gettime(clock_id);
>  		__u64 xdp_clock = meta->xdp_timestamp;
>  		__s64 delta_X = xdp_clock - meta->rx_timestamp;
> @@ -179,8 +180,24 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
>  		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
>  		       (double)delta_X2U / NANOSEC_PER_SEC,
>  		       (double)delta_X2U / 1000);
> +	} else {
> +		printf("No rx_timestamp, err=%d\n", meta->rx_timestamp_err);
>  	}
>  
> +	if (meta->hint_valid & XDP_META_FIELD_CTAG)
> +		printf("rx_ctag: %u\n", meta->rx_ctag);
> +	else
> +		printf("No rx_ctag, err=%d\n", meta->rx_ctag_err);
> +
> +	if (meta->hint_valid & XDP_META_FIELD_STAG)
> +		printf("rx_stag: %u\n", meta->rx_stag);
> +	else
> +		printf("No rx_stag, err=%d\n", meta->rx_stag_err);
> +
> +	if (meta->hint_valid & XDP_META_FIELD_CSUM_LVL)
> +		printf("Checksum was checked at level %u\n", meta->rx_csum_lvl);
> +	else
> +		printf("Checksum was not checked, err=%d\n", meta->rx_csum_err);
>  }
>  
>  static void verify_skb_metadata(int fd)
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 6664893c2c77..7c0267a8918a 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -17,12 +17,38 @@
>  #define ETH_P_8021AD 0x88A8
>  #endif
>  
> +#define BIT(nr)			(1 << (nr))
> +
> +enum xdp_meta_field {
> +	XDP_META_FIELD_TS	= BIT(0),
> +	XDP_META_FIELD_RSS	= BIT(1),
> +	XDP_META_FIELD_CTAG	= BIT(2),
> +	XDP_META_FIELD_STAG	= BIT(3),
> +	XDP_META_FIELD_CSUM_LVL	= BIT(4),
> +};
> +
>  struct xdp_meta {
> -	__u64 rx_timestamp;
> +	union {
> +		__u64 rx_timestamp;
> +		__s32 rx_timestamp_err;
> +	};
>  	__u64 xdp_timestamp;
>  	__u32 rx_hash;
>  	union {
>  		__u32 rx_hash_type;
>  		__s32 rx_hash_err;
>  	};
> +	union {
> +		__u16 rx_ctag;
> +		__s32 rx_ctag_err;
> +	};
> +	union {
> +		__u16 rx_stag;
> +		__s32 rx_stag_err;
> +	};
> +	union {
> +		__u8 rx_csum_lvl;
> +		__s32 rx_csum_err;
> +	};
> +	enum xdp_meta_field hint_valid;
>  };
> -- 
> 2.35.3
> 

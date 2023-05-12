Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE7700EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbjELSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbjELSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:34:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA45E2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:33:40 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643fdfb437aso36935402b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916416; x=1686508416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+exEN8RF1B40fPaxoi0k2T6E5J3rfhVEZNB9EwpzSM=;
        b=2ytWwJWpT3Nf+cnrsDcHH5KcIuij7GP+ouRdzIMCILh4WRZNrgSQNN19FSJ6vu+wm/
         g0+G/4bQvlOFdtBGD5dHnfuOdk5TdxYByrmDF/2aFlZR2UBLds/mJtqx7rVI/xdWNV8a
         A1sQZ3OALNJkgExEqH3hNisJlOeCU6VF+0abfQro0LL+7l/tUtTnsvTbjzSn/CFfEHbY
         JftijlPqjlutp/AJ42j6ITeno9LWWA0lSoxJy/tp7dLa+Ew/jHMGV8EWdRRN483nrDsw
         9YTIf9wrfY8U9jS72O3GInOWIoyv2ASsoGVZklk/M7us4MtfGa8fvueuzWf/66l5Ffps
         ZvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916416; x=1686508416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+exEN8RF1B40fPaxoi0k2T6E5J3rfhVEZNB9EwpzSM=;
        b=Tc/0HR57QrgY2cFNuJ4cFkur5cSHXHEAOem/ImjKKZQD/HwFi7C30oLz43u6WLsKv0
         JxXJZYHqHUYYWFTM8ZD9C/DWC+jE6Ij7ot2JXaVPj9GDUbQUh3XEFkxe9ffjPPoQgPUz
         bZw4HbcPEV+983rG00VN8oOXsuoQYpbpEkDdzAnKDytlMhuQTVs7EpnuY7rU25jMypmy
         qzvCi9466KrqRE24xpQYAMefjlNZm0bpNq8ZqMuQn6Dd43PBAbUOIlvppUUU8ZaV7ecS
         UKHfmEVP7I9iBpcZ5WGelJkc9mptbrmgre7FLQwnhBCykDTs0zZT+rUkDPQ5+EzWj8iO
         3sUA==
X-Gm-Message-State: AC+VfDwHZSmP63heSCwuAcuXnc9qFs9cmhXw+D8NHz3Jqwv3+aytsIPb
        /qZOVw9EVyf/3iL0CKEw+HHR5lw=
X-Google-Smtp-Source: ACHHUZ6izS/sXksepkikL2WJhUgl6hDj55lJDgbldJSMaJRr8WAp/vT3O0/iHqJ2+q6vfS70QyzAspA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:23c8:b0:250:2099:783 with SMTP id
 md8-20020a17090b23c800b0025020990783mr8403658pjb.2.1683916415913; Fri, 12 May
 2023 11:33:35 -0700 (PDT)
Date:   Fri, 12 May 2023 11:33:34 -0700
In-Reply-To: <20230512152607.992209-14-larysa.zaremba@intel.com>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-14-larysa.zaremba@intel.com>
Message-ID: <ZF6GfoZVgKX78bpq@google.com>
Subject: Re: [PATCH RESEND bpf-next 13/15] selftests/bpf: Allow VLAN packets
 in xdp_hw_metadata
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
> Make VLAN c-tag and s-tag XDP hint testing more convenient
> by not skipping VLAN-ed packets.
> 
> Allow both 802.1ad and 802.1Q headers.

Can we also extend non-hw test? That should require adding metadata
handlers to veth to extract relevant parts from skb + update ip link
commands to add vlan id. Should be relatively easy to do?

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 9 ++++++++-
>  tools/testing/selftests/bpf/xdp_metadata.h          | 8 ++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index b2dfd7066c6e..f95f82a8b449 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -26,15 +26,22 @@ int rx(struct xdp_md *ctx)
>  {
>  	void *data, *data_meta, *data_end;
>  	struct ipv6hdr *ip6h = NULL;
> -	struct ethhdr *eth = NULL;
>  	struct udphdr *udp = NULL;
>  	struct iphdr *iph = NULL;
>  	struct xdp_meta *meta;
> +	struct ethhdr *eth;
>  	int err;
>  
>  	data = (void *)(long)ctx->data;
>  	data_end = (void *)(long)ctx->data_end;
>  	eth = data;
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021AD))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
>  	if (eth + 1 < data_end) {
>  		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
>  			iph = (void *)(eth + 1);
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 938a729bd307..6664893c2c77 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -9,6 +9,14 @@
>  #define ETH_P_IPV6 0x86DD
>  #endif
>  
> +#ifndef ETH_P_8021Q
> +#define ETH_P_8021Q 0x8100
> +#endif
> +
> +#ifndef ETH_P_8021AD
> +#define ETH_P_8021AD 0x88A8
> +#endif
> +
>  struct xdp_meta {
>  	__u64 rx_timestamp;
>  	__u64 xdp_timestamp;
> -- 
> 2.35.3
> 

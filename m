Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CF610740
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiJ1B3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiJ1B3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85DCA98EF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666920525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wla9uF0gA118Z36K6veuICKKbGh2thQWauGdmuDklz4=;
        b=GxNduojNsSNUKgm0ztStR1NGhJpYtLRwTSCzygsnO+NBnvaSFGPzu1BH5TWGM8Ath+laCG
        KbFnPHTtDFSAAEWFjBQ8qa+X1WzgW/wqKErVnETbIAj0K49OblhFfgOug5+PUeoJwn9b+x
        fJ+6yU5J11WkdGIpsi/6cFDypdc3IsY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-VdeKynq5MX2d6akY15g4Jg-1; Thu, 27 Oct 2022 21:28:44 -0400
X-MC-Unique: VdeKynq5MX2d6akY15g4Jg-1
Received: by mail-pg1-f198.google.com with SMTP id h2-20020a656382000000b0044b0f6c572fso1705321pgv.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wla9uF0gA118Z36K6veuICKKbGh2thQWauGdmuDklz4=;
        b=QdtlkiXRVSF5DFgw9dqlR1w9jx8W5bBbmcqIYMeKx5VSxaG8z2u6ABgntzJmDH8mXz
         g/kEsyi844/Sy31VdwHyzRbVEAJfOFClK9rPq7CgPx25qGJAYrJxFehPXifetn/RPijS
         cRBJAYv493IRbCSokwiVCybwcYqtKcMX36VERFzgsS78CFx8sG0bHPtkpyqm24mG34fJ
         N5wzV8045kd+qAQHT0KzcjXNP+86ORGxNAyxSkxBtThzV7Hm29wCBc0HLNAWH2lwtBGx
         mt7BAAuPuNM9zhGuC6hfocA53fmuupqTjxK2aujrIm36RGEnhYNgq97orC0jo+VO61kQ
         Kn5g==
X-Gm-Message-State: ACrzQf0pbIlNNJT0haxor1yVnmXi7QhNOsiwy1CQoNgk1niJxwNIQuG/
        fDaEaiqiZ3dDh0i8Q6GU7JkCG9Cqop2JdYy02XWUxpTLuXhiTgA3RQZ10dSp/67H1gX2QpKrZ7v
        +pnu1SwRwRwG9GpP16I5MWLTxIUiH4aif2FDTAyUTxVsumGWBxcZfsWd2XknhGYW8rX36fnDQcA
        ==
X-Received: by 2002:a63:3184:0:b0:46f:714d:96f6 with SMTP id x126-20020a633184000000b0046f714d96f6mr211389pgx.298.1666920523388;
        Thu, 27 Oct 2022 18:28:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64yR5cKYB75ppDJGHgde46Bvcv+KVzYwGEN3aPYDhKENXwt2ytxb7v1yXtoNq23XOELC+igQ==
X-Received: by 2002:a63:3184:0:b0:46f:714d:96f6 with SMTP id x126-20020a633184000000b0046f714d96f6mr211363pgx.298.1666920523052;
        Thu, 27 Oct 2022 18:28:43 -0700 (PDT)
Received: from [10.72.13.65] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0e8100b002009db534d1sm1545432pjx.24.2022.10.27.18.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 18:28:42 -0700 (PDT)
Subject: Re: [PATCH] ceph: fix mdsmap decode for v >= 17
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027152811.7603-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8b666226-ef41-13ae-c90c-aaa5f499b0a0@redhat.com>
Date:   Fri, 28 Oct 2022 09:28:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221027152811.7603-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/2022 23:28, Luís Henriques wrote:
> Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
> maximum xattr size") was merged before the corresponding MDS-side changes
> have been merged.  With the introduction of 'bal_rank_mask' in the mdsmap,
> the decoding of maps with v>=17 is now incorrect.  Fix this by skipping
> the 'bal_rank_mask' string decoding.
>
> Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi!
>
> This inconsistency was introduced by ceph PR #43284; I think that, before
> picking this patch, we need to get PR #46357 merged to avoid new
> problems.
>
> Cheers,
> --
> Luís
>
>   fs/ceph/mdsmap.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 3fbabc98e1f7..fe4f1a6c3465 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -379,6 +379,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>   		ceph_decode_skip_8(p, end, bad_ext);
>   		/* required_client_features */
>   		ceph_decode_skip_set(p, end, 64, bad_ext);
> +		/* bal_rank_mask */
> +		ceph_decode_skip_string(p, end, bad_ext);
>   		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>   	} else {
>   		/* This forces the usage of the (sync) SETXATTR Op */
>
Luis,

Because the ceph PR #43284 will break kclient here and your xattr size 
patch got merged long time ago, we should fix it in ceph. More detail 
please see my comments in:

https://github.com/ceph/ceph/pull/46357#issuecomment-1294290492

Thanks!

- Xiubo




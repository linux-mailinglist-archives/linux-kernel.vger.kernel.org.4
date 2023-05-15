Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F07031B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjEOPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbjEOPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32491BC9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684164978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7CbMDqqB7Ef24aQqJke8PthcM5mzwIBmyE952+ZY6Q=;
        b=XqQ0Z/KnMqF1TMAi/7tu5y6uf3zyazEP/HOyKomsE7cVgzdt55yrb9evo4x5DmNElgz/KV
        VE6qmpQa2uNp8s/oSUOs630dgxUyo+9UAqllBnfEdBSSM3hp4sqAbA+SZhXhXiF6Li7NQC
        w3cHD/9OlIx52Phuq+zWw9K9bUXD/uw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-8xEW-NpFMRyHlqjFqLNi8Q-1; Mon, 15 May 2023 11:36:16 -0400
X-MC-Unique: 8xEW-NpFMRyHlqjFqLNi8Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-966329c872bso1176017266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684164975; x=1686756975;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7CbMDqqB7Ef24aQqJke8PthcM5mzwIBmyE952+ZY6Q=;
        b=GwrSgOAmd/CcxkwoBuu/qAxBDPjcP98M0mN9S4DL3OuqKRhA3cdN1z7+LCaVuMEIAv
         N9nIWfozQmhtU2p1Itfum0yVUA+Khj/zuB9DS/loBtCADUiVBbN3btRcjs/N30zff7pr
         vMu9O9rqRFjD5jDMQr4PhmOKrIAXG0vudQyE51YtOy+hNPc7Cm78nizc5evxtgW9vU8y
         tcw078IV28k52sFowyU0FVISR5LHbXNe8anF+8tQEVdwBDzF1FmqrGIelW/MDJkNxZ8G
         6r0FofHf3Gz0CmlmY0GwAx56ZfisvkWUfcZVfg2+Vs/YI4iwdUQGBCTkgJHFhGMoHx7W
         p5ug==
X-Gm-Message-State: AC+VfDzgQTiIOH5Ra5ORw9EYd2V8gJUZ4lrDPAEp8XU279xsxnol1dUH
        KopRVmFpmNOmY9jYTAtfKVP4mNQj21YnFBTkM//zN5BMoSUdrBEJCgVN5DD2XFqdd7xPXyUhiCH
        XCIMiCg3RvQpcGbe/Pzf/BkE1
X-Received: by 2002:a17:907:804:b0:94f:adb2:171f with SMTP id wv4-20020a170907080400b0094fadb2171fmr27955081ejb.28.1684164975549;
        Mon, 15 May 2023 08:36:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46GxPVBqoq2psgT5XG+XapuVBE6/4vYM0++VGwPutqBc+4LJ5jMPnxCh49EGXYSOjGcFb1gg==
X-Received: by 2002:a17:907:804:b0:94f:adb2:171f with SMTP id wv4-20020a170907080400b0094fadb2171fmr27955042ejb.28.1684164975130;
        Mon, 15 May 2023 08:36:15 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090632d200b009661f07db93sm9660631ejk.223.2023.05.15.08.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:36:14 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b0694577-e2b3-f6de-cf85-aed99fdf2496@redhat.com>
Date:   Mon, 15 May 2023 17:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND bpf-next 09/15] xdp: Add VLAN tag hint
Content-Language: en-US
To:     Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-10-larysa.zaremba@intel.com>
In-Reply-To: <20230512152607.992209-10-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2023 17.26, Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
[...]

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 41e5ca8643ec..eff21501609f 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -738,6 +738,30 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   	return -EOPNOTSUPP;
>   }
>   

Remember below becomes part of main documentation on HW metadata hints:
  - https://kernel.org/doc/html/latest/networking/xdp-rx-metadata.html

Hint compiling locally I use:
  make SPHINXDIRS="networking" htmldocs

> +/**
> + * bpf_xdp_metadata_rx_ctag - Read XDP packet inner vlan tag.

Is bpf_xdp_metadata_rx_ctag a good function name for the inner vlan tag?
Like wise below "stag".

I cannot remember if the C-tag or S-tag is the inner or outer vlan tag.

When reading BPF code that use these function names, then I would have
to ask Google for help, or find-and-read this doc.

Can we come-up with a more intuitive name, that e.g. helps when reading
the BPF-prog code?

> + * @ctx: XDP context pointer.
> + * @vlan_tag: Return value pointer.
> + *

IMHO right here, there should be a description.

E.g. for what a VLAN "tag" means.  I assume a "tag" isn't the VLAN id,
but the raw VLAN tag that also contains the prio numbers etc.

It this VLAN tag expected to be in network-byte-order ?
IMHO this doc should define what is expected (and driver devel must
follow this).

> + * Returns 0 on success or ``-errno`` on error.
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_ctag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * bpf_xdp_metadata_rx_stag - Read XDP packet outer vlan tag.
> + * @ctx: XDP context pointer.
> + * @vlan_tag: Return value pointer.
> + *
> + * Returns 0 on success or ``-errno`` on error.

IMHO we should provide more guidance to expected return codes, and what
they mean.  IMHO driver developers must only return codes that are
described here, and if they invent a new, add it as part of their patch.

See, formatting in bpf_xdp_metadata_rx_hash and check how this gets
compiled into HTML.


> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_stag(const struct xdp_md *ctx, u16 *vlan_tag)
> +{
> +	return -EOPNOTSUPP;
> +}
> +


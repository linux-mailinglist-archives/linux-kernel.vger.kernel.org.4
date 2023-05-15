Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB3703108
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbjEOPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjEOPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24E1720
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684163251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqAunJggVfMk8DVsWWYkCIQsfbXlahXMSDO8JBjiKzE=;
        b=DG5LXRu2c+AFvkUL6iJHFyECUOjfPpNjB+p5ZGJFjVpgU7F4WX3Ujne056f5zDhj91qiyl
        JDAT7SckMxyWv1LutsAyYwYzctazC1amzdt+Yybdws+e8CU+Sx9uM+nlq2yT7ooWxKr04t
        TskAMsjdqXfYYDoam2u6FXFgiVmS0l4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-RpY46iqUPJOU9MuvkLD1BQ-1; Mon, 15 May 2023 11:07:24 -0400
X-MC-Unique: RpY46iqUPJOU9MuvkLD1BQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a348facbbso1607738266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684163242; x=1686755242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqAunJggVfMk8DVsWWYkCIQsfbXlahXMSDO8JBjiKzE=;
        b=cZ4mGOrWhpMOloyONB1f9IH7vEMbLAJpAEWhQdVUTTV3E0lxLUsmDmUwKO/IIGTgFJ
         TkIMm//nFSbvLRQNCIFrlBT7/WyWI0UNiA1l6gOD5KkCSK/hRLWMuguIoB41pvAZMbp4
         plroLl56Y0U+einrERFfxme/3x3a6EukukQA4zDksvFHZLpildFsIq/HEA9nDx/umwjo
         oapz9MtP56vPpWKG/cWEJJYOZfnuJS8Tcm7D7BcIPOTAD8g60C9Pqbf04BMqYd5JdWqJ
         g9uJO4+FInjB0g6JOQtVxUbdlD5OuAHaiQ1d64VfBWhYyh3EjvGSe0pjNEyQeATdLTQJ
         ic4Q==
X-Gm-Message-State: AC+VfDwPgwXkDGohXbAKhuSSvXWs1DaqwtwrKdNRLsSO2ldGxaatmyNW
        6p7XV1IMbtnjhBW8hPhIzNKyVqQld7nR9WPls9E9FSvw/aGMdsCWC2QN8B9HYi2DmBYwl4XsynK
        XmcPAmJ6Q80CZbMl72t5IWBXj
X-Received: by 2002:a17:907:d91:b0:933:4d37:82b2 with SMTP id go17-20020a1709070d9100b009334d3782b2mr31485003ejc.57.1684163242585;
        Mon, 15 May 2023 08:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KJfmiDaL9BJh3jJxYB1OG8NuTPCjYqSvJHsOpWGNg4A0jTsW7kReLmT9LoGqXUg8hKEYa+Q==
X-Received: by 2002:a17:907:d91:b0:933:4d37:82b2 with SMTP id go17-20020a1709070d9100b009334d3782b2mr31484980ejc.57.1684163242248;
        Mon, 15 May 2023 08:07:22 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id l17-20020a170907915100b0095004c87676sm9682583ejs.199.2023.05.15.08.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:07:21 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e4a9fa43-06f7-5271-effc-20cac59b0e64@redhat.com>
Date:   Mon, 15 May 2023 17:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
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
Subject: Re: [PATCH RESEND bpf-next 10/15] ice: Implement VLAN tag hint
To:     Larysa Zaremba <larysa.zaremba@intel.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-11-larysa.zaremba@intel.com>
 <ZF6F+UQlXA9REqag@google.com> <ZGI2oDcWX+o9Ea0T@lincoln>
Content-Language: en-US
In-Reply-To: <ZGI2oDcWX+o9Ea0T@lincoln>
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



On 15/05/2023 15.41, Larysa Zaremba wrote:
>>> +	*vlan_tag = ice_get_vlan_tag_from_rx_desc(xdp_ext->eop_desc);
>> Should we also do the following:
>>
>> if (!*vlan_tag)
>> 	return -ENODATA;
>>
>> ?
> Oh, returning VLAN tag with zero value really made sense to me at the beginning,
> but after playing with different kinds of packets, I think returning error makes
> more sense. Will change.
> 

IIRC then VLAN tag zero is also a valid id, right?

--Jesper


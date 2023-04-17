Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26186E4B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDQOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjDQOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02118A74
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681741478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ih22A54IlQcIcpW8AJafH3qjCniWddl0rR6pTvOIfYU=;
        b=AxKbK0DfkZDmb1L1zhuJJLKIRnDzBnONFip8TNqQFsHjNE2z/80oib8S6z/fPJX21I7UcL
        wyrJljXoXr2RxtEQhg8KaJn8PezECluv+7V+OQUixEttER5RhoLSt4+6RWQJ9UZpNyk/qI
        XI9Si2wyWv7eS4cymmjYilWTVXwiC94=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-_nuF1o_lMVmG3RO59CFnfg-1; Mon, 17 Apr 2023 10:24:37 -0400
X-MC-Unique: _nuF1o_lMVmG3RO59CFnfg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso10600268a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681741476; x=1684333476;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih22A54IlQcIcpW8AJafH3qjCniWddl0rR6pTvOIfYU=;
        b=ALRCLAEt6cVzmmvI0VeGfcTFkD6lCpbVLuQLo2ObSXwQMYWN6+N408P9DI2i3qYZNO
         duRT/eg1qPI6Z+gkBNJ247DroDMCUyzLFa9mDwPDybB8gurPX/w6CewLQ+7WvJ8q2J6t
         yqk+Fmrvv2P10ZJJ+d3uw3F3u3Nu1iww2N2EdxAZx4Nu5ximXQZJfHiSPqMbZwk04urZ
         8wkOy6lH/q+vz/NtkycVnodRLUbQ58Sv2jpf2zeWIZx/Chw2qyvAInaPX/1BAnd27Z1W
         +gBl8F6FLoA4JkixbKw53k7y9fcE4N6GXOdv/Hd9wUphK1b3QYiwmyx8YPSjzLGVMQqx
         j/+g==
X-Gm-Message-State: AAQBX9cqnYqs2BUS9Eb09D0L2ASkQ/oGNBzP9MfJ5NQh4XgfhTltPdFZ
        tLGt4/iqd2YLbLqupurhYJtI4rSaiVCRJr0ScWI6OWOsE3TLIfWlRcudPFoQ8vQFZWjNmI+bOzb
        3kBfsBKqQP+j+nQDuwwvdKp/G
X-Received: by 2002:a05:6402:510a:b0:504:a336:22d5 with SMTP id m10-20020a056402510a00b00504a33622d5mr18020036edd.15.1681741476377;
        Mon, 17 Apr 2023 07:24:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzCTM4iTY4cjU7RvpTj9V6B1opCLDxjF2En5J3oVG+O+Xu2rEAPmG7p+piBgCrXtL93dXnUA==
X-Received: by 2002:a05:6402:510a:b0:504:a336:22d5 with SMTP id m10-20020a056402510a00b00504a33622d5mr18020003edd.15.1681741476043;
        Mon, 17 Apr 2023 07:24:36 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7db46000000b00504b203c4f1sm5879091edt.40.2023.04.17.07.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:24:35 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e7b9cb2c-1c18-7354-8d33-a924b5ae1d5b@redhat.com>
Date:   Mon, 17 Apr 2023 16:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] igc: read before write to SRRCTL register
Content-Language: en-US
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        David Laight <David.Laight@ACULAB.COM>
References: <20230414154902.2950535-1-yoong.siang.song@intel.com>
 <934a4204-1920-f5e1-bcde-89429554d0d6@redhat.com>
In-Reply-To: <934a4204-1920-f5e1-bcde-89429554d0d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/04/2023 22.05, Jesper Dangaard Brouer wrote:
>  
> On 14/04/2023 17.49, Song Yoong Siang wrote:
>> igc_configure_rx_ring() function will be called as part of XDP program
>> setup. If Rx hardware timestamp is enabled prio to XDP program setup,
>> this timestamp enablement will be overwritten when buffer size is
>> written into SRRCTL register.
>>
>> Thus, this commit read the register value before write to SRRCTL
>> register. This commit is tested by using xdp_hw_metadata bpf selftest
>> tool. The tool enables Rx hardware timestamp and then attach XDP program
>> to igc driver. It will display hardware timestamp of UDP packet with
>> port number 9092. Below are detail of test steps and results.
>>
[...]
>>
>> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
>> Cc: <stable@vger.kernel.org> # 5.14+
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> ---
> 
> LGTM, thank for the adjustments :-)
> 
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 

Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>

I can confirm that this patch fix the issue I experienced with igc.

This patch clearly fixes a bug in igc when writing the SRRCTL register.
(as bit 30 in register is "Timestamp Received Packet" which got cleared 
before).

Florian might have found another bug around RX timestamps, but this
patch should be safe and sane to apply as is.

>> v2 -> v3: Refactor SRRCTL definitions to more human readable definitions
>> v1 -> v2: Fix indention
>> ---
>>   drivers/net/ethernet/intel/igc/igc_base.h | 11 ++++++++---
>>   drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++--
>>   2 files changed, 13 insertions(+), 5 deletions(-)


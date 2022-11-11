Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CC625839
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiKKKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiKKKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:25:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2CBA7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:25:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79B291FB4A;
        Fri, 11 Nov 2022 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668162347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKlbaNjH9a/ib4nLB2iq4s9RI+vzvvZHsbyVJHY64Og=;
        b=yNVg9j85Xiu55gGuCY08PXpWvE1cwnsaxvx88MqXrd+UAH3CSoTHudHee9dZdafbOALjYM
        zF6tjmdQrQuEioF0/dfRrrcdp4lGQhry3mzct4ZE8KwSxMdE+FP8nKcc0vvha8JhHTKOnZ
        2pfbUg+0/yft70tdVCTfIhI8d8iCBJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668162347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKlbaNjH9a/ib4nLB2iq4s9RI+vzvvZHsbyVJHY64Og=;
        b=VgtDqXBAJsGsn1nOjsN3HfwJjVD3DnjswsaGwAoOls+kPLL1DsFaobg4RxvM8HKK8tcHDy
        t/dKTJuLnlbvYEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C08913357;
        Fri, 11 Nov 2022 10:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id npH1DSsjbmPSAgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Nov 2022 10:25:47 +0000
Message-ID: <5a902810-2e72-9021-e189-a1cd2aa6f77f@suse.cz>
Date:   Fri, 11 Nov 2022 11:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor.Dooley@microchip.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, willy@infradead.org,
        roman.gushchin@linux.dev, pasha.tatashin@soleen.com,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rkovhaev@gmail.com, akpm@linux-foundation.org
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <efa623fb-686f-072e-df0d-9f5727ae1b1f@microchip.com>
 <a0201035-8cd3-f8bc-7db3-4d011cd2c35c@opensource.wdc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a0201035-8cd3-f8bc-7db3-4d011cd2c35c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 00:00, Damien Le Moal wrote:
> On 11/10/22 02:57, Conor.Dooley@microchip.com wrote:
>> +CC Damien
>> 
>>> There are some devices with configs where SLOB is enabled by default.
>>> Perhaps, the owners/maintainers of those devices/configs should be
>>> included into this thread:
>>>
>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>> 
>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>> 
>> Saw you were not added to the CC Damien & I know you don't want your
>> baby broken!
> 
> :)
> 
> I set SLOB=y for the K210 as the config help mentions it is a bit more
> efficient in low memory cases. I did run a few times with SLAB and it
> was OK, so removing slob should not be a problem. Can check again.

Thanks, but please check with SLUB, not SLAB, if possible.
Disable SLUB_CPU_PARTIAL (default y on SMP) if you want to minimize the
memory usage.

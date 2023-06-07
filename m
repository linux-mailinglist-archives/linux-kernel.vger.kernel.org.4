Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896D272550A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbjFGHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjFGHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A91A7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686121620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HtcYeeSFJX97ey2U3FsO6n3a4Uc4lf1gY3baMGyOsg=;
        b=aqzGV9aNDCngZzfskhQt/xNNzQdH81q23DBbBomUSv95AfYMQWUT+avo0CLoXodTOsB2Oj
        SyVwc5afV4vJRPQzYpqlxj0FnQiu/J4Nevqt81hmoGAdKlts26hvnE+diS/ornoXCvl3/k
        vO6KCuw8bavrz854qEj2XFKBowhTZ5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-k6EZqqTYM-aPUEkh-2V8fg-1; Wed, 07 Jun 2023 03:06:59 -0400
X-MC-Unique: k6EZqqTYM-aPUEkh-2V8fg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f603fed174so39503605e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121618; x=1688713618;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HtcYeeSFJX97ey2U3FsO6n3a4Uc4lf1gY3baMGyOsg=;
        b=PdDTAnkhDPaxPSAth85Qj9LYSODKGr+aPq7Bnm5RGJ/gV5QF88u2a/Ej8zjKrPebWO
         jOoD8Ffy4IfQ7POQ1I2OYoo4HFu4uAP7yXcctfdM89i1IycsB/bfIzXU+rOEdPKx0Fae
         CvIcDtmWSl/cFpAjLYqeAq9KTBWb7lbs9IIk+/UKOasR/UnbNS/U6TSuVkX/HeDqy0Wx
         rOkCAok0p/Xs811id+YlZFDVRlO9TxXuoBj4H5nEp34tjQH0vqm7tc8MKrAVslmg7e3+
         uIn0OAgxPe/iSi0oGTtH6k+MvjIWxeLLzD8bx+eL+ns/B0a4T8kl/T1ZDOnqQUZzh10o
         vbww==
X-Gm-Message-State: AC+VfDwODKBPQVgL1Yn8dko2x0Xc3sth59etTUJGZcM/tUthD0tMbGyo
        AUNDb17oaBXTAR+7lR2b340B2tKsTr8Kop8L6lOQOz08t1oTNC1n1jyg/7mGJrRMlOUhCffL/AN
        vPEtnF2YduAGUsDWv04EwSlr3sSwc7G0E
X-Received: by 2002:adf:d083:0:b0:30e:46d4:64ee with SMTP id y3-20020adfd083000000b0030e46d464eemr3948781wrh.29.1686121618405;
        Wed, 07 Jun 2023 00:06:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DUBOkCQ9JowHqUyllgFXCIVD6fEblIKTGJR9ZYvHc80WE7D9tuEKCsuYHge47+8cHI0sI2w==
X-Received: by 2002:adf:d083:0:b0:30e:46d4:64ee with SMTP id y3-20020adfd083000000b0030e46d464eemr3948757wrh.29.1686121617971;
        Wed, 07 Jun 2023 00:06:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b003095bd71159sm14743684wrh.7.2023.06.07.00.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:06:57 -0700 (PDT)
Message-ID: <b8821b15-5555-a298-797e-573c4bdf2c8c@redhat.com>
Date:   Wed, 7 Jun 2023 09:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/sparse: remove unused parameters in
 sparse_remove_section()
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230607023952.2247489-1-yajun.deng@linux.dev>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230607023952.2247489-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.23 04:39, Yajun Deng wrote:
> These parameters ms and map_offset are not used in
> sparse_remove_section(), so remove them.
> 
> The __remove_section() is only called by __remove_pages(), remove it.
> And put the WARN_ON_ONCE() in sparse_remove_section().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3546441E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiLFLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiLFLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8833C24F12
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670324966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6aKmUCMDnNQvag3kWpTzZtLHE4fcJsb6IlXQMzU/no=;
        b=euagKWt6RD65OJ02X9ZFJ6CIF7+3btKGXQlLmU+nf+q2JvqKNIPXKRQM9yAFzkKzCKidFY
        6Io+tRqHbzV7Gk4ZGLr+tgkFDwwpMG7ZUQ03ilxpI+NJ89caZZfgao7DzEk/lb8EZdqEe7
        8xROINX/oxCz2nGYEQHgFFjHU/Ndpno=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-NhdAY6IMOsC8ILRnzkJeJQ-1; Tue, 06 Dec 2022 06:09:25 -0500
X-MC-Unique: NhdAY6IMOsC8ILRnzkJeJQ-1
Received: by mail-qt1-f199.google.com with SMTP id j26-20020ac84c9a000000b003a7e6d38e01so4474452qtv.14
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 03:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6aKmUCMDnNQvag3kWpTzZtLHE4fcJsb6IlXQMzU/no=;
        b=2AISG6WZ5rf0cC4Rqj5S2v+0JLJZ4Q61MH1EYLL5iQ06ioWVKtYcT75RxMV+x5eV4a
         m4phHYM7RjYoXDc2CDkueQy83Idl3h++PfaxY7ahuat8MhE4S/Zd4vi/PFYxtpupAQbz
         6obmVMSKSYEx5Hn8mtxhmHKbqkeaOGu5i3dT4xfgrLwjWidPmH2pUpSf42zjNp6V6hWK
         JRxUgFVTpBjQHPAkRsNTyi5tA+EufItRPYqAvHGZ5+PKBvw9DB1vZ7hZJSCfVFNRD83G
         UFtZWT+FsZ+QhZw6rONcmes2U43M8YEoJIzt3dr7kbZ2Ok2pYmQLd3yfFBFpahdxHzBy
         18lQ==
X-Gm-Message-State: ANoB5pljvBpFu9Bk+WbjS2PM1GqsLAdO5Lw9J6L0ENl+eANW1JDtm6jC
        Kr66qO2gKR4nDFmByAN5ccErqqvsp3tTnWpb6goKMaXrM4jFp0prIwQNYUN0La8d40DaYHem/li
        UhyB8A10ehVJk/b6shxreqPmM
X-Received: by 2002:a05:620a:a10:b0:6fa:27fa:6612 with SMTP id i16-20020a05620a0a1000b006fa27fa6612mr76798088qka.224.1670324965073;
        Tue, 06 Dec 2022 03:09:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6utXWXbJYlK6nrHBiI15D+1PvtKl4efQcbfNet+Kqm5JquX15Pkc0wvPL2KiN6FyzXSEdWsw==
X-Received: by 2002:a05:620a:a10:b0:6fa:27fa:6612 with SMTP id i16-20020a05620a0a1000b006fa27fa6612mr76798075qka.224.1670324964814;
        Tue, 06 Dec 2022 03:09:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006cfc7f9eea0sm14547214qkp.122.2022.12.06.03.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:09:24 -0800 (PST)
Message-ID: <fc76b5ffbcd1855cdfdb3ad8973ed313decb2868.camel@redhat.com>
Subject: Re: [PATCH v2] nfc: llcp: Fix race in handling llcp_devices
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, sameo@linux.intel.com, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Dec 2022 12:09:21 +0100
In-Reply-To: <20221203071218.3817593-1-bobo.shaobowang@huawei.com>
References: <20221203071218.3817593-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-12-03 at 15:12 +0800, Wang ShaoBo wrote:
> @@ -282,9 +285,13 @@ struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev)
>  {
>  	struct nfc_llcp_local *local;
>  
> +	spin_lock(&llcp_devices_list_lock);
>  	list_for_each_entry(local, &llcp_devices, list)
> -		if (local->dev == dev)
> +		if (local->dev == dev) {
> +			spin_unlock(&llcp_devices_list_lock);

I'm sorry for not noticing the above earlier, but it looks like this is
not enough. At this point local_release() may kick in and free 'local':
the caller will experience UaF. 

You could acquire a reference here and let the caller release it.

If the above race is not possible due to some other safeguards, it
should at least be documented clearly here.

Thanks,

Paolo


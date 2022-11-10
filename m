Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7555E624085
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiKJK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiKJK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A286A6B7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668077849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZYU2O1MuKWlTe+pb6TVyDbRzRa29zM5AqFFWo5hi4A=;
        b=Xzg8vTQOeZ+OoT6XEb266fWx4vagBOOSwxNZjBFXjJzNj+ErNqY38mX0BtNVGyKh9P/0uo
        sZLb6jdfhf4eRp/ZUGE4Tt/YxduLhUTnewh3/99V5sPJGGH1nfBcorVVQ+uu+wlpnkiFaQ
        3z0x69HJjH15s/F4Z/Qqjj/+jWjaE4U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-bXjZ2NMSMw--bHtxPOTXaA-1; Thu, 10 Nov 2022 05:57:27 -0500
X-MC-Unique: bXjZ2NMSMw--bHtxPOTXaA-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso1244473qvr.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZYU2O1MuKWlTe+pb6TVyDbRzRa29zM5AqFFWo5hi4A=;
        b=cjDO8Smgck/EJkq0RuU5oTVRiM8eKb+r6ph44NYWKsBo6XHuVC16tqS8tGsCTt9Yjv
         R6ds+5jJPzTcMz/5C9HR0JwBg5giODZ7XvfQYT0XFs859wFXe62scIk/dgRSNChwV7+/
         AUk/wWEVsHFdkoWb6NpOGJ8PWV6/sqNGS5dPKntwNkTuidMvr5uY4swhBkG8Xvz+RuOA
         ZxxFq/5yzJgy8y+eynxCxWyHsi+cDLYdFFDDBnPSs4rsiisLiPIOu5AHtYQK6Zor6NtW
         SI4nFjaQlWBlK7sm4etSs3h0hPEiRD/TYWxX0INsnLP4XemtyNlGG+cKSncvcfImh7/x
         kuwQ==
X-Gm-Message-State: ACrzQf3dOdfnCLT0bzCzxcU1PNqe7qIjuPsbEJxFFfqROt50L+BTUf84
        h7yv9++vWe+ninlgbtUqIqXhuvmykesSLeV357IqZTJxPeJzipy9NdGMFWlO2Y87V2pUtl2TE5a
        HWwyTAgN2sxx7UMFuj78BJu45
X-Received: by 2002:a0c:e34f:0:b0:4bb:5d3a:bd25 with SMTP id a15-20020a0ce34f000000b004bb5d3abd25mr59177975qvm.23.1668077846618;
        Thu, 10 Nov 2022 02:57:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4ZIGpiA+xevI7EHSgXaWJ7bAlEEcOnNtYundIZMqZL46zaa/5cbaSc7VlkNSUq8m4Hgbhvng==
X-Received: by 2002:a0c:e34f:0:b0:4bb:5d3a:bd25 with SMTP id a15-20020a0ce34f000000b004bb5d3abd25mr59177964qvm.23.1668077846365;
        Thu, 10 Nov 2022 02:57:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a21c600b006f9e103260dsm12402445qka.91.2022.11.10.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:57:25 -0800 (PST)
Message-ID: <63f95025240ce6fa9d9c57ac26875d67dfd2bc71.camel@redhat.com>
Subject: Re: [PATCH v1] net: macvlan: Use built-in RCU list checking
From:   Paolo Abeni <pabeni@redhat.com>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Nov 2022 11:57:22 +0100
In-Reply-To: <20221108125254.688234-1-nashuiliang@gmail.com>
References: <20221108125254.688234-1-nashuiliang@gmail.com>
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

On Tue, 2022-11-08 at 20:52 +0800, Chuang Wang wrote:
> hlist_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to hlist_for_each_entry_rcu() to silence false
> lockdep warning when CONFIG_PROVE_RCU_LIST is enabled.
> 
> Execute as follow:
> 
>  ip link add link eth0 type macvlan mode source macaddr add <MAC-ADDR>
> 
> The rtnl_lock is held when macvlan_hash_lookup_source() or
> macvlan_fill_info_macaddr() are called in the non-RCU read side section.
> So, pass lockdep_rtnl_is_held() to silence false lockdep warning.
> 
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>

The patch LGTM, but IMHO this should target the -net tree, as it's
addressing an issue bothering people. 

Can you please re-submit, specifying the target tree into the subj and
including a suitable Fixes tag?

Thanks!

Paolo



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6886197A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiKDNWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiKDNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D32D1D6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667568058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=hGd8pylCeh0mGbZZWCiLN4JbsVkueKhNa7k1o67opB0XAJ9C6s3vZDzLRojj3ufxKf7UXE
        lW3kevGaxfDKSPzUr8tSsRhx30Ushk/hYVs7NGLEAEKnsYpQ6g6CLGUSuNA4dbjwwrYUfT
        P1dgEvzYsPHj/KohGztIxfqr2fuh2+k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-aA8AjvQsNqSwW78IBvTm-Q-1; Fri, 04 Nov 2022 09:20:57 -0400
X-MC-Unique: aA8AjvQsNqSwW78IBvTm-Q-1
Received: by mail-pg1-f200.google.com with SMTP id l63-20020a639142000000b0046f5bbb7372so2552982pge.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=HPH5FSTVq6MVzdrC8E4GFCgY5wzUwuRtFeyF+TdW0AWoPjwxAfTc5Zrmhpb7U3WTjW
         IUF2JBoD1UrnRItq6shuinEruVSptpikLHr38xiYQGtOjV3kazciG+AWXXB+shGF15Uv
         GvRwLSOUhkJO2S0mMMLOeZ6U7b6Cwb6dRrxn3swrke//isEHJe7d8uTTjSKv/XdA9SAz
         HP1Uj14oKgZNT2ZwGqxatyaMXGhxNND0+o/XcX5aNEU3sCi6Jw2wYDMOrHoBdpEAJT8X
         z9rJwyFBuUH4sFt5c5SvmxU+bUJih0JMQvgcrtUYPfElbdgkQo1jtDrdpaE2eIPw1ZrD
         D0uA==
X-Gm-Message-State: ACrzQf1ImYVQiQiAUHlI3vMzx+GU7GO1fGsD7I1+/ii8GLWftUsLG1dq
        dvDtaPeaHzQFahdyw7BePAt+ILy8OVcM2GvMLe+Bpf9IFhOG/o0Erh1cbGKpST3IRDd5fz2XKHc
        FR0oDzmr1aUwddNMbuGlwPhtP
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329603plg.118.1667568056599;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XbTeqtZliMwzZ7MGO3ejsjE4fdEnYbMsIkDBmckaWvRU+DhCnC80HUipTcPjnE/pSnZOacw==
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329594plg.118.1667568056353;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
Received: from localhost ([240e:479:210:84fd:b8ac:1631:3300:5ef])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001780e4e6b65sm2597596plb.114.2022.11.04.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:20:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:20:35 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     eric.snowberg@oracle.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nramas@linux.microsoft.com,
        pvorel@suse.cz, roberto.sassu@huawei.com, serge@hallyn.com,
        tiwai@suse.de, zohar@linux.ibm.com
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Message-ID: <20221104132035.rmavewmeo6ceyjou@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I wonder if there is any update on this work? I would be glad to do
anything that may be helpful including testing a new version of code.

-- 
Best regards,
Coiby


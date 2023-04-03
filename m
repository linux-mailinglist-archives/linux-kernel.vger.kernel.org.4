Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6776B6D3C21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDCD3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDCD2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839C4681
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 20:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680492484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEUorhcJCP4eTV5i9gmTOnShTwWQaJkm0+Sy2bx605I=;
        b=EcMnrGdGSOzCNzHurznwtV7Q+PsCjcNCtDZpJLm2Pv6D5XAv9/rK2A3H8UsQzLYo/5VORH
        Rf/mQgUwGGqEQMsCRDrvlMdF0vu1WDWAn7SEzacNUvBcxMaRbU87J10c0ryD8eRDHazAoM
        os0VdSBK2XNU1p8+jT66zt5XF9V0eE4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-QJdC58qBMiSZMZCbLnmOXw-1; Sun, 02 Apr 2023 23:27:55 -0400
X-MC-Unique: QJdC58qBMiSZMZCbLnmOXw-1
Received: by mail-pf1-f199.google.com with SMTP id y186-20020a62cec3000000b00627df3d6ec4so12709400pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 20:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680492475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEUorhcJCP4eTV5i9gmTOnShTwWQaJkm0+Sy2bx605I=;
        b=KQI8n+/0jb9JrdA5LDsdk6O+DcczEhLDpQOXz9LTZhyfkvkG8R01FWzE4Y0T8tXPcf
         QpnK6JYKL073DRz0EkhPhxbOTyBFWTKgmAcRTgWqCBWW5UhambdcIkVVbXgvrouuuTwT
         crBeU3DzePFUYf5NJLFaKYwyebx+XVSV2he554+66Y1O6vAO247oQVdPCep1E75k2n1+
         TsidTLnKkkPJlCg2PoHHpiW015ESw2ZII5QKEmcmbYL8U72tQ9Aak2mkNfdxo7Zjw71Y
         KGo/Je1LxRawUDpfwzn5BotzHUE3z2QZD7qKpdIKxNSPmIj5NnTwkjFR8vRs+YDh7hNz
         wsUg==
X-Gm-Message-State: AO0yUKXfy6tsJDaY5UrQetS+K5hN9wgqNZqbsl43ZjgQaxUznM3F5sve
        fq7trSGG+ODESVFWy1sNOKYS1EJRvz3qvJcBzQJtxdzTZ88YfeCoplEWmZUAiBm4sHN3+EnjC/A
        ySQlNetxgHIK2qxMvspkVZm86
X-Received: by 2002:a05:6a20:8b9d:b0:dd:b941:5d90 with SMTP id m29-20020a056a208b9d00b000ddb9415d90mr29852856pzh.60.1680492474887;
        Sun, 02 Apr 2023 20:27:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Aw9qy1gCxyVuunFgi76rTmU9rp4S0qoZan45QMX21+8iAVTXQmaKPycUMXPmVQLIdXDUDeA==
X-Received: by 2002:a05:6a20:8b9d:b0:dd:b941:5d90 with SMTP id m29-20020a056a208b9d00b000ddb9415d90mr29852831pzh.60.1680492474586;
        Sun, 02 Apr 2023 20:27:54 -0700 (PDT)
Received: from [10.72.12.66] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k20-20020aa78214000000b006259e883ee9sm5626335pfi.189.2023.04.02.20.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 20:27:54 -0700 (PDT)
Message-ID: <c99f1f3d-25ac-6f5c-b5f1-26f7bfa513e8@redhat.com>
Date:   Mon, 3 Apr 2023 11:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v2 37/48] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather
 than sendpage()
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <7f7947d6-2a03-688b-dc5e-3887553f0106@redhat.com>
 <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-38-dhowells@redhat.com>
 <709552.1680158901@warthog.procyon.org.uk>
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <709552.1680158901@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/23 14:48, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>> BTW, will this two patch depend on the others in this patch series ?
> Yes.  You'll need patches that affect TCP at least so that TCP supports
> MSG_SPLICE_PAGES, so 04-08 and perhaps 09.  It's also on top of the patches
> that remove ITER_PIPE on my iov-extract branch, but I don't think that should
> affect you.

Why I asked this is because I only could see these two ceph relevant 
patches currently.

Thanks

- Xiubo


> David
>


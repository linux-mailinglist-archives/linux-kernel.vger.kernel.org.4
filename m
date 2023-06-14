Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BE7302B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbjFNPEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbjFNPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64F1FD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686754985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StBjlzC+K1w2JzS0mxfSPzu6vQtFOd/XKwJV6KORDbk=;
        b=EV8BRoAOQ1axV9jWSefMVPoKb5IhnOCPgBskbClKE+20o0PXeXwobFu4shZmSoIsRYXNzh
        0JxxkDTbLwJgqRRoooWFLxsAQU7ifEzSY8nVsSsb2kevWnQlM9Q0H+uWG1HfkprGwRG6z1
        L1QtvJS9YC7XK7OSdHxGgH/RU5tE0JI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-a6mO525DMBu3VrvK6o3vNg-1; Wed, 14 Jun 2023 11:03:03 -0400
X-MC-Unique: a6mO525DMBu3VrvK6o3vNg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d4d5eda29so169563985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754982; x=1689346982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StBjlzC+K1w2JzS0mxfSPzu6vQtFOd/XKwJV6KORDbk=;
        b=b6EkMhNMb/pOYGUOfYSA/ZUlQ3Oix7ntnrtcXb07XKpqLtE0MVQYaaO4cP0214JDVI
         Q2a7TH92Pek493XSIUBG1HDMFGBdR3RzEg/W8S3OuTyQhCHl3IZhyzBAi49BR/kMAWg1
         WlfZ4I/aLlZ1SgBo2Rv5yXSy6yii0IR+V9mQ2HMToDjfFNC0KP7a6pscmw26b8Fj+baH
         q0B6dup8/aKITdwh9WIxcSctq1dN/6SZmuMNR2pBds8OKzjvktTrphx0xAxe6J7k0Qg5
         yssDp5WPzMkcUr3RJ2xwljnZIB/kHRjgXWdOtUjSpsEmgE2g/Wk5SGENBPd+4PBZ15fe
         uEFA==
X-Gm-Message-State: AC+VfDywrSE1ameDfvs2soVWvz2fyF3AduQbzc/qFt0ngNMDQ1J0wYwB
        pSbogc6EonxyAxwDo8LWyYvP83+XScPa1ElWKyMfo1NK0esCr+DcHkfLdZZpQeINQE8ICqJb0QS
        4+ManiLigwqZwOCK4HY7fwBlBQDrBGXfvWwUrOQ==
X-Received: by 2002:a37:b97:0:b0:75f:3d6:8166 with SMTP id 145-20020a370b97000000b0075f03d68166mr1526839qkl.18.1686754982706;
        Wed, 14 Jun 2023 08:03:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XDQaV76PDXC2pJoOhzFD6+vh+s9cTgaUdn5cYBrmPYPQaLYjT+qo9PTIrwiabwmcUXAsuIA==
X-Received: by 2002:a37:b97:0:b0:75f:3d6:8166 with SMTP id 145-20020a370b97000000b0075f03d68166mr1526815qkl.18.1686754982463;
        Wed, 14 Jun 2023 08:03:02 -0700 (PDT)
Received: from redhat.com ([172.58.139.140])
        by smtp.gmail.com with ESMTPSA id o23-20020a05620a15d700b0075cdad9648dsm4364920qkm.25.2023.06.14.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:03:01 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:02:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: Can vhost translate to io_uring?
Message-ID: <20230614103152-mutt-send-email-mst@kernel.org>
References: <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:02:58AM -0500, Eric W. Biederman wrote:
> At a quick glance it looks like io_uring already supports the
> functionality that vhost supports (which I think is networking and
> scsi).

There's vsock too.

-- 
MST


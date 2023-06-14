Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D384473019C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbjFNOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245529AbjFNOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845B1711
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686752457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXku3YB8jZRDn1PVtMCllG5PapuVlNga2nXVph7/LWk=;
        b=ZDt96I3f0n50DuvGxz0CDsHKkRkam1htVV6/bzEqvv6b1BStOlm5KfKaTcFyOopLTgW56D
        JK6COTtu6foyfDuC+AbRBKthgBHKR0NM9/LKRi3OJSshKI7vUOyRQDuPoczKQF9ZkfK4Rg
        k3ymJQ9F2PG55VsE/ih/He9KU0F05+A=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-dztQ_oxeNmmE5rVlwVM-Og-1; Wed, 14 Jun 2023 10:20:53 -0400
X-MC-Unique: dztQ_oxeNmmE5rVlwVM-Og-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-bce1d7a8d2aso764263276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752453; x=1689344453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXku3YB8jZRDn1PVtMCllG5PapuVlNga2nXVph7/LWk=;
        b=jCuRSclafs8ujDWWW/XagSBT8zU8tPvNT57AMXQXrYecAva1npwUtswjWz24F+swpD
         PbxODzA0v0M4/nhhijVy9+AatqeNl2GOUu2SwjbL7uQuUlU4eYn5vKoU6DyKo0H2aaJK
         ixo1YQ744jhqPPg2NPrDa6vr0eRkFHJCsg7mVtxzNWWKhSQSh2bnK3imXhlH+/ShoN3w
         iHMV5SmmvHXmoY7BzeM/VZVH3zCbr72WTRnbLUPmONoqktRaVr0VcPf66t5AuQLVw8xL
         bDRECPX8q2mjKQpqnSoTGzVIHDlLnoTZTCcSULoFmbs0ifNKwBiOAEc+wJ7M4MXoWwSH
         wcTw==
X-Gm-Message-State: AC+VfDxdlTN8agT1DeqM4Wftp+jKWL2wsZ+xh1wS/RuXK1CXCtcFwHs1
        zUXQ6ifXZhslOJPPgMn76sMFrz9OaBFWJfdjFF4B+cvn54/Bw7q6+bDGnnQFdZ0nC1s63SchXCN
        Owih5+WmdyYWS7c7PxQlJZLQm
X-Received: by 2002:a25:ae57:0:b0:bc9:92c9:7fd1 with SMTP id g23-20020a25ae57000000b00bc992c97fd1mr2036291ybe.3.1686752452993;
        Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55c4UJLMpZucuKbY6+TCCYSBjctZCn+vU6/vzdkwA5/zCwTGxJVt7jQHO4SoPbkTdGrqyhIw==
X-Received: by 2002:a25:ae57:0:b0:bc9:92c9:7fd1 with SMTP id g23-20020a25ae57000000b00bc992c97fd1mr2036256ybe.3.1686752452550;
        Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
Received: from redhat.com ([172.58.139.140])
        by smtp.gmail.com with ESMTPSA id e71-20020a25694a000000b00bd586162582sm646086ybc.53.2023.06.14.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:20:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: Can vhost translate to io_uring?
Message-ID: <20230614101951-mutt-send-email-mst@kernel.org>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:02:58AM -0500, Eric W. Biederman wrote:
> 
> I am sad my idea for simplifying things did not work out.
> 
> 
> Let's try an even bigger idea to reduce maintenance and simplify things.
> 
> Could vhost depend on io_uring?
> 
> Could vhost just be a translation layer of existing vhost requests to
> io_uring requests?

I expect that's going to have a measureable performance impact.

> At a quick glance it looks like io_uring already supports the
> functionality that vhost supports (which I think is networking and
> scsi).
> 
> If vhost could become a translation layer that would allow removing
> the vhost worker and PF_USER_WORKER could be removed completely,
> leaving only PF_IO_WORKER.
> 
> 
> I suggest this because a significant vhost change is needed because in
> the long term the hacks in exec and coredump are not a good idea.  Which
> means something like my failed "[PATCH v3] fork, vhost: Use CLONE_THREAD
> to fix freezer/ps regression".
> 
> If we have to go to all of the trouble of reworking things it why can't
> we just make io_uring do all of the work?
> 
> Eric


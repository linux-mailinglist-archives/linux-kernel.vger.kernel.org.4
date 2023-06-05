Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7F722AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjFEPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFEPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA17106
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685977930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bywKZhtlg51wzfiscYPd6CmyliJ7OItYPiep19smH9g=;
        b=BNFk9haRfXbEl8y3C+1jeb3Miwvov2smSVb8rp0nF7t/HrLRrpFcdqdaS0pldKnoFe0ARE
        LYXae0q+zstbTtsulzgCkxhYfwwx5ZZv/3Ss3YNbm2mLIOiqRSW85r7GlzCps41zYsM2ng
        z75u6SeOudhoU8RrJ9Wyau/LQCzJH9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-eP_K2iQ2Pr6AedXeMPAcpQ-1; Mon, 05 Jun 2023 11:12:07 -0400
X-MC-Unique: eP_K2iQ2Pr6AedXeMPAcpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A2FC8EF5BB;
        Mon,  5 Jun 2023 15:11:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id 813AF9E72;
        Mon,  5 Jun 2023 15:11:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Jun 2023 17:10:42 +0200 (CEST)
Date:   Mon, 5 Jun 2023 17:10:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     michael.christie@oracle.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605151037.GE32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03, michael.christie@oracle.com wrote:
>
> On 6/2/23 11:15 PM, Eric W. Biederman wrote:
> The problem is that as part of the flush the drivers/vhost/scsi.c code
> will wait for outstanding commands, because we can't free the device and
> it's resources before the commands complete or we will hit the accessing
> freed memory bug.

ignoring send-fd/clone issues, can we assume that the final fput/release
should always come from vhost_worker's sub-thread (which shares mm/etc) ?

Oleg.


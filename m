Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B06C309F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCULov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCULot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8938EBD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679399043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ip0ypPWj0y6T3kRIH9Tya2rrM/dKmttRsWWLGVarwIU=;
        b=iy1Xb/O/sVarMBkBjoFyV0kAAdBnuwFT2crJHolRBnHdEsoQdHupQectcvakcHFCmVfBsw
        tMnEX3DsQMzubIXf8DHYDwwMI1HLlXgEXF0sVaiOqstOcqVlqnfJrR/t3FRoyGbBD9wCU0
        Jeujk6GhNpqMnIyVaWcGIS+WSZKC2Vs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-zDzNZeAJNaCSu7nOK5F_fQ-1; Tue, 21 Mar 2023 07:43:59 -0400
X-MC-Unique: zDzNZeAJNaCSu7nOK5F_fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 156C529AB3EA;
        Tue, 21 Mar 2023 11:43:59 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACA531121314;
        Tue, 21 Mar 2023 11:43:51 +0000 (UTC)
Date:   Tue, 21 Mar 2023 19:43:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        ming.lei@redhat.com
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
Message-ID: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:21:58AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes from RFC:
>  - remove the patch to factor out GD_NEED_PART_SCAN
> 
> Yu Kuai (2):
>   block: Revert "block: Do not reread partition table on exclusively
>     open device"
>   block: fix scan partition for exclusively open device again

Hi Yu kuai,

Looks the original issue starts to re-appear now with the two patches:

https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/

And underlying disk partition and raid partition can be observed at the
same time.

Can you take a look?

Follows the script, which isn't 100% triggered, but still easy.

#create level 1 with 2 devices, meta 1.0
mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0

#create partition 0, start from 0 sector, size 100MiB
sgdisk -n 0:0:+100MiB /dev/md0

#observe partitions
cat /proc/partitions

#stop the array
mdadm -S /dev/md0

#re-assemble 
mdadm -A /dev/md0 /dev/sda /dev/sdb
cat /proc/partitions


Thanks,
Ming

